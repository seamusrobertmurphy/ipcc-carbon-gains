# ipcc-carbon-gains

**Soil carbon gains and their greenhouse gas offsets under updated IPCC Tier 1 methods for organic soils, coastal wetlands and improved grasslands**

*Stock-change and flux-based accounting with Irish national data*

Seamus Murphy ([0000-0002-1792-0351](https://orcid.org/0000-0002-1792-0351)). Target venue **Catena** (Elsevier), Original Research Paper.

The master is [`01.manuscript/Manuscript.qmd`](01.manuscript/Manuscript.qmd), an executable Quarto document. Every emission factor and reference stock is encoded from the published IPCC tables in base R and every number the paper reports is computed when the document is rendered. Nothing is typed in by hand.

    cd 01.manuscript && quarto render Manuscript.qmd

The render needs R with knitr and nothing else, and takes about fifteen seconds. It writes `Manuscript.html` for checking and `Manuscript.docx` for submission, with the figures under `03.outputs/figures/`.

## Abstract

Since 2013 the IPCC methods have let a country report a soil carbon gain on rewetted peatland, restored coastal wetland and improved grassland, and no study has set those gains against the methane and nitrous oxide the same soils emit. The default tables were encoded, the rewetted flux subtracted from its drained counterfactual across thirteen cases at hundred-year and twenty-year horizons, and the published bounds propagated by Monte Carlo. Every case benefited at the point estimates over a hundred years, but resampling put the probability of benefit below 0.95 in five, which turned negative at twenty years, all temperate or boreal. Rewetted wetland mineral soil and restored brackish tidal marsh were net sources in absolute terms, and fertilised improved grassland became one because a twenty-year gain meets a perpetual penalty. In Ireland's inventory the same pathway gained about seven tonnes of carbon dioxide equivalent per hectare a year over a century and cost nearly three over twenty, on unchanged factors. The published reference stocks exceeded the median of their own source profiles in 34 of 37 cells, by 13 per cent at the median, the printed interval was the precision of a global mean, about an eighth of the range a single parcel faces, and the Irish factors ran opposite to the defaults for the two gases on the same land. A reported soil carbon gain is therefore not a climate benefit, and neither the metric dependence nor the bias appears in the interval printed beside the default.

## Results

All values are computed at render time and read from the current render. Positive is a removal unless stated.

| Result | Value |
|---|---|
| Benefit of rewetting, 13 organic soil cases, GWP-100 | +1.26 to +54.54 t CO2e/ha/yr, no negative case |
| Same cases at GWP-20 | −13.17 to +54.40, five negative, all temperate or boreal |
| Monte Carlo, 10,000 draws on the published bounds | P(benefit > 0) below 0.95 in 5 of 13 at GWP-100, the same five |
| Coastal soil gain | Mangrove 5.94, tidal marsh 3.34, seagrass 1.58 t CO2/ha/yr; mangrove headroom 238 years |
| Tidal marsh below 18 ppt | −1.89 in absolute terms, +27.08 against the drained state |
| Inland wetland mineral soil rewetting | Net source in 9 of 9 climate regions in years 1 to 20, 8 of 9 in years 21 to 40 |
| Improved grassland gain | 0.92 to 6.71 t CO2/ha/yr from nominal, 1.97 to 14.30 from severely degraded |
| Nitrogen penalty | 5.894 kg CO2e per kg N; crossover at year 31 for the low case at 100 kg N/ha/yr |
| Reference stocks, Table 2.3 against Batjes | Mean exceeds median in 34 of 37 cells, median 13.0 per cent, maximum 154.5 |
| Area-weighted | Mean excess 18.6 per cent unweighted, 15.5 weighted by mapped area |
| Printed error against profile spread | Median printed ±13.4 per cent against a median CV of 54.9; a single parcel's 95 per cent range is about ±108, eight times the printed figure |
| 2006 to 2019 | The 2006 ±90 per cent was two standard deviations, a dispersion; the 2019 figure is 1.96 standard errors, a precision |
| Ireland, industrial peat extraction, from the CRT | Benefit +7.02 t CO2e/ha/yr at AR6 GWP-100, −2.89 at GWP-20, no factor changed |
| Ireland, near-natural peatland | Reported as a removal; net source of 1.4 t CO2e/ha/yr, about 1.2 Mt, once reported DOC and methane are added |
| Ireland, drained nutrient-poor grassland | CO2 factor 4.0 times below the default, CH4 factor 6.3 times above it |
| Ireland, nitrogen crossover at 180 kg N/ha/yr | Year 29 under calcium ammonium nitrate, year 70 under protected urea |
| Ireland, national soils map | No carbon value on 32 per cent of the mapped area and 92 per cent of the peat |
| Ireland, saltmarsh | 238 ha (10.5 per cent) below 18 ppt; 89.5 per cent cannot be classified |
| GWP* | A sustained methane flux is charged 0.28 of its GWP-100 value beyond year 20 |

The global ledger covers eight pathways. Scale calculations are in the supplement and are bounds, not estimates. The 5 arc-minute IPCC soil layer holds 131 Mha of Histosols and 398 Mha of Gleysols within the Wetlands Supplement zones, and over Ireland it finds 0.71 Mha of organic soil where the national map records 1.90 Mha of peat.

## Datasets and scripts

Raw inputs never enter the render. A saved script writes a small CSV under `02.inputs/derived/`, and the manuscript reads it with base `read.csv`.

| Script | Writes |
|---|---|
| `05.scripts/prep-irish-soils.R` | `irish-soils-area-by-class.csv` |
| `05.scripts/prep-irish-crt.py` | `irish-crt-peat-balance.csv` |
| `05.scripts/prep-irish-saltmarsh-salinity.R` | `irish-saltmarsh-salinity.csv` |
| `05.scripts/prep-global-area-weights.py` | `global-area-by-zone-soil.csv` |
| `05.scripts/prep-global-pathway-areas.py` | `global-pathway-areas.csv` |
| `05.scripts/make-input-maps.R` | the map figures and `irish-input-map-checks.csv` |

Provenance per dataset is in `02.inputs/MANIFEST.md` and the READMEs under `02.inputs/`.

## Submission files

| File | Purpose |
|---|---|
| `01.manuscript/Manuscript.docx` | The manuscript, double spaced, line and page numbered, single column |
| `01.manuscript/Highlights - Murphy 2026 Catena.docx` | Five highlights, each under 85 characters |
| `01.manuscript/Declaration of Competing Interest - Murphy 2026 Catena.docx` | Separate declaration, as Catena requires |
| `04.references/references.bib` | 65 entries, 42 cited, all verified against CrossRef |
| `04.references/elsevier-harvard.csl` | Elsevier author-date style |
| `04.references/style-catena.docx` | Word reference document with double spacing and line numbering |

## Layout

| Folder | Contents |
|---|---|
| `01.manuscript/` | Master `.qmd`, its Word render, and the submission files |
| `02.inputs/` | Raw data (ignored by git), per-folder READMEs, committed derived CSVs |
| `03.outputs/` | Figures, written at render time |
| `04.references/` | Bibliography, citation style and Word reference documents |
| `05.scripts/` | Pre-processing, one script per dataset |

Third-party guidance, standards, reports and cited PDFs are not committed; `04.references/README.md` records what they are and where they came from.
