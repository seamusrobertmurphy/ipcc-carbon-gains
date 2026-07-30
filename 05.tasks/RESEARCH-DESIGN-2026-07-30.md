# Research design: the uncertainty gate on soil carbon crediting

Drafted 2026-07-30. Sole author: Seamus Murphy. Co-authors to be invited once the
draft is developed and lead authorship is settled.

Target venue: **Carbon Balance and Management**. Guidelines to be verified against
the live journal pages before any formatting decision is taken.

---

## 1. The question

Wetland, peatland and grassland soil carbon are largely absent from both national
greenhouse gas inventories and carbon crediting programmes. The usual explanation is
that the methods do not exist or the data are missing. Neither survives inspection.
The methods exist: the 2013 Wetlands Supplement gives flux-based Tier 1 emission
factors for drained and rewetted organic soils, and the 2019 Refinement gives updated
stock change factors for improved grassland. The data exist: 117 Parties report
organic soil areas in machine-readable form, and global spatial products cover peat
extent, mangrove extent, drained organic soil area and soil carbon stock.

So the research question is not whether the opportunity exists. It is why it is not
taken.

> **RQ.** Why are wetland, peatland and grassland soil carbon pools systematically
> excluded from greenhouse gas accounting and carbon crediting, and under what
> conditions does including them become viable?

**Thesis.** Exclusion is not explained by the size of the pool, nor by the reason
that reporting entities give for it. It is explained by the interaction between the
uncertainty attached to IPCC default factors and the conservativeness rules that
crediting standards impose. Those rules deduct credits in proportion to uncertainty.
A large, uncertain pool is therefore worth less than a small, certain one, and past a
threshold it is worth nothing at all. Rational actors exclude it. The opportunity is
real and it is unbankable, and those two facts have the same cause.

## 2. Hypotheses

**H1. Magnitude is not the filter.**
The probability that a pool is reported Not Estimated is uncorrelated with, or
positively correlated with, that pool's estimated magnitude. Excluded pools are not
systematically smaller than included ones.
*Falsified if* excluded pools are systematically smaller, which would mean exclusion
is ordinary materiality triage and there is no paper.

**H2. Uncertainty is the filter.**
P(Not Estimated) increases monotonically with the uncertainty attaching to the IPCC
default factors for that pool, climate zone and soil class, controlling for magnitude,
land area and reporting capacity.
*Identification:* the predictor is the uncertainty in the IPCC default tables
themselves (Table 2.3 SOCref, ±5% to ±90%; Table 6.2 stock change factors, ±7% to
±40%; 2013 Wetlands Supplement organic soil emission factors), not uncertainty
reported by the country. Country-reported uncertainty exists only for pools the
country estimated, so using it would condition on the outcome. The default value is
defined for every pool whether estimated or not, and it is the right counterfactual:
it is the uncertainty a Party would face if it used Tier 1, which is the decision
being modelled.

**H3. The stated justification does not hold.**
Where "lack of data" is given as grounds for exclusion, sufficient public data exist
to produce a Tier 1 estimate. Quantified as the share of Not Estimated party-pool
cells for which WoSIS measured profiles, PEATGRIDS, FAO DROSA and Global Mangrove
Watch jointly supply the activity data and stock terms a Tier 1 calculation requires.

**H4. Inventory exclusion propagates into crediting exclusion.**
ART TREES §4.5 requires that a credited pool be estimated at no lower a tier than the
national inventory uses. A pool marked Not Estimated in the inventory is therefore
excluded from crediting in the same jurisdiction. Inventory exclusion is a sufficient
condition for crediting exclusion, which makes the inventory the upstream bottleneck
and gives the paper a specific intervention point.

**H5. The deduction gate. (The punchline.)**
Under each standard's own uncertainty deduction rule, applying IPCC Tier 1 defaults
to organic soil pools yields net creditable volume that is negative or negligible.
Formally, for pool p and jurisdiction j:

```
net(p, j) = ER(p, j) x (1 - D(u(p)))
```

where `D(.)` is the standard's deduction function. There exists a threshold `u*` above
which `net <= 0`. Organic soil defaults sit above `u*` for most standards, so no
rational developer proposes them.

**H6. The defaults are biased, not merely uncertain.**
IPCC Table 2.3 SOCref defaults are the arithmetic means of skewed distributions and
exceed the robust median in the great majority of cells, with the largest divergence
falling on wetland, volcanic and tropical montane classes, which are exactly the
systems being excluded.
*Status: already tested and confirmed* in
`02.inputs/batjes-2010-socref-mean-vs-median.R`. The mean exceeds the median in 34 of
37 cells (92%), median bias 13.0%, range -3.5% to +154.5%, with warm temperate dry
volcanic at +154.5%, warm temperate moist wetland at +43.6% and tropical montane
wetland at +41.4%.
*Consequence:* a jurisdiction that does include these pools overstates both its stocks
and its losses, which inflates apparent mitigation potential at the same moment the
deduction removes it.

**H7. The deduction rules are calibrated against the wrong quantity.**
The stated ± in Table 2.3 is a 95% confidence interval on the mean, `1.96 x SE / mean`.
It therefore shrinks with sample size and is decoupled from how much the soils actually
vary. The coefficient of variation of the underlying profiles has a median of 54.9%
across cells, against stated errors as low as ±5%.
*Consequence:* a pool can pass a standard's uncertainty gate while being far less
certain than the gate believes, and conservativeness deductions are being computed
against a precision statistic rather than a dispersion statistic. If H7 holds, the
architecture is not merely strict, it is measuring the wrong thing.

**Corroborating natural experiment.** H5 predicts near-zero uptake of methodologies
that require exactly these pools, and that is what is observed. VM0036, Rewetting
Drained Temperate Peatlands, has been active since July 2017 and reportedly has zero
registered projects in nine years. The Paris Agreement Crediting Mechanism has
approved two methodologies in total and neither concerns wetlands, peatland or soil
carbon. These are the observable consequence of the gate, not anecdotes.

## 3. Design

Unit of analysis: **Party x land-use category x carbon pool x inventory year**.

Scope is deliberately wide: all six pools across all six land-use categories, not
only the target systems. Biomass pools carry low default uncertainty and are almost
always included; organic soil pools carry high uncertainty and are almost always
excluded. That spread is the identifying variation for H2. Restricting the sample to
the excluded systems would compress the predictor into its high range and attenuate
the effect the study is trying to detect.

Three layers:

1. **Inventory layer (the population).** UNFCCC Common Reporting Tables, notation
   keys retained as the outcome variable.
2. **Crediting layer (the monetising subset).** Jurisdictions and methodologies under
   ART TREES, Verra, ACR, CAR, FCPF, ISFL and PACM, coded for pool inclusion and for
   the stated justification of each exclusion.
3. **Spatial layer (magnitude).** Zonal statistics over existing global products to
   estimate area and carbon at stake per excluded pool per jurisdiction. Google Earth
   Engine is used for reduction and Monte Carlo sampling only, not for new mapping.

## 4. Data, with the access reality

### 4.1 Inventory layer

**Do not build on the UNFCCC DI interface.** It is a dead end for this study, and the
failure is not obvious until the pipeline is written. Its non-Annex I side uses the
1996 IPCC category tree, which has no Wetlands land-use category, no drained/rewetted
split and no separate soil carbon pool. It ends at inventory year 2021 and in practice
at 2016 for developing countries: a query across soil and land-use-change categories
for ten major forest countries returned 342 records in total. It is also fronted by a
rate limiter that returns HTTP 200 with a challenge page instead of data, so a naive
client records silent empties.

**Parse the CRT workbooks directly.** Each Party publishes a ZIP of one XLSX per
inventory year, 60 sheets per workbook, one per reporting table. The tables this study
needs, confirmed present and machine-readable:

| Sheet | What it carries |
|---|---|
| `Table4.A`–`Table4.F` | Per land-use category. Area of mineral soil and area of organic soil in kha, and soil carbon as a **separate pool**, split mineral/organic, alongside living biomass, dead wood and litter. |
| `Table4.D` | Wetlands: remaining wetlands, peat extraction, flooded land, other wetlands including coastal, and land converted to wetlands. |
| `Table4(II)` | **The key table.** Drainage and rewetting. Rows for total, drained and rewetted organic soils and rewetted mineral soils, with area, implied emission factors for CO2, N2O-N and CH4, and emissions. |
| `Table4.1` | Land transition matrix, wetlands split managed/unmanaged. |

Notation keys are literal strings in the cells (`NE`, `NO`, `NA`, `IE`, and comma
combinations). Key order is **not normalised**, so `NE,NA` and `NA,NE` both occur and
the parser must sort tokens before comparing.

Coverage as of 7 July 2026: 134 Parties have filed a Biennial Transparency Report,
**117 with CRT tables**. Eighteen filed a BTR with no CRT, and four of those are
peatland countries the study wants: Bangladesh, Cambodia, Papua New Guinea and the
Philippines. Treat them as a documented coverage gap, not a silent omission.

Three engineering constraints to budget for explicitly. There is no bulk download and
no manifest. The file server returns 403 to bare requests and needs a session cookie
and a Referer obtained by fetching the document landing page first. Total volume runs
to several gigabytes across thousands of workbooks.

`lambwf/Tidy-GHG-Inventories` is the right skeleton to fork, but note that it
**destroys the notation keys**: `compile_crt_summaries.Rmd` maps `IE` and `NE` to `NA`
and `NO` to zero. For this study those three lines are the entire dependent variable.
Invert them, do not repair downstream.

### 4.2 Spatial layer

| Product | GEE asset | Note |
|---|---|---|
| PEATGRIDS | `projects/sat-io/open-datasets/PEATGRIDS/*` | The only peat product with per-pixel uncertainty. Use it as the Monte Carlo backbone. |
| PEATMAP | none, vector from Leeds repo | Extent basis. |
| FAO DROSA | `FAO/GHG/1/DROSA_A` | Drained organic soil area, cropland and grassland, 1992–2018. Drainage is **inferred from land cover, never observed**, and it is agricultural only, so drained peat under oil palm, pulpwood, forestry and extraction is out of scope. That excludes most of insular Southeast Asia. State this as an assumption, not a measurement. |
| Global Mangrove Watch v3 / v4 | `projects/sat-io/open-datasets/GMW/*` | v3 1996–2020 at 30 m; v4 2020 only at 10 m. |
| SoilGrids OCS and SOC | `projects/soilgrids-isric/ocs_mean`, `soc_mean` | Community-hosted. The official catalog entry `ISRIC/SoilGrids250m/v2_0` carries volumetric water content only. Do not conflate. |
| ISRIC WoSIS | not GEE | Measured profiles for the validation panel. |

**Licensing trap.** Global Peatland Map 2.0 is CC BY-NC-SA, non-commercial. Given the
commercial context this work sits in, use PEATMAP or PEATGRIDS as the extent basis
instead.

No global map of drainage ditches or canals exists. The best anywhere is regional:
Dadap et al. 2021, 5 m CNN over Borneo, Sumatra and Peninsular Malaysia for 2017 only.
A global drained/intact split has to be constructed from DROSA plus a peat extent
denominator, and every step is a documented assumption.

### 4.3 Crediting layer

Two registry migrations in the last two months broke the routes most scrapers use.
ART and ACR left APX for ICE GreenTrace in June 2026, and Verra migrated to an S&P
Global platform on 27 July 2026. Neither exposes a public API or bulk export now.

Workarounds that were verified to work: TREES validation and verification reports are
mirrored as direct PDFs on the UNFCCC REDD+ Info Hub with no barrier; the Climate
Action Reserve registry still serves server-rendered HTML tables without login; and
the **Berkeley Voluntary Registry Offsets Database**, version 2026-04, is the right
source for project counts across ACR, ART, CAR, Gold Standard and Verra.

## 5. Analysis

R throughout, as an executable manuscript in Quarto with all code echoed, following
the pattern established in the allometry paper. The render runs the pipeline, so the
prose and the numbers cannot drift.

1. **Extraction.** CRT workbooks to a tidy party x category x pool x year panel with
   notation keys retained verbatim.
2. **Predictor construction.** Join IPCC default uncertainty to each cell by pool,
   climate zone and soil class, from Table 2.3, Table 6.2 and the Wetlands Supplement
   factor tables.
3. **H1 and H2.** Mixed-effects logistic regression of P(Not Estimated) on default
   uncertainty, with magnitude, land area and capacity as controls and Party as a
   random effect.
4. **H3.** Coverage analysis: for each Not Estimated cell, does public data suffice
   for a Tier 1 estimate?
5. **H4.** Test whether inventory notation predicts crediting-programme pool scope in
   the jurisdictions present in both layers.
6. **H5.** A deduction-rule engine implementing each standard's actual conservativeness
   function, run against IPCC Tier 1 uncertainty by Monte Carlo, solving for `u*` per
   standard and locating each pool relative to it.
7. **H6 and H7.** Already implemented in
   `02.inputs/batjes-2010-socref-mean-vs-median.R`, base R only, output written to
   `03.outputs/batjes-2010-socref-bias.csv`. This code moves into the manuscript as an
   echoed chunk when the `.qmd` is created, so the reported figures cannot drift from
   the table.

The H6 and H7 findings originate in the limitations Seamus recorded in Appendix II of
the Ecuador Emissions Update Report and were verified independently against the Batjes
(2010) tables held in `04.references/ipcc-guidelines/`. The full set of eight recorded
limitations is written up in `CLAUDE.md` and belongs in the manuscript's methods
critique.

## 6. Things that could sink this, and the answer to each

| Risk | Response |
|---|---|
| CRT extraction is heavier than it looks: no bulk download, WAF, gigabytes | Budget it as a named work package. Fork the existing skeleton rather than starting cold. |
| Outcome has too little variance: if nearly every Party excludes organic soil, the logistic model has nothing to explain | Wide pool scope is the mitigation, and it was chosen for exactly this reason. Check the marginal distribution early, before building further. |
| Deduction rules may not be public in usable form for every standard | ART TREES §4.5 is quoted in the Ecuador material. Verify each standard's rule against the live document and drop any standard whose rule cannot be sourced. |
| Drainage status is inferred, not observed | State it as an assumption throughout. Do not let an inferred class become an implied measurement. |
| Four peatland countries have no CRT | Report the gap explicitly. Do not let it disappear into a footnote. |

## 7. Terminology, to be got right from the first draft

"Flux-based" applies to **organic soils only**. There, Equation 2.26 gives
`L_Organic = sum over climates of (Area x EF)`, a genuine annual emission factor in
tonnes C per hectare per year. Mineral soil in grassland and cropland is
**stock-change**: Equation 2.25 differences two modelled equilibrium stocks and divides
by a 20-year linear transition. Calling the grassland method flux-based will be caught
immediately by anyone who works in this area.

"New" also needs care. The Wetlands Supplement is 2013 and the Refinement is 2019.
What is recent is the uptake, or rather the non-uptake, by crediting standards.

The 2019 Refinement's one substantive advance for soil carbon, the Tier 2 steady-state
three-pool method, is parameterised for Cropland Remaining Cropland only. Its own
footnote says extension to other land uses "will require further development and
parameterisation". That absence for grassland is itself a citable finding.

One further constraint that shapes what can be claimed: under the KP Supplement,
Wetland Drainage and Rewetting has **no baseline scenario and no project boundary**.
Its counterfactual is a fixed base year under net-net accounting, not a without-project
trajectory. IPCC supplies the flux methodology and the stratification logic; the
baseline-and-credit architecture must come from elsewhere and be defended on its own
terms. Do not write a hypothesis that assumes IPCC hands you a project method.

## 8. Open items

- The Lake Chilwa paper: not in this repository and not yet described. Needed to fix
  the Google Earth Engine idiom and to decide what carries over.
- Verify Carbon Balance and Management's live submission guidelines: publisher,
  article types, length, figure and table limits, citation style.
- Confirm each standard's uncertainty deduction rule against its live standard
  document, ART TREES first.
- Decide whether the paper reports Ecuador as a worked case. If it does, the
  authorship on the 2025 Emissions Update Report is a conflict of interest that must
  be disclosed.
