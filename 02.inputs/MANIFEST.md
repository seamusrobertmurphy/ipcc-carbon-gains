# 02.inputs manifest

Surveyed 2026-07-30 with `ogrinfo` and `gdalinfo` against every file as delivered. 2.7 GB
total. **Nothing here is committed**: `.gitignore` excludes `02.inputs/**` and re-admits only
`*.md`, `*.R`, `*.py` and `derived/*.csv`. Three files exceed GitHub's 100 MB hard limit, so
this exclusion is load-bearing, not tidiness.

Status vocabulary: **USABLE** = opened and verified. **BROKEN** = incomplete, cannot be read.
**WRONG PROJECT** = valid data belonging to different work. **MISLABELLED** = readable but is
not what the folder name says.

---

## USABLE

| Layer | Path | What it is | Verified |
|---|---|---|---|
| FAO Global Ecological Zones 2010 | `IPCC/Veg Type (IPCC 2019)/gez_2010_wgs84.shp` | 21 polygons, global, WGS 84. Fields `gez_name`, `gez_code`, `gez_abbrev`. The standard route to the IPCC climate zones that Table 2.3 and Table 6.2 are keyed on. | Opens, 21 features, extent global |
| HWSD-derived soil units, WRB 2014 | `IPCC/Soil Type (WRB 2014)/soils-parent-merged.shp` | 300,076 polygons, global, WGS 84. 731 MB `.dbf`. | Opens |
| Same data as GeoPackage | `IPCC/Soil Type (IPCC 2019)/soils-merged.gpkg` | **Duplicate** of the above: identical 300,076 features and extent. Fields `MU_GLOBAL`, `ISSOIL`, `SHARE`, `SEQ`, `T_TEXTURE`, i.e. HWSD mapping-unit schema. | Opens |
| Global soil type raster | `IPCC/Soil Type (IPCC 2019)/soil_type.tif` | 4320 × 2160, 5 arc-minute, EPSG:4326, global. Companion `SOIL_TYPE.rst`/`.RDC` is the same grid in Idrisi format. | Opens |

The `.gpkg` and the `.shp` are the same 300,076 features in two formats, costing 845 MB and
265 MB respectively. Keep one. The GeoPackage is the better citizen: single file, proper
types, no `.dbf` field-width limits.

## RESOLVED 2026-07-31: the Irish soils layer, retrieved from source

**The missing geometry and attributes were downloaded from the EPA's public web feature
service and the layer is now complete.** Provenance, so this is reproducible:

| Item | Value |
|---|---|
| Service | `https://gis.epa.ie/geoserver/EPA/wfs` |
| Layer | `EPA:SOIL_SISNationalSoils` |
| Request | `service=WFS&version=2.0.0&request=GetFeature&typeNames=EPA:SOIL_SISNationalSoils&outputFormat=SHAPE-ZIP&srsName=EPSG:29902` |
| Retrieved | 2026-07-31, HTTP 200, 120,716,941 bytes in 28 s |
| Archive kept | `IRL/SIS/sis-wfs-download.zip` |
| Licence | **CC BY 4.0**, per the data.gov.ie record for "Irish Soil Information System National Soils Map" |

**Three independent checks confirm it is the same dataset the incomplete delivery came
from.** The service reported `numberMatched="25143"`, and the delivered `.shx` index is
201,244 bytes, which at 100 bytes of header plus 8 bytes per record implies exactly 25,143
features. The downloaded `.shx` is byte-for-byte the same length. And the CRS matches the
delivered `.prj`: TM65 Irish Grid, EPSG:29902.

Extracted with `unzip -n`, so the originally delivered `.shx`, `.prj` and `.CPG` were
preserved and only the two missing files were added.

**One schema discrepancy, recorded because it will confuse the next reader.** The delivered
`README.txt` documents an earlier ArcGIS export whose field names differ from the WFS
export's:

| README (ArcGIS) | WFS export |
|---|---|
| `Associat_1`, `Associat_2` | `Associati0`, `Associati1` |
| `ha`, `DRAINAGE`, `TEXTURE`, `DEPTH` | `Ha`, `Drainage`, `Texture`, `Depth` |
| — | adds `PlainEngli`, `URLtext` |

Same 25,143 features, same CRS, same attributes: the same data under a different
truncation. `05.scripts/prep-irish-soils.R` accepts either spelling.

**What the data actually says**, from that script:

- 25,143 polygons, **6,989,574 ha**, agreeing with the map's own stated hectares to 0.04%.
- `SOC` is **numeric and association-level**, 43 distinct values from 108 to 317 t C/ha,
  not a category as the `.lyr` symbology names suggested.
- `Drainage` has 6 classes, `Texture` 7, `Depth` 3.
- **SOC is populated on only 67.7% of the mapped area.** It is absent on 2,257,022 ha, and
  the gap is not random: **92% of the peat is blank**, including a single blanket bog unit
  (`01_Bk`) of 1,643,401 ha across 3,754 polygons. Tidal marsh and salt marsh are blank too.

That last point became a manuscript result rather than a data problem: it is the paper's
structural claim, that there is no reference stock for peat, visible in the national dataset
a compiler would actually use. See Results, "The national soils map has no carbon stock for
peat".

**Derived output:** `02.inputs/derived/irish-soils-area-by-class.csv`, 75 classes retaining
all 25,143 polygons, written by `05.scripts/prep-irish-soils.R` and read by the manuscript
with base `read.csv`. This is the only file in `02.inputs/` that is committed to git.

## Historical: the original delivery was incomplete

*Kept for the record; superseded by the retrieval above.*

**`IRL/SIS/` was missing both essential shapefile components and could not be opened.**

A shapefile needs `.shp` (geometry) and `.dbf` (attributes) at minimum. Delivered:

| Component | Status |
|---|---|
| `.shp` geometry | **MISSING** |
| `.dbf` attributes | **MISSING** |
| `.shx` index | present, 189 KB, useless alone |
| `.prj`, `.CPG`, `.sbn`, `.sbx` | present |
| `.lyr` symbology (7 files, incl. SoilSOC, SoilDrainage, SoilDepth, SoilTexture) | present, ArcGIS-only, carry no data |
| `SOIL_SISNationalSoils_Shp/` subfolders (Data, Metadata, Legend, Report) | **empty of real files**, only macOS `._` forks |
| `Soils Keys.xlsx`, metadata `.xlsx`, `README.txt` | present, readable |

A filesystem-wide search of `/Volumes/PortableSSD` for `SOIL_SISNationalSoils.shp` or `.dbf`
returned **nothing**. The files are not elsewhere on the drive.

This blocks the entire Irish mineral-soil arm: SIS is the route from Irish soil series to the
IPCC soil classes (HAC, LAC, SAN, POD, VOL, WET) that Equation 2.25 needs, and its peat mask
is the route to the organic/mineral split that decides which of the two accounting logics
applies to a given hectare. **Re-export needed**, ideally as GeoPackage rather than shapefile
to avoid this failure mode and the `.dbf` 10-character field-name truncation.

## WRONG PROJECT: Ecuador and West Africa leftovers, ~1.24 GB

Ecuador is a **declared conflict of interest** for this paper: Seamus is a named author on the
2025 Emissions Update Reports, and `CLAUDE.md` requires the interest be declared if Ecuador
appears. These files are not needed here and should be moved out rather than left to be
picked up by a future glob.

| File | Evidence it is not for this paper |
|---|---|
| `IPCC/Soil Type (IPCC 2019)/shp_unidad_geopedologica_2019.zip`, **1.2 GB** | Internal path `MINISTERIO_AGRICULTURA_GANADERIA/E_FISIOGRAFIA/EL_GEOPEDOLOGIA/`. Ecuadorian Ministry of Agriculture and Livestock geopedological units, 2019. |
| `IPCC/Soil Type (IPCC 2019)/IPCC_Soils_sf.shp` | Extent −91.83° to −75.17° lon, −5.0° to 1.5° lat: mainland Ecuador plus Galápagos. 6 features, single `soil` field. |
| `IPCC/Protected Areas (WDPA)/WDPA_Mar2025_Public_32629_GOLA.zip` | 4 features: Gola Rainforest National Park (ISO3 **SLE**), Bong Mountain, Kpo Mountains, Foya (ISO3 **LBR**). Sierra Leone and Liberia. Named `32629` for UTM 29N, which covers both West Africa and Ireland, which is probably why it travelled. |
| `IPCC/Soil Type (IPCC 2019)/Plots-Soil+Climate-Stratified.zip` | Not opened. Adjacent to the Ecuador files; assume Ecuador until checked. |

## MISLABELLED

**`IPCC/Wetlands (GLWD 2023)/` contains no wetlands.**

`glwd_2.shp` opens with 244,892 features, but the only values in its `TYPE` field are **Lake,
Reservoir and River**. There is no wetland class in it. Its `.dbf` last-update stamp is
**2003-05-20**.

That identifies it as **Level 2 of the original Global Lakes and Wetlands Database** (Lehner &
Döll, 2004), which is the large-waterbody polygon layer. In the original GLWD the wetlands
live in **Level 3**, a 30-arcsecond raster, not in Level 2. The folder name promises GLWD
**2023**, meaning GLWD v2 (Lehner et al.), a different and much later product with a far
richer class scheme.

Consequences: the layer cannot supply wetland extent for anything, it is twenty-plus years
old, and its `.shp` carries **no CRS** (`Layer SRS WKT: (unknown)`), so a CRS must be assigned
by hand before any overlay. Either obtain GLWD v2 properly, or drop the layer: for Ireland the
national sources are better than any global wetland product anyway.

---

## What is still needed for the Irish arm

1. **SIS national soils, re-exported with geometry and attributes.** Blocking.
2. **Irish peat/organic soil extent, drained versus intact versus rewetted.** Not in this
   delivery under any name.
3. **Saltmarsh and seagrass extent.** Not in this delivery. NPWS is the source.
4. **Grassland nitrogen application rates**, kg N/ha/yr by system. Not in this delivery. This
   is the single most important number for the nitrogen crossover and it is tabular, not
   spatial, so it does not need GIS at all.
5. **Ireland's CRT/NIR submission tables.** Not in this delivery.

Nothing in the current delivery answers 2 through 5. The global reference layers that did
arrive intact (FAO GEZ, HWSD/WRB soils, the soil-type raster) are useful for placing Ireland
in the right IPCC climate zone and soil class, which is real progress, but they are the
denominator, not the numerator.
