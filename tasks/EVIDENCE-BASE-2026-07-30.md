# Evidence base: countable carbon gains under IPCC Tier 1 and Tier 2

Assembled 2026-07-30 from the full `04.references` set, every document read. Each claim
carries its source and IPCC table or equation number. This is the substrate for the
manuscript.

---

## 1. The pivotal change

2013 Wetlands Supplement, Chapter 3. Equation 3.1 replaces Equations 2.24 and 2.26 of
the 2006 Guidelines because those:

> implicitly assumed that organic soils can only lose carbon, while in fact undrained or
> rewetted organic soils can accumulate soil organic carbon if covered with vegetation.

This produced the first negative Tier 1 emission factors in the guidelines' history.
Before it, the only organic-soil term in the framework was `L_Organic`, a loss.

The 2006 justification for the omission, Vol. 4 Ch. 2 §2.3.3, is worth quoting because
it shows the reasoning that was overturned:

> national inventories typically do not estimate the accumulation of C in the soil pool
> resulting from the accumulation of plant detritus in un-drained organic soils. Overall,
> the rates of C gain are relatively slow in wetland environments with organic soils
> (Gorham, 1991), and any attempt to estimate C gains, even those created through wetland
> restoration, would also need to address the increase in CH4 emissions.

2006 Ch. 7 §7.5 adds the evidential reason: "published studies based on observational
data are too recent and limited to develop default emission factors."

2003 GPG-LULUCF had already named rewetting and declined it: "Methodologies for rewetting
are not included due to the scarcity of available data", and "At present, no good practice
guidance can be given for CH4 emissions from rewetting of organic soils."

---

## 2. The gain pathways

### 2.1 Rewetted inland organic soils (2013 WS Ch. 3)

Applies **from the year of rewetting**, no transition period: "the Tier 1 basic
methodology assumes that there is no transient period and that rewetted organic soils
immediately behave like undrained/natural organic soils in terms of CO2 flux dynamics."

**Table 3.1**, EF_CO2, t CO2-C/ha/yr. Negative denotes removal.

| Climate | Nutrient status | EF_CO2 | 95% range | n |
|---|---|---|---|---|
| Boreal | Poor | **−0.34** | −0.59 to −0.09 | 26 |
| Boreal | Rich | **−0.55** | −0.77 to −0.34 | 39 |
| Temperate | Poor | −0.23 | −0.64 to +0.18 | 43 |
| Temperate | Rich | +0.50 | −0.71 to +1.71 | 15 |
| Tropical | n/a | 0 | none | — |

Only the two boreal rows have confidence intervals wholly below zero. Temperate poor is
not significantly different from zero. The tropical zero is a stop-the-loss value: it
"reflects the fact that successful rewetting effectively reduces the decay of soil organic
matter, but does not necessarily re-establish a soil C sequestration function."

The EF is **composite**: soil plus non-tree vegetation. Woody biomass must be added
separately via 2006 Eqs 2.7/2.8, with an explicit double-counting warning.

**Table 3.3**, CH4, kg CH4-C/ha/yr, all positive: boreal poor 41, boreal rich 137,
temperate poor 92, temperate rich 216, tropical 41. Ditches are folded into the site at
Tier 1, so no separate rewetted-ditch factor exists. N2O is assumed negligible.

**Table 3.2**, DOC. Rewetting reduces DOC export, and the Supplement evidences it:
"Collated data from seven rewetting studies suggest a median DOC reduction of 36%, with a
range of 1 to 83%." Gain against drained: boreal 0.04, temperate 0.07, tropical 0.31
t C/ha/yr.

**Net GWP benefit of rewetting** (computed, not in the Supplement, AR4 GWPs used in the
source calculation and to be redone at AR6):

| Transition | Drained | Rewetted | Net benefit, t CO2e/ha/yr |
|---|---|---|---|
| Temperate rich deep-drained grassland | 29.18 | 9.91 | **19.27** |
| Peat extraction to rewetted temperate poor | 12.23 | 3.10 | 9.12 |
| Tropical drained cropland | 55.64 | 3.24 | **52.40** |
| Boreal poor drained forest | 1.77 | 0.41 | 1.35 |

The methane penalty never overturns the benefit at Tier 1 defaults. Break-even is not a
live risk. But note the boreal poor case books a CO2 removal while remaining a net GWP
source once methane is counted, a distinction invisible in the Supplement because it
never aggregates.

### 2.2 Coastal wetlands (2013 WS Ch. 4)

**Table 4.12**, EF_RE, t C/ha/yr, negative denotes removal: mangrove **−1.62** (n=69),
tidal marsh **−0.91** (n=66), seagrass **−0.43** (n=6). No climate disaggregation at
Tier 1; vegetation type only.

**The duration rule is the single biggest asymmetry in IPCC guidance.** Apply the factor

> as long as the soil remains rewetted and vegetated, until such time as stocks are
> equivalent to soil carbon stocks in natural/undrained settings with vegetation

Ceiling from Table 4.11: mangrove 386 t C/ha, tidal marsh 255. At 1.62 t C/ha/yr that is
roughly 240 years of headroom, so the ceiling almost never binds. Every other soil
pathway is capped at 20 years, and inland mineral wetland rewetting at 40.

**Two eligibility gates.** Vegetation must be planted or seeded: "If the rewetting,
revegetation or creation activity is associated with recolonization (no direct replanting
or reseeding), apply EF_RE = 0." And canopy cover must reach 10%.

**The salinity switch, Table 4.14.** Above 18 ppt, CH4 = 0 by assumption. Below,
193.7 kg CH4/ha/yr, which at GWP-100 exceeds a tidal marsh removal and flips the project
to a source. This is the decisive design lever for a coastal project.

**Counterfactual, Table 4.13:** drained mangrove and tidal marsh 7.9 t C/ha/yr. Against
a rewetted mangrove at −1.62 the swing is 9.52 t C/ha/yr, or 34.9 t CO2/ha/yr.

**Managing an existing mangrove earns nothing.** "The Tier 1 default assumption is that
soil CO2 emissions and removals are zero (EF = 0)" for forest management in mangroves.
Only rewetting, revegetation and creation unlock Table 4.12.

**Mangrove biomass** runs through the Gain-Loss method (2006 Eq 2.7 + 2.9 + 2.10), and
2019 Ch. 4 contains **no mangrove, swamp or wetland forest type in any default table**.
The parameters exist only in the Supplement: AGB growth 9.9 t d.m./ha/yr tropical wet
(n=23), 3.3 tropical dry, 18.1 subtropical; root:shoot 0.49 / 0.29 / 0.96; wood density
0.71; carbon fraction 0.451, not the 0.47 default. Growth applies only until the AGB
stock ceiling (192 t d.m./ha tropical wet), roughly 19 years. **There is no BCEF for
mangroves at any tier**; it must be built as BEF × D via WS Eq 4.1.

Dead roots below 2 cm belong to the **soil** pool, not dead organic matter. Claiming both
double-counts.

### 2.3 Inland wetland mineral soils (2013 WS Ch. 5)

**Table 5.3**, F_LU: long-term cultivated 0.71, rewetting years 1 to 20 **0.80**,
years 21 to 40 **1.0**. The only 40-year recovery in the guidance. Cold temperate moist
gives 37.1 t C/ha over 40 years, about 3.4 t CO2/ha/yr.

**Table 5.4**, CH4: boreal 76, temperate 235, tropical 900 kg CH4/ha/yr. At temperate
values the methane costs 5.9 t CO2e against a 3.4 t CO2 gain, so **inland mineral-soil
rewetting is a net source under Tier 1 defaults**.

### 2.4 Improved grassland (2019 Ch. 6)

`gain (t CO2/ha/yr) = SOC_REF × ΔF × 0.1833`, since F_LU = 1.0 for all grassland.

**Table 6.2** compound factors: temperate improved + high input 1.2654, tropical 1.2987,
montane 1.2876. Nominal to improved + high gives **0.92 to 6.71 t CO2/ha/yr** in the
temperate branch, and **0.49 to 7.83** across all zones. Severely degraded to improved +
high gives **1.97 to 14.30**.

**The grassland factors have not changed since 2003.** F_MG 1.14 / 1.17 and F_I 1.11 are
identical to GPG-LULUCF Table 3.4.5, twenty-three years old. What 2019 added was a loss
factor, high-intensity grazing at 0.90, from "31 published studies with 176 observations"
where "There was insufficient data to develop reliable factors by climate or soil."

**Grazing management is not a Tier 1 gain lever.** GPG 2003 §3.4.7: "The management
improvements considered here were limited to fertilization (organic or inorganic), sowing
legumes or more grass species, and irrigation."

### 2.5 Biochar (2019 Eq 2.25A)

The only genuinely new gain-generating equation in the 2019 Refinement. Tier 2, cropland
and grassland mineral soils.

---

## 3. The nitrogen trap

This is the most consequential finding of the review, and it is absent from the guidance.

"Improved grassland" requires "at least one improvement (e.g., fertilization, species
improvement, irrigation)". Fertilisation triggers N2O. Per kg N applied, wet temperate,
aggregated 2019 factors: direct EF1 0.010, volatilisation 0.11 × 0.010, leaching
0.24 × 0.011, giving 0.01374 kg N2O-N, or **5.894 kg CO2e per kg N** at AR6 GWP-100 = 273.

**Break-even N application rate:**

| Parameterisation | SOC gain 0.92 t | 3.815 t | 6.71 t |
|---|---|---|---|
| 2019 aggregated, wet (5.894) | **156 kg N/ha/yr** | 647 | 1138 |
| Disaggregated, wet, urea (8.897) | **103** | 429 | 754 |
| Upper percentiles (16.534) | **56** | 231 | 406 |

Intensively fertilised temperate pasture runs 150 to 350 kg N/ha/yr. On low-carbon soils,
real fertilisation rates cancel the entire claimed SOC gain.

**The durations differ, and that is decisive.** The SOC gain is a one-off transition of
finite size amortised over 20 years and zero thereafter. The N2O penalty is annual and
open-ended. Crossover year `T* = 20G / annual penalty`:

| SOC gain | N = 100, central | N = 200, central |
|---|---|---|
| 0.92 t/ha/yr | **31 yr** | **16 yr** |
| 3.815 | 130 | 65 |
| 6.71 | 228 | 114 |

Every fertilised improved grassland eventually becomes a net source. The question is only
whether crossover falls inside the accounting horizon. For a 30-year crediting period on
a low-carbon soil, it does.

**The escape hatch.** Fertilisation is one option among several, not a requirement. A
grassland improved by species improvement and grazing management, with no nitrogen
applied, earns F_MG × F_I with zero direct and volatilisation N2O. The 2019 Refinement
also removed biological nitrogen fixation as a direct N2O source, "because of the lack of
evidence of significant emissions arising from the fixation process itself (Rochette and
Janzen, 2005)". **So the SOC gain is claimable without the nitrogen penalty only if the
improvement is non-nitrogenous.** That is a publishable, actionable conclusion.

**IPCC saw this in 2003 and dropped it.** GPG-LULUCF §4.2.9.3.4:

> Management practices adopted to increase soil carbon may also influence the emission of
> non-CO2 greenhouse gases... increasing the carbon pools could also increase levels of
> organic nitrogen which, when mineralised, could become available as a substrate for
> denitrification and thus increase N2O production... These effects can be calculated in
> higher-tier methods, but still should be reported in the Agriculture sector, to avoid
> double counting or omission.

The 2019 grassland chapter contains **zero occurrences of "N2O" or "nitrous"**. The
sectoral firewall that prevents double counting in a national inventory becomes a blind
spot the moment a stock-change factor is read as a project-level carbon gain.

**One-sided mineralisation accounting.** Eq 11.8 charges N2O for carbon lost but grants
no credit for carbon gained: "the opposite process to mineralisation, whereby inorganic N
is sequestered into newly formed SOM, is not taken account of". Rule of thumb: every tonne
of soil C lost to land-use change carries a mineralisation N2O charge of roughly 10%
(R=15) to 15% (R=10) of the CO2 from that carbon.

---

## 4. Metric choice, and a correction

The 2013 Wetlands Supplement contains **no GWP weighting anywhere in 354 pages**. A grep
for GWP, global warming potential and CO2-equivalent returns a single hit, a bibliography
entry. The paper must supply the metric and justify it.

**Qualified 2026-07-30.** The Supplement omits it, but its own authors supplied it
externally: Wilson et al. (2016) *Mires and Peat* 17:04, Table 5, gives GWP-100 balances
for drained versus rewetted inland organic soils across 14 land-use categories. That
table also contains a published instance of this paper's H1: temperate Forest Land,
nutrient-rich, drained 12.25 versus rewetted 12.50 t CO2-eq/ha/yr, **emission reduction
−0.25**, i.e. rewetting that cell is marginally worse. The remaining gap is cross-pathway,
not the absence of any weighting. See the prior-work note.

**AR6 Table 7.15**, values including carbon-cycle and chemical responses:

| Species | GWP-20 | GWP-100 | GTP-100 |
|---|---|---|---|
| CH4 fossil | 82.5 ± 25.8 | 29.8 ± 11 | 7.5 ± 2.9 |
| CH4 non-fossil | 79.7 ± 25.8 | **27.0 ± 11** | 4.7 ± 2.9 |
| N2O | 273 ± 118 | **273 ± 130** | 233 ± 110 |

**The 30.65 figure in the Ecuador report is wrong.** It was built as 27.9 + 2.75. Three
errors: 2.75 is the molar-mass ratio of CO2 to CH4, not a metric contribution; the sign is
reversed, since for biogenic methane AR6 gives a **sink** of 0.7 ± 0.7 kg CO2 per kg CH4,
not a source; and 27.9 is the value that deliberately excludes carbon accounting so that
budgeting can be done separately. AR6 arithmetic confirms it: 27.9 → 27.0 for non-fossil
(a reduction of 0.9), and 27.9 → 29.8 for fossil (an increase of 1.9). **Use 27.0.**

**AR6 says GWP-100 understates a new methane source by 4 to 5 times over its first
20 years** (§7.6.1.4, citing Lynch et al. 2020). Rewetting introduces a new methane
source, so GWP-100 is the permissive choice over the horizon that matters, not the
conservative one.

AR6 declines to recommend a metric (Box 7.3) and warns that "GWP and GTP metrics were not
designed for use under a cumulative carbon dioxide equivalent emissions framework".
**Report rewetting under GWP-100, GWP-20 and GWP\*.** GWP\* is implementable from AR6
footnote 2: multiply by GWP-100 × 0.28 and add the 20-year emissions change × GWP-100 ×
4.24. For a sustained rewetting flux that charges roughly 28% of what GWP-100 charges,
once the step has aged out.

---

## 5. Why organic soils need the flux method

Batjes (2011) §1, the definitive statement:

> Tier 1 and 2 methods do not explicitly consider SOC stocks in organic soils; instead,
> the annual C-flux following drainage is estimated using an annual emission factor
> (IPCC, 2006, p. 2.35)... Therefore, they are not considered in this study.

**There is no SOCref for peat.** There cannot be a Tier 1 stock-change gain on organic
soil. That is the structural reason the two accounting logics coexist, and it is why the
paper must treat them separately rather than as variants of one method.

---

## 6. Limitations of the data behind Table 2.3

Seamus recorded eight in Appendix II of the Ecuador Emissions Update Report. Each is now
corroborated from source, and several are stronger than recorded.

| Appendix II point | Verification from source |
|---|---|
| Means not medians, 10 to 30% overestimation | Confirmed and extended. Computed in `02.inputs/batjes-2010-socref-mean-vs-median.R`: mean exceeds median in **34 of 37 cells**, median bias 13.0%, range −3.5% to **+154.5%**, worst in wetland, volcanic and montane classes. Batjes himself: "the mean exceeds the median in every climate zone, by up to 2.4×. Tier 1 uses the mean." |
| Brazilian sampling bias | Confirmed and quantified. Batjes (2011): 2006 defaults rest on ~3500 profiles "with a strong geographical bias (**77%**) with respect to profiles from Brazil". The 1,909 replacement profiles are **57.5% Northern America**. |
| Depth truncation at 0 to 30 cm | Confirmed, plus a worse finding: **there is no documented rule for a horizon straddling 30 cm.** No interpolation, spline or proportional-allocation method appears in either Batjes document. Gap-filling operates on a 0-20 / 20-40 cm grid against a 0-30 cm target. Batjes: "Historically, in many countries, the SOC content has only been measured in the upper 10-30 cm of the profile." |
| Methodological discontinuity between soil types | Confirmed at source: Batjes excludes organic soils by design (§5 above). |
| Omitted soil classes | Confirmed. Boreal and Polar undifferentiated; cells still carrying ±90% are precisely those with no Batjes data. |
| Seven classes cannot carry volcanic and montane diversity | Confirmed. **32% of populated cells sit below the author's own n ≥ 30 threshold**, two resting on six profiles. |
| Cross-stratification degrades climate precision | Confirmed. Only 41 of 60 possible climate × soil cells are populated. |
| Fixed reference period | Confirmed. |

**Further limitations found, not in Appendix II, all citable:**

- **Purposive sampling.** "there is a risk of bias as purposive sampling relies heavily on
  personal (expert) judgement... **there is no way of knowing just how good this judgement
  is.**"
- **Gap-filled bulk density and coarse fragments.** "some **63%** have no measured data for
  CF and some **51%** have no measured data for BD", filled by class-median taxotransfer
  rules that are never published.
- **The outlier filter is doing double duty.** A Tukey k=1.5 fence is used both as a
  data-quality filter and to absorb GIS geolocation error: "some 'unrealistic' IPCC climate
  classes may have been allocated to some profiles during the GIS overlay."
- **Profiles with no land-use code default into the native-vegetation reference
  population.** The count is never reported.
- **Dispersion exceeds what IPCC assumes.** Batjes CVs "range from 38%... to 106%... with
  an average of **59%**. By comparison, the IPCC2006 Guidelines assume a relative error of
  ±90%... which corresponds to an average, assumed, CV of 45%."
- **The author's own scale caveat, which is the one to quote:** "The broad grouping of
  SOC30 data into the large, aggregated units that underlie the IPCC Tier 1 level approach
  **may thus mask meaningful variation at the regional (sensu sub-national and project)
  level.**" And: "validation of IPCC reference SOC stocks by comparison with results from
  field measurements, before their widespread adoption in a given project area. **The
  current study supports that recommendation.**"

Do not over-read this. Batjes never says the values should not be used. His operative
recommendation is escalation to Tier 2, not abstention.

---

## 7. Tracking the activity, and what remote sensing cannot do

Improved grassland carries a Tier 1 gain factor and **no land-cover signature**. IPCC says
so directly, in text unchanged between 2006 and 2019 (Annex 3A.4):

> it is often difficult to ascertain changes in land management practices through remote
> sensing. For example, it may be difficult to detect a change from intensive to reduced
> tillage on a specific land area.

The minimum IPCC accepts is a **proportion, not a location**: "management can be
summarized as a proportion of the management practice... in each 'lands remaining' and
'lands converted' land-use category." And even with Approach 3, "it is likely that
inference, for example, based on survey data and expert judgement, will be needed to
apportion the land-use conversion and biophysical data by management practices as data on
management practices are rarely available in spatially explicit formats."

2019 Table 3.6b offers proxies. The entire grassland entry is livestock statistics and
agricultural census data.

Consequence for the paper: remote sensing supplies the denominator (grassland extent),
not the numerator (which hectares are improved). Any project claiming spatially explicit
improved-grassland gains goes beyond what the guidance assumes.

---

## 8. Chronology, corrected

| Year | Event | Effect on countable gains |
|---|---|---|
| 1996/97 | Revised 1996 Guidelines Vol. 3 Ch. 5 | 20-year period, SOCref × factors, sink convention. Gains countable from the start. |
| 2003 | GPG-LULUCF | F_LU/F_MG/F_I formalised. Grassland improved 1.14 / 1.17, F_I 1.11. Rewetting named and declined. |
| 2006 | 2006 Guidelines | `D` symbol introduced, linearity a formal assumption. SOCref from Jobbagy & Jackson and Bernoux, **not Batjes**. Organic soils loss-only. |
| Oct 2010 | IPCC Expert Meeting, Geneva, on HWP, wetlands and soil N2O | The cause of the Wetlands Supplement. |
| Dec 2010 | Batjes, ISRIC Report 2010/10 | Not IPCC. Carbon Benefits Project deliverable. |
| 2011 | Batjes, *Agric. Ecosyst. Environ.* 142:365-373 | The peer-reviewed version of the same study. Values identical to the 2010 report. |
| Dec 2011 | Decision 2/CMP.7, Durban | Created Wetland Drainage and Rewetting as an elective activity. |
| 2012 | IPCC 35th Session, Geneva; Decision 2/CMP.8, Doha | Decision and drafting year. **No methods publication.** |
| Oct 2013, imprint 2014 | Wetlands Supplement and KP Supplement | **"2013" and "2014" are the same documents.** Cite as IPCC 2014, *2013 Supplement...*. The first countable organic-soil and coastal gains. |
| 2019 | 2019 Refinement | Batjes enters Tier 1. **Net effect on gains is negative.** Biochar added. Peatlands untouched. |

**Two corrections.** `IPCC-2010-Erata-Land-Climate-Soil-Carbon-Classification.pdf` is
**EU Commission Decision 2010/335/EU** under the Renewable Energy Directive, not an IPCC
erratum. Its Table 1 is a verbatim copy of IPCC 2006 Table 2.3.

**There was never an immediate-100%-oxidation default for soil.** The 20-year linear
transition is in the 1996 Guidelines, restated in 2003 GPG §4 ("does not alter the basic
default assumptions that land use changes have a linear impact on soil organic matter for
20 years") and formalised in 2006. The immediate-loss rule applies to **biomass**. The
Ecuador Emissions Update conflates the two.

---

## 9. The 2019 Refinement reduced mineral-soil gains

2019 Overview, verbatim:

> Many of the updated factors reflect a smaller impact of anthropogenic activity on soil
> carbon than default factors provided in the 2006 IPCC Guidelines.

Cropland Table 5.5, 2006 versus 2019:

| Practice | Zone | 2006 | 2019 | Change |
|---|---|---|---|---|
| No-till | Tropical dry | 1.17 | 1.04 | **−76% of the gain** |
| No-till | Tropical moist/wet | 1.22 | 1.10 | −55% |
| No-till | Cool temperate/boreal dry | 1.10 | 1.03 | −70% |
| Reduced till | Tropical dry | 1.09 | 0.99 | **sign flip** |
| Reduced till | Tropical moist/wet | 1.15 | 1.04 | −73% |
| Paddy rice F_LU | All | 1.10 | 1.35 | **+0.25** |
| Perennial/tree crop | Temperate/boreal | 1.00 | 0.72 | **−0.28** |

Input factors (F_I) are unchanged. Tropical montane was deleted from the tillage rows.

The mechanism is in Annex 5A.1: depth-explicit integration to 30 cm, "to avoid errors
associated with aggregating data into a uniform set of depth increments", which suppresses
the shallow-layer stratification signal that inflated apparent no-till gains. **This is
the most important methodological point in the 2006 to 2019 comparison.**

Note a consistency problem: Annex 5A.1 defines uncertainty as a 95% confidence interval
while Table 5.5 footnote 2 still says "two standard deviations", carried over unedited.
The ± figures in the two editions are not on the same footing.

---

## 10. Absences to state plainly

- No Tier 1 accumulation rate for undrained, natural, managed peatland. A tropical
  undrained sink of 0.3 to 1.1 t CO2-C/ha/yr sits in Annex 3A.1 prose and is deliberately
  not promoted to a factor.
- No guidance for restoration or rehabilitation without rewetting.
- ~~No published water-table-to-flux regression coefficients~~ **CORRECTED 2026-07-30.**
  The coefficients are not in the Supplement, but they ARE published, in Wilson et al.
  (2016) *Mires and Peat* 17:04, Table 1, by the same authors. Form `flux = a + (b × MWTL)`.
  Temperate rewetted CO2 b = −0.04 ± 0.02 t C/ha/yr per cm; temperate rewetted CH4
  b = 0.036 ± 0.012 log10 units per cm; boreal rewetted CH4 b = 0.049 ± 0.033. See the
  prior-work note.
- **No Tier 1 method for paludiculture anywhere.** The Wetlands Supplement names it six
  times and declines: "does not provide Tier 1 methods for management practices such as
  paludicultures."
- No DOC or POC factors for coastal wetlands in either direction.
- No mangrove BCEF at any tier.
- No agroforestry mineral-soil SOC factor in Table 5.5 in either edition.
- 2006 Ch. 9 Other Land contains **no gain pathway of any kind**, at any tier.
- Settlements Tier 1 yields exactly zero biomass change by construction.
- No C:N default for grassland in Eq 11.8.

## 11. Three distinct "20 years" that must not be conflated

1. The land-conversion residence period (2006 Ch. 2 §2.3.1.1, Ch. 4 §4.3), traced to the
   1996 equilibrium assumption.
2. The transition constants `T_on` in Eq 2.23 and `D` in Eq 2.25, **asymmetric**: 20 years
   for gains, 1 year for losses.
3. The urban-tree active growing period in 2019 Ch. 8, a tree-age sink-duration
   assumption, not a land transition.

Only (1) and (2) coincide numerically, and by design. The 1996 Guidelines explain the
asymmetry and concede it: "the approach to a new equilibrium value is more rapid for
degrading systems than for aggrading systems."
