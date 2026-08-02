# EPA WFD transitional water bodies

**Source.** EPA GeoServer WFS, layer `EPA:TWB_WFD_LatestStatus`, retrieved 2026-08-01 as
`SHAPE-ZIP`, `srsName=EPSG:2157`.

**Dimensions.** 195 polygons · Irish Transverse Mercator **EPSG:2157** · fields `European_C`,
`Name`, `Status`, `Period_for`.

**Applied as** the join partner for the saltmarsh layer in `../Saltmarsh/`. Each marsh polygon
is assigned to the transitional water body it overlaps most.

**The salinity values are in neither layer.** They are hand-encoded in the script from Inland
Fisheries Ireland, *Fish Stock Survey of Transitional Waterbodies around the Republic of
Ireland, 2015* (WFD-TW-Report-2015), **grey literature but a primary measurement source**,
covering **9 of 195** water bodies.

**Three limitations travel with any result from this join:**

1. These are **water-column** salinities at low-tide beach-seine stations, **not marsh soil
   porewater**, which is the quantity Table 4.14 names. Porewater is generally the fresher.
2. They are **single-survey ranges from 2015**, not annual means, which is why every classified
   hectare lands in the "spans 18 ppt" class rather than cleanly either side.
3. Only 9 of 195 were surveyed, so the result is a **lower bound on exposure**, never a total.

**Result:** of 2,268 ha of confirmed Annex I saltmarsh, **225 ha (9.9%)** sits in estuaries
recorded below 18 ppt; **90.1% cannot be classified at all**.
