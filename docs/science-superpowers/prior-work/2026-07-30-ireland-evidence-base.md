# Ireland evidence base: peatlands, coastal wetlands, restoration and crediting

Compiled 2026-07-30 from three parallel deep-dive reviews. Every DOI below was resolved
against Crossref unless flagged. **Evidence classes are load-bearing and must survive into the
manuscript:** PEER = peer-reviewed and read; GREY = official or agency report, read; PREPRINT
= not peer-reviewed; SNIPPET = search-result text only, source not opened.

Two further reviews (grassland nitrogen, national inventory practice) were still running when
this file was written. Their findings go in a companion section.

---

## 1. The four findings that change the paper

### 1.1 Ireland is a published case of a Tier 1 default failing in both directions at once

For the same land use, Irish country-specific factors run **4.1× below** Tier 1 on drained CO2
and **6.3× above** it on drained CH4.

| Land use | Gas | Tier 1 default | Irish country-specific | Direction |
|---|---|---|---|---|
| Grassland, nutrient-poor, drained | CO2 | 5.3 t C/ha/yr | **1.30** (0.04–2.55) | Irish 4.1× lower |
| Grassland, nutrient-poor, drained | CH4 | 1.4 kg C/ha/yr | **8.82** (2.63–15.02) | Irish 6.3× higher |
| Industrial cutaway, poor | CO2 | 2.8 | **1.21** (0.4–2.0) | Irish 2.3× lower |
| Forestry, poor | CO2 | 2.6 | **1.68** | Irish lower |
| Grassland, nutrient-rich, deep-drained | CO2 | 6.1 | **5.08** (3.6–6.57) | indistinguishable |

Source: **Aitova, E., Morley, T., Wilson, D. & Renou-Wilson, F. (2023)**, *Mires and Peat* 29,
Article 04, DOI 10.19189/MaP.2022.SNPG.StA.2414, Table 2. PEER, open access, read in full.

The stated mechanism is that the Tier 1 drained-CO2 pool is dominated by intensively managed
**German** grassland, while the Tier 1 CH4 pool is **deep-drained continental** and Irish sites
are **shallow-drained temperate oceanic**. A single default cannot be conservative for both
gases at once. This is the sharpest empirical statement of the paper's thesis I have found.

Note the structural gap it exposes: Wetlands Supplement Tables 2.1, 2.3 and 2.5 sub-split
deep- from shallow-drained **only within nutrient-rich temperate grassland**. There is no
Tier 1 cell for shallow-drained nutrient-poor temperate grassland, which is arguably Ireland's
most extensive drained-peat land use.

### 1.2 On Ireland's own adopted factors, rewetting a nutrient-rich cutaway is a net penalty

| Transition | Drained (t C/ha/yr) | Rewetted (t C/ha/yr) | Benefit |
|---|---|---|---|
| Domestic extraction → rewetted, **nutrient-poor** | +1.77 (±0.87) | −0.05 (±0.19) | **+1.82** |
| Industrial extraction → rewetted, **nutrient-rich** | +1.93 (±0.84) | **+3.58 (±1.76)** | **−1.65, a penalty** |

Combined emission factors, Aitova (2023) Table 4. The rewetted nutrient-rich CO2 factor is
**+3.22 t C/ha/yr against a Tier 1 default of +0.5, i.e. 6.4× higher**. Aitova's own reading:
"for this type of rewetted peatlands, rewetting actions alone would not be sufficient to avoid
CO2 emissions... rewetting programmes... should prioritise nutrient-poor extraction sites",
and the trajectory explanation is that nutrient-rich rewetted cutaway heads toward **fen**
development rather than raised bog.

This is a countable gain that does not survive, published by the same authors whose factors
Ireland's inventory has since adopted. It is the Irish analogue of the paper's global finding.

**Also note:** rewetted nutrient-poor extraction is a net sink of only **−0.05 ± 0.19**, a
confidence interval straddling zero. In absolute terms the gain is statistically
indistinguishable from nothing. The entire case rests on the counterfactual subtraction. This
independently vindicates the manuscript's callout on never presenting the absolute rewetted
flux as a finding.

### 1.3 The Supplement's own nutrient tie-break is biased against Ireland

Wetlands Supplement Chapter 3: "If the nutrient status of rewetted organic soils in boreal or
temperate zones is not known, countries should use the default nutrient poor EF for sites in
the boreal zone, and the **nutrient rich EF for sites in the temperate zone**."

Ireland is temperate. Ireland's peatland estate is overwhelmingly **ombrotrophic**, roughly
1.4–1.47 Mha of bog against about 20,000 ha of fen, a ratio near **73:1**. Applying the default
rule mechanically assigns unclassified Irish rewetted bog the nutrient-rich factors of
**+0.5 t CO2-C/ha/yr and 216 kg CH4-C/ha/yr** when the physically correct poor factors are
**−0.23 and 92**. The fallback converts a sink into a source by assumption.

**This matters directly to the manuscript**, whose `map_nutrient()` function implements exactly
this rule (currently cited to Ch. 2 p. 2.17; Chapter 3 carries it too). Ireland is a concrete,
citable case where the Tier 1 fallback is biased against a real gain, and it should be named
in the Discussion.

Compounding it: **"nutrient-rich" in the Irish EF tables is not fen at all.** It is (a)
industrially cutaway raised bog at Blackwater, where extraction stripped the ombrotrophic dome
and exposed richer basal peat, and (b) one deep-drained grassland at Lanesborough on limestone.
**No Irish fen GHG flux dataset exists** — Aitova's eleven-category classification contains no
fen category. Any claim that Ireland's nutrient-rich factors represent Irish fens is
unsupported.

And the operative national nutrient split comes from **Hammond, R.F. (1981), *The Peatlands of
Ireland*, Soil Survey Bulletin No. 35, An Foras Talúntais** — a 1981 survey applied as a fixed
proportion, not an observation of present condition. GREY, not opened. **Highest-value document
to obtain**, given how much the inventory rests on it.

### 1.4 Irish saltmarsh accumulates at about a third of the Tier 1 default

| Pathway | IPCC Table 4.12 | Best Irish measured | Ratio |
|---|---|---|---|
| Tidal marsh soil C accumulation | 0.91 t C/ha/yr | **0.290 to 0.384** | **32–42%** |
| Tidal marsh, GB comparator (dated) | 0.91 | 1.109 ± 0.431 | 122% |
| Tidal marsh, global comparator | 0.91 | 2.447 | 269% |
| Seagrass | 0.43 | **no Irish value exists** | — |

Irish values: **Burke, S.A., Manahan, J., Eichelmann, E. & Cott, G.M. (2022)**, *Frontiers in
Marine Science* 9:976457, DOI 10.3389/fmars.2022.976457. PEER. Three Dublin marshes.

Applying Tier 1 in Ireland would **over-credit** tidal marsh by roughly 2.4 to 3.1×, the
opposite direction from the global critique the manuscript currently carries. The honest
framing is that the error direction is **regional**: a single global default is wrong in
opposite directions in different places.

**Two caveats that must travel with this number.** The Irish rates are stock divided by an
assumed marsh age of 150–200 years, not radiometrically dated, so they are long-run averages
including post-depositional loss, whereas Pb-210 rates are recent-century and systematically
higher for that reason. And they come from four marshes in one bay system. A Europe PMC query
for Pb-210 or Cs-137 with Ireland and saltmarsh returns **zero hits**: no dated Irish
accumulation rate exists.

---

### 1.5 H1 reproduces inside Ireland's own national inventory

> **SUPERSEDED 2026-08-01. The table below is WRONG and is kept only to document the error.**
> The corrected result, computed by `05.scripts/prep-irish-crt.py` from the actual workbooks,
> is in **§1.5b immediately after this**. The benefit is **positive at GWP-100 and negative at
> GWP-20**, not negative at both.
>
> **What went wrong:** the reviewing agent used the emission factor of **1.7 t CO2-C/ha/yr**
> that Ireland's inventory *document* states for industrial peat extraction. The **implied**
> factor in the reporting tables for 2024 is **3.587 t C/ha**, more than twice as large.
> Implied factors are emissions divided by area, so they are what the inventory actually
> reports and what reconciles with the reported totals. Using the stated factor understated
> the drained side by about 7 t CO2/ha and reversed the sign at GWP-100.
>
> **The general lesson, worth carrying beyond this paper:** a *stated* factor and an *implied*
> factor can differ by a factor of two within the same national submission. Always compute
> from the reporting tables.

Implied emission factors read directly off Ireland's Common Reporting Tables
(IRL-CRT-2026-V1.0, 2024 vintage), per hectare per year. The arithmetic is the reviewing
agent's and **is superseded**.

| Component | Drained industrial peat extraction | Rewetted industrial peat extraction |
|---|---|---|
| On-site CO2 | 1.700 t C/ha → 6.233 t CO2/ha | 0.410 t C/ha → 1.503 t CO2/ha |
| Off-site DOC CO2 | 1.109 t CO2/ha | 0.784 t CO2/ha |
| CH4 | 22.63 kg CH4/ha | **210.71 kg CH4/ha** |
| N2O | 0.3 kg N2O-N/ha | not occurring |
| **Total, AR5 GWP-100 (Ireland's own metric)** | **8.10 t CO2e/ha/yr** | **8.19 t CO2e/ha/yr** |
| Total, AR6 GWP-100 (CH4 = 27.0) | 8.08 | 7.98 |
| Total, AR6 GWP-20 (CH4 = 79.7) | 9.27 | 19.08 |

**Benefit of rewetting, as Ireland reports it:**

| Metric | Benefit (t CO2e/ha/yr) |
|---|---|
| **AR5 GWP-100, the inventory's own metric** | **−0.09, a net disbenefit** |
| AR6 GWP-100 | +0.10 |
| **AR6 GWP-20** | **−9.81** |

This is the paper's hypothesis reproduced inside a real national inventory rather than from
default tables. On Ireland's own reported factors, post-industrial peatland rewetting is
approximately carbon-neutral at GWP-100 and strongly negative at GWP-20. **Ireland reports at
AR5 (CH4 = 28, N2O = 265), not AR6**, so every comparison with this manuscript's ledger must
convert.

**The near-natural comparison sharpens it.** 885,022 ha of near-natural peatland is reported as
an on-site CO2 **sink** of −1,070.88 kt CO2, but once 551.66 kt of DOC CO2 and 64.55 kt of CH4
(1,807 kt CO2e at GWP-28) are added it becomes a **net source of roughly 1,288 kt CO2e, about
1.46 t CO2e/ha/yr**. This independently reproduces the UK Peatland Code finding in §5.1 that the
reference condition does not net out its own methane, in a second jurisdiction and a different
evidence base.

**A unit ambiguity inside the NID could make it worse.** Supplement Table 3.3 is in kg CH4-**C**;
Chapter 2 Tables 2.3/2.4 are in kg CH4. Ireland converts correctly in its Grassland section
(§6.5.2.4 writes "kg CH4-C") and for forest-converted-to-rewetted-wetland (122.667 = 92 × 16/12),
but **§6.6.4.2 on peat extraction drops the "-C"**. The reported IEF of 210.71 fits either a
95.7% nutrient-rich unconverted reading or a 53.3% nutrient-rich converted reading. If the
conversion is in fact omitted, rewetted CH4 is understated by a third and the GWP-100 benefit
becomes a clear disbenefit of about **−2.05 t CO2e/ha/yr at AR5** and **−15.4 at GWP-20**.
**Resolve by asking the EPA for the nutrient split of the 44,527 ha before publishing.**

### 1.5b CORRECTED: H1 in Ireland's own inventory, computed from the workbooks

Computed by **`05.scripts/prep-irish-crt.py`** from **IRL-CRT-2026-V1.0**, all 35 annual
workbooks 1990–2024, downloaded from the EPA on 2026-08-01. Output:
`02.inputs/derived/irish-crt-peat-balance.csv`. This is in the manuscript, Results, "Ireland's
own inventory, added up".

**Method.** Ireland splits the balance across two tables and neither alone is the answer:
**Table 4.D** carries the on-site soil carbon stock change (t C/ha, CRT sign convention,
positive = gain), and **Table 4(II)** carries the off-site CO2, N2O-N and CH4 from drainage
and rewetting (per hectare). The balance is their sum, and computing it is the arithmetic the
guidance never requires.

**Industrial peat extraction, 2024, t CO2e/ha/yr, positive = net source:**

| Metric | Drained | Rewetted | **Benefit of rewetting** |
|---|---|---|---|
| **AR5 GWP-100 (Ireland's own reporting metric)** | 15.02 | 8.19 | **+6.83** |
| AR6 GWP-100 | 15.00 | 7.98 | **+7.02** |
| **AR6 GWP-20** | 16.19 | 19.08 | **−2.89** |

**The finding is the sign flip, not the level.** No factor changes between those lines; only
the horizon does. The driver is a rewetted CH4 implied factor of **210.7 kg CH4/ha against
22.6 drained, a factor of 9.3**, which a hundred-year weighting discounts and a twenty-year
weighting does not. Ireland reports at AR5 GWP-100, the metric most favourable to the
intervention, and no short-lived-pollutant treatment appears anywhere in its land-use
reporting.

**Near-natural peatland is confirmed as a net source, and this figure was right all along.**
On-site soil carbon **+0.33 t C/ha** (a genuine removal), but adding Ireland's own reported
DOC and CH4 for the same hectares gives a full balance of **+1.46 t CO2e/ha/yr** at AR5
GWP-100, or **+1,288 kt CO2e** across 885,022 ha. This reproduces, in a second jurisdiction
from a different evidence base, the UK Peatland Code finding in §5.1 that near-natural bog is
a net source once methane is counted.

**One completeness gap, reported rather than smoothed over.** Industrial peat extraction is
**62.68 kha in Table 4.D but 34.66 kha in Table 4(II)**. The **28.02 kha** difference carries
an on-site CO2 term but **no CH4 and no N2O**. That understates the drained side and therefore
understates the benefit of rewetting, so the result above is conservative in that respect.

**Still open on this thread:** the unit ambiguity flagged in §1.5 remains unresolved. NID
§6.6.4.2 writes the rewetted peat-extraction CH4 factors without the "-C" where §6.5.2.4
writes them correctly as kg CH4-C. The implied factor of 210.7 fits both a 95.7%-nutrient-rich
unconverted reading and a 53.3%-nutrient-rich converted one. Resolving it needs the nutrient
split of the 44,527 ha from the EPA. If the conversion is in fact omitted, the rewetted side
is understated by a third and the GWP-100 benefit shrinks substantially.

### 1.6 Ireland's reported "rewetted" area is an inference, not an observation

NID §6.6.1: "it is reasonable that where a reduction in exploited peat areas occurs that these
areas become rewetted to some extent where no further information exists as to their status."

The 44,527 ha of "Rewetted Industrial Peat Extraction" reported for 2024 (up from 4,792 ha in
1990) is a **residual**: when extraction area falls, the difference is reclassified as rewetted.
It is not derived from project activity data, hydrological monitoring or verification.

**PCAS activity data has not entered the inventory.** NID §6.6.8: data on the extent of Bord na
Móna's 33,000 ha scheme "is being collated and will be incorporated... in future submissions".
The reported rewetted area runs in parallel with PCAS but is not measured from it.

**And the largest de facto rewetted area in the country is reported as not rewetted.** Ireland
reports 338,918 ha of grassland organic soil, of which 141,000 ha are drained and **197,918 ha
sit under "Other organic soils"** while the CRT line "Rewetted organic soils" reads **NO**. NID
§6.5.2.4 justifies this: "The deliberate rewetting of grasslands on organic soils is as yet not
an established practice in Ireland." Yet Ireland **applies the Supplement's Chapter 3 rewetted
factors to that area** (0.5 t CO2-C/ha on-site nutrient-rich, 0.24 DOC, Table 3.3 CH4). The
category label and the emission factors disagree by design, which keeps the area invisible to
any accounting that keys on the "rewetted" line.

### 1.7 Ireland has the highest methane implied EF of any reporting Party

UNFCCC individual inventory review **FCCC/ARR/2023/IRL**, issued 6 February 2024, finding **L.6,
status "not resolved"**: Ireland reported a CH4 implied EF for drained organic soils in wetlands
of **119.64 kg CH4/ha for 2021**, and the review states this "continues to be the highest CH4 IEF
of all reporting Parties (0.16–119.64 kg CH4/ha)". Ireland replied that it "relates to a
misallocation of emissions". The 2025 simplified review (**FCCC/ETF/SRR/2025/IRL**, 27 June 2025)
still flags 4(II).D.1.a peat extraction CH4 at **95.481 kg CH4/ha as "Above range"**.

Related open finding **L.13**: no CH4 from nutrient-rich organic soils under grassland was
reported at all, with no justification, while it was reported for forest land. Acted on in the
2026 submission.

### 1.8 Uncertainties Ireland assigns to its own numbers

| Category (2024) | Value kt CO2e | Combined uncertainty |
|---|---|---|
| **Grassland remaining grassland, organic soils, CO2** | 2,289.81 | **228.80%** |
| Grassland remaining grassland, CH4 | 1,275.42 | 181.96% |
| Wetland remaining wetland, CH4 | 2,225.05 | 68.00% |
| Rewetted industrial extraction, EF | — | **240%** |
| Industrial extraction, CH4 EF | — | 201.0% |

The **228.8% combined uncertainty on drained grassland organic soil CO2, Ireland's single
largest LULUCF source**, is the number to quote. LULUCF was a **net source in every year from
1990 to 2024**.

### 1.9 The EU layer, verified against EUR-Lex

**Regulation (EU) 2018/841 as amended by 2023/839, Annex IIa**: Ireland's 2016–2018 average is
**4,354 kt CO2e**, its 2030 target is **−626 kt**, and its column D value is **+3,728 kt**, i.e.
a net **emission**. Ireland is one of only two Member States (with Denmark) whose 2030 value is
a net emission rather than a net removal. Compliance is assessed against the inventory submitted
in **2032**; excess in 2026–2029 is multiplied by **1.08** under Article 13c.

EPA projections (26 May 2026) put Ireland **missing the target under both scenarios**: With
Existing Measures LULUCF rises 72.2% to 5.2 Mt, exceeding by 2.6 Mt; With Additional Measures
rises 4.1% to 3.1 Mt, exceeding by 0.5 Mt. The EPA's own assessment is that **no Article 13b
organic-soils flexibility will be available to Ireland**.

**Regulation (EU) 2024/1991 (Nature Restoration Regulation), Article 11(4)**, verbatim: measures
on "at least (a) 30% of such areas by 2030, of which at least a quarter shall be rewetted;
(b) 40% ... by 2040, of which at least a third; (c) 50% ... by 2050, of which at least a third."
Rewetting on agricultural land **remains voluntary for farmers and private landowners**. Peat
extraction sites may be counted, and non-agricultural drained peatland up to a maximum of 40%.

**The denominator problem is the interesting part.** Applying Article 11(4)(a) to Ireland's own
CRT lines:

| Denominator | Basis | Restored by 2030 | Rewetted by 2030 |
|---|---|---|---|
| 338,918 ha | all grassland organic soils | 101,675 ha | 25,419 ha |
| 141,000 ha | only the area Ireland classifies as drained | 42,300 ha | 10,575 ha |

The obligation differs by a **factor of 2.4** depending on which line of the same submission is
treated as "drained peatlands", and because Ireland reports the 197,918 ha as *not* rewetted
while applying rewetted factors to it, both readings can be defended from that submission. Add
the countable peat-extraction sites and the 40% non-agricultural allowance, and Ireland's
already-reported 44,527 ha of rewetted industrial peatland plus the 65,900 ha CAP rehabilitation
KPI could absorb much of the obligation **without a hectare of farmland changing hands**.

### 1.10 Inventory null results worth reporting

- **Ireland does not report a Wetland Drainage and Rewetting category at all.** WDR was an
  elective Article 3.4 activity under the Kyoto Protocol's second commitment period; Ireland
  elected only Cropland management and Grazing land management. The ETF architecture that
  replaced KP accounting is **gross reporting with no counterfactual**, so the counterfactual now
  sits entirely in the EU LULUCF Regulation's 2016–2018 baseline.
- **No coastal wetland emissions or removals anywhere in the inventory.** Salt marsh and
  intertidal flats sit in unmanaged wetlands where "only the area of these lands is reported".
  Chapter 4 of the Supplement is never invoked. (Independently confirmed by the coastal review.)
- **Rewetted organic soils under Forest Land: NO.** "Forest soils are managed to maintain drains
  ... Therefore, forest soils are not rewetted."
- **N2O from rewetted organic soils: NO in every category**, per the Tier 1 negligibility
  assumption.
- **Cropland on organic soils: NO** for both organic and mineral soils, all gases.
- **No GWP\* or short-lived-climate-pollutant treatment anywhere in Irish LULUCF reporting.** The
  inventory is AR5 GWP-100 throughout. Ireland is therefore a jurisdiction whose entire peatland
  accounting rests on the one metric under which the benefit is smallest and the sign least
  secure.
- **The Technical Expert Review Team identified no LULUCF areas of improvement** in Ireland's
  first Biennial Transparency Report (FCCC/ETF/TERR.1/2024/IRL, published 2 June 2026). Every
  sector except Agriculture drew at least one finding. The reporting passes review while carrying
  a 228.8% uncertainty and the highest methane implied EF of any Party.

**Vintage warning.** The TERT reviewed BTR1 figures of 3.98 Mt (2022) and 5.61 Mt (2023); the
NID 2026 now reports 2.47 Mt and 2.96 Mt for the same years, **40 to 47% lower**. Any comparison
across Irish submissions must state the vintage.

### 1.11 Ireland's nitrogen factor is higher than the default, and formulation is the escape hatch

**Ireland uses a country-specific Tier 2 EF1 that exceeds the IPCC default.** NID 2025 Annex 3.3.F
Table 3.3.F.1, extracted directly from the PDF, kg N2O-N per kg N applied on **grassland**:

| Fertiliser | Grassland EF1 | vs IPCC default 1.0% |
|---|---|---|
| **CAN** | **0.0149 (1.49%)** | 1.49× |
| Urea + NBPT (protected) | **0.0040 (0.40%)** | 0.40× |
| Urea (unprotected) | 0.0025 (0.25%) | 0.25× |

Derived from **Harty et al. (2016)**, *Sci. Total Environ.* 563-564:576–586, DOI
10.1016/j.scitotenv.2016.04.120, for grassland, and Roche et al. (2016) for arable, weighted
92:8. Ireland's implied EF1 is **0.0124**, which the NID describes as 24% above the 2006 default
and 107% above the 2019 Refinement wet-climate default of 0.006. *(Both statements appear in the
same document against different comparators; neither is wrong but the NID does not reconcile
them.)*

Independent corroboration of the ranking, CAN ≫ protected urea > urea: **Rahman et al. (2021)**,
*Agric. Ecosyst. Environ.* 313:107382, DOI 10.1016/j.agee.2021.107382 (CAN 1.62%, urea 0.46%,
urea+NBPT 0.60%); **Cowan et al. (2020)**, *Environ. Int.* 135:105366, DOI
10.1016/j.envint.2019.105366, Bayesian over 20 years of UK and Irish data (CAN 1.11%,
urea+NBPT 0.32%).

**Rahman et al. also found EF1 rises significantly with N rate**, in 3 site-years for CAN, 5 for
urea and 2 for protected urea. The penalty is therefore **not linear in N applied; it
accelerates**. Any crossover computed with a constant EF1 is conservative.

**Consequence for the manuscript's nitrogen trap.** At AR6 GWP-100 with the 2019 indirect
defaults, the penalty per kg N applied is **5.894 kg CO2e at the IPCC default** (this reproduces
the manuscript's existing figure exactly, confirming the calculation chain) and **7.997 kg CO2e
under Ireland's CAN factor**, a 36% increase, but only **3.320 kg CO2e under protected urea**.

**Formulation is therefore a second escape hatch alongside non-nitrogen improvement**, and it is
the policy-active one: Ireland's Nitrates Regulations now make the full chemical-N allowance
conditional on excluding unprotected solid urea (S.I. 119/2026, Table 13, footnote 4), and
protected urea's share of straight N fertiliser rose from 0.5% of total N in 2017 to 18% in
2024, **falling back to 15% in 2025**, the first decline.

### 1.12 Irish data contradict the improved-grassland factor itself

Two independent Irish datasets put improved grassland **below** unimproved, against F_MG = 1.14.

**EPA Research Report 422 (SOLUM)**, GREY. Its Tier 2 general linear model for SOC uses
unimproved grassland as reference; the coefficient for improved grassland is **−0.10519 ± 0.04408,
p = 0.017** on the log scale, i.e. **exp(−0.10519) = 0.900**, about **10% less** soil carbon under
improvement. The report's own words: "the calculated tier 2 SOC stocks being higher for
unimproved grasslands than for improved systems." Scale of the resulting change: currently
reported mineral-soil removals from grassland remaining grassland of **−1,246 and −1,563 kt CO2**
(2005, 2015) become **−24 and −74 kt CO2** under Tier 2, a reduction of **95 to 98%**.

**NID 2025 Table 6.20**, Ireland's own Tier 2 F_LU values from Black et al. (2014) and the Irish
Soil Information System soil pits:

| Soil group | Improved grassland | Unimproved grassland |
|---|---|---|
| Cambisol | 1.09 | 0.91 |
| **Gleysol** | **0.85** | 0.89 |
| Luvisol | 1.37 | 0.99 |
| Podzol | 1.09 | 0.94 |
| **Average** | **1.05** | 0.92 |
| **IPCC Tier 1** | **1.14** | 0.98 |

The Irish average is below the default, and **on gley soils it is 0.85, a loss where the default
claims a gain**. Gleysols are 0.22 of the Irish soil-association area.

**Reproducing Ireland requires care:** Ireland places the 1.14 in the **F_I column, not F_MG**
(NID Table 6.31) and does **not** compound it with F_I 1.11. Ireland's effective adjustment
factor is **1.14, not 1.2654**. Ireland's dominant IPCC soil class is **LAC at SOCref 85 t C/ha**,
0.71 of national area (NID Table 6.28).

### 1.13 Rewetting Irish grassland peat is also a disbenefit on Ireland's own factors

Using Aitova (2023) Table 2 country-specific factors, on-site CO2 plus CH4 only, AR6 biogenic
methane:

| Metric | Drained (t CO2e/ha/yr) | Rewetted | **Benefit** |
|---|---|---|---|
| GWP-100 | 5.084 | 5.568 | **−0.484** |
| GWP-20 | 5.704 | 10.353 | **−4.649** |

A second national instance of the metric-dependence finding, and again from **country-specific
factors Ireland has already adopted**, not from IPCC defaults. Three cautions: the rewetted
grassland CH4 factor rests on a **single study**; adding fluvial carbon would improve the drained
side slightly (drained 0.37 t C/ha/yr, **no rewetted value published**); and Aitova's own combined
carbon-mass ledger reads the other way, 3.09 drained against 1.16 rewetted t C/ha/yr, **precisely
because it applies no GWP to methane**. That last point is the paper's thesis in one line.

### 1.14 Two Irish papers, same year, same inventory, opposite signs

**Tuohy et al. (2023)** use an entirely different factor set, from Paul et al. (2018), giving a
large **positive** rewetting benefit:

| Land use | Drained (t CO2e/ha/yr) | Rewetted | Benefit |
|---|---|---|---|
| Grassland, nutrient-poor, shallow drained | 23.29 | 3.1 | **+20.2** |
| Grassland, nutrient-poor, deep drained | 24.08 | 3.1 | **+21.0** |
| Grassland, nutrient-rich, deep drained | 29.18 | 9.9 | **+19.3** |

These are **irreconcilable** with the Aitova/NID factors that give −0.484. Two Irish papers
published in the same year, both feeding the same national inventory, disagree on the **sign** of
the rewetting benefit. That contradiction is itself citable and is a compact illustration of how
much rests on factor choice.

### 1.15 Irish nitrogen application rates, for the crossover

- **Dairy chemical N** roughly **148 to 185 kg N/ha** over 2019–2024 (Teagasc, read off an
  unlabelled chart to ±3 kg; the Teagasc NFS Fertiliser Dashboard holds the exact series but is a
  Power BI embed that returned 403 — **request from Teagasc directly**).
- **Derogation dairy farms:** chemical N fell 212 → 163 kg N/ha, total N 290 → 230, 2013 to 2023
  (McCormack et al. 2026, *J. Dairy Sci.*, DOI 10.3168/jds.2025-27663; **SNIPPET, 403, verify**).
- Dairy uses close to **3× the chemical N per hectare of the average drystock farm** (Teagasc NFS
  Sustainability Report 2022).
- **National fertiliser N sales** peaked at 408,495 t (2018), troughed at 280,569 t (2023),
  rebounded to 349,293 t (2025), which **exceeds Ireland's 2025 Climate Action Plan target of
  330,000 t by 5.8%**. CSO, official statistics.
- **Derogation:** 250 kg N/ha fell to **220 kg N/ha from 1 January 2024** in affected catchments
  under Article 12(3) of **Commission Implementing Decision (EU) 2022/696**; renewed for three
  years to 2028 by **Commission Implementing Decision (EU) 2026/67**, with a further 5% cut from
  1 January 2028 under a new Article 9a.
- **NULL: no Irish study sets a grassland soil carbon gain against its N2O penalty over time.**
  Searched extensively. The nearest is Wang et al. (2023), *Nat. Commun.* 14:7625, which is global.
  **The gap is real and the paper can claim it.**

### 1.16 The measured-gain inversion

If the Tier 1 gain is replaced by Ireland's **measured** values, the crossover disappears
entirely. Teagasc MACC 2023 puts enhanced grassland management at a modelled **0.5 t CO2e/ha/yr**
with a sensitivity range of **−0.1 to 0.84**. At 0.5 t CO2e/ha/yr, the CAN penalty at 180 kg N/ha
(1.44 t CO2e/ha/yr) **exceeds the gain from year one**: the system is a net source immediately,
with no crossover at all.

Against that, NASCO eddy-covariance at Johnstown Castle gives a **preliminary** measured
2.34 t CO2/ha/yr against a Tier 1 EF of 0.51, "nearly 4.5 times more CO2 than is reported".
**The same page immediately qualifies it and the qualification is the important part:** after
conversion to forage crops the site "shifted from a net sink of C to a net source... ranging from
1.9 to 6.9 t CO2/ha per year", and during the 2018 heatwave it "transitioned from a net sink to a
net source at a mean rate of 4.9 t CO2/ha per year". Irish grassland sink estimates are not
robust to management change or to a single hot summer.

**NULL: Ireland has no national repeat-sampling soil carbon inventory** and "there is no
measurement, reporting and verification (MRV) strategy for carbon sequestration in Irish grassland
soils" (SOLUM). A ~200-site fixed observatory is proposed, not established.

---

## 2. Irish peatland extent and condition

**Derived Irish Peat Map v2: 1,466,469 ha, 20.6% of the national area.** Connolly, J. & Holden,
N.M. (2009), *Irish Geography* 42(3), 343–352, **DOI 10.1080/00750770903407989**. PEER.
*Citation trap: a duplicate Crossref record exists at DOI 10.55650/igj.2009.104, the journal's
later re-hosting, dated 2014. Cite the Taylor & Francis DOI. Do not quote the superseded DIPM
v1 figure of 13.8%.*

Cross-tabulation by type and land use, reconciling to the DIPMv2 total (EPA Research Report
401, Table 3.3, GREY):

| Type | Natural | Grassland | Forestry | Cutaway | Cutover | Total |
|---|---|---|---|---|---|---|
| Raised bog | 80,000 | 171,572 | 83,000 | 71,401 | 98,504 | 504,477 |
| Lowland blanket bog | 123,026 | 161,478 | 239,161 | 8,599 | 96,041 | 628,305 |
| Mountain blanket bog | 66,245 | 86,950 | 128,779 | – | 51,714 | 333,688 |
| **Total** | 269,270 | 420,000 | 450,940 | 80,000 | 246,259 | **1,466,469** |

EPA 401 = Renou-Wilson, F., Byrne, K.A., Flynn, R., Premrov, A., Riondato, E., Saunders, M.,
Walz, K. & Wilson, D. (2022), *Peatland Properties Influencing Greenhouse Gas Emissions and
Removal (AUGER)*, EPA Research Report 401. **GREY.** Caveat printed in the source: the
lowland/mountain split is **not observed** but applied as a fixed 65:35 ratio, and cutover
areas are obtained by subtraction.

**The drained area was halved in 2023.** Tuohy, P., O'Sullivan, L., Bracken, C.J. & Fenton, O.
(2023), *Journal of Environmental Management* 344, 118391, **DOI 10.1016/j.jenvman.2023.118391**.
PEER, open access, read from PDF. The inventory assumes all 335,000 ha of grassland peat is
drained, giving 8–9 Mt CO2e/yr. Scenario testing puts the likely drained area at
**90,000–120,000 ha** and emissions at **3.6–4.7 Mt CO2e, i.e. 40–53% of the inventory
estimate**. Mechanism: drains on peat have limited lateral influence, were rarely installed at
the spacing needed to hold a 0.4–0.5 m water table, and were not maintained, so much nominally
drained grassland peat has effectively self-rewetted.

**Largest activity-data uncertainty:** domestic cutover, quoted as **101,767 to 612,000 ha**, a
six-fold range. Aitova resolve it by subtraction at 334,259 ha.

---

## 3. Irish flux measurements that matter

### 3.1 Moyarwood, Co. Galway: the paired before/after with a drained control

**The single most useful Irish study for a counterfactual argument.** Wilson, D., Mackin, F.,
Tuovinen, J.-P., Moser, G., Farrell, C. & Renou-Wilson, F. (2022), *Global Change Biology*
28(21), 6349–6365, **DOI 10.1111/gcb.16359**, PMC9804235. PEER, open access.

230 ha raised bog, Sphagnum peat 440 cm mean depth, pH 4.4, **nutrient-poor**. Rewetted by
peat-dam ditch blocking 2012/13; monitored **5 years from the year of rewetting**. Static
chambers, not eddy covariance.

| Flux (g C m⁻² yr⁻¹) | Drained (marginal) | Rewetted (sub-central) |
|---|---|---|
| CO2 (NEE) | +141.1 ± 25.5 | −103.7 ± 37.2 |
| CH4 | 0.5 | **19.3 ± 5.2** |
| DOC | 15.4 ± 0.6 | 6.4 ± 0.4 |
| N2O | not detectable | not detectable |
| **NECB** | **+157.0 ± 25.5** | **−78.0 ± 37.6** |

**Benefit of rewetting = 2.35 t C/ha/yr.**

**A methane overshoot was observed and it did not reverse the gain.** CH4 by year: peak in
**year 2 at 20.58**, then 19.01, 19.53, 18.62 g C m⁻² yr⁻¹, a decline of roughly 10% over three
years. CO2 uptake climbed monotonically and much faster: −19.5, −77.3, −131.1, −147.8, −143.0.
NECB went from +5.7 (source, year 1) to −121.9 (sink, year 4), a net sink in 4 of 5 years.

**The absolute methane level, not the trajectory, is where Ireland departs from Tier 1:** the
sustained 19.3 g C m⁻² yr⁻¹ is **193 kg CH4-C/ha/yr, 2.1× the Tier 1 temperate nutrient-poor
default of 92**. Both the paper and EPA 401 state this explicitly. Proposed mechanism: rewetting
inundated a standing vegetation layer, supplying labile carbon to methanogens.

Radiative-forcing switch-over from warming to cooling, modelled: SSP1-1.9 in 2085; SSP1-2.6 in
2094; SSP2-4.5 in 2097; SSP3-7.0 ~2087; **SSP5-8.5 never through 2200**.

### 3.2 A crude chronosequence, assembled across sites (not a published finding)

| Site | Rewetted before study | CH4 (g C m⁻² yr⁻¹) |
|---|---|---|
| Moyarwood | 0 yr (concurrent) | 19.3 |
| Abbeyleix | 7 yr | 12.6 ± 7.9 |
| Bellacorick | 7 yr | 9 ± 2 |
| Clara West | 22 yr | — |

Reads as roughly 19 in years 0–5 and 9–13 from year 7, consistent with a decadal decline. **It
is a comparison across sites with different previous land uses, not a controlled
chronosequence, and no Irish chronosequence study exists.** Do not present it as one.

### 3.3 Rewetting that failed

Rigney, C., Wilson, D., Renou-Wilson, F., Müller, C., Moser, G. & Byrne, K.A. (2018), *Mires
and Peat* 21, Article 24, **DOI 10.19189/MaP.2017.OMB.314**. PEER. Two rewetted ex-forestry
sites, Pollagoona (Co. Clare) and Scohaboy (Co. Offaly/Tipperary), remained CO2 sources at
+131.6 ± 298.3 and +585.3 ± 241.5 g C m⁻² yr⁻¹ after felling and rewetting: "the C sink function
has not yet been restored at either site". Brash plots worst at +819.31.

Aitova **excluded these sites from EF derivation** for that reason and fell back to Tier 1.
Ireland's inventory goes further and states "forest soils are not rewetted".

Blackwater, Co. Offaly (Renou-Wilson et al. 2019, *Ecological Engineering* 127, 547–560, DOI
10.1016/j.ecoleng.2018.02.014, PEER): rewetting hydrologically successful, but the nutrient-rich
industrial cutaway "did not exhibit typical raised bog flora" and stayed a CO2 source at
+0.66 ± 168 g C m⁻² yr⁻¹.

### 3.4 Unit trap that must not be missed

The Supplement is **internally inconsistent between chapters** and Irish papers convert
silently:

- **Chapter 2 CH4 (Tables 2.3, 2.4) is in kg CH4.**
- **Chapter 3 CH4 (Table 3.3) is in kg CH4-C.**

Aitova report everything as carbon and therefore restate Table 2.3 values by 12/16. Verified:
grassland nutrient-poor temperate 1.8 kg CH4 → 1.4 kg C; grassland deep-drained nutrient-rich
16 → 12; forest temperate 2.5 → 1.9; peat extraction 6.1 → 4.6. **The manuscript's `drained`
chunk already handles this correctly** (comment: "methane, NOT methane-carbon"); keep it.

---

## 4. Coastal: extent, gates and the salinity question

**Mangroves are absent from Ireland**, so the strongest coastal pathway in the global ledger
(1.62 t C/ha/yr, 386 t C/ha ceiling, ~240 years of headroom) has no national application.
Ireland inherits the two weakest coastal factors and none of the strong one. That is itself a
result worth stating.

**Extent disagrees by a factor of 2.6.** Ireland's own ground survey gives **38 km²** of Annex I
saltmarsh (about 53 km² counting *Spartina* swards); the Marine Institute synthesis uses
**100 km²** taken from a global remote-sensing compilation. McCorry & Ryle (2009) address it
directly: their figure "is likely to be more accurate than other remote-sensing techniques such
as the CORINE land-use survey". Article 17 returns give 3,799 ha (2013–18) and 3,796 ha
(2019–24).

**Every Irish saltmarsh creation event fails the planting gate.** NPWS's own monitoring report
(Brophy et al. 2019, Irish Wildlife Manuals No. 108, GREY) documents all three: Kilmacleague was
a deliberate breach that colonised unassisted and partly by invasive *Spartina*; Harper's Island
was an **accidental** levee breach; the Youghal Bypass realignment produced mudflat and **no
saltmarsh at all**. Unassisted recolonisation scores **zero** under Table 4.12. Ireland's
contribution to the 15,807 ha of European managed realignment is nil.

**Seagrass is the mirror image.** Transplant work at Killala Bay, Tralee Bay and Kilkieran Bay
would qualify on the planting gate, but no areas, dates, survival rates or peer-reviewed
publication were located, scale appears to be experimental plots, and the 0.43 t C/ha/yr default
has **never been checked against a single measurement anywhere on the island**. The only island
seagrass stock measurement is Northern Irish: McIlvenny, Clements & Helyar (2026), *Frontiers in
Marine Science* 13:1809172, DOI 10.3389/fmars.2026.1809172, PEER, 109.7 ± 18.9 Mg C/ha, with no
dating and a borrowed UK accumulation rate.

**Ireland reports no coastal wetlands in its inventory, at any tier.** Text extraction of the
2025 and 2026 National Inventory Documents: "coastal wetland" **zero occurrences**, "seagrass"
**zero**, "salt marsh" **twice**, in one sentence placing it in an undifferentiated *unmanaged
wetlands* pool where **only area is reported**. Chapter 4 of the Supplement is never invoked,
while Chapters 2 and 3 are fully operationalised. The peatland half of the Supplement is in use;
the coastal half is untouched.

**The salinity gate bites in Ireland, and the hectares are unquantified.** Table 4.14's 18 ppt
threshold is the Venice-system mesohaline/polyhaline boundary, which Irish WFD reporting already
uses. Inland Fisheries Ireland's 2015 transitional-waters survey (GREY, primary measurement)
records these below 18 ppt:

| Estuary | Salinity recorded (ppt) |
|---|---|
| Avoca, Co. Wicklow | 0.059–6.43 (entirely) |
| Erne, Co. Donegal | 10.1–21.5 (2.4 max in 2012) |
| Ballysadare, Co. Sligo | 0.39–18.5 |
| Gweebarra, Boyne, Camus, Kinvara, Castlemaine | upper reaches |

Upper Shannon saltmarsh pore water averages **≤7.0 ppt** (Deegan, Harrington & Dundon 2005,
*Aquatic Botany* 81:199–211, DOI 10.1016/j.aquabot.2004.11.006, PEER; the 7.0 figure is from the
abstract via SNIPPET). The Fergus and Lower Shannon estuaries carry substantial Annex I
saltmarsh.

**No dataset joins the NPWS saltmarsh polygons to WFD salinity class.** Building that join would
quantify the hectares exposed to the 193.7 kg CH4/ha/yr default, which costs **5.23 t CO2e/ha/yr
at AR6 GWP-100** and reverses the pathway's sign. Both layers are public. **This is the
recommended Irish analysis:** tractable, novel, needs no fieldwork, and does not depend on the
broken SIS export.

**Contradicting assertion to handle:** the Marine Institute synthesis asserts "the majority of
saltmarshes in Ireland are inundated by full seawater (35 ppt salinity), it is likely they emit
low amounts of methane gas". That is an assertion, not a measurement, and the IFI salinity data
contradict it in detail.

---

## 5. Restoration and crediting

### 5.1 The UK Peatland Code's own science corroborates the thesis

Evans et al., *Aligning the Peatland Code with the UK Peatland Inventory*, report to Defra and
the IUCN Peatland Programme, March 2022 rev. January 2023. **GREY**, read in full. Tier 2
factors, **AR5 GWP-100 (CH4 = 28, N2O = 265)**, t CO2e/ha/yr:

| Condition | Direct CO2 | DOC | POC | Direct CH4 | Ditch CH4 | N2O | **Total** |
|---|---|---|---|---|---|---|---|
| Near-Natural Bog | −3.54 | 0.69 | 0.00 | 3.17 | 0 | 0 | **+0.32** |
| Near-Natural Fen | −5.06 | 0.69 | 0.00 | 4.01 | 0 | 0 | −0.36 |
| **Rewetted Bog** | −0.58 | 0.88 | 0.00 | 3.11 | 0 | 0.01 | **+3.42** |
| Rewetted Modified Bog | −3.54 | 0.69 | 0.00 | 3.17 | 0 | 0 | +0.32 |
| **Modified Bog, drained** | 0.03 | 1.14 | 0.26 | 1.69 | 0.15 | 0.05 | **+3.32** |
| Extracted, industrial | 5.44 | 1.14 | 10.27 | 1.14 | 0.76 | 0.12 | +18.86 |
| Cropland, peat >40 cm | 27.06 | 1.14 | 0.51 | 0.05 | 1.63 | 6.78 | +37.17 |

Three things fall straight out:

1. **Near-natural bog is a net source at GWP-100.** A genuine −3.54 CO2 sink is overturned by
   3.17 of methane plus 0.69 of DOC. The reference condition of the whole restoration enterprise
   does not net out its own methane.
2. **Rewetted Bog (3.42) exceeds drained Modified Bog (3.32)**, a **−0.10 disbenefit**. The Code
   avoids booking it only by routing restoration into *Rewetted Modified Bog*, whose footnote
   reads: "The EF for Rewetted Modified Bog is assumed to be the same as Near-Natural Bog **due
   to lack of data**." The credited benefit for the commonest project type rests on an
   **assumed** post-restoration factor.
3. **Methane is managed by exclusion as much as by pricing.** Evans et al. removed from the
   database every site with a mean water table more than 5 cm above the surface, "due to extreme
   levels of methane... which do not represent a desirable re-wetting endpoint", and recommended
   such projects be ineligible. The Code echoes it. Underlying CH4: Rewetted Bog 111.11,
   Near-Natural Fen 143.25 kg CH4/ha/yr against drained Modified Bog 61.75.

**Deployment reality:** 408 registered projects on 58,860 ha, but **2 verified**. Verified
tonnage is **0.87%** of registered. Northern Ireland has 5 projects on 174 ha. Average project
duration 80 years. IUCN statistics as of 30 April 2026, GREY.

The Code does supply what the IPCC does not: a measured baseline held at pre-restoration
condition, two additionality tests, a permanence rule tied to peat depth, and a four-stage
deduction stack ending in a 20% risk buffer.

### 5.2 Irish carbon claims omit methane entirely

**Methane appears in none of seven primary Irish sources checked:** the Bord na Móna 100 Mt
press release, the PCAS homepage, the Peatlands and People scheme announcement, the Peatland
Standard for Ireland pages, the Peatland Finance Ireland FAQ, the PFI Irish Peatlands page, and
the Amazon release. The one PCAS page that mentions it cites Günther et al. (2020) as a reason
not to worry and **presents no calculation in which methane is netted**.

**The clearest single instance:** Irish Times, February 2022, sourced to Bord na Móna: "At least
7.5m tonnes of carbon captured by peatlands rehabilitated in 2021", on **5,200 ha**. That is
roughly **1,440 t C per hectare in one year**, which is not a flux at all. It is almost certainly
the **stock** beneath the rehabilitated area restated in the grammar of an annual capture. No
methodology, no counterfactual, no gas split, methane unmentioned.

**The one Irish number built correctly:** "over the period to 2050, 3.2 million tonnes of CO2
emissions will be avoided... in comparison to a **standard rehabilitation scenario**". Incremental,
against the licence-mandated counterfactual, and **two orders of magnitude smaller** than the
100–109 Mt headline. Roughly 3.9 t CO2e/ha/yr over 33,000 ha if realised evenly, the right order
for a drained-to-rewetted difference. The derivation is unpublished; the consultancy page
carrying it now redirects.

**PFI's public claims:** Irish peatlands emit >2.3 MtCO2/yr; healthy peat soils could sequester
"up to 4.5 MtCO2 per annum"; restoration "for less than €5/tCO2e". Methane unmentioned. Against
Evans et al.'s Tier 2 numbers a rewetted or near-natural bog carries ~3.1–3.2 t CO2e/ha/yr of
methane, of the same order as the entire CO2 sink. A gross-uptake headline paired with a
€5/tCO2e abatement cost is precisely the failure mode this paper describes.

**No published critique of Irish restoration carbon claims for omitting methane exists.** That
makes this original material.

### 5.3 The institutional layer

- **No operating Irish peatland carbon code.** The **Peatland Standard for Ireland v1.0**
  (Peatland Finance Ireland, launched 7 March 2025) certifies "verified ecosystem certificates",
  not carbon credits, is in **pilot** with no new restoration activities, and has **issued
  nothing**. Its public pages make no mention of methane, IPCC tiers, emission factor source,
  baseline method, additionality test, permanence period or buffer.
- **No Verra or Gold Standard project on Irish peatland or coastal wetland.** SNIPPET-strength
  null: both registries are JavaScript applications that could not be queried directly. Confirm
  by hand before publishing the claim.
- **No Irish farmer-facing scheme pays on a quantified greenhouse gas outcome.** ACRES, FarmPEAT
  and the Pearl Mussel Project all pay on habitat condition scores or prescribed actions. Irish
  rewetting policy runs entirely on proxies, with no counterfactual and no gas-by-gas ledger
  anywhere in the payment chain.
- **The Climate Action Plan's 80,000 ha commitment is not a rewetting target.** It is "reduced
  management intensity" on grassland on drained organic soils by 2030, a catch-all covering
  rewetting, lower stocking, fertiliser cuts and shallower drains. Reported ACRES uptake ~2,500 ha.
  SNIPPET, paywalled source.
- **PCAS delivery:** 33,000 ha target across 82 bogs, €108 m EU, contractual completion 31 August
  2026. 18,861 ha (57%) by end-2024 per a third-party research site; the EC portal publishes **no
  quantitative progress metrics**. Treat the 20,000 ha cumulative figure as unverified.

### 5.4 The document that would close the argument

**The EU adopted the CRCF carbon farming delegated act on 9 July 2026**, including a methodology
for **"rewetting and restoration of peatlands and other organic soils"**, under Regulation (EU)
2024/3012. The Commission news item confirms adoption but does not state which gases are
counted, the monitoring period, or the baseline rule. **The Annex is unread and is the single
highest-value outstanding document for this paper.** If it imports IPCC Tier 1 defaults without
importing a counterfactual and a gas-by-gas net test, it institutionalises exactly the failure
described here, and that is the natural closing argument.

---

## 6. Traps, contradictions and things not to repeat

1. **Aitova (2023) version trap.** The PDF is stamped "Data corrected 15 Dec 2023" and gives a
   national total of **1.9 Mt C/yr (0.4–3.4)**. Indexed abstracts and secondary sources still
   carry **2.3 Mt C/yr**. **Use 1.9 and cite the corrected PDF.**
2. **Aitova Table 2 lists Tier 1 N2O for temperate drained Forest Land as 2.5**; Supplement Table
   2.5 says **2.8**, with an identical confidence interval. Probable transcription slip. Verify
   before reproducing either.
3. **The 883 vs 112 Mg C/ha coastal contradiction.** The Marine Institute synthesis reports
   883 ± 225 Mg C/ha for North Bull Island attributed to "Burke et al., unpubl. data"; Burke et
   al. (2022) published the same lagoons at **72.6 and 73.5**. An order of magnitude. Ireland's
   circulating 8.8 Mt national saltmarsh stock rests on the unpublished value **and** on the
   contested 100 km² extent. Do not use 8.8 Mt without a correction note.
4. **Moyarwood double-counting.** The site appears in both Renou-Wilson et al. (2019) and Wilson
   et al. (2022) with near-identical CH4 (19.7 vs 19.3). One site, not two observations.
5. **Do not cite "~75 t CO2-eq/ha mitigated at Bellacorick"** to Renou-Wilson et al. (2019). A
   search snippet attributes it there; the agent could not find it in the manuscript.
6. **The IPCC coincidence.** The Irish Peatland Conservation Council (an advocacy NGO, confusingly
   also "IPCC") gives 269,267 ha "in conservation", numerically identical to the EPA "natural"
   area. Different concepts sharing a number; do not treat one as corroborating the other.
7. **The one Irish saltmarsh methane measurement is a preprint** (Fuchs, Delamer, Jessen & Cott
   2025, SSRN, DOI 10.2139/ssrn.5641719, **not peer reviewed**), its values read only from a
   search snippet because SSRN returned 403 twice, and it sampled a **fully marine** site in
   October, April and May, missing the summer maximum. Do not annualise it.
8. **NID and Aitova disagree on whether rewetted grassland exists.** Aitova list the area as
   **0 ha**; Ireland's inventory creates one by reclassifying ineffectively drained land as
   rewetted. Flag the disagreement rather than picking a side.
9. **Every Irish rewetting study is chamber-based.** No Irish eddy-covariance record of a rewetted
   peatland exists; EC exists only for near-natural Glencar. Barry et al. (2025), *Wetlands
   Ecology and Management* 33:81, DOI 10.1007/s11273-025-10089-6, compares light and dark chamber
   CH4 measurements in Irish bogs and is directly relevant, since Wilson et al. (2022) used an
   **opaque** chamber for CH4 and a transparent one for CO2. Not opened.

## 7. Null results worth reporting as findings

- **No Irish fen GHG flux dataset exists.** The largest structural gap for any nutrient-status
  argument, given that Irish fens map cleanly onto the IPCC nutrient-rich class.
- **No Irish CH4 ditch flux measurements.** Ireland uses Tier 1 ditch factors of 527, 1165 and
  542 kg CH4/ha/yr throughout, and Aitova state the data "are not currently available in Ireland".
- **No Irish N2O measurement from a near-natural peatland**, and **no CH4 or N2O data for drained
  forestry on peat**.
- **No radiometrically dated saltmarsh carbon accumulation rate anywhere on the island.**
- **No Irish seagrass sedimentary carbon stock in the Republic**, and no dated seagrass
  accumulation rate anywhere on the island.
- **No Irish saltmarsh methane measurement in a brackish or low-salinity setting**, which is
  exactly the setting where the Table 4.14 gate would bite.
- **No Irish chronosequence study of post-rewetting methane.**
- **No published critique of Irish restoration carbon claims for omitting methane.**

## 7b. Documents retrieved 2026-07-31, closing most of §8

### The CRCF carbon farming delegated act. OBTAINED, and it answers the paper's policy question

**Commission Delegated Regulation supplementing Regulation (EU) 2024/3012 ... establishing the
certification methodologies for carbon farming activities**, document **C(2026) 4666 final**,
Brussels, 9 July 2026. Act 10 pp., Annex 42 pp.

**No CELEX or OJ reference exists yet, and that is not a retrieval failure.** Article 4 makes
entry into force contingent on OJ publication; the act was transmitted to Parliament and Council
on 10 July 2026 (Council doc 11809/26) and sits inside the Article 16(4) two-month scrutiny
window. Cite as `C(2026) 4666 final, 9 July 2026` and **re-check EUR-Lex after ~9 September
2026**, then replace with the published Delegated Regulation number. The comparable permanent-
removals act completed this route as Delegated Regulation (EU) 2026/285.

Retrieval route, since EUR-Lex and the transparency register both fail: the Better Regulation
attachment API, `https://ec.europa.eu/info/law/better-regulation/api/download/090166e5303f9d0c`
(act) and `.../090166e5303f9cd4` (annex). EUR-Lex search pages return HTTP 202 with an empty
body; `data.consilium.europa.eu` PDFs return 500. **Copy both PDFs into `02.inputs/` before the
URLs rot.**

Four provisions, all quotable and all now in the manuscript Discussion §4.8:

1. **Tier 1 defaults are excluded from the organic soil pool.** Annex Table 4 permits only
   Approach 1 (models) and Approach 3 (proxies) for soil organic carbon in organic soils.
   Approach 4 (default emission factors) is confined to N2O from managed agricultural soils,
   liming and urea, and fuel combustion. Section 2.4.4.1 allows national Tier 2 factors first and
   IPCC Tier 1 only where no Tier 2 exists, **but only within those Approach-4 pools**. The soil
   flux the intervention is about cannot come from a default table at all.
2. **CH4 is quantified, never assumed.** Annex Table 3 assigns "CO2, CH4, N2O" to organic soils.
   Proxy models must rest on "a meta-analysis of published data including at least CO2 and CH4
   emissions", must "correlate site proxy variables (such as water table depth or vegetation
   types) to GHG fluxes using statistical regression or multivariate analysis", and must be
   validated on "year-round GHG measurements on at least 100 sites, representative of at least 10
   different combinations of water table depths and vegetation". Off-site fluvial carbon (POC,
   DOC, DIC) is mandatory.
3. **The methane overshoot is priced.** Section 1.2.2.1: "During the first five years of the
   activity, either the absence of a methane emission peak shall be plausible based on monitored
   vegetation and water table depth or **10 tons CO2-equivalent per hectare shall be deducted each
   year** from the net soil emission reduction benefit." That charge exceeds the entire GWP-100
   benefit of most rows in our ledger.
4. **The horizon is capped by the substrate.** Activity period at least 10 years, at most 30 or
   the peat depletion time, whichever is smaller, at **1.0 cm/yr on bogs and 1.5 cm/yr on fens**.
   The first duration rule in the corpus derived from a physical quantity rather than assumed.

Also: baseline is activity-specific over at least three prior years, and the 1%/yr ambition
ratchet **explicitly does not apply to peatlands** (Recital 7). Uncertainty deduction is "8% or
equal to the estimated uncertainty, whichever is higher" in the operative text but "at least 10%"
in Recital 8; **the two disagree and the manuscript footnotes it**. Proxies for CO2 and CH4 from
organic soils carry a default 10% deduction; N2O by emission factor carries 15% with Tier 1 and
10% with Tier 2. GWPs from Delegated Regulation (EU) 2020/1044 or the latest IPCC Assessment
Report, with AR6 WGI Chapter 7 cited.

**One provision our results complicate.** Recital 11 exempts peatland rewetting from any liability
mechanism or buffer pool because the reductions "are therefore irreversible". A rewetted site can
revert through drainage failure or drought, and the near-natural reference condition is itself a
net source once methane is counted. Irreversibility here is a property of the accounting
convention, not of the ecosystem. Recital 9 separately concedes that ILUC and land-speculation
risk from peatland rewetting **cannot currently be quantified**.

### Gilet et al. (2025). OBTAINED

*Land Use Policy* 159, 107792, DOI 10.1016/j.landusepol.2025.107792. ScienceDirect 403s; the
publisher PDF is open on the QUB Pure file server at
`https://pureadmin.qub.ac.uk/ws/files/656987676/peat.pdf` (CC BY-NC). **General lesson: for
hybrid-OA Elsevier articles, try co-authors' institutional Pure servers.**

Irish peat area **1,660,289 ha (23.3% of the State)**, a **13.2% increase** on Connolly & Holden's
DIPM v2. *(Cite the 1,466,469 ha figure to Connolly & Holden 2009 or Gilet et al. 2024 Geoderma,
**not** to this paper: 1,466,469 appears in it only as a coincidental column total of the areas
Aitova used.)* Driven by a broader definition, thickness ≥10 cm and organic matter ≥8.6%, against
previous thresholds of 20–34.5% OM and 30–45 cm.

Land cover on peat: grassland **508,346 ha** (~30.5%, half wet grassland and 45% improved),
forest 334,463 ha (20%), near-natural 267,260 ha (~16%), cutover 105,928 ha, cutaway 51,947 ha.
Total emissions **12.26 to 13.85 Mt CO2e/yr** on two EF sets (Aitova-based and Evans-based).

**Two findings that bear on our Irish arm.** Ireland's reporting definition is narrower than the
science: the NID requires >30 cm and >20% OC where the IPSM uses ≥10 cm and ≥8.6% OM. And the area
revision reallocates the emissions story: excluding near-natural, grassland carries **59–66%** of
peat emissions on the new areas against **33–42%** on the areas Aitova used. Roughly **93,000
additional hectares of grassland** move onto peat. Also confirms two of our nulls in the authors'
own words: "No specific EF for Irish fens has been reported to date", and no distinct EF for
intensive, extensive or rough grazing. Grassland drainage status is the dominant uncertainty, a
**245% spread** between minimum and maximum scenarios.

**From 2026 it is compulsory to include managed wetlands, including peatland, in the EU
commitment.** Useful framing for the Discussion.

### Walz et al. (2026), the national peatland database. OBTAINED, and it is not what we hoped

*Data in Brief* 67, 112965, DOI 10.1016/j.dib.2026.112965. Gold OA, mirrored at **PMC13292776**.
Dataset openly downloadable at **Zenodo DOI 10.5281/zenodo.16746479**, CC BY 4.0, 5.3 MB.

Fifty plots, **4,024 soil samples from 270 sampling points**, across raised bog, lowland blanket
bog and mountain blanket bog, stratified by land use (near-intact, grassland, forestry, domestic
and industrial extraction) and management (deep drained, shallow drained, rewetted), plus eight
continuous water-table records 2017–2020. *(Do not quote 2,012 as the sample count; that is the
row range of one worksheet.)*

**Three cautions.** It carries **no GHG flux records**, only peat properties and hydrology, its
stated purpose being to let others model fluxes from edaphic and vegetation properties. It carries
**no nutrient classification** at all, and explicitly excludes near-intact fens as "<2% of the
total peatland area", so it cannot resolve the nutrient split that decides the sign of the Irish
rewetting result. And **Aitova et al. (2023) is not cited anywhere in it**; the two are
complementary, not linked, though Wilson and Renou-Wilson are common to both.

### The Peatland Standard for Ireland v1.0. OBTAINED, and the earlier finding is confirmed

*PFI – Peatland Standard of Ireland D, Version 1.0*, 28 pp.,
`https://peatlandfinance.ie/s/Peatland-Standard_V10-Doc-D.pdf`, plus four companion documents,
all read.

**Methane appears once in 28 pages, and not as an accounting provision**: a warning to avoid
permanently deep open water partly because of "the potential to increase methane emissions".
**"CH4", "N2O" and "GWP" occur zero times**, and no GWP horizon or AR version is stated anywhere.
Carbon is reported as "Emission Reduction tCO2e" with nothing saying whether that figure includes
methane or which metric converts it.

**No emission factor and no source for one is published.** "IPCC" occurs once, in a glossary
definition of wetland. The factors live in a *Field Protocol* and *Emission Reduction Calculators*
which the standard **explicitly lists among documents not made publicly available**. Section 29.1
describes the water-table and vegetation-category approach as "results-based methodologies (Tier
3)", a loose use of the tier language given that the CRCF classifies exactly that construct as
Approach 3, proxies, distinct from measurement.

What it does publish: a **frozen baseline** assuming no further deterioration absent the project;
a three-part additionality test (legal, financial break-even, technical); permanence by **peat
exhaustion**, "Peat depth (cm) / deterioration rate = Project length (years)" at the same 1.0 and
1.5 cm/yr rates the CRCF later adopted but capped at **100 years against the CRCF's 30**; and a
**20% risk buffer** plus a transition-and-works buffer, with the arithmetic "Gross emissions
reductions from baseline − Leakage (− Uncertainty) = Net Emissions reductions. Net emissions
reduction − Standard Risk Buffer of 20% (− Transition and Works Buffer) = Claimable Emissions
Reductions."

**The citable finding:** the standard publishes its governance, buffers, additionality and
permanence but not the quantification that turns a rewetted hectare into a tonne, and the gas that
decides whether the intervention nets out is unaddressed in every published document. Set against
the CRCF adopted four months later, which mandates CH4 quantification and forbids default factors
for organic soils, that is a gap rather than an absence of evidence.

### Renou-Wilson et al. (2016). NOT OBTAINED, and a substitute is supplied

*Agric. Ecosyst. Environ.* 222, 156–170, DOI 10.1016/j.agee.2016.02.011. **Genuinely closed.**
Unpaywall `oa_status: closed`, `has_repository_copy: false`; OpenAlex, Semantic Scholar, Europe
PMC, OpenAIRE, CORE, BASE, fatcat, UCD's DSpace and Giessen's JLUpub all confirm no copy exists.
Thirteen routes logged. **No flux values from it are recorded anywhere in this evidence base**,
because its tables were never seen. Its published abstract is qualitative and contains no numbers.

**Use instead: Renou-Wilson, F., Barry, C., Müller, C. & Wilson, D. (2014)**, *Biogeosciences* 11,
4361–4379, **DOI 10.5194/bg-11-4361-2014**, CC BY, full PDF open at Copernicus. This is the
peer-reviewed CALISTO paper and carries the same underlying measurements. **But it is a different
study: two years, three plots, all drained, no rewetted treatment.** It is not a substitute for
the drained-versus-rewetted comparison; it is the open Irish drained-grassland-on-organic-soil
flux set. EPA Research Report 141 (CALISTO) Table 9.2 gives the country-specific factors, and its
own comparison is directly useful: "The absence of CH4 fluxes from both our well-drained organic
soils is at variance with the IPCC guidance which presents an EF of 16 kg CH4 ha-1 yr-1 for
nutrient rich and 1.8 kg CH4 ha-1 yr-1 for nutrient poor."

To close the 2016 paper out: a CORE API key, a UCD or subscriber login, interlibrary loan, or a
direct request to Renou-Wilson, who is corresponding author and UCD-based.

## 8. Highest-value documents still to obtain

1. **CRCF carbon farming delegated regulation, peatland rewetting Annex**, adopted 9 July 2026.
2. **Hammond (1981), Soil Survey Bulletin No. 35.** Underpins the entire Irish nutrient split.
3. **Walz, K., Wilson, D., Byrne, K.A. & Renou-Wilson, F. (2026), "A national peatland database
   for the Republic of Ireland", *Data in Brief* 67, 112965, DOI 10.1016/j.dib.2026.112965.**
   Crossref-verified, 403 twice, but *Data in Brief* is fully open access so it is retrievable.
   Likely the definitive current activity-data source.
4. **Gilet et al. (2025), "Peatland use and peat soil land cover types in Ireland", *Land Use
   Policy* 159, 107792, DOI 10.1016/j.landusepol.2025.107792.** 403; likely the most current
   land-cover-by-peat-type source.
5. **Peatland Standard for Ireland v1.0 full methodology.** Only marketing pages were readable.
6. **EPA Research 236 (NEROS)**, to convert its reported 70 g C m⁻² yr⁻¹ sink and 19.3 g C m⁻²
   yr⁻¹ CH4 into a CO2e balance. **Its "net sink" conclusion is a carbon balance, not a radiative
   one; converting the CH4 term at any GWP may change the sign.** Do not repeat "net sink" from
   this source without redoing it in CO2e, and if the paper does that conversion it must be a
   saved pipeline calculation.
