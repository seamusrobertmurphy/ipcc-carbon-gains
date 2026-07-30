# ipcc-carbon-gains

Why wetland, peatland and grassland soil carbon are excluded from greenhouse gas
accounting and carbon crediting, and what it would take to include them.

**Status:** design stage. No analysis written yet.
**Author:** Seamus Murphy, sole author. Co-authors to be invited once the draft is
developed; deliberately not before, to keep lead authorship settled.
**Target venue:** Carbon Balance and Management, guidelines not yet verified.

## Start here

[`CLAUDE.md`](CLAUDE.md) carries the conventions, the authorship rule, the full
limitations of the global Tier 1 soil carbon dataset, and the terminology that must not
slip.

[`05.tasks/RESEARCH-DESIGN-2026-07-30.md`](05.tasks/RESEARCH-DESIGN-2026-07-30.md)
carries the research question, seven hypotheses, the design, the verified data access
position and the risk register.

Read both before touching anything else.

## Established so far

IPCC 2019 Table 2.3 SOCref defaults are the arithmetic means from Batjes (2010), who
also published medians. Computed in
`02.inputs/batjes-2010-socref-mean-vs-median.R`: the mean exceeds the robust median in
34 of 37 cells, median bias 13.0%, range -3.5% to +154.5%, with the largest divergences
on wetland, volcanic and tropical montane classes. The stated ± in Table 2.3 is a
confidence interval on the mean and narrows with sample size; the dispersion of the
underlying soils has a median CV of 54.9% against stated errors as low as ±5%.

The defaults are therefore biased in a known direction, and the uncertainty that
crediting standards deduct against measures the precision of a global mean rather than
the variability of the ground.

## Layout

| Folder | Holds |
|---|---|
| `01.manuscript` | The Quarto master. Single source of truth once it exists. |
| `02.inputs` | Extracted CRT panels, spatial summaries, factor tables. |
| `03.outputs` | Generated tables and figures, committed because the manuscript cites them. |
| `04.references` | IPCC guidance and jurisdictional reports. See the manifest in that folder. |
| `05.tasks` | Design documents and task requests. |

## The argument in one paragraph

The methods exist and the data exist. What blocks inclusion is that IPCC Tier 1
default uncertainty for soil pools is wide enough that, once a crediting standard
applies its conservativeness deduction, a large uncertain pool yields less net credit
than a small certain one, and past a threshold yields none. Exclusion is therefore
rational rather than negligent, and the observable consequence is visible: VM0036 has
been available for rewetting drained temperate peatlands since 2017 with reportedly
zero registered projects, and the Paris Agreement Crediting Mechanism has approved no
wetland, peatland or soil carbon methodology at all.

## Traps recorded so far

1. **"Flux-based" applies to organic soils only.** Mineral soil in grassland and
   cropland is stock-change (Equation 2.25, 20-year linear transition). Flux-based
   accounting (Equation 2.26, area x annual emission factor) exists only for organic
   soils. Getting this wrong will be caught immediately.
2. **`IPCC-2013-Kyoto-Supplement-Overview.pdf` is a Second Order Draft** stamped DO NOT
   CITE OR QUOTE. It is not citable, and at least two of its statements were corrected
   in the final, including a reversed description of the organic soil definition. Cite
   `IPCC-2013-Kyoto-Supplement.pdf` instead.
3. **The UNFCCC DI interface cannot carry this study.** Its non-Annex I side uses the
   1996 category tree with no Wetlands category, no drained/rewetted split and no
   separate soil pool, and it ends at 2016 in practice. Parse the CRT workbooks
   directly.
4. **Global Peatland Map 2.0 is CC BY-NC-SA, non-commercial.** Use PEATMAP or
   PEATGRIDS as the extent basis given the commercial context.
5. **The obvious R fork destroys the dependent variable.** `lambwf/Tidy-GHG-Inventories`
   maps `IE` and `NE` to `NA` and `NO` to zero. Those notation keys are the outcome
   variable. Invert that, do not patch it downstream.
