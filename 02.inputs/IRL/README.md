# `02.inputs/IRL/` — Irish national datasets

Every dataset here is used by the manuscript. Each is processed by a saved script in
`05.scripts/` that writes a small CSV to `02.inputs/derived/`, which the manuscript reads
with base `read.csv`. That two-stage split exists so the manuscript stays base-R and keeps
its "renders anywhere" property; see `tasks/Irish-data-sources.md`.

Nothing in this folder is committed. The derived CSVs are.

---

## `SIS/` — Irish Soil Information System, national soils map

| | |
|---|---|
| **Source** | Teagasc / EPA. Retrieved from the EPA GeoServer WFS on **2026-07-31**: `https://gis.epa.ie/geoserver/EPA/wfs`, layer `EPA:SOIL_SISNationalSoils`, `outputFormat=SHAPE-ZIP`, `srsName=EPSG:29902`. Archive kept as `sis-wfs-download.zip` (120,716,941 bytes). |
| **Licence** | **CC BY 4.0**, per the data.gov.ie record "Irish Soil Information System National Soils Map" |
| **Dimensions** | 25,143 polygons; **6,989,574 ha**, agreeing with the map's own stated hectares to 0.04%; TM65 Irish Grid, **EPSG:29902** |
| **Key fields** | `SOC` (numeric, association-level, 43 distinct values 108–317 t C/ha), `Drainage` (6 classes), `Texture` (7), `Depth` (3), `Associati0`/`Associati1` (association symbol and name), `Ha` |
| **Script** | `05.scripts/prep-irish-soils.R` → `derived/irish-soils-area-by-class.csv` |
| **Applied** | Results, "The national soils map has no carbon stock for peat". Establishes that **SOC is populated on only 67.7% of the mapped area and 92% of the peat is blank**, including a single blanket bog unit (`01_Bk`) of 1,643,401 ha across 3,754 polygons. That is the paper's structural claim, that there is no reference stock for peat, visible in the dataset a compiler would actually reach for. Also supplies the area-weighted mean mineral SOC of 141 t C/ha, above every Table 2.3 default available to Ireland. |

**Provenance warning.** The originally delivered copy was **missing its `.shp` and `.dbf`**;
only the `.shx`, `.prj`, `.CPG` and ArcGIS `.lyr` files arrived. Those were preserved
(`unzip -n`) and the two missing components added from the WFS. Three checks confirm the
same dataset: the service reported `numberMatched="25143"`, the delivered `.shx` is 201,244
bytes which at 8 bytes per record implies exactly 25,143 features, and the CRS matches.

**Schema discrepancy.** The delivered `README.txt` documents an earlier ArcGIS export whose
field names differ: `Associat_1`/`Associat_2`/`ha`/`DRAINAGE`/`TEXTURE`/`DEPTH` against the
WFS's `Associati0`/`Associati1`/`Ha`/`Drainage`/`Texture`/`Depth`, which also adds
`PlainEngli` and `URLtext`. Same data, different truncation. The script accepts either.

---

## `CRT/` — Ireland's Common Reporting Tables, 2026 submission

| | |
|---|---|
| **Source** | EPA, downloaded **2026-08-01** from `https://www.epa.ie/publications/monitoring--assessment/climate-change/air-emissions/IRL-CRT-2026-V1.0.zip` (40,816,340 bytes). **The UNFCCC mirror is behind a WAF that returns a JavaScript challenge to curl and to automated fetchers alike; use the EPA copy.** |
| **Dimensions** | 35 annual workbooks, **1990–2024**, 61 sheets each. Tables used: **4.D** (wetlands, on-site soil carbon stock change) and **4(II)** (emissions and removals from drainage and rewetting) |
| **Metrics** | Ireland reports at **AR5 GWP-100**: CH4 = 28, N2O = 265. Not AR6. |
| **Script** | `05.scripts/prep-irish-crt.py` → `derived/irish-crt-peat-balance.csv` |
| **Applied** | Results, "Ireland's own inventory, added up". Ireland splits the balance for a hectare of organic soil across two tables and neither alone is the answer; adding them is the arithmetic the guidance never requires. Yields the paper's strongest national result: rewetting industrial peat extraction is worth **+6.83 t CO2e/ha/yr at Ireland's own AR5 GWP-100 and −2.89 at AR6 GWP-20**, a sign flip inside a live national inventory. Also shows near-natural peatland, booked as a soil carbon removal, is a **net source of +1.46 t CO2e/ha/yr** once Ireland's own reported DOC and CH4 are added. |

**Use implied factors, not stated ones.** An earlier derivation used the 1.7 t CO2-C/ha/yr
factor that the inventory *document* states for industrial peat extraction. The **implied**
factor in the tables for 2024 is **3.587 t C/ha**, more than twice as large, and the
difference reverses the sign at GWP-100. Implied factors are emissions divided by area, so
they reconcile with the totals actually reported.

**Completeness gap, reported not smoothed.** Industrial peat extraction is 62.68 kha in
Table 4.D but 34.66 kha in Table 4(II). The 28.02 kha difference carries an on-site CO2 term
but no CH4 and no N2O.

---

## `Saltmarsh/` — NPWS Saltmarsh Monitoring Project

| | |
|---|---|
| **Source** | National Parks and Wildlife Service, Saltmarsh Monitoring Project 2006–2008, national resource layer revised 2011. `https://www.npws.ie/sites/default/files/general/saltmarsh-monitoring-project-2006-2008.zip`, downloaded 2026-08-01 (9,226,970 bytes) |
| **Dimensions** | 13,071 polygons, 7,788 ha total, **EPSG:29902** |
| **Key fields** | `H_EU_Code` (Annex I habitat code, and "Potential" prefix for desk-mapped polygons), `HABITAT`, `SMP_SITE`, `COUNTY`, `AREA__HA_` |
| **Strata computed** | Annex I confirmed **2,268 ha**; Annex I potential 1,903 ha; Spartina sward 1,343 ha; mudflat/sandflat 428 ha (**excluded, not saltmarsh**); other non-Annex 1,846 ha. Confirmed plus potential brackets McCorry & Ryle's published 3,774 ha. |
| **Script** | `05.scripts/prep-irish-saltmarsh-salinity.R` → `derived/irish-saltmarsh-salinity.csv` |
| **Applied** | Results, "How much Irish saltmarsh is exposed to the salinity gate". |

---

## `WaterBodies/` — EPA WFD transitional water bodies

| | |
|---|---|
| **Source** | EPA GeoServer WFS, layer `EPA:TWB_WFD_LatestStatus`, retrieved 2026-08-01 as `SHAPE-ZIP`, `srsName=EPSG:2157` |
| **Dimensions** | 195 polygons, Irish Transverse Mercator **EPSG:2157** |
| **Fields** | `European_C`, `Name`, `Status`, `Period_for` |
| **Applied** | The join partner for the saltmarsh layer. Each marsh polygon is assigned to the transitional water body it overlaps most, and salinity is attached where Inland Fisheries Ireland measured it. |

**The salinity values are not in either layer.** They are hand-encoded in the script from
Inland Fisheries Ireland, *Fish Stock Survey of Transitional Waterbodies around the Republic
of Ireland, 2015* (WFD-TW-Report-2015), **grey literature but a primary measurement source**,
covering **9 of 195** water bodies.

**Three limitations travel with any result from this join**, and are stated in the
manuscript as well as the script header:

1. These are **water-column** salinities at low-tide beach-seine stations, **not marsh soil
   porewater**, which is the quantity Table 4.14 names. Porewater is generally the fresher.
2. They are **single-survey ranges from 2015**, not annual means, which is why every
   classified hectare lands in the "spans 18 ppt" class rather than cleanly either side.
3. Only 9 of 195 water bodies were surveyed, so the result is a **lower bound on exposure**,
   never a total.

**Result:** of 2,268 ha of confirmed Annex I saltmarsh, **225 ha (9.9%)** sits in estuaries
recorded below 18 ppt at some point, where the Table 4.14 default costs 5.23 t CO2e/ha/yr
against a soil gain of 3.34 and the pathway becomes a net source. **90.1% cannot be
classified at all**: half in water bodies where salinity was never measured, two fifths
outside the transitional network entirely.
