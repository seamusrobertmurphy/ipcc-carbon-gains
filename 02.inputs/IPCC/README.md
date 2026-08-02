# `02.inputs/IPCC/`: global reference layers

Surveyed 2026-07-30 with `ogrinfo` and `gdalinfo` against every file as delivered.

> **None of the layers in this folder is used by the manuscript as it currently stands.**
> They were assembled to place Ireland in the correct IPCC climate zone and soil class, but
> that assignment was made directly from the published Table 2.3 and Table 6.2 strata
> instead, which needs no spatial data. The folder is retained because the assignment would
> have to be made spatially if the study were extended to a second country. Roughly half of
> it belongs to other projects and should be removed; see the last section.

Nothing here is committed. `.gitignore` excludes `02.inputs/**` and re-admits only `*.md`,
`*.R`, `*.py` and `derived/*.csv`. Three files exceed GitHub's 100 MB limit.

---

## Layers that open and are what they claim to be

### `Veg Type (IPCC 2019)/gez_2010_wgs84.shp`

| | |
|---|---|
| **What** | FAO Global Ecological Zones, 2010 revision |
| **Source** | FAO, redistributed with the folder; no retrieval URL was recorded at delivery |
| **Dimensions** | 21 polygons, global, WGS 84 (EPSG:4326), extent −180/−89.9 to 180/83.6 |
| **Fields** | `gez_name`, `gez_code`, `gez_abbrev` |
| **Size** | 91 MB `.shp` |
| **Applied** | Not used. This is the standard route from a coordinate to the IPCC climate zone that Table 2.3 and Table 6.2 are keyed on. Ireland is cool temperate moist (zone C1), assigned from the published strata rather than by overlay. |

### `Soil Type (WRB 2014)/soils-parent-merged.shp` and `Soil Type (IPCC 2019)/soils-merged.gpkg`

| | |
|---|---|
| **What** | Harmonised World Soil Database mapping units, WRB 2014 legend |
| **Dimensions** | 300,076 polygons, global, WGS 84. **The two files are the same data in two formats**, costing 845 MB and 265 MB respectively |
| **Fields** | `MU_GLOBAL`, `ISSOIL`, `SHARE`, `SEQ`, `T_TEXTURE` and related HWSD attributes |
| **Applied** | Not used. Would be the route to the IPCC soil classes (HAC, LAC, SAN, POD, VOL, WET) for a country without a national soils map. Ireland has one, so the Irish Soil Information System was used instead. |

**Keep one of the two.** The GeoPackage is the better citizen: a single file, proper types,
no `.dbf` ten-character field-name limit.

### `Soil Type (IPCC 2019)/soil_type.tif`

5 arc-minute global soil-type raster, 4320 × 2160, EPSG:4326. `SOIL_TYPE.rst` and `.RDC`
alongside are the same grid in Idrisi format. Not used.

---

## Mislabelled: the wetlands folder contains no wetlands

`Wetlands (GLWD 2023)/GLWD_level2/glwd_2.shp` opens with 244,892 features whose `TYPE` field
takes exactly three values: **Lake, Reservoir and River**. There is no wetland class in it.
The `.dbf` last-update stamp is **2003-05-20**.

That identifies it as **Level 2 of the original Global Lakes and Wetlands Database** (Lehner
& Döll, 2004), the large-waterbody polygon layer. In that database the wetlands are in
**Level 3**, a 30-arcsecond raster. The folder name promises GLWD **2023**, meaning GLWD v2,
a different and much later product.

It also carries **no CRS** (`Layer SRS WKT: (unknown)`), so one must be assigned by hand
before any overlay. **Recommendation: delete it.** For Ireland the national sources are
better than any global wetland product, and the study uses those.

---

## Belongs to other projects: remove, roughly 1.24 GB

Ecuador is a **declared conflict of interest** for this paper. Seamus is a named author on
the 2025 Ecuador Emissions Update Reports, and the project record requires the interest be
declared if Ecuador appears. These files are not needed here and are a trap for a future
glob.

| File | Evidence |
|---|---|
| `Soil Type (IPCC 2019)/shp_unidad_geopedologica_2019.zip`, **1.2 GB** | Internal path `MINISTERIO_AGRICULTURA_GANADERIA/E_FISIOGRAFIA/EL_GEOPEDOLOGIA/`. Ecuadorian Ministry of Agriculture and Livestock geopedological units, 2019. |
| `Soil Type (IPCC 2019)/IPCC_Soils_sf.shp` | Extent −91.83° to −75.17° longitude, −5.0° to 1.5° latitude: mainland Ecuador plus Galápagos. 6 features, one `soil` field. |
| `Protected Areas (WDPA)/WDPA_Mar2025_Public_32629_GOLA.zip` | 4 features: Gola Rainforest National Park (ISO3 **SLE**), Bong Mountain, Kpo Mountains, Foya (ISO3 **LBR**). Sierra Leone and Liberia. Filed under UTM 29N, which covers both West Africa and Ireland, which is probably why it travelled. |
| `Soil Type (IPCC 2019)/Plots-Soil+Climate-Stratified.zip` | Not opened. Adjacent to the Ecuador files; assume Ecuador until checked. |
