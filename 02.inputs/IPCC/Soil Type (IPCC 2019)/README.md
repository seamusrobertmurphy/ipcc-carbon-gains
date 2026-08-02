# Soil Type (IPCC 2019)

Two distinct things live here, plus Ecuador leftovers.

## `soils-merged.gpkg`: Harmonised World Soil Database  **USED**

The most important global layer in the project. 300,076 polygons, EPSG:4326, carrying the full
HWSD attribute set: `SU_SYM90` (FAO 1990 soil unit), `SHARE`, `SEQ`, `DRAINAGE`, `T_OC` and the
complete horizon properties. `soils-parent-merged.shp` in the sibling WRB folder is the **same
300,076 features** in shapefile form; keep one.

Querying the soil-unit symbols gives **7,509 Histosol polygons** (peat) and **12,976 Gleysol
polygons** (wetland mineral soil). Total polygon area 13,431 Mha, matching global land.

**Two traps, both established empirically and both load-bearing:**

1. **`SEQ` is 1 on all 272,247 valid rows**, only the *dominant* soil component of each mapping
   unit survived the merge. Geometry is **not** duplicated per component; summing row areas and
   unique geometries both give 13,431 Mha. Do **not** multiply by `SHARE/100` expecting to
   apportion: that discards area. Both bases are reported downstream.
2. **`DRAINAGE` is an intrinsic soil property, not management status.** All 7,509 Histosols
   carry `DRAINAGE = 1`; sandy Arenosols carry 4 and 6. It cannot supply the drained-versus-
   rewetted split that every organic-soil emission factor turns on.

Consequence: Histosols total **138 Mha** here against 265 Mha from the raster below and 400–500
Mha published. Peat present as a subordinate component is invisible. **Lower bound only.**

Applied by `05.scripts/prep-global-pathway-areas.py` → `derived/global-pathway-areas.csv`.

## `soil_type.tif`: IPCC soil classification raster  **USED**

4320 × 2160, 5 arc-minute, EPSG:4326. Legend from the Idrisi sidecar `SOIL_TYPE.RDC`, whose
lineage records derivation from HWSD v1.1 via an `IPCC_SOIL_CLS` reclassification:

`1` Organic · `2` Sandy · `3` Wetland · `4` Volcanic · `5` Spodic · `6` High Activity Clay ·
`7` Low Activity Clay · `8` Other. `0` is background (ocean and unclassified), 76.3% of cells.

Applied by `05.scripts/prep-global-area-weights.py` → `derived/global-area-by-zone-soil.csv`,
which supplies the area weighting for the Batjes reference-stock bias.

## Not for this project: remove

`shp_unidad_geopedologica_2019.zip` (1.2 GB) is Ecuadorian, internal path
`MINISTERIO_AGRICULTURA_GANADERIA/E_FISIOGRAFIA/EL_GEOPEDOLOGIA/`. `IPCC_Soils_sf.shp` is 6
features spanning −91.83° to −75.17° longitude, mainland Ecuador plus Galápagos.
`Plots-Soil+Climate-Stratified.zip` is 2,430 Ecuadorian forest-inventory plots with Spanish
field names. **Ecuador is a declared conflict of interest for this paper.**
