# Veg Type (IPCC 2019): FAO Global Ecological Zones 2010

`gez_2010_wgs84.shp` · 21 polygons · global · EPSG:4326 · fields `gez_name`, `gez_code`,
`gez_abbrev`. `Veg Type (FAO 2010).zip` contains the same shapefile plus a methods PDF.

**USED** as the climate stratification, via a documented crosswalk to the IPCC climate zones
that Table 2.3 and Table 6.2 are keyed on.

**The crosswalk is an approximation and is stated as such wherever it is used.** FAO ecological
zones are built from vegetation and climate; IPCC climate zones are built from mean annual
temperature, precipitation, elevation and frost (2006 Guidelines Vol. 4 Ch. 3 Annex 3A.5). The
three *mountain system* zones are genuinely ambiguous because elevation moves a site between
IPCC zones in a way GEZ does not resolve, so every result is run twice with the mountain zones
assigned both ways. Boreal and Polar have no counterpart in the encoded Batjes table and are
reported as excluded area rather than dropped.

Crosswalk defined once in `05.scripts/prep-global-area-weights.py` and imported by the sibling
scripts so the two cannot drift apart.
