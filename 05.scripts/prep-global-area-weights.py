#!/usr/bin/env python3
"""
prep-global-area-weights.py

Compute the global land area of each IPCC climate zone x soil class combination, so the
bias in the Table 2.3 reference stocks can be weighted by how much land each cell actually
represents rather than treated as if all 37 cells mattered equally.

WHY
---
The manuscript shows the Table 2.3 arithmetic means exceed the robust median in 34 of 37
cells, median bias 13.0%, maximum 154.5%. Those are per-cell figures. They cannot say
whether the bias sits in cells that cover a lot of land or in rare ones. This script
supplies the denominator.

INPUTS
------
1. IPCC soil classification raster, 5 arc-minute, 4320 x 2160, EPSG:4326.
   02.inputs/IPCC/Soil Type (IPCC 2019)/soil_type.tif
   Legend read from the Idrisi sidecar SOIL_TYPE.RDC, whose lineage records it was derived
   from HWSD v1.1 via an IPCC_SOIL_CLS reclassification:
     1 Organic       2 Sandy Soils    3 Wetland Soils   4 Volcanic Soils
     5 Spodic Soils  6 High Activity Clay  7 Low Activity Clay   8 Other Areas
   0 is background (ocean and unclassified), 76.3% of cells.

2. FAO Global Ecological Zones 2010, 21 polygons, EPSG:4326.
   02.inputs/IPCC/Veg Type (IPCC 2019)/gez_2010_wgs84.shp

THE APPROXIMATION, STATED UP FRONT
----------------------------------
FAO Global Ecological Zones are an ECOLOGICAL classification built from vegetation and
climate. The IPCC climate zones that Table 2.3 is keyed on are a CLIMATIC classification
built from mean annual temperature, mean annual precipitation, elevation and frost
occurrence (2006 Guidelines Vol. 4 Ch. 3 Annex 3A.5). They are not the same scheme and the
crosswalk below is a documented approximation, not the IPCC's own map.

Two consequences, both handled explicitly:
  - The three MOUNTAIN SYSTEM zones are genuinely ambiguous, because elevation moves a site
    between IPCC zones in a way GEZ does not resolve. They are assigned in the main run and
    re-assigned in a sensitivity run; if the conclusion moves, it is not robust.
  - Boreal and Polar GEZ zones have no counterpart in the encoded Batjes table, which covers
    the eight temperate and tropical zones only. They are reported as excluded area, never
    silently dropped.

Any result from this script must carry that caveat. It is a first-order weighting, adequate
to answer "does the bias concentrate in large or small cells" and not adequate to produce a
global stock estimate.
"""

import csv
import os
import sys

import numpy as np

try:
    import rasterio
    from rasterio import features
    import geopandas as gpd
except ImportError:
    sys.exit("needs rasterio and geopandas")

BASE = "../02.inputs/IPCC"
TIF = os.path.join(BASE, "Soil Type (IPCC 2019)/soil_type.tif")
GEZ = os.path.join(BASE, "Veg Type (IPCC 2019)/gez_2010_wgs84.shp")
OUT = "../02.inputs/derived/global-area-by-zone-soil.csv"

# Raster code -> the soil abbreviations used in the manuscript's Batjes table.
SOIL = {1: "Organic", 2: "SAN", 3: "WET", 4: "VOL", 5: "POD",
        6: "HAC", 7: "LAC", 8: "Other"}

# FAO GEZ -> IPCC climate zone. "amb" marks the assignments the sensitivity run flips.
GEZ_MAIN = {
    "Tropical rainforest": "T2", "Tropical moist forest": "T3",
    "Tropical dry forest": "T4", "Tropical shrubland": "T4",
    "Tropical desert": "T4", "Tropical mountain system": "T1",
    "Subtropical humid forest": "W1", "Subtropical dry forest": "W2",
    "Subtropical steppe": "W2", "Subtropical desert": "W2",
    "Subtropical mountain system": "W1",          # amb
    "Temperate oceanic forest": "C1", "Temperate continental forest": "C1",
    "Temperate steppe": "C2", "Temperate desert": "C2",
    "Temperate mountain system": "C1",            # amb
    "Boreal coniferous forest": "Boreal", "Boreal tundra woodland": "Boreal",
    "Boreal mountain system": "Boreal", "Polar": "Polar", "Water": "Water",
}
# Sensitivity: push both ambiguous mountain systems to the dry side.
GEZ_ALT = dict(GEZ_MAIN)
GEZ_ALT["Subtropical mountain system"] = "W2"
GEZ_ALT["Temperate mountain system"] = "C2"

ENCODED_ZONES = {"C1", "C2", "W1", "W2", "T1", "T2", "T3", "T4"}


def cell_area_km2(height, width):
    """Area of each 5-arcmin cell, varying with latitude. Rows are north to south."""
    R = 6371.0088
    lat_edges = np.linspace(90.0, -90.0, height + 1)
    band = (np.abs(np.sin(np.radians(lat_edges[:-1])) -
                   np.sin(np.radians(lat_edges[1:]))) *
            (2 * np.pi * R ** 2) / width)
    return np.repeat(band[:, None], width, axis=1)


def main():
    with rasterio.open(TIF) as src:
        soil = src.read(1)
        transform, h, w = src.transform, src.height, src.width

    gez = gpd.read_file(GEZ).to_crs("EPSG:4326")
    names = sorted(gez["gez_name"].unique())
    unknown = [n for n in names if n not in GEZ_MAIN]
    if unknown:
        sys.exit(f"Unmapped GEZ zone(s), refusing to guess: {unknown}")

    codes = {n: i + 1 for i, n in enumerate(names)}
    gez["code"] = gez["gez_name"].map(codes)
    zone_r = features.rasterize(
        ((geom, c) for geom, c in zip(gez.geometry, gez["code"])),
        out_shape=(h, w), transform=transform, fill=0, dtype="int32")

    area = cell_area_km2(h, w)
    rows = []
    for scheme, mapping in (("main", GEZ_MAIN), ("mountains_dry", GEZ_ALT)):
        for gname, gcode in codes.items():
            zone = mapping[gname]
            m_zone = zone_r == gcode
            if not m_zone.any():
                continue
            for scode, sname in SOIL.items():
                m = m_zone & (soil == scode)
                if not m.any():
                    continue
                rows.append({
                    "scheme": scheme, "gez_name": gname, "zone": zone,
                    "soil": sname,
                    "area_ha": round(float(area[m].sum()) * 100.0, 1),   # 1 km2 = 100 ha
                    "n_cells": int(m.sum()),
                })

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", newline="") as fh:
        wr = csv.DictWriter(fh, fieldnames=["scheme", "gez_name", "zone", "soil",
                                            "area_ha", "n_cells"])
        wr.writeheader()
        wr.writerows(rows)

    main_rows = [r for r in rows if r["scheme"] == "main"]
    tot = sum(r["area_ha"] for r in main_rows if r["zone"] != "Water")
    enc = sum(r["area_ha"] for r in main_rows
              if r["zone"] in ENCODED_ZONES and r["soil"] not in ("Organic", "Other"))
    org = sum(r["area_ha"] for r in main_rows if r["soil"] == "Organic")
    bor = sum(r["area_ha"] for r in main_rows if r["zone"] in ("Boreal", "Polar"))

    print(f"Wrote {OUT}: {len(rows)} rows ({len(main_rows)} in the main scheme)")
    print(f"\n  Total classified land            {tot/1e6:10.0f} Mha")
    print(f"  In the 8 encoded IPCC zones,")
    print(f"    on mineral soils Batjes covers  {enc/1e6:10.0f} Mha  ({100*enc/tot:.1f}%)")
    print(f"  Organic soils, excluded by design {org/1e6:10.0f} Mha  ({100*org/tot:.1f}%)")
    print(f"  Boreal and Polar, not encoded     {bor/1e6:10.0f} Mha  ({100*bor/tot:.1f}%)")


if __name__ == "__main__":
    main()
