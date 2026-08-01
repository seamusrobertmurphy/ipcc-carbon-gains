# ipcc-carbon-gains

**Counting the gains: IPCC Tier 1 and Tier 2 removal pathways in peatlands, coastal
wetlands and improved grasslands.**

Status as of 2026-07-30: framing approved, prior-work survey complete, **master manuscript
built, restructured against its exemplar, and rendering with a full Discussion and
Conclusions**. Sole-authored. Target venue Carbon Balance and Management, guidelines
verified live. Structural exemplar: **Wilson et al. 2016, *Mires and Peat* 17(4)**, whose
architecture the manuscript now follows. See `CLAUDE.md` for what that changed.

**The master is [`01.manuscript/ipcc-carbon-gains.qmd`](01.manuscript/ipcc-carbon-gains.qmd).**
Edit it, not the render. All figures are derived in base R at render time with code visible.
Build: `cd 01.manuscript && quarto render ipcc-carbon-gains.qmd --to html`.

**Status, 2026-07-30 (late):** Discussion and Conclusions written and cited; **Ireland section
built and computing**. 39 citations resolve, none unresolved. No placeholders remain in the
manuscript. The Irish arm is built entirely from published emission factors and needs **no
spatial data**; see `docs/science-superpowers/prior-work/2026-07-30-ireland-evidence-base.md`
for the quote-backed evidence behind it.

**Now the critical path:** a saved script reading Ireland's published Common Reporting Tables
(IRL-CRT-2026-V1.0), to recompute two results currently held out of the manuscript under the
never-quote-unsaved-code rule. Second, the SIS re-export (see `02.inputs/MANIFEST.md`), which
blocks only the eligibility arm.

Note citations were inserted as hand-written `@keys` drawn from the rebuilt bib; the standing
decision is to use RStudio's visual editor with Zotero, so reconcile before any mass insertion,
because Zotero mints its own keys.

The drained counterfactual is **closed**: 14 rows, 13 complete on all four gas terms. Only
Plantation acacia (tropical) remains, missing its N2O term.

## Read in this order

0. [`05.tasks/TASK-REQUEST-2026-07-30.md`](05.tasks/TASK-REQUEST-2026-07-30.md) — **start
   here.** Current state, critical path, and the runtime-cost pruning to do first.
1. [`CLAUDE.md`](CLAUDE.md) — conventions, authorship rule, terminology, corrections, traps.
2. [`05.tasks/EVIDENCE-BASE-2026-07-30.md`](05.tasks/EVIDENCE-BASE-2026-07-30.md) — the
   quote-backed evidence from the complete reference corpus, every document read.
3. [`docs/science-superpowers/questions/2026-07-30-countable-carbon-gains.md`](docs/science-superpowers/questions/2026-07-30-countable-carbon-gains.md)
   — the approved research question and hypotheses.
4. [`docs/science-superpowers/prior-work/2026-07-30-prior-work-note.md`](docs/science-superpowers/prior-work/2026-07-30-prior-work-note.md)
   — the literature survey: methods to adopt, confounds, prior effect sizes, and the two
   corrections it forced.
5. [`04.references/README.md`](04.references/README.md) — provenance and citability of
   every source.

## Scope

Two parts. The pathway ledger and the net-benefit test are **global**, because the
cross-pathway comparison is the gap. **Ireland** is then worked end to end as the national
case, because it carries raised and blanket bog, saltmarsh and intensively fertilised
grassland on one island, and because drained nutrient-rich peat under fertilised grass is
where both of the paper's sharpest findings land. Title, abstract and keywords are in
[`01.manuscript/title-abstract-keywords.md`](01.manuscript/title-abstract-keywords.md);
Irish data sources in
[`02.inputs/README-irish-data-sources.md`](02.inputs/README-irish-data-sources.md).

## The question

Across every carbon gain pathway IPCC Tier 1 and Tier 2 permits a jurisdiction or project to
count in peatlands, coastal wetlands and improved grasslands, under which combinations of
climate zone, soil or vegetation class and management condition does the countable CO2 gain
survive its own methane and nitrous oxide offsets and remain a net benefit?

H1 is that it often does not, and that a compliant Tier 1 claim can be booked on a site that
is a net source.

## Established so far

**The pivotal change is 2013.** The Wetlands Supplement's Equation 3.1 replaced 2006
Equations 2.24 and 2.26 because those "implicitly assumed that organic soils can only lose
carbon". First negative Tier 1 emission factors in the guidelines' history.

**The 2019 Refinement reduced mineral-soil gains.** Its Overview: "Many of the updated factors
reflect a smaller impact of anthropogenic activity on soil carbon than default factors
provided in the 2006 IPCC Guidelines." No-till fell by 55 to 76% of its gain. Peatlands were
untouched. Grassland factors are unchanged since 2003.

**Coastal wetlands escape the 20-year cap**, running to a stock ceiling roughly 240 years
away for mangrove, while every other soil pathway is capped at 20 years and inland mineral
wetland rewetting at 40.

**The Table 2.3 defaults are biased, not merely uncertain.** Computed in
`02.inputs/batjes-2010-socref-mean-vs-median.R`: the published mean exceeds the robust median
in 34 of 37 cells, median bias 13.0%, range −3.5% to +154.5%, worst in wetland, volcanic and
montane classes. The stated ± is a confidence interval on the mean and narrows with sample
size; the dispersion of the underlying soils has a median CV of 54.9% against stated errors as
low as ±5%.

**The nitrogen trap.** Improved grassland fertilised at 100 kg N/ha/yr on a low-carbon soil
crosses from net benefit to net source at year 31, because the soil gain is capped at 20 years
while the nitrous oxide penalty is open-ended. The 2019 grassland chapter contains zero
occurrences of "N2O".

## Layout

| Folder | Contents |
|---|---|
| `01.manuscript` | Quarto master, single source of truth. Renders in ~9 s. |
| `02.inputs` | Analysis scripts and factor tables. |
| `03.outputs` | Generated tables and figures, committed because the manuscript cites them. |
| `04.references` | IPCC guidance and reports (139 MB, not committed; see manifest), plus `references.bib`, 49 verified entries, which **is** committed. |
| `05.tasks` | Evidence base, design documents and task requests. |
| `docs/science-superpowers` | Team pipeline artefacts: questions, then design, then pre-registration. |

## Reproducing the current result

```
Rscript 02.inputs/batjes-2010-socref-mean-vs-median.R
```

Base R only. Writes `03.outputs/batjes-2010-socref-bias.csv`.
