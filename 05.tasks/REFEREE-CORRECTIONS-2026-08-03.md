# Referee corrections, located in the manuscript

Diagnosis only. Nothing in `01.manuscript/ipcc-carbon-gains.qmd` has been edited.
Line numbers are against the file as it stood at 2026-08-03 19:35, 1,557 lines.
Every computed value quoted below is read from the render of 19:38, which is newer
than the source, so the render is current.

---

## A. Three corrections to the diagnosis itself, made before anything else

These change what work is actually outstanding, so they come first.

### A1. The missing-chapters finding is stale. All seven chapters are present.

`04.references/standards/IPCC-md/` now holds `IPCC-2013-Wetlands-Supplement-Ch.1.md`
through `Ch.7.md`, each with a provenance header reading "Extracted from
IPCC-2013-Wetlands-Supplement.pdf with pypdf text-layer extraction (no OCR, no
paraphrase)" and "This is the PUBLISHED report, not a draft", with PDF page spans
covering pages 17 to 354. All eight files, including the replaced
`IPCC-2019-V4-Ch6-Grassland.md`, are timestamped 3 Aug 20:37, which is after the
referee pass ran. The three questions said to be unanswerable are answered below.

**Table 4.13 is coastal-specific.** Published Ch.4, PDF page 184:

> TABLE 4.13 ANNUAL EMISSION FACTORS ASSOCIATED WITH DRAINAGE (EFDR) ON AGGREGATED
> ORGANIC AND MINERAL SOILS (TONNES C HA-1 YR-1)
> Ecosystem / EFDR / 95% CI / Range / N
> Tidal marshes and mangroves / 7.9 / 5.2, 11.8 / 1.2-43.9 / 22
> Sources: Camporese et al., 2008; Deverel and Leighton, 2010; Hatala et al., 2012;
> Howe et al., 2009; Rojstaczer and Deverel, 1993

Its own source list, its own n, its own CI. Identity with the Chapter 2 temperate
cropland 7.90 is coincidence. This confirms the fix at item C7.

**Table 4.14 is tidal marsh and mangrove only.** Published Ch.4, PDF page 186, table
title: "EMISSION FACTORS FOR CH4 (EFREWET) FOR TIER 1 ESTIMATION OF REWETTED LAND
PREVIOUSLY VEGETATED BY TIDAL MARSHES AND MANGROVES". Rows are `<18` at 193.7
(95% CI 99.8, 358) and `>18` at 0. Seagrass is absent. The encoding at lines 480-484
is right and the caption at line 498 is right.

**Chapter 5 has no drainage adjustment factor and says so in its own voice.**
Published Ch.5, line 889, verbatim:

> Due to the lack of studies, however, we are unable to develop guidance for CH4
> emissions from drained IWMS at this time.

Quote this at line 579 in place of the current assertion. It is far stronger.

### A2. The 354-pages claim is TRUE and is now provable.

Searching all seven published chapters for `global warming potential|GWP|CO2-eq|CO2
equivalent|carbon dioxide equivalent` returns exactly one hit in the whole Supplement:

```
Ch.3 line 1978: Nagata, O., Takakai, F. & Hatano, R. (2005) Effect of sasa invasion
                on global warming potential in sphagnum ...
```

That is a reference-list entry, a cited paper's title. Chapters 1, 2, 4, 5, 6 and 7
return zero. The Badiou "3.25 Mg CO2-equivalents" sentence that prompted the caution
does **not** appear in the published Chapter 5: `grep '3\.25'` on the published file
returns nothing, and every Badiou hit in the published chapter is a citation, not a
quoted figure. That sentence belonged to the superseded do-not-cite draft.

So do not narrow the claim. Strengthen it by saying how it was tested. See item C6.

### A3. The nutrient fallback rule IS in Chapter 3, verbatim. CLAUDE.md is wrong.

`CLAUDE.md` finding 5 says "The nutrient fallback rule is Chapter 2, not Chapter 3 ...
Chapter 3 ... gives no fallback for the unknown case." Published Ch.3, lines 586-588,
printed page 3.12, PDF page 123:

> If the nutrient status of rewetted organic soils in boreal or temperate zones is not
> known, countries should use the default nutrient poor EF for sites in the boreal
> zone, and nutrient rich EF for sites in the temperate zone (Table 3.1).

Chapter 2 carries a parallel rule for the drained side at printed page 2.17:

> It is good practice for boreal countries that do not have information on areas of
> nutrient-rich and nutrient-poor organic soils to use the emission factor for
> nutrient-poor organic soils. It is good practice for temperate countries that do not
> have such data to use the emission factor for nutrient-rich organic soils.

Both chapters have it. **The Discussion sentence at line 1514 is therefore correct and
needs no change.** The defect is the other way round: `map_nutrient` at lines 338-341
is called by `net_rewetted` at line 344, so it operates on the rewetted side, and the
comment at line 337 citing "Ch.2 p.2.17" should cite Chapter 3. Correct `CLAUDE.md`
finding 5 as well, or the next session will edit a correct sentence into an incorrect one.

---

## B. The two false statements. Fix these first.

### B1. Line 1482, the screening rule. Delete it.

Current text, second sentence of the paragraph:

> The practical consequence is that a single test would do: any pathway whose GWP-100
> benefit is under about 2 t CO2e/ha/yr in our ledger fails both checks, and every
> pathway above 3 passes both.

Falsified by row 10 of both tables. Grassland, Temperate, Rich, shallow-drained:
GWP-100 benefit **6.24**, GWP-20 benefit **−5.59**, P(benefit > 0) **0.586**. Twice the
stated threshold, fails both tests. The 2-to-3 band is also occupied by a failing row,
Forest Land Boreal Rich at 2.21 / −7.03 / 0.500.

**Fix.** Delete the sentence from "The practical consequence" to the end of the
paragraph. It was a post-hoc separator read off thirteen sorted numbers, with no
mechanism and no out-of-sample test, and it adds nothing the preceding paragraph does
not already say. End the paragraph at "discloses neither."

The claim it rests on, at **line 456** and restated at **line 1480**, survives and should
be kept:

> Every combination that turns negative at GWP-20 also fails the 95% threshold at
> GWP-100, and no combination fails one test but passes the other.

Verified: the five GWP-20 negatives (−0.97, −7.03, −13.17, −5.59, −11.52) are exactly
the five rows with P below 0.95 (0.421, 0.500, 0.357, 0.586, 0.336).

### B2. Abstract line 11 and Conclusions line 1548, the GWP-100 positivity claim.

Three places assert it, and a fourth contradicts all three.

| Line | Text |
|---|---|
| 11 (Abstract) | "At GWP-100 the benefit is positive in every combination." |
| 387 (Results) | "At GWP-100 every complete combination shows a benefit" |
| 1548 (Conclusions) | "Rewetting organic soils is beneficial in every case at GWP-100" |
| 1144 (caption) | "Contrast with the global ledger, where every complete row is positive at GWP-100." |
| **1154 (Ireland)** | **"Both Irish pathways are negative at GWP-100"** |

The statement is true of the **point estimates** (min 1.26) and false of the **Monte
Carlo medians**, four of which are at or below zero: Forest Land Boreal Poor −0.45
(P 0.421), Forest Land Boreal Rich 0.00 (P 0.500), Forest Land Temperate −2.53
(P 0.357), Peat extraction Temperate −2.98 (P 0.336). Temperate peat extraction is,
on the manuscript's own uncertainty model, twice as likely to harm as to help.

**Fix.** Qualify each of the four to "positive in every combination *at the published
point estimates*", and in the Abstract add the median clause immediately after, so a
reader meets both facts in one breath. Suggested Abstract wording:

> At GWP-100 the benefit is positive in every combination at the published point
> estimates, but Monte Carlo medians fall at or below zero in four.

At line 1144 the caption contrast is with the Irish result, so it must say "positive at
the point estimate" or the reader cannot reconcile it with line 1154 five lines earlier.

---

## C. Refutable by one search

### C3. Line 681, "a different volume". Change one word.

> and the nitrous oxide methodology sits in a different chapter of a different volume

Chapter 11 is Volume 4, the same volume as the Chapter 6 grassland factors. The code
comment at line 638 says so: `# 2019 Refinement Ch.11, aggregated Tier 1 factors`.

**Fix.** "sits in a different chapter of the same volume". The argument is unharmed:
the point is that neither chapter is responsible for closing the trap, and that holds
within one volume.

### C6. Line 85, the 354-pages claim. Strengthen, do not narrow.

> And the Wetlands Supplement performs no greenhouse gas weighting anywhere in its
> 354 pages

**Fix.** Say how it was tested, per A2. Suggested:

> And the Wetlands Supplement performs no greenhouse gas weighting anywhere in its 354
> pages: a search of the full text for global warming potential, GWP and carbon dioxide
> equivalent returns a single hit, inside a reference-list entry.

Add the 2019 Overview as the corroborating authority in the IPCC's own voice, printed
Overview p. 5, verbatim:

> Methods are provided for estimating emissions (and removals as appropriate) for each
> gas in mass units. It does not recommend any specific metrics (e.g., GWP values) to
> calculate emission estimates in CO2 equivalent units.

Line 87 already gestures at this with AR6 Box 7.3; the Overview sentence is closer to
the point and belongs beside it.

### C7. Line 1500, the 7.9 conflation.

> Zhao et al. report the 7.9 t C/ha/yr drained cropland factor overestimating by 31 to
> 88% at water tables between −0.7 and −0.3 m

This is about the **Chapter 2 temperate cropland** factor, which happens to equal 7.90.
The manuscript's coastal `EF_DR <- 7.9` at line 474 is **Table 4.13**, a different
factor with its own n = 22 and its own sources (A1 above). A referee already conflated
them.

**Fix.** "the Chapter 2 temperate cropland factor of 7.90 t C/ha/yr", and add a clause:
"which is numerically identical to the Table 4.13 coastal drainage factor used above
but derived from a different study pool." Otherwise the sentence appears to undermine
the coastal result, which sits on the same page of the Discussion.

---

## D. The novelty claim

### D1. Line 89 is falsified by line 1484 of the same document.

Line 89, last sentence:

> Nobody has extended the comparison to coastal wetlands, inland wetland mineral soils
> or improved grassland, and nobody has asked how the sign of the answer moves with the
> emission metric and horizon.

Line 1484, last sentence:

> Zhang et al. [@zhang2025] reach a compatible conclusion for UK peatlands, where metric
> choice does not flip the headline but turns the second restoration step from
> near-certainty into a 42.2% chance of increasing emissions under GWP-20.

That is metric sensitivity with Monte Carlo at GWP-20, which is precisely what line 89
says nobody has asked. `zhang2025` is also already load-bearing in Methods: the GWP\*
implementation at line 135 is credited to it.

**Fix.** Do not cut Zhang. Promote them into the Introduction beside Wilson and state
the increment precisely. Replace the final sentence of the paragraph at line 89 with
something on these lines:

> Zhang et al. [@zhang2025] test metric sensitivity directly, resampling UK peatland
> restoration under GWP-100 and GWP-20 and finding that the second restoration step
> carries a 42.2% chance of increasing emissions at the shorter horizon. Their scope is
> one country and one pathway. What has not been done is to extend the subtraction to
> coastal wetlands, inland wetland mineral soils and improved grassland, to carry the
> duration rule alongside the factor, and to ask whether the metric test and the
> uncertainty test select the same pathways.

Then adjust line 91 ("This paper does both") to match the three-part increment.

---

## E. The Monte Carlo. Describe it honestly; do not rebuild it.

### E1. Line 313, the Methods sentence is wrong in two ways.

> Sampling is applied to the carbon dioxide and methane terms, which carry the published
> intervals; ditch fractions and nitrous oxide factors are held at their defaults, so the
> reported intervals understate total uncertainty.

Read the chunk at lines 407-417. On the **drained** side only `co2_d` is drawn
(line 409). `ch4_land`, `ch4_dit`, `fdit` and `n2o_n` all enter at their fixed defaults
(lines 411-412). Methane is sampled on the **rewetted side only** (line 415). Three of
roughly seven terms are sampled, not "the carbon dioxide and methane terms".

**Fix.** Replace with a sentence that names what is and is not sampled:

> Sampling is applied to the carbon dioxide factor on both sides and to the methane
> factor on the rewetted side, these being the terms for which the Supplement publishes
> intervals. Drained land methane, ditch methane, the ditch fraction and the nitrous
> oxide factor are held at their defaults, so the reported probabilities are conditional
> on those four terms and understate total uncertainty.

### E2. Line 400-405, the triangular mode inflates rewetted methane.

`rtri` takes the published central value as the **mode**. The published methane bounds
are violently right-skewed, so the resulting **mean** far exceeds the published central
value:

| Rewetted row | lo | published | hi | triangular mean | inflation |
|---|---|---|---|---|---|
| Boreal Poor | 0.5 | 41 | 246 | 95.8 | 2.34x |
| Temperate Poor | 3 | 92 | 445 | 180.0 | 1.96x |
| Temperate Rich | 0 | 216 | 856 | 357.3 | 1.65x |

The sampler charges the rewetted state 1.6 to 2.3 times the methane the guidance
publishes. That, not sampling spread, is what drives the four negative medians in B2.

Compounding it in the other direction, treating a 95% confidence interval as **hard
support** makes six of thirteen rows print `P = 1.000` (Cropland Temperate Rich,
Cropland Tropical, Grassland Boreal, Grassland Temperate Poor, Grassland Tropical,
Plantation oil palm), which is not a defensible output for a sign claim.

**Fix, and it is cheap.** Do not rebuild the sampler. Add a paragraph after the Monte
Carlo chunk, and a limitation, stating: that the central value is passed as the mode
rather than the mean; that on right-skewed bounds this raises the sampled rewetted
methane above the published default by the factors tabulated above; that hard support
on a 95% interval is why six rows return exactly 1.000; and that the **count** is
nevertheless robust. The stats referee re-ran it: five of thirteen fail at P < 0.95
under a normal parameterisation of the same bounds, six of thirteen under a uniform.
Report that sensitivity. It converts the weakest methodological point in the paper into
evidence that the headline does not depend on the distributional choice.

The individual medians and probabilities should be described as conditional on the
triangular assumption wherever they are quoted, which is lines 11, 427, 429-430, 456,
1480 and 1548.

---

## F. Ireland

### F1. The peat-extraction contradiction. Lines 1144 and 1346 disagree by 15 t.

Same intervention, both introduced as resting on Ireland's own inventory, opposite sign:

| Source | Line | Pathway | Benefit |
|---|---|---|---|
| Aitova Tier 2 table | 1140-1145 | Peat extraction, nutrient-rich | **−8.068** t CO2e/ha/yr at GWP-100 |
| CRT implied factors | 1344-1346 | Industrial peat extraction | **+7.02** t CO2e/ha/yr at AR6 GWP-100 |

Two referees found this independently, and the near-mirrored magnitudes are the pattern
a transposition makes. The arithmetic is faithful to the encoded table either way, so if
there is an error it is in the encoding of Aitova Table 2 at **lines 1046-1047 and 1053**
(`Industrial cutaway,Rich,2.8,2.18,...` against `Rewetted extraction,Rich,0.50,3.22,216.0,117.90,...`)
or in the system boundary, not in the code.

Note the boundary difference is real and may be the whole explanation: the Aitova pair is
on-site CO2 and CH4 only (line 1113), while the CRT pair is Table 4.D on-site soil carbon
**plus** Table 4(II) off-site CO2, N2O and CH4. The CRT rewetted side also carries a
methane implied factor around nine times the drained one (line 1348-1350).

**Fix.** This must be reconciled in the manuscript, not left for a referee. Add a short
subsection after the CRT chunk that puts the two side by side, states the boundary
difference explicitly, and says which is preferred and why. Done properly the
reconciliation is a better result than either number alone: it shows that the sign of a
national pathway depends on whether off-site fluxes are inside the boundary, which is
the paper's own thesis applied to its own case study. Until it is written, the two
numbers should not both stand unqualified.

### F2. Lines 1110-1112, the omitted DOC term is larger than the result, and the comment is wrong twice.

```r
# Same subtraction as the global analysis, run on the Irish Tier 2 factors.
# On-site CO2 and CH4 only: Aitova publish no fluvial value for rewetted grassland,
# so including the drained fluvial term (0.37 t C/ha/yr) would bias the comparison
# in favour of rewetting. Omitting both is the conservative choice and is stated.
```

The Irish grassland headline is **−0.484** t CO2e/ha/yr. The omitted drained fluvial
term is 0.37 t C/ha/yr, which is 0.37 x 44/12 = **1.357 t CO2**, nearly three times the
result. Including it on the drained side alone gives **+0.873**; including it on both
sides with the Table 3.2 temperate rewetted default of 0.24 gives **−0.007**. Either way
the sign or the magnitude moves.

Two errors in four lines of comment:

1. **"conservative" runs the wrong way.** The paper's Irish finding is that the benefit
   is negative. Omitting the drained-side DOC lowers the drained flux, lowers the
   benefit, and pushes the result **towards** the conclusion. That is the opposite of
   conservative.
2. **"Same subtraction as the global analysis" is not accurate.** The global analysis
   carries DOC on both sides: `doc_drained` at line 330 and `r$doc_rewet` at line 348.

**Fix.** Rewrite the comment to say plainly that the term is omitted because Aitova
publish no rewetted fluvial value, that the omission moves the result in the direction
of the paper's conclusion, and that this differs from the global treatment. Then report
both sensitivities (+0.873 and −0.007) in the prose at line 1154, computed in the chunk
rather than quoted from here, per the never-report-a-number-from-unsaved-code rule.

### F3. Ireland is 28% of the prose and 54% of Results, and appears in none of the summary matter.

Word counts, prose only, chunks excluded:

| Span | Lines | Words |
|---|---|---|
| Whole body | 81-1553 | 8,871 |
| Introduction + Methods | 81-314 | 1,150 |
| Results excluding Ireland | 315-1029 | 2,145 |
| **Ireland** | **1030-1476** | **2,495** |
| Discussion | 1478-1544 | 2,648 |
| Conclusions | 1546-1553 | 325 |

"Ireland" appears in the subtitle (line 3) and nowhere in the Abstract (lines 10-12),
the keywords (lines 14-21) or the Conclusions (lines 1546-1552).

**Fix, and this is the one decision that is yours alone.** Either Ireland earns a
sentence in the Abstract, a keyword, and a clause in the Conclusions, or it is cut to
the two results that test a global claim and the rest becomes a companion paper. The two
that carry global weight are the opposite-direction bias on the same hectares
(lines 1099-1101, CO2 four times below default while CH4 is six times above) and the
salinity gate being unresolvable from national data (lines 1408-1410, 90% unclassifiable).
Everything from line 1206 to line 1373, the nitrogen factors, contested grassland
factors, national peatland stocks and the CRT analysis, stands on its own as a second
paper.

---

## G. Submission blockers

### G1. There are no declarations. BMC returns manuscripts for this without review.

Confirmed absent: no Declarations, Availability of data and materials, Competing
interests, Funding, Authors' contributions, Ethics approval, or Consent sections. The
document runs `# References` at line 1554 straight after `# Conclusions`.

**Fix.** Add before `# References`:

```
# Declarations

## Availability of data and materials
## Code availability
## Competing interests
## Funding
## Authors' contributions
## Ethics approval and consent to participate
## Consent for publication
```

Carbon Balance and Management requires an **archived code DOI**, so plan a Zenodo
deposit, not a GitHub link. The Ecuador conflict of interest declared in `CLAUDE.md`
does not apply here, since Ecuador does not appear in the manuscript, but the competing
interests statement must still be present and explicit.

### G2. Five derived CSVs are read with no data section in Methods.

| Line | File |
|---|---|
| 775 | `../02.inputs/derived/global-area-by-zone-soil.csv` |
| 899 | `../02.inputs/derived/global-pathway-areas.csv` |
| 970 | `../02.inputs/derived/global-area-by-zone-soil.csv` (reread) |
| 1272 | `../02.inputs/derived/irish-soils-area-by-class.csv` |
| 1324 | `../02.inputs/derived/irish-crt-peat-balance.csv` |
| 1385 | `../02.inputs/derived/irish-saltmarsh-salinity.csv` |

Produced by six scripts in `05.scripts/`: `prep-global-area-weights.py`,
`prep-global-pathway-areas.py`, `prep-irish-crt.py`, `prep-irish-saltmarsh-salinity.R`,
`prep-irish-soils.R`, `batjes-2010-socref-mean-vs-median.R`.

Methods (lines 97-313) mentions **none** of HWSD, the FAO Global Ecological Zones, the
Irish Soil Information System map, the NPWS saltmarsh layer, the EPA transitional water
bodies, the Inland Fisheries Ireland salinity survey, or the IRL-CRT-2026 workbooks.
All of it exists only as comments inside Results chunks (lines 772-774, 894-898,
1268-1271, 1321-1323, 1382-1384).

**Fix.** Add a Methods subsection after "Uncertainty propagation" (line 313) naming each
source layer, its licence, its retrieval date, the script that processes it and the CSV
it writes. This is also what the availability declaration in G1 has to point at.

### G3. Twenty-two tables, three figures, and not one cross-reference.

`grep -c 'knitr::kable'` returns **22**. Figure labels are three: `fig-metric-dependence`
(line 434), `fig-duration-asymmetry` (line 857), `fig-ireland-both-directions` (line 1077).
`grep '@fig-\|@tbl-'` over the prose returns **zero**. Two chunks carry `tbl-` labels
(`tbl-socref` line 154, `tbl-batjes-bias` line 688) that nothing references.

Twenty-two tables is roughly four times what this journal carries.

**Fix.** Two separate jobs. Add `@fig-` and `@tbl-` cross-references throughout, which
also requires giving every kable a `tbl-cap` and a labelled chunk. Then move the
model-input tables to supplementary: the rewetted-soil input table (line 252), the
Table 2.3 encoding, the ten-most-biased Batjes cells (line 758), the area-weighted top
eight (line 799), and, if Ireland stays, the Irish soils coverage table (line 1287).

---

## H. Small, cheap, and visible

| Line | Problem | Fix |
|---|---|---|
| 1199 | Callout title `## Two opposing persepctives` | `perspectives` |
| 1020 | "counts steppe that no one fertilises or grazes improvedly" | "grazes under an improved system" |
| 1544 | "Four bound the result." Opens with no subject, no heading, and sits at the end of the EU regulation section | Give it a heading, `## Limitations`, and a subject: "Four limitations bound the result." |
| 1179 | "Tuohy et al. factor set, after Paul et al." Paul has no bib entry | Add the entry or drop the attribution |
| 1500 | "Zhao et al. report" No bib entry | Add the entry |
| 1522 | "Arias-Ortiz et al. place breakpoints at 21 ± 2 psu" No bib entry | Add the entry |
| 1258 | Whole "Contested grassland factors" paragraph: four quantitative claims (Tier 2 average 1.05, gley 0.85, gley 22% of area, SOLUM cutting removals 95-98%) and zero citations | Cite each, or cut the paragraph. It is also duplicated at line 1504, which does cite |
| 1364 | "the result found in the United Kingdom's Tier 2 factors, where near-natural bog is also a net source" No citation | Cite it |

Sixteen bib entries are never cited: `brennand2025`, `cardenas2019`, `gilet2025`,
`guenet2021`, `hergoualch2021`, `ipcc2003gpg`, `ipcc2006`, `ipcc2014kp`, `jiang2025`,
`malerba2022`, `neubauer2015`, `neubauer2019`, `rosentreter2021`, `strack2022`,
`wang2023`, `williamson2022`. Vancouver is citation-sequence so they do not render, but
they should go or be used. Note `ipcc2006` and `ipcc2014kp` are both discussed in the
prose without a key and are probably meant to be cited.

---

## I. Two results that are thinner than they read

### I1. Line 574-579, "six of six" understates the finding and rests on a thin cell.

**Table 5.2 publishes nine climate regions. The manuscript encodes six** (lines 543-544).
The three omitted are Cold temperate dry 87, Warm temperate dry 74 and Tropical dry 22.
All three are net sources on the same arithmetic in both blocks:

| Zone | SOCref | Gain yr 1-20 | Gain yr 21-40 | CH4 offset | Net 1-20 | Net 21-40 |
|---|---|---|---|---|---|---|
| Cold temperate dry | 87 | 1.44 | 3.19 | 6.35 | −4.91 | −3.16 |
| Warm temperate dry | 74 | 1.22 | 2.71 | 6.35 | −5.12 | −3.63 |
| Tropical dry | 22 | 0.36 | 0.81 | 24.30 | −23.94 | −23.49 |

Encoding them turns the result into **nine of nine** in years 1-20 and **eight of nine**
in years 21-40, which is a stronger claim than the one currently made. Update lines 574,
579, 1018, 1548 and Abstract line 11 accordingly. Reconfirm against the render; do not
transcribe the table above.

**And disclose the boreal cell.** Published Ch.5 Table 5.4:

> Boreal 76, ±76, 1 study
> B Bridgham et al. (2006)
> C This study (Bridgham et al., 2006) is a synthesis of numerous studies

A 95% interval of ±76 on a mean of 76. That is the cell producing the −0.14 t CO2e/ha/yr
boreal margin, seven per cent of the gain. Also note that the code at lines 562-565 sets
the inundated fraction to one implicitly, which should be stated.

### I2. Line 528 and line 1500 contradict each other eight pages apart.

Line 528:

> Below 18 ppt the single default of 193.7 kg CH4/ha/yr costs 5.23 t CO2e/ha/yr at
> GWP-100. That exceeds the tidal marsh soil gain of 3.34, so a restored brackish tidal
> marsh is a net source in absolute terms

The flip requires the accumulation rate to stay below 5.23 / (44/12) = **1.426 t C/ha/yr**.
Line 1500:

> the tidal marsh accumulation default of 0.91 t C/ha/yr sits two to three times below
> independent global syntheses [@ouyang2014; @wang2019]

Two to three times 0.91 is 1.82 to 2.73, both above 1.426. On the syntheses the paper
itself cites, the marsh does not flip.

**Fix.** State the threshold explicitly at line 528 and note that the finding is
conditional on the Tier 1 default: "the reversal holds at the Tier 1 default of 0.91 t
C/ha/yr and disappears above 1.43, which the global syntheses discussed below exceed."
This is not a retraction. It is the paper's own thesis, that a sign follows from an
accounting choice, applied to its own coastal result, and it is stronger stated than
left for a referee to find.

---

## Order of work

**A morning.** B1 delete the threshold rule. B2 qualify four sentences. C3 one word.
C6 strengthen with the grep evidence. C7 name the right factor. D1 reposition Zhang.
E1 rewrite one Methods sentence. G1 add the declarations block. H all of it.
Correct `CLAUDE.md` per A1, A2 and A3.

**A day.** E2 the honest Monte Carlo paragraph plus the normal and uniform sensitivity.
I1 encode the three missing Table 5.2 zones and disclose the boreal cell. I2 state the
1.426 threshold. G2 the Methods data section.

**Real work.** F1 reconcile the Irish peat-extraction contradiction. F2 the DOC
sensitivity. G3 the cross-references and the table cull.

**Your decision alone.** F3, whether Ireland is a section or a second paper.
