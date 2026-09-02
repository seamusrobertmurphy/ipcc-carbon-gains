# ipcc-carbon-gains

**Soil carbon gains and offsets under updated IPCC Tier 1 methods for organic soils, coastal wetlands and improved grasslands**

*Stock-change and flux-based accounting with Irish national data*

Seamus Murphy ([0000-0002-1792-0351](https://orcid.org/0000-0002-1792-0351)). Target venue **Catena** (Elsevier), Original Research Paper.

The master is [`01.manuscript/Manuscript.qmd`](01.manuscript/Manuscript.qmd), an executable Quarto document. Every emission factor and reference stock is encoded from the published IPCC tables in base R and every number the paper reports is computed when the document is rendered. Nothing is typed in by hand.

    cd 01.manuscript && quarto render Manuscript.qmd

The render needs R with knitr and nothing else, and takes about fifteen seconds. It writes `Manuscript.html` for checking and `Manuscript.docx` for submission, with the figures under `03.outputs/figures/`. Two saved steps run after every render, `05.scripts/finish-docx.py`, which sets the table row heights and alignment in the Word file, and `05.scripts/make-submission-files.py`, which rebuilds the figures, tables, cover letter, highlights and declaration files from the render. The maps are drawn separately by `05.scripts/make-input-maps.R`, which needs sf and terra.

## Abstract

Since 2013 the IPCC Guidelines have allowed a country to report a soil carbon removal when it rewets drained peatland, restores a tidal marsh or mangrove, or improves grassland management. This study asked whether those removals are climate benefits once the methane and nitrous oxide emitted from the same land are counted. The default emission factors and reference stocks were encoded, the emissions after rewetting subtracted from those of continued drainage across thirteen cases, and the gases weighted at hundred-year and twenty-year global warming potentials with the published 95 per cent ranges propagated by Monte Carlo. Three problems were found. First, whether rewetting reduced or increased warming depended on the horizon chosen rather than on the emission factors, since five of thirteen peatland cases changed sign between GWP100 and GWP20 and the same five fell below a 0.95 probability of benefit at GWP100. Second, the default reference stocks lay above the median of their own source profiles in 34 of 37 cells, by 13 per cent at the median, and the range printed beside each default describes the precision of a global mean rather than the distance of any site from it, so the bias cannot be seen from within the method. Third, Ireland's country-specific emission factors showed the defaults biased in opposite directions for carbon dioxide and methane on the same land. A soil carbon removal reported in a national inventory is therefore not evidence of a climate benefit, and the guidance gives no test that separates the two.

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
| Printed error against profile spread | Median printed ±13.4 per cent against a median CV of 54.9; a single site's 95 per cent range is about ±108, eight times the printed figure |
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
| `05.scripts/make-input-maps.R` | the six-map Irish panel, the separate maps, and `irish-input-map-checks.csv` |

Provenance per dataset is in `02.inputs/MANIFEST.md` and the READMEs under `02.inputs/`.

## Submission files

All in `01.manuscript/`, and all rebuilt from the render by the post-render scripts.

| File | Purpose |
|---|---|
| `Manuscript.docx` | The manuscript, A4, double spaced, line and page numbered, single column, with the IPCC equations in the Guidelines' own layout |
| `Figures.docx` | The four main-text figures with their rendered captions |
| `Tables.docx` | The supplementary material, Tables S1 to S15 |
| `Cover Letter.docx` | Cover letter to the Editors-in-Chief of Catena, from `Cover Letter - Murphy 2026 Catena.md` |
| `Highlights - Murphy 2026 Catena.docx` | Five highlights, each under 85 characters |
| `Declaration of Competing Interest - Murphy 2026 Catena.docx` | Separate declaration, title copied from the manuscript |
| `../04.references/references.bib` | 73 entries, 51 cited; journal papers verified against CrossRef, IPCC chapters cited by chapter with their printed author lists |
| `../04.references/elsevier-harvard.csl` | Elsevier author-date style |
| `../04.references/style-catena.docx` | Word reference document with A4, double spacing, line numbering, the table style and the equation style |

## Layout

| Folder | Contents |
|---|---|
| `01.manuscript/` | Master `.qmd`, its Word render, and the submission files |
| `02.inputs/` | Raw data (ignored by git), per-folder READMEs, committed derived CSVs |
| `03.outputs/` | Figures, written at render time |
| `04.references/` | Bibliography, citation style and Word reference documents |
| `05.scripts/` | Pre-processing, one script per dataset |

Third-party guidance, standards, reports and cited PDFs are not committed; `04.references/README.md` records what they are and where they came from.
