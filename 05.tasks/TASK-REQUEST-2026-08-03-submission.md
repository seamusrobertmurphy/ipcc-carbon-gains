# Task request: finish the submission package, Carbon Balance and Management

Written 2026-08-03 for a fresh context. State at handoff is commit `0e0ad6d` on `main`.
Read `../CLAUDE.md` first, then this file. Do not read the whole session history; everything
needed is here.

The manuscript is `01.manuscript/ipcc-carbon-gains.qmd`. It renders to HTML and DOCX with no
warnings, every cited key resolves, the abstract is 347 words against a 350 cap, and the
science has been verified against the published primary sources. What is missing is the
submission apparatus, and two items need the author rather than an agent.

## Rules that apply to every task below

1. **The master `.qmd` is the only source of truth.** Edit it, never the renders. Rebuild
   with `quarto render ipcc-carbon-gains.qmd --to html` and `--to docx` from inside
   `01.manuscript/`.
2. **Section headings are the author's and are numbered by hand** (`## 3.11 Title`). Do not
   renumber, retitle or reorder them without being asked. `number-sections` is deliberately
   `false` in the HTML format because the numbers are manual; leaving it true printed
   "3.10 3.10 National peatland stocks".
3. **Never report a number that code did not produce.** If a figure appears in prose it must
   come from a chunk in the document or a saved script in `05.scripts/`.
4. **Never invent a citation.** Two references are unresolved (see task 2). If a reference
   cannot be verified, say so; do not attach the nearest plausible paper. This was attempted
   once in this session and reverted.
5. Code is always echoed. No `echo: false`, no `include: false`.

## Blocking, and only the author can do them

- **Competing interests, funding, acknowledgements and the licence.** The declarations block
  sits immediately before `# References` with these marked `[AUTHOR TO COMPLETE BEFORE
  SUBMISSION]`. The journal will not accept the paper with placeholders in it.
- **Zenodo deposit.** The availability declaration requires an archived DOI, not a GitHub
  link. Deposit the repository, then replace `[ZENODO DOI TO BE INSERTED ON DEPOSIT]`.

## Task 1: cross-references (highest value, roughly two hours)

There are twenty tables and four figures and **not one cross-reference in the prose**. No
`@tbl-` or `@fig-` appears anywhere. Production will reject this and referees cannot map a
claim to its evidence.

Most `knitr::kable()` calls sit in chunks whose labels are not `tbl-` prefixed, so Quarto
does not register them as referenceable. For each table worth citing:

1. Give the chunk a `#| label: tbl-<name>` and move the caption into `#| tbl-cap:` if that is
   cleaner than the `caption =` argument. Note that a chunk producing both a table and
   printed output may need splitting.
2. Insert `@tbl-<name>` at the point in the prose where the table is first discussed.
3. Same for the four figures, which already carry `fig-` labels and only need `@fig-` calls
   in the text.

Check afterwards that no reference renders as a literal `?tbl-name`.

## Task 2: the two unresolved references

Both are named in the prose with no citation key, which an editor flags on sight.

- **Zhao et al.**, in the Contested defaults section, for the 7.9 t C/ha/yr drained cropland
  factor overestimating by 31 to 88%. The bibliography header records it as *Zhao et al.
  (2026), Communications Earth & Environment 7:461, drained-factor bias*. Crossref did not
  return it on repeated queries. Ask the author for the DOI, or hand-enter from the header.
- **Arias-Ortiz et al.**, in The salinity gate section, for breakpoints at 21 ± 2 psu
  porewater and 15 ± 3 psu surface water. The header records it as *Arias-Ortiz et al.
  (2024), coastal salinity breakpoints*, also unresolved. **Do not cite the 2021 JGR
  Biogeosciences paper**; it is a different study and does not report those breakpoints.

If either cannot be sourced tonight, the fallback is to delete the sentence rather than
submit an uncited attribution. That is the author's call, so ask.

## Task 3: table triage

Twenty tables in the main text is roughly three times what this journal carries. Keep six or
seven and move the rest to supplementary, renumbering nothing in the headings. Suggested
keepers: the drained-minus-rewetted benefit table, the Monte Carlo table, the coastal
counterfactual table, the inland mineral table, the nitrogen crossover table, the assembled
ledger, and one Irish table. Everything else, including the AR6 metric table, the rewetted
input table, the coastal headroom table, the grassland gain matrix, the Batjes ten-most-biased
table and both magnitude tables, becomes supplementary. Confirm the split with the author
before moving anything.

## Task 4: final compliance checks

- **Reference style.** `04.references/vancouver.csl` is the Elsevier NLM/Vancouver variant.
  The journal specifies Springer Basic. Confirm against the live guidelines and swap if they
  differ in a way a copy editor would catch.
- **Tables must carry no colour or shading.** Verify in the rendered DOCX, not the HTML.
- **Abstract** must stay at or under 350 words; it is at 347, so any addition needs a
  matching cut.
- Keywords are nine, within the three to ten range.

## Task 5: deferred, do not attempt tonight

**Convert the prose numbers to inline R.** There are roughly 195 hand-typed figures in the
narrative against zero inline `` `r ` `` expressions, so prose and tables can drift silently.
This is the largest latent defect in the manuscript and the most likely source of a future
erratum, but it is a day's careful work and it is not a submission blocker. Do it in the
revision window, not before submission.

## What was fixed earlier and should not be reopened

The Wetlands Supplement is extracted per chapter into `04.references/standards/IPCC-md/`
(gitignored, local only) and every encoded factor was checked against it. The "no greenhouse
gas weighting in 354 pages" claim is true and provable. Chapter 5 states in its own voice
that it cannot supply a drained counterfactual. The inland result is nine of nine climate
regions, not six of six. The Monte Carlo section now describes what the sampler actually
does and shows the headline count survives the distributional choice. The coastal sign claim
is qualified by its break-even accumulation rate. Details are in `../CLAUDE.md`.
