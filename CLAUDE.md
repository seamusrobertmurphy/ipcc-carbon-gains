# ipcc-carbon-gains

## State as of 2026-07-30, read this first

**`01.manuscript/ipcc-carbon-gains.qmd` is the master and it renders.** Every number is
computed at render time from IPCC default tables encoded in base R. `code-fold: false`, so
chunks are visible. Render with `quarto render ipcc-carbon-gains.qmd --to html` from inside
`01.manuscript/`. Output is a self-contained 3.0 MB HTML, no sidecar directory.

**Structural exemplar, chosen 2026-07-30: Wilson et al. 2016, *Mires and Peat* 17(4)
(`@wilson2016`).** Until this point no model paper had been named, and the draft had grown
into a pathway-by-pathway walk through the IPCC tables in the order they were encoded, with
lab-notebook section titles and empty Discussion and Conclusions. Wilson et al. is the right
model because it is the direct predecessor: written by the Supplement's own authors, it
encodes the factors in Methods and drives the entire Results to one drained-minus-rewetted
GWP-weighted table. The manuscript has been rebuilt to that architecture. All computation was
preserved unchanged; what moved was order and framing.

Specifically: the `rewetting` and `drained` encoding chunks are now **Methods inputs**, not
results, which retires the awkward "here is a table, now ignore it" callout and enforces the
counterfactual rule structurally rather than by warning. The drained-minus-rewetted benefit
is now **Results §3.1**, the first thing the reader meets, with metric dependence at §3.2 and
the Monte Carlo at §3.3. Coastal, inland mineral, grassland, the nitrogen trap, the Batjes
bias and the ledger follow as supporting results. Discussion (six subsections) and
Conclusions are written. Section titles now state claims rather than describe process.
Abstract restructured to the journal's mandatory Background / Results / Conclusions. Title
changed to lead with the finding: "Countable is not beneficial".

Chunk dependency order is load-bearing after the reorder: `setup` → `metrics` (defines
`g100_ch4`, `g20_ch4`, `g100_n2o`) → `tbl-socref` → `rewetting` → `drained` → `benefit` →
`benefit-mc` → `coastal` → `inland-mineral` → `grassland-gain` → `n2o-crossover` →
`tbl-batjes-bias` → `ledger`. Moving a chunk above its dependency breaks the render.

`batjes2010` has been **added to the bib** as a `@techreport` (ISRIC Report 2010/10), closing
the gap where the mean-versus-median section computed from a source it could not cite. The
bib now holds 49 entries; 34 are cited and all 34 resolve, with zero unresolved keys in the
render.

**What computes now:** Table 2.3 reference stocks (42 cells); the Batjes mean-versus-median
bias (34 of 37 cells biased high, median 13.0%, max +154.5%, median CV 54.9% against a
median stated error of 13.4%); the grassland gain matrix (0.92 to 6.71 t CO2/ha/yr from
nominal, 1.97 to 14.30 from degraded); the nitrogen crossover (5.894 kg CO2e per kg N,
crossover at year 31 for the low case at 100 kg N/ha/yr); rewetted organic soil fluxes;
coastal pathways (mangrove 5.94, tidal marsh 3.34, seagrass 1.58 t CO2/ha/yr, mangrove
headroom 238 years, and **tidal marsh flips to a net source below 18 ppt**); inland mineral
wetland rewetting (**net source in 6 of 6 zones in years 1-20, 5 of 6 in years 21-40**); an
eight-pathway ledger; and the drained-minus-rewetted benefit calculation.

**Correction, 2026-07-30:** an earlier version of this file said "tidal marsh and seagrass
both flip to net sources below 18 ppt". Both halves were wrong and the render disproves
them. Seagrass is **out of scope** for Table 4.14, which covers tidal marsh and mangrove
only, so its salinity columns are NA, not zero. Mangrove does **not** flip: the sub-18-ppt
methane default of 193.7 kg CH4/ha/yr costs 5.23 t CO2e/ha/yr against a mangrove gain of
5.94, leaving +0.71. Only tidal marsh reverses. Do not restate the old claim.

**H1 IS CONFIRMED, AND IT IS METRIC-DEPENDENT.** Drained counterfactual now has 14 rows,
13 complete. Benefit of rewetting at **GWP-100 runs 1.26 to 54.54 t CO2e/ha/yr with no
negative case**. At **GWP-20 it runs −13.17 to 54.40, and five rows go negative**: Forest
Land boreal poor, boreal rich, temperate; Grassland temperate nutrient-rich; Peat extraction
temperate. All temperate or boreal. Monte Carlo over the published 95% bounds puts
**P(benefit > 0) below 0.95 for 5 of 13 rows even at GWP-100**. That is the paper.

Note the Supplement provides **no nutrient split for temperate Forest Land** although
Equation 2.7 carries separate nutrient-rich and nutrient-poor terms. The table and the
equation contradict each other; we assign the single value to both and say so.

**2026-07-30 session, late.** Three changes. (1) `04.references/references.bib` was
**rebuilt**: it had been holding the canadian-tree-allometry bibliography as a render
placeholder, all 36 entries irrelevant. It now carries 49 entries, 43 pulled from Crossref by
DOI content negotiation so author lists and pages are the registry's own, plus 6 hand-entered
IPCC sources. A comment block at the top lists what could **not** be resolved, plus the
do-not-cite warnings. (2) Two render defects fixed: the ledger called `max(inland$gain_tCO2)`
on a column that never existed and printed `-Inf`, now corrected to `max(inland$gain_1_20,
inland$gain_21_40)` giving 1.25 to 14.30; and the paragraph after the benefit Monte Carlo
claimed the Wilson temperate Forest Land row could not be reproduced, which was stale, since
that row is complete and turns negative at GWP-20. (3) Batjes 2010 is now identified in full
from the PDF: **ISRIC Report 2010/10**, "A global framework of soil organic carbon stocks
under native vegetation for use with the simple assessment option of the Carbon Benefits
Project system (Ver. 1.0)", Wageningen, 79 pp. It is **not yet in the bib** and must be added
as a `@techreport`, because the mean-versus-median section computes from a source it cannot
currently cite.

**Citation workflow, decided by Seamus 2026-07-30: use RStudio's visual editor with Zotero,
not hand-written `@keys`.** `apa.csl` stays; the Vancouver switch happens at submission prep,
not during drafting. Two `@keys` were inserted by hand before this decision (`@wilson2016`,
`@forster2021`) and both resolve. Zotero mints its own keys, so reconcile before mass-inserting.

**Ireland is built, 2026-07-30 late.** Results §3.10 encodes Irish country-specific Tier 2
factors and computes at render time like every other section. Four results, all verified against
the render: nutrient-poor drained grassland has a CO2 factor **4.0x below** Tier 1 and a CH4
factor **6.3x above** it, same hectares, same land use, opposite directions; **both** Irish
rewetting pathways are negative at GWP-100 and worse at GWP-20, on factors Ireland has already
adopted into its inventory; the nitrogen crossover at 180 kg N/ha moves from **year 30 under CAN
to year 73 under protected urea**, so formulation is a second escape hatch alongside
non-nitrogen improvement; and Irish Tier 2 land-use factors average 1.05 against the 1.14
default, falling to **0.85 on gley soils**, a loss where the default books a gain.

**The Irish arm needs no spatial data.** Everything above is computed from published emission
factors. Only the eligibility arm (soil series to IPCC class, saltmarsh to salinity class) needs
GIS, and that is what the broken SIS export blocks. Evidence base with quote-backed sources,
evidence classes and traps:
`docs/science-superpowers/prior-work/2026-07-30-ireland-evidence-base.md`.

**Two Irish results are deliberately held OUT of the manuscript** under the never-report-a-number-
from-unsaved-code rule, and a callout says so: the drained-minus-rewetted benefit implied by
Ireland's own reported inventory factors (**−0.09 t CO2e/ha/yr at AR5 GWP-100, −9.81 at GWP-20**),
and Ireland's near-natural peatland turning from a reported CO2 sink into a **net source of
~1.46 t CO2e/ha/yr** once its own reported DOC and CH4 are added. Both were derived by a review
agent from IRL-CRT-2026-V1.0. **Write the CRT-reading script, then they can go in.** This is now
the highest-value next task.

**Still open, in priority order.** (1) The **CRT script** above. (2) **GWP\*** is defined in `metrics` and reported once as an illustrative
weighting, but never applied to a pathway; the Limitations section now says so explicitly.
Applying it is the obvious next result, since rewetting is a step change in methane and
GWP\* was built for exactly that. (3) Uncertainty propagation covers the organic soil
benefit only; coastal, inland mineral and grassland pathways have none. (4) Polar and Boreal
rows of Table 2.3 remain unencoded. (5) `apa.csl` is still in place and the venue is
**Vancouver**; switch at submission prep, not during drafting.

**Do not present the absolute rewetted flux as a finding.** A wet organic soil emits methane
and is a net source in absolute terms everywhere. The hypothesis concerns the intervention,
so the counterfactual subtraction is mandatory. A callout in the manuscript says this.

**On the "team".** Personas are files, not processes. Nothing runs in the background between
sessions. `../../.claude/personas/wetland-scientist.md` and `carbon-cycle-scientist.md` are
the two in force; read them and adopt their conventions. Science-superpowers skills are not
registered from this subdirectory, so read them from `../../.claude/skills/<name>/SKILL.md`.
Pipeline gates passed: framing-research-questions, surveying-prior-work. Next:
designing-the-analysis, then preregistering-analysis.

Read [`INDEX.md`](INDEX.md) for layout, then
[`05.tasks/EVIDENCE-BASE-2026-07-30.md`](05.tasks/EVIDENCE-BASE-2026-07-30.md) for the
quote-backed evidence, then
[`docs/science-superpowers/questions/2026-07-30-countable-carbon-gains.md`](docs/science-superpowers/questions/2026-07-30-countable-carbon-gains.md)
for the approved framing.

Inherits repo-root conventions from `../../CLAUDE.md`: executable manuscript, master `.qmd`
as single source of truth, code always echoed, never report a number from code that was not
saved, verify venue guidelines against live pages.

## What this paper is

**A quantified synthesis of the carbon GAINS countable under IPCC Tier 1 and Tier 2 in
peatlands, coastal wetlands and improved grasslands**, and a test of whether each countable
gain survives its own methane and nitrous oxide offsets.

The pivotal change is 2013, not 2019. The Wetlands Supplement's Equation 3.1 replaced 2006
Equations 2.24 and 2.26 because those "implicitly assumed that organic soils can only lose
carbon". That produced the first negative Tier 1 emission factors in the guidelines' history.

**This paper is not about exclusion.** An earlier framing on why these pools are left out of
crediting was investigated on 2026-07-30 and set aside as a different paper. Do not
reintroduce it.

## Scope

Global pathway ledger and net-benefit test, plus **Ireland** as a single national worked
example. The global part carries the novelty, since no cross-pathway comparison exists;
Ireland supplies the eligibility gates that global defaults cannot resolve. Do not let the
national case swallow the paper: a single-country study of IPCC factors is a crowded genre.

## Venue

### Primary: Carbon Balance and Management (Springer Nature, BMC imprint)

Constraints, **verified live 2026-07-30**: **Vancouver** references, not APA, so the `apa.csl`
in `04.references/` is wrong. Abstract **350 words, structured** Background / Results /
Conclusions. Three to ten keywords. The availability declaration requires an **archived code
DOI**, so plan a Zenodo deposit, not a GitHub link. Tables may not use colour or shading.

### Candidate: Global Biogeochemical Cycles (AGU, published by Wiley)

Added 2026-08-03 at Seamus's request, motivated by **base publication fees**.

> **NOTHING ABOUT THIS VENUE IS VERIFIED. Do not write a single guideline fact, fee figure,
> word limit or reference style for GBC into the manuscript or into any planning document until
> the live pages have been read.** This is the repo's standing rule and it exists because it has
> already caught two errors: Forest Science moved from Oxford Academic to Springer Nature in
> January 2025, changing citation style and limits, and the "saved guidelines PDF" in this repo
> turned out to be 43 blank pages.

**Verification attempted 2026-08-03 and it failed.** Recorded so the next session does not
repeat the same dead ends:

| Route | Result |
|---|---|
| `agupubs.onlinelibrary.wiley.com` journal and about pages | HTTP 403 to curl and to WebFetch |
| AGU publication-fees page | HTTP 403; Cloudflare JavaScript challenge behind the text proxy |
| Wiley author guidelines via `r.jina.ai` proxy | Loads, but returns navigation and login chrome only, no guideline text |
| Wiley APC listing page | Loads the preamble; the price table itself is JavaScript-loaded |
| WebSearch | **Budget exhausted, 200/200 for the session** |

**What must be established before this becomes more than a note.** The article processing
charge and, separately, whether the subscription (non-open-access) route carries any charge at
all, since "base fees" is the motivation. Member versus non-member rates. Excess-length or page
charges. Waiver policy. Then the ordinary things: accepted article types and their word limits,
abstract limit and whether it must be structured, reference style, figure and table limits, and
the data and software availability policy, in particular whether an archived DOI is required as
Carbon Balance and Management requires.

**A scope judgement, offered as opinion and clearly not a verified fact.** GBC publishes
biogeochemistry: fluxes, cycles, mechanisms, and the processes behind them. This manuscript is
substantially an **accounting and methods critique**: it argues that a countable gain is not a
climate benefit because of how the guidance is structured, and its central result is that a sign
depends on the emission metric. That is a defensible fit if the paper leads with the
biogeochemistry, the methane and nitrous oxide offsets and the transient, and it is a poor fit if
it leads with inventory practice and crediting architecture. **The framing that suits Carbon
Balance and Management may be the wrong framing for GBC**, so treat this as a decision about the
paper, not only about the destination. Verify before committing either way.

## Authorship

**Sole author: Seamus Murphy.** Co-authors, including the TÜV SÜD soil teams, come in only
once the draft is developed, to keep lead authorship settled. Operational rule: **never put
another party on the critical path.** No design option that depends on client-data clearance,
partner access or someone else's primary measurements. Public sources only.

## Terminology that must not slip

**"Flux-based" applies to organic soils only.** Equation 2.26,
`L_Organic = Σ (Area × EF)`, tonnes C per hectare per year. Mineral soil in grassland and
cropland is stock-change: Equation 2.25, two modelled equilibrium stocks differenced over a
20-year linear transition. **There is no flux-based Tier 1 or Tier 2 method for improved
grassland.**

**There is no SOCref for peat.** Batjes (2011): "Tier 1 and 2 methods do not explicitly
consider SOC stocks in organic soils... Therefore, they are not considered in this study."
That is the structural reason the two accounting logics coexist and must be treated
separately.

**Three distinct "20 years" must not be conflated**, and an earlier version of this note got
the second one wrong. Corrected 2026-08-03 against the primary source
(`04.references/standards/IPCC-md/IPCC-2019-V4-Ch2-Generic-Methodologies.md`):

1. The **land-conversion residence period**, 20 years.
2. **`T_on`, Equation 2.23**, verbatim: "time period of the transition from old to new land-use
   category, yr. The Tier 1 default is **20 years for carbon stock increases and 1 year for
   carbon losses**." The surrounding text defines `Cn` as **dead wood and litter** stock, so
   **the asymmetry belongs to the dead organic matter pool only**, where a one-year loss on
   conversion is defensible because the guidance assumes litter carbon is lost in the year of
   transition.
3. **`D`, Equation 2.25**, the **mineral soil** transition, verbatim: "Time dependence of
   mineral soil organic C stock change factors which is the default time period for transition
   between equilibrium SOC values, yr. **Commonly 20 years**, but depends on assumptions made
   in computing the factors FLU, FMG and FI." **There is no gain/loss asymmetry here.** D is 20
   years in both directions.
4. The urban-tree active growing period in 2019 Ch. 8.

**The old note claimed `T_on` and `D` were both asymmetric. They are not.** Do not build an
argument on a mineral-soil gain/loss asymmetry: it does not exist, and a referee checking the
equation would find it immediately. The manuscript never repeated the error; it was confined to
this record.

**Wetland Drainage and Rewetting has no baseline and no project boundary** under the KP
Supplement. Its counterfactual is a fixed base year under net-net accounting. IPCC supplies
the flux methodology; the baseline-and-credit architecture must come from elsewhere.

## Corrections carried in the record

1. **`IPCC-2010-Erata-Land-Climate-Soil-Carbon-Classification.pdf` is not IPCC and not an
   erratum.** It is EU Commission Decision 2010/335/EU under the Renewable Energy Directive.
   Its Table 1 is a verbatim copy of IPCC 2006 Table 2.3. The real 2010 event is the IPCC
   Expert Meeting, Geneva, October 2010, which caused the Wetlands Supplement.
2. **There was never an immediate-100%-oxidation default for soil.** The 20-year linear
   transition is in the 1996 Guidelines, restated in 2003 and 2006. The immediate-loss rule
   applies to **biomass**. The Ecuador Emissions Update conflates the two.
3. **Biogenic CH4 GWP-100 is 27.0 (AR6 Table 7.15), not 30.65.** The 30.65 figure adds the
   molar-mass ratio 2.75 to 27.9, which triple-errs: 2.75 is not a metric contribution, the
   biogenic carbon adjustment is a **sink** of 0.7 kg CO2 per kg CH4 rather than a source,
   and 27.9 is the value that deliberately excludes carbon accounting.
4. **"2013" and "2014" are the same documents.** Cite as IPCC 2014, *2013 Supplement to the
   2006 IPCC Guidelines: Wetlands*.
5. **`IPCC-2013-Kyoto-Supplement-Overview.pdf` is a Second Order Draft** stamped "do not cite
   or quote", with at least two statements corrected in the final. Cite the final.

## The two findings to protect

**The nitrogen trap.** "Improved grassland" requires an improvement, and fertilisation is one
option. At AR6 GWP-100 the penalty is 5.894 kg CO2e per kg N applied. The soil gain is capped
at 20 years; the nitrous oxide is open-ended. Crossover at 100 kg N/ha/yr on a low-carbon soil
is **year 31**. The escape hatch is that fertilisation is optional: species improvement plus
grazing management earns the same factors with no nitrogen penalty, and 2019 removed
biological nitrogen fixation as a direct N2O source. The 2019 grassland chapter contains
**zero occurrences of "N2O"**.

**The coastal duration asymmetry.** Table 4.12 applies "as long as the soil remains rewetted
and vegetated", to a ceiling of 386 t C/ha for mangrove, roughly 240 years of headroom. Every
other soil pathway is capped at 20 years, inland mineral wetland at 40. Two gates: planted or
seeded, since recolonisation scores zero, and 10% canopy cover. Above 18 ppt salinity methane
is zero by assumption; below it, 193.7 kg CH4/ha/yr can flip the project to a source.

## Data traps

- **SoilGrids in Earth Engine:** `ISRIC/SoilGrids250m/v2_0` carries volumetric water content
  only. Carbon is at `projects/soilgrids-isric/ocs_mean` and `soc_mean`.
- **Global Peatland Map 2.0 is CC BY-NC-SA**, non-commercial. Use PEATMAP or PEATGRIDS.
- **FAO DROSA infers drainage from land cover**, never observes it, and is agricultural only,
  so drained peat under oil palm, pulpwood and forestry is out of scope.
- **No mangrove BCEF exists at any tier.** Build it as BEF × D via WS Eq 4.1.
- **Mangrove carbon fraction is 0.451, not the 0.47 default.**
- **Dead roots below 2 cm belong to the soil pool**, not dead organic matter. Claiming both
  double-counts.
- **Ecuador is a conflict of interest.** Seamus is a named author on the 2025 Emissions Update
  Reports. Declare it if Ecuador appears.

## Team activation

Personas at `../../.claude/personas/`. Domain Lead for this paper is **wetland-scientist**
plus **carbon-cycle-scientist**; both are loaded and their conventions apply, in particular
the carbon-cycle rule that sign conventions are contractual and that policy metrics must state
GWP version, scope and permanence.

Science-superpowers skills are not registered from this subdirectory. Read them directly from
`../../.claude/skills/<name>/SKILL.md`. The pipeline gate is
framing-research-questions → surveying-prior-work → designing-the-analysis →
preregistering-analysis, and **no outcome analysis until pre-registration is complete**.

## Environment

R is the CRAN build at `/usr/local/bin/R`, packages from `~/Library/R/arm64/4.4/library`.
No renv, no Docker. Prefer base R. Earth Engine for zonal statistics and Monte Carlo sampling
only, not new mapping.
