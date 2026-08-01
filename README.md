# ipcc-carbon-gains

**Countable is not beneficial: metric dependence in the IPCC Tier 1 soil carbon gain pathways for peatlands, coastal wetlands and improved grasslands**

Sole author: Seamus Murphy ([0000-0002-1792-0351](https://orcid.org/0000-0002-1792-0351)).
Target venue **Carbon Balance and Management** (Springer Nature, BMC imprint), guidelines
verified against the live journal pages 2026-07-30.

**Status:** full draft. IMRaD, roughly 7,700 words of prose, 17 tables, 3 figures, 40
references. Renders to HTML and DOCX.

> **The master is [`01.manuscript/ipcc-carbon-gains.qmd`](01.manuscript/ipcc-carbon-gains.qmd).
> Edit it, not the renders.** Every number in the paper is computed when the document is
> built, from IPCC default tables encoded in base R and from three derived CSVs. Nothing is
> typed in by hand.
>
> ```
> cd 01.manuscript && quarto render ipcc-carbon-gains.qmd --to html
> ```

---

## Abstract

**Background.** The 2013 IPCC Wetlands Supplement replaced Equations 2.24 and 2.26 of the 2006
Guidelines, which had implicitly assumed that organic soils can only lose carbon, and in doing
so introduced the first negative Tier 1 emission factors in the guidelines' history. Soil
carbon gains in peatlands, coastal wetlands and improved grasslands thereby became countable
in national inventories and creditable in principle. The pathways are scattered across two
supplements and five chapters, their duration rules differ by more than two orders of
magnitude, and no document in the corpus weights a pathway's carbon dioxide gain against its
methane and nitrous oxide costs. Whether a countable gain is a climate benefit therefore
cannot be determined from the guidance.

**Results.** We encode the default tables in base R, computing every figure at render time,
and subtract the rewetted flux from its drained counterfactual across thirteen land use,
climate and nutrient combinations. At GWP-100 the benefit is positive in every combination. At
GWP-20 five turn negative, all temperate or boreal: three Forest Land cases, nutrient-rich
temperate Grassland, and temperate peat extraction. Monte Carlo sampling of the published 95%
bounds puts the probability of a benefit below 0.95 for five of thirteen combinations even at
GWP-100. Beyond organic soils, tidal marsh flips to a net source below 18 ppt salinity, inland
wetland mineral soil rewetting is a net source in all six climate zones during its first
twenty-year block once Table 5.4 methane is charged, and fertilised improved grassland crosses
to a net source within decades because the soil gain is capped at twenty years while nitrous
oxide is perpetual. The Table 2.3 reference stocks are arithmetic means that exceed the robust
median in almost every cell.

**Conclusions.** A countable carbon gain is not equivalent to a climate benefit. For a
substantial minority of pathways the sign of the benefit is set by the emission metric and
horizon rather than by the emission factor. Inventory compilers and crediting programmes
should report the offsetting fluxes, the duration rule and the metric alongside any claimed
soil carbon gain.

---

## Figures

All three are written to [`03.outputs/figures/`](03.outputs/figures/) as a side effect of
rendering, so the files below are always the ones the current draft displays.

### Figure 1. The benefit of rewetting is metric-dependent

![Benefit of rewetting at GWP-100 and GWP-20](03.outputs/figures/fig-metric-dependence-1.png)

Benefit of rewetting across thirteen land use, climate and nutrient combinations, at two
horizons. Bars left of zero are cases where rewetting increases radiative forcing. **Nothing
changes between the two panels except the weighting applied to methane.** Every combination is
positive at GWP-100; five turn negative at GWP-20, and all five are temperate or boreal.

### Figure 2. Duration rules span more than two orders of magnitude

![Annual gain against claimable duration](03.outputs/figures/fig-duration-asymmetry-1.png)

Annual gain against the years over which it may be claimed, on a logarithmic axis. Two
pathways with the same annual factor are not the same asset if one runs for twenty years and
the other to a stock ceiling two centuries away, yet nothing in the guidance requires the
duration rule to be reported alongside the factor.

### Figure 3. A default that fails in opposite directions on the same hectares

![Irish factors as a ratio to Tier 1 defaults](03.outputs/figures/fig-ireland-both-directions-1.png)

Irish country-specific factors as a ratio to the Wetlands Supplement temperate default. A
ratio of one is agreement. **Carbon dioxide sits below the line and methane above it for the
same hectares**, so no single adjustment to the default can be conservative for both gases.

---

## Results, in the order they appear

### Methods

| # | Table | What it establishes |
|---|---|---|
| 1 | AR6 Table 7.15 metrics | Biogenic CH4 at 27.0 (GWP-100) and 79.7 (GWP-20); N2O at 273. Not the molar-mass-adjusted figure |
| 2 | Rewetted organic soils, absolute flux | **A model input, not a result.** Every zone is a net source in absolute terms, because wet peat emits methane |

### Results, global

| # | Table | Headline |
|---|---|---|
| 3 | Benefit of rewetting, 13 combinations | GWP-100 **+1.26 to +54.54**, no negative case. GWP-20 **−13.17 to +54.40**, five negative |
| 4 | Monte Carlo, 10,000 triangular draws | P(benefit > 0) below 0.95 for **5 of 13** rows even at GWP-100, and a different five |
| 5 | Coastal wetland soil carbon | Mangrove 5.94, tidal marsh 3.34, seagrass 1.58 t CO2/ha/yr. **Only tidal marsh flips** below 18 ppt |
| 6 | Inland wetland mineral soils | Net source in **6 of 6** climate zones in years 1–20, and 5 of 6 in years 21–40 |
| 7 | Improved grassland gains | 0.92 to 6.71 t CO2/ha/yr from nominal; 1.97 to 14.30 from severely degraded |
| 8 | Nitrogen break-even and crossover | 5.894 kg CO2e per kg N at the IPCC default. Every fertilised grassland crosses eventually |
| 9 | Ten most biased Table 2.3 cells | Mean exceeds median in **34 of 37** cells; median bias 13.0%, maximum 154.5% |
| 10 | The countable gain ledger | 8 pathways, 4 distinct duration rules, gains 1.25 to 14.30 t CO2/ha/yr |

### Results, Ireland

| # | Table | Headline |
|---|---|---|
| 11 | Irish factors against Tier 1 | Drained nutrient-poor grassland: CO2 **4.0× below** the default, CH4 **6.3× above** it |
| 12 | Irish rewetting benefit | **Both** pathways negative at GWP-100 and worse at GWP-20, on factors Ireland has adopted |
| 13 | The nitrogen trap, measured factor | Crossover moves from **year 30 under CAN to year 73 under protected urea** |
| 14 | National soils map SOC coverage | SOC populated on **67.7%** of the mapped area; **92% of the peat is blank** |
| 15 | Ireland's own inventory, added up | Benefit **+6.83 at AR5 GWP-100** (Ireland's own metric), **−2.89 at AR6 GWP-20** |
| 16 | Saltmarsh by salinity class | **225 ha (9.9%)** exposed to the sub-18 ppt default; **90.1% unclassifiable** |
| 17 | Methane under three metrics | GWP\* charges a sustained flux **0.28×** its GWP-100 value beyond year 20 |

Two further results are load-bearing and sit in prose rather than a table. Ireland's
**near-natural peatland**, booked as a soil carbon removal, is a **net source of +1.46 t
CO2e/ha/yr**, about 1.3 Mt nationally, once Ireland's own reported dissolved organic carbon
and methane are added. And the **EU adopted its carbon farming certification methodology on
9 July 2026**, which forbids default emission factors for organic soils outright, requires
methane to be quantified rather than assumed, prices the post-rewetting methane transient at
10 t CO2e/ha/yr for five years, and caps the crediting horizon at the physical exhaustion of
the peat.

---

## Datasets used

| Dataset | Source and licence | Dimensions | Applied to |
|---|---|---|---|
| **IPCC 2013 Wetlands Supplement** | IPCC. Tables 2.1–2.5, 3.1–3.3, 4.11–4.14, 5.2–5.4 | ~15 tables, encoded into the manuscript | The whole global ledger: drained and rewetted organic soils, coastal, inland mineral |
| **IPCC 2019 Refinement, Vol. 4** | IPCC. Tables 2.3 and 6.2, Chapter 11 | 42 reference-stock cells; grassland management and input factors | Mineral soil stock-change; the nitrogen trap |
| **Batjes (2010, 2011)** | ISRIC Report 2010/10; *Agric. Ecosyst. Environ.* 142 | 37 climate × soil cells, means and medians | Table 2.3 defaults exceed the robust median in 34 of 37 cells |
| **Irish Soil Information System** | Teagasc/EPA via EPA GeoServer WFS. **CC BY 4.0** | 25,143 polygons, 6,989,574 ha, EPSG:29902 | The peat has no reference stock: SOC blank on 92% of it |
| **Ireland's Common Reporting Tables** | EPA, `IRL-CRT-2026-V1.0` | 35 workbooks 1990–2024; Tables 4.D and 4(II) | The sign flip inside a live national inventory |
| **NPWS Saltmarsh Monitoring Project** | NPWS, 2006–2008, revised 2011 | 13,071 polygons, 7,788 ha, EPSG:29902 | Saltmarsh exposure to the salinity gate |
| **EPA WFD transitional water bodies** | EPA GeoServer, `EPA:TWB_WFD_LatestStatus` | 195 polygons, EPSG:2157 | Join partner for the saltmarsh layer |
| **Inland Fisheries Ireland (2015)** | `WFD-TW-Report-2015`. **Grey literature** | Salinity at seine stations, **9 of 195** water bodies | The salinity classification. A lower bound: water-column, not porewater |
| **Aitova et al. (2023)** | *Mires and Peat* 29:04, Table 2 | Irish country-specific Tier 2 factors | The both-directions failure; the Irish rewetting benefit |
| **Harty et al. (2016)** via NID 2025 | *Sci. Total Environ.* 563-564 | Grassland EF1 by fertiliser formulation | The Irish nitrogen crossover and its formulation escape hatch |
| *(acquired, unused)* FAO GEZ, HWSD/WRB soils, GLWD | see [`02.inputs/IPCC/README.md`](02.inputs/IPCC/README.md) | global | **Not used.** Retained in case the study extends to a second country |

Per-folder provenance, dimensions and application:
[`02.inputs/IPCC/README.md`](02.inputs/IPCC/README.md) ·
[`02.inputs/IRL/README.md`](02.inputs/IRL/README.md) ·
[`02.inputs/derived/README.md`](02.inputs/derived/README.md) ·
full survey in [`02.inputs/MANIFEST.md`](02.inputs/MANIFEST.md).

---

## How it fits together

Raw data never enters the render. A saved script in `05.scripts/` does the spatial and
spreadsheet work and writes a small CSV to `02.inputs/derived/`; the manuscript reads that CSV
with base `read.csv` and does the IPCC arithmetic in chunks that stay visible in the output.
That keeps the manuscript dependency-free and keeps the project rule that **no number may be
quoted from code that was not saved**.

| Script | Reads | Writes |
|---|---|---|
| `prep-irish-soils.R` | Irish Soil Information System shapefile | `derived/irish-soils-area-by-class.csv` |
| `prep-irish-crt.py` | 35 CRT workbooks | `derived/irish-crt-peat-balance.csv` |
| `prep-irish-saltmarsh-salinity.R` | NPWS saltmarsh + EPA water bodies | `derived/irish-saltmarsh-salinity.csv` |

Raw inputs are **not committed**: the tree is 2.9 GB and three files exceed GitHub's 100 MB
limit. The derived CSVs are committed, because they are what the paper cites.

## Repository layout

| Folder | Contents |
|---|---|
| `01.manuscript/` | The master `.qmd` and its HTML and DOCX renders |
| `02.inputs/` | Raw data (gitignored), per-folder READMEs, and the committed `derived/` CSVs |
| `03.outputs/` | Figures, written at render time |
| `04.references/` | `references.bib` (53 entries) and the CSL style |
| `05.scripts/` | Pre-processing, one script per dataset |
| `tasks/` | Task requests, research design, evidence base |
| `docs/` | Quote-backed prior-work notes, including the Ireland evidence base |

## Known gaps

- **Citation style.** `apa.csl` is still in place; the venue requires **Vancouver**. The switch
  happens at submission prep, not during drafting.
- **The EU delegated act has no CELEX number yet.** It is inside its scrutiny window. Re-check
  EUR-Lex after roughly 9 September 2026 and replace the working citation.
- **One question outstanding with the EPA**: the nutrient split of the 44,527 rewetted
  hectares, which would settle whether the methane factor was converted from kg CH4-C to
  kg CH4. If it was not, the rewetted side is understated by a third.
- **Uncertainty propagation** covers the organic soil benefit only. The coastal, inland
  mineral, grassland and Irish pathways have none.
- **Polar and Boreal rows** of Table 2.3 are not encoded.

## Corrections carried in the record

`IPCC-2010-Erata-Land-Climate-Soil-Carbon-Classification.pdf` is **not an IPCC document and
not an erratum**. It is EU Commission Decision 2010/335/EU under the Renewable Energy
Directive, and its Table 1 is a verbatim copy of IPCC 2006 Table 2.3. The real 2010 event is
the IPCC Expert Meeting in Geneva that October, which led to the Wetlands Supplement.

There was never an immediate-100%-oxidation default for **soil** carbon. The 20-year linear
transition dates to the 1996 Guidelines and was restated in 2003 and 2006. The immediate-loss
assumption applies to **biomass**.

An earlier derivation of the Irish inventory result used the emission factor the inventory
*document* states, 1.7 t CO2-C/ha/yr. The **implied** factor in the reporting tables is 3.587,
and the difference reverses the sign at GWP-100. A stated factor and an implied factor can
differ by a factor of two in the same submission; compute from the tables.

## Licence and data

Third-party guidance documents and reports are not redistributed here.
[`04.references/README.md`](04.references/README.md) records provenance and retrieval for each.
