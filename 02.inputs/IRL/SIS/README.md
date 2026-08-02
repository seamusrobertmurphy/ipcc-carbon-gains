# Irish Soil Information System: national soils map

**Source.** Teagasc / EPA, retrieved from the EPA GeoServer WFS on **2026-07-31**:
`https://gis.epa.ie/geoserver/EPA/wfs`, layer `EPA:SOIL_SISNationalSoils`,
`outputFormat=SHAPE-ZIP`, `srsName=EPSG:29902`. Archive kept as `sis-wfs-download.zip`
(120,716,941 bytes). **Licence CC BY 4.0**, per the data.gov.ie record.

**Dimensions.** 25,143 polygons · **6,989,574 ha**, agreeing with the map's own stated hectares
to 0.04% · TM65 Irish Grid, **EPSG:29902**.

**Key fields.** `SOC` (numeric, association-level, 43 distinct values 108–317 t C/ha),
`Drainage` (6 classes), `Texture` (7), `Depth` (3), `Associati0`/`Associati1`, `Ha`.

**Provenance warning.** The originally delivered copy was **missing its `.shp` and `.dbf`**;
only the `.shx`, `.prj`, `.CPG` and ArcGIS `.lyr` files arrived. Those were preserved
(`unzip -n`) and the two missing components added from the WFS. Three checks confirm the same
dataset: the service reported `numberMatched="25143"`, the delivered `.shx` is 201,244 bytes
which at 8 bytes per record implies exactly 25,143 features, and the CRS matches.

**Schema discrepancy.** The delivered `README.txt` documents an earlier ArcGIS export whose
field names differ: `Associat_1`/`Associat_2`/`ha`/`DRAINAGE`/`TEXTURE`/`DEPTH` against the
WFS's `Associati0`/`Associati1`/`Ha`/`Drainage`/`Texture`/`Depth`, which also adds `PlainEngli`
and `URLtext`. Same data, different truncation. The script accepts either.

**Applied by** `05.scripts/prep-irish-soils.R` → `derived/irish-soils-area-by-class.csv`.
Establishes that **SOC is populated on only 67.7% of the mapped area and 92% of the peat is
blank**, including a single blanket bog unit (`01_Bk`) of 1,643,401 ha across 3,754 polygons.
