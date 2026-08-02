# Wetlands (GLWD 2023): mislabelled, contains no wetlands

**NOT USED. Recommend deletion.**

`glwd_2.shp` opens with 244,892 features whose `TYPE` field takes exactly three values:
**Lake, Reservoir and River**. There is no wetland class in it. The `.dbf` last-update stamp is
**2003-05-20**.

That identifies it as **Level 2 of the original Global Lakes and Wetlands Database** (Lehner &
Döll, 2004), the large-waterbody polygon layer. In that database the wetlands are in **Level 3**,
a 30-arcsecond raster. The folder name promises GLWD **2023**, meaning GLWD v2, a different and
much later product. `GLWD_level2.zip` is the same data, not a newer version.

It also carries **no CRS** (`Layer SRS WKT: (unknown)`).

Global wetland extent for this project comes from HWSD Gleysols instead, in
`../Soil Type (IPCC 2019)/`, which gives 12,976 polygons and 470 Mha.
