#!/usr/bin/env python3
"""
prep-global-pathway-areas.py

Compute the global land area to which each IPCC Tier 1 gain pathway could apply, stratified
by climate zone, so the manuscript can move from rates per hectare to magnitude.

WHY
---
Every result in the paper is a rate. Nothing says how much land each pathway covers, so
nothing says what is at stake. This supplies the denominator.

INPUT
-----
Harmonised World Soil Database, delivered as
  02.inputs/IPCC/Soil Type (IPCC 2019)/soils-merged.gpkg
300,076 polygon-by-soil-component rows, EPSG:4326, carrying the full HWSD attribute set:
`SU_SYM90` (FAO 1990 soil unit), `SHARE`, `DRAINAGE`, `T_OC`, and horizon properties.

FAO Global Ecological Zones 2010, for the climate stratification:
  02.inputs/IPCC/Veg Type (IPCC 2019)/gez_2010_wgs84.shp
The GEZ-to-IPCC-climate-zone crosswalk is imported from prep-global-area-weights.py rather
than restated, so the two scripts cannot drift apart.

THE AREA ARITHMETIC, established empirically 2026-08-01
------------------------------------------------------
An earlier version of this script assumed the delivered layer repeated each polygon once per
soil component, and multiplied by SHARE/100 to apportion. **That was wrong and the validation
gate caught it.** Summing row areas and summing over unique geometries both give 13,431 Mha,
so no geometry is duplicated: each row is one polygon carrying one soil component.

`SEQ` is 1 for all 272,247 valid rows, which means **only the DOMINANT component of each
mapping unit survived the merge**. Subordinate components were dropped. `SHARE` is the
dominant component's percentage of its mapping unit, mean 86.4% for Histosols.

Two areas are therefore reported for every pathway and neither is "the" answer:

  area_dominant_ha  full polygon area, i.e. treat the polygon as entirely that soil
  area_share_ha     polygon area x SHARE/100, i.e. only the dominant component's fraction

The truth lies between them. The gate is on total polygon area, which must approximate global
land area, and does.

THE PEATLAND UNDERCOUNT, which must travel with any use of these numbers
-----------------------------------------------------------------------
Because only dominant components survived, **peat that occurs as a subordinate component of a
mapping unit is invisible to this layer**. Histosols come to 138 Mha on the dominant-component
basis against a published global peatland area of roughly 400 to 500 Mha, a threefold
shortfall, and against 265 Mha from the 5-arcminute IPCC soil raster which was built from the
same HWSD by a different route.

This is a property of dominant-soil mapping, not a defect in the arithmetic. Treat the
Histosol area as a **lower bound** and say so wherever it is used. Do not reconcile it by
scaling to a published total: that would import an area from one source and a factor from
another without a shared definition of peat depth or organic-carbon threshold.

WHAT `DRAINAGE` DOES AND DOES NOT GIVE
--------------------------------------
Confirmed empirically on 2026-08-01: **all 7,509 Histosol rows carry DRAINAGE = 1**, while
sandy Arenosols carry 4 and 6. The scale therefore runs 1 (very poor) to 6 (excessive), the
FAO convention. But a value that is constant across every Histosol is an INTRINSIC property
of the soil type, not a record of whether the land has been artificially drained.

**`DRAINAGE` cannot supply the drained-versus-rewetted split**, which is the split every
organic-soil emission factor in this paper turns on. No global dataset resolves it reliably;
the manuscript already records that FAO's DROSA infers drainage from land cover rather than
observing it. Organic soils are therefore carried forward as a single area to be bracketed
downstream under explicit all-drained and all-intact bounds, never as a point estimate.
"""

import csv
import importlib.util
import os
import sys

try:
    import geopandas as gpd
    import numpy as np
except ImportError:
    sys.exit("needs geopandas")

HERE = os.path.dirname(os.path.abspath(__file__))
BASE = os.path.join(HERE, "../02.inputs/IPCC")
GPKG = os.path.join(BASE, "Soil Type (IPCC 2019)/soils-merged.gpkg")
GEZ = os.path.join(BASE, "Veg Type (IPCC 2019)/gez_2010_wgs84.shp")
OUT = os.path.join(HERE, "../02.inputs/derived/global-pathway-areas.csv")

# Import the crosswalk from the sibling script rather than restating it.
spec = importlib.util.spec_from_file_location(
    "weights", os.path.join(HERE, "prep-global-area-weights.py"))
weights = importlib.util.module_from_spec(spec)
spec.loader.exec_module(weights)
GEZ_MAIN, ENCODED = weights.GEZ_MAIN, weights.ENCODED_ZONES

# Equal-area projection for area computation. World Cylindrical Equal Area is adequate at
# global scale and is what the area totals are validated against.
EQUAL_AREA = "+proj=cea +lat_ts=30 +datum=WGS84 +units=m +no_defs"


def pathway(sym):
    """FAO 1990 soil unit -> the Tier 1 pathway whose factors apply to it."""
    if not isinstance(sym, str) or not sym:
        return "Unclassified"
    if sym.startswith("HS"):
        return "Organic soil"          # Wetlands Supplement Ch. 2 and 3, flux-based
    if sym.startswith("GL"):
        return "Wetland mineral soil"  # Wetlands Supplement Ch. 5, stock-change
    return "Other mineral soil"        # 2019 Refinement Ch. 2/6, stock-change


def main():
    print("Reading HWSD ...", flush=True)
    g = gpd.read_file(GPKG, columns=["SU_SYM90", "SHARE", "DRAINAGE", "T_OC", "MU_GLOBAL"])
    print(f"  {len(g):,} polygon-by-component rows")

    print("Projecting and computing area ...", flush=True)
    ga = g.to_crs(EQUAL_AREA)
    g["poly_ha"] = ga.geometry.area / 10000.0
    share = g["SHARE"].fillna(0.0).clip(lower=0.0, upper=100.0)
    # Two bases, reported side by side. See the header: the merge kept dominant components
    # only, so neither the full polygon nor its SHARE fraction is unambiguously correct.
    g["area_dominant_ha"] = g["poly_ha"]
    g["area_share_ha"] = g["poly_ha"] * share / 100.0

    print("Assigning climate zone by centroid ...", flush=True)
    z = gpd.read_file(GEZ)[["gez_name", "geometry"]].to_crs("EPSG:4326")
    cent = gpd.GeoDataFrame(geometry=g.geometry.representative_point(), crs=g.crs)
    joined = gpd.sjoin(cent, z, how="left", predicate="within")
    joined = joined[~joined.index.duplicated(keep="first")]
    g["gez_name"] = joined["gez_name"].reindex(g.index)
    g["zone"] = g["gez_name"].map(GEZ_MAIN).fillna("Unassigned")

    g["pathway"] = g["SU_SYM90"].map(pathway)

    agg = (g.groupby(["zone", "pathway"], dropna=False)
             .agg(area_dominant_ha=("area_dominant_ha", "sum"),
                  area_share_ha=("area_share_ha", "sum"),
                  n_rows=("area_share_ha", "size"),
                  mean_SHARE=("SHARE", "mean"),
                  mean_T_OC=("T_OC", "mean"))
             .reset_index())
    agg = agg[agg["area_dominant_ha"] > 0].sort_values("area_dominant_ha", ascending=False)

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", newline="") as fh:
        w = csv.writer(fh)
        w.writerow(["zone", "pathway", "area_dominant_ha", "area_share_ha",
                    "n_rows", "mean_SHARE", "mean_T_OC"])
        for _, r in agg.iterrows():
            f = lambda v, d=2: "" if (v is None or np.isnan(v)) else round(v, d)
            w.writerow([r["zone"], r["pathway"], round(r["area_dominant_ha"], 1),
                        round(r["area_share_ha"], 1), int(r["n_rows"]),
                        f(r["mean_SHARE"], 1), f(r["mean_T_OC"])])

    # ---- validation: the gate is on total polygon area ----
    tot_poly = g["poly_ha"].sum()
    by = agg.groupby("pathway")[["area_dominant_ha", "area_share_ha"]].sum()
    org_d = by.loc["Organic soil", "area_dominant_ha"]
    org_s = by.loc["Organic soil", "area_share_ha"]
    wet_d = by.loc["Wetland mineral soil", "area_dominant_ha"]

    print(f"\nWrote {OUT}: {len(agg)} rows")
    print(f"\n  Total polygon area            {tot_poly/1e6:9.0f} Mha "
          f"(global land ~13,000)  -> gate {'PASS' if 0.85*13.0e9 < tot_poly < 1.15*13.0e9 else 'FAIL'}")
    print(f"\n  Pathway areas, Mha        dominant   share-weighted")
    for p in by.index:
        print(f"    {p:24s} {by.loc[p,'area_dominant_ha']/1e6:8.0f} {by.loc[p,'area_share_ha']/1e6:14.0f}")
    print(f"\n  PEATLAND UNDERCOUNT: Histosols {org_d/1e6:.0f} Mha dominant, {org_s/1e6:.0f} Mha share-weighted,")
    print(f"    against 265 Mha from the 5-arcmin raster and ~400-500 Mha published.")
    print(f"    Only dominant components survived the merge, so subordinate peat is invisible.")
    print(f"    USE AS A LOWER BOUND.")
    print(f"\n  Wetland mineral (Gleysols)    {wet_d/1e6:9.0f} Mha dominant")
    enc = agg[agg["zone"].isin(ENCODED)]["area_dominant_ha"].sum()
    print(f"  In the 8 encoded IPCC zones   {enc/1e6:9.0f} Mha  ({100*enc/tot_poly:.1f}%)")

if __name__ == "__main__":
    main()
