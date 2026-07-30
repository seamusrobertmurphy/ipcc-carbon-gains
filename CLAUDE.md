# ipcc-carbon-gains

Read [`INDEX.md`](INDEX.md) for layout and
[`05.tasks/RESEARCH-DESIGN-2026-07-30.md`](05.tasks/RESEARCH-DESIGN-2026-07-30.md)
for the question, hypotheses and design before touching anything.

Inherits the repo-root conventions in `../../CLAUDE.md`: executable manuscript, master
`.qmd` as single source of truth, code always echoed, never report a number from code
that was not saved, verify venue guidelines against the live pages.

## Authorship

**Sole author: Seamus Murphy.** Co-authors, including the TÜV SÜD soil science teams,
are invited only once the draft is substantially developed. This is deliberate: early
collaborators would unsettle lead authorship.

The operational consequence is a design rule. **Never put another party on the critical
path.** No option that depends on client-data legal clearance, on a partner institution
granting access, or on a co-author supplying primary measurements. Everything the paper
needs must be obtainable from public sources by one person. Where a richer option exists
that requires someone else, note it as a later phase, do not design around it.

## The argument

The methods exist and the data exist. What blocks inclusion of wetland, peatland and
grassland soil carbon is that IPCC Tier 1 default uncertainty is wide enough that once a
crediting standard applies its conservativeness deduction, a large uncertain pool yields
less net credit than a small certain one, and past a threshold yields none. Exclusion is
rational, not negligent.

Two observations carry it. VM0036, Rewetting Drained Temperate Peatlands, has been
active since July 2017 with reportedly zero registered projects. The Paris Agreement
Crediting Mechanism has approved two methodologies in total, landfill gas and nitric
acid, and has nothing for wetlands, peatland or soil carbon even in development.

## What the Tier 1 SOCref defaults actually are

This is the technical core of the paper and it must be got exactly right.

**IPCC 2019 Refinement Vol.4 Ch.2 Table 2.3 publishes the arithmetic means from
Batjes (2010).** Verified cell by cell: the Table 2.3 values match the Batjes mean row
exactly. Batjes also published medians with median absolute deviation, and for skewed
soil carbon distributions the median is the robust statistic.

Computed in `02.inputs/batjes-2010-socref-mean-vs-median.R`, output in
`03.outputs/batjes-2010-socref-bias.csv`:

- The mean exceeds the median in **34 of 37 cells, 92%**.
- Median bias across cells is **13.0%**; the range runs from **-3.5% to +154.5%**.
- The extremes fall precisely on the systems this paper is about: warm temperate dry
  volcanic **+154.5%**, warm temperate moist wetland **+43.6%**, tropical montane
  wetland **+41.4%**, tropical montane volcanic **+29.7%**, tropical moist wetland
  **+28.3%**.

**The stated ± error in Table 2.3 is not what most readers assume.** It is the 95%
confidence interval on the mean, `1.96 x SE / mean`, so it narrows with sample size and
says nothing about how much soils actually vary. The coefficient of variation of the
underlying profiles has a **median of 54.9%** across cells. Tropical dry high-activity
clay carries a stated error of ±5% from n=554, against a CV of 61.9%. A country applying
that default to a particular hectare believes it is working to ±5% precision when the
soils behind the number vary by an order of magnitude more.

That distinction does double duty in the argument. Countries and standards act on the
stated error, which is what makes the exclusion decision modellable. The true dispersion
is far larger, which is what makes the whole edifice fragile.

## Limitations of the global Tier 1 SOC dataset

Recorded by Seamus in Appendix II of the Ecuador Emissions Update Report, expanded here
with independent verification against Batjes (2010) in this folder. These belong in the
manuscript's methods critique.

1. **Means, not medians.** The defaults use arithmetic means where the distributions are
   skewed, giving the 10 to 30% overestimation quantified above. Geographic sampling bias
   toward Brazilian sources explains the elevated warm temperate moist (W1) values
   relative to geographically diverse recalculations.

2. **Depth truncation at 0 to 30 cm.** Estimates ignore deeper disturbance. Batjes (2010)
   put it directly: "The potential impact of a change in land use and management on SOC30
   stocks, vis a vis SOC stocks to say 100 cm depth, may vary markedly according to IPCC
   climate zone and soil class, depending on the actual depth, type and intensity of soil
   disturbance." For peat this is not a refinement but a category error, since peat
   profiles routinely run metres deep.

3. **Methodological discontinuity between soil types.** Organic soils take flux-based
   emission factors, mineral soils take stock-difference. Organic SOC stocks are
   therefore absent from the stock-difference equations altogether, so a landscape
   containing both is accounted by two incompatible logics with no reconciliation.

4. **Omitted soil classes.** Boreal (Bx) and Polar (Px) regions are undifferentiated.
   Several cells in Table 2.3 are not Batjes values at all: some are carried over from
   the 2006 Guidelines and some are 1996 vintage, all flagged at a nominal ±90% and
   several with no sample size.

5. **Seven soil classes cannot carry volcanic and montane diversity.** The scheme
   inadequately captures volcanic soil diversity and Andean pedoclimatic gradients. Note
   that volcanic soils show the largest mean-median divergence in the whole table.

6. **Cross-stratification degrades climate precision.** Climate zones must align with
   soil classes and land-use categories, so climate resolution is sacrificed for system
   consistency. A country wanting its own climate classification must then derive its own
   emission factors, which is a resource barrier that pushes countries back to defaults.

7. **Fixed climate reference period, 1985 to 2015.** Poorly suited to complex
   topographic variation and blind to recent climate change.

8. **The soil map underneath has moved.** The classification scheme is unchanged from FAO
   (1998), but the geospatial datasets cited in Ch.3 of the 2019 Refinement carry revised
   delineations with known country-level consequences. See Sinitambirivoutin et al.
   (2024), *Catena* 244:108258, on IPCC major soil type maps derived from the Harmonized
   World Soil Database v2.0.

## Terminology that must not slip

**"Flux-based" applies to organic soils only.** Equation 2.26,
`L_Organic = sum over climates of (Area x EF)`, a genuine annual emission factor in
tonnes C per hectare per year. Mineral soil in grassland and cropland is stock-change:
Equation 2.25 differences two modelled equilibrium stocks and divides by a 20-year linear
transition. There is no flux-based Tier 1 or Tier 2 method for improved grassland.

**"New" needs care.** The Wetlands Supplement is 2013 and the Refinement is 2019. What is
recent is the non-uptake by crediting standards.

**The 2019 Refinement's Tier 2 steady-state method is cropland-only.** Its own footnote
says extension to other land uses "will require further development and parameterisation".
That absence for grassland is a citable finding.

**Wetland Drainage and Rewetting has no baseline and no project boundary.** Under the KP
Supplement its counterfactual is a fixed base year under net-net accounting, not a
without-project trajectory. IPCC supplies the flux methodology and the stratification
logic; the baseline-and-credit architecture must come from elsewhere and be defended
separately.

## Traps

1. **`IPCC-2013-Kyoto-Supplement-Overview.pdf` is a Second Order Draft** stamped "do not
   cite or quote". Not citable. At least two of its statements were corrected in the
   final, including a reversed description of the organic soil definition. Cite
   `IPCC-2013-Kyoto-Supplement.pdf`.

2. **The UNFCCC DI interface cannot carry this study.** Its non-Annex I side uses the
   1996 category tree with no wetlands category, no drained/rewetted split and no
   separate soil pool, and effectively stops at 2016. Parse the CRT workbooks directly.
   The interface also rate-limits by returning HTTP 200 with a challenge page, so
   validate response length rather than status code.

3. **The obvious R fork destroys the dependent variable.** `lambwf/Tidy-GHG-Inventories`
   maps `IE` and `NE` to `NA` and `NO` to zero in `compile_crt_summaries.Rmd`. Those
   notation keys are the outcome variable. Invert those lines, do not patch downstream.

4. **Notation key order is not normalised.** `NE,NA` and `NA,NE` both occur. Sort tokens
   before comparing.

5. **Global Peatland Map 2.0 is CC BY-NC-SA, non-commercial.** Use PEATMAP or PEATGRIDS
   as the extent basis given the commercial context.

6. **FAO DROSA infers drainage from land cover, never observes it,** and covers
   agricultural drainage only. Drained peat under oil palm, pulpwood, forestry and
   extraction is out of scope, which excludes most of insular Southeast Asia. State it as
   an assumption, never as a measurement.

7. **SoilGrids in Earth Engine is easy to get wrong.** The official catalog entry
   `ISRIC/SoilGrids250m/v2_0` carries volumetric water content only. Carbon lives in the
   community project at `projects/soilgrids-isric/ocs_mean` and `soc_mean`.

8. **Four peatland countries filed a BTR with no CRT:** Bangladesh, Cambodia, Papua New
   Guinea and the Philippines. Report the gap; do not let it vanish into a footnote.

9. **Ecuador is a conflict of interest.** Seamus is a named author on the 2025 Emissions
   Update Reports. If Ecuador appears as a worked case, declare it.

10. **The 30 July 2025 Ecuador significance analysis does not reconcile.** Its reference
    level is 38,162,524 tCO2/yr against the 2024 report's 69,394,985, unexplained; and
    adding 12,735 tCO2/yr of peat produces a stated total that is lower than the starting
    figure. Do not quote its arithmetic uncritically.

## Environment

R is the CRAN build at `/usr/local/bin/R`, packages from `~/Library/R/arm64/4.4/library`.
No renv, no Docker. Prefer base R where it will do: the Batjes script needs nothing else,
which keeps the manuscript renderable anywhere. Earth Engine is used for zonal statistics
and Monte Carlo sampling only, not for new mapping.
