# Irish data sources for the national worked example

Recorded 2026-07-30. Supplied by Seamus, who also holds local copies. **Not yet fetched or
verified**; the availability check was stopped mid-run. Verify each before use.

## How incoming data enters the manuscript: two stages, deliberately separated

**The manuscript must stay base-R.** `01.manuscript/ipcc-carbon-gains.qmd` declares "no
external packages beyond knitr, so the document renders anywhere", and that property is worth
keeping: it is why the executable manuscript is reproducible without an environment spec.
Spatial work needs `sf`, `terra` or `geopandas`, none of which belong in the render.

So the Irish arm runs in two stages:

1. **Pre-process, outside the render.** A saved, committed script in `02.inputs/` reads the
   spatial or tabular source, does the CRS work, overlays, zonal statistics or unit
   conversion, and writes a **small tidy CSV** of derived quantities: areas by class, mean
   stocks by zone, application rates. This script may use `sf`, `terra`, `exactextractr`,
   `geopandas`, `rasterio` or the GDAL CLI, all of which are installed and confirmed working
   on this machine.
2. **Consume, inside the render.** The `.qmd` reads that CSV with base `read.csv` and does
   the IPCC arithmetic in visible chunks, exactly as every existing section does.

This keeps the repo-root rule intact: **never report a number from code that was not saved.**
The pre-processing script is the saved code, the CSV is its committed output, and the
manuscript cites the CSV. Ad-hoc terminal work on the incoming files does not qualify and
must be written into the script before any figure it produces is quoted.

Environment confirmed 2026-07-30: R 4.4.1 at `/usr/local/bin/R` with `sf`, `terra`, `stars`,
`exactextractr`, `tmap`; Python 3.12 with `geopandas` 1.1.1, `rasterio` 5.0, `fiona`,
`pyproj`; `ogr2ogr` and `gdalinfo` at `/opt/local/bin/`. No new environment is needed.
Note `xarray` and `netCDF4` are **absent**; install with `sudo port install py312-xarray
py312-netcdf4` if a NetCDF source arrives.

## Irish Soil Information System (SIS)

The national soils map, produced by Teagasc with EPA funding. Gives soil associations and
series, which is the route to the IPCC soil classes (HAC, LAC, SAN, VOL, WET) needed for
Equation 2.25, and identifies organic soils and peats for the flux-based pathway.

| Source | URL |
|---|---|
| data.gov.ie dataset record | https://data.gov.ie/ga/dataset/irish-soil-information-system-national-soils-map |
| Teagasc SIS programme page | https://teagasc.ie/environment/soil/irish-soil-types-and-maps/irish-soil-information-system/ |
| Teagasc soils web GIS | https://gis.teagasc.ie/soils/ |
| EPA GeoNetwork metadata record | https://gis.epa.ie/geonetwork/srv/eng/catalog.search#/metadata/2cd0c5e9-83b2-49a9-8c3e-79675ffd18bf |
| EPA GeoNetwork API record | https://gis.epa.ie/geonetwork/srv/api/records/2cd0c5e9-83b2-49a9-8c3e-79675ffd18bf |

Use the API record rather than the catalog search URL when scripting: the `#/metadata/`
form is a client-side fragment and will not resolve server-side.

## What still needs establishing

1. **Scale and resolution** of the national soils map, and whether SOC concentration and
   bulk density accompany the polygons or only soil type.
2. **Organic soil area**, drained versus intact versus rewetted. Whether Ireland reports
   this in CRT Table 4(II).
3. **Saltmarsh extent and any Irish carbon data.** This is the arm most likely to fail.
   NPWS saltmarsh survey is the place to look.
4. **Grassland nitrogen application rates**, kg N/ha/yr, dairy versus drystock. Teagasc
   National Farm Survey and the fertiliser use survey. This is the single most important
   number for the nitrogen crossover.
5. **Aitova et al. (2023)**, *Mires and Peat* 29:04, the Irish peatland flux compilation:
   how many sites, which land uses, and whether the underlying data are released.
6. **Ireland's CRT submission**, and whether it uses Tier 1 defaults or country-specific
   factors for drained and rewetted organic soils.

Note from the interrupted check: the Teagasc SIS API returned HTTP 500. Try the
data.gov.ie and EPA GeoNetwork routes, or Seamus's local copies.
