# Task request, 2026-07-30

For a model starting with fresh context. Read `CLAUDE.md` then `INDEX.md` before acting.
Sole author: Seamus Murphy. Target venue Carbon Balance and Management.

---

## 0. Do this first: cut the runtime cost

This repo is expensive to work in for reasons that have nothing to do with the science.
Measured on 2026-07-30, every single request carries roughly **45,000 tokens of fixed
preamble** before any work happens:

| Source | Per request |
|---|---|
| 399 registered skills, name plus description | ~34,000 tokens |
| Four stacked `CLAUDE.md` files plus `MEMORY.md` | ~6,300 tokens |
| ~30 agent definitions and ~90 deferred tool names | several thousand more |

That is paid on every turn whether the task is editing a table or answering yes or no.

**Task 0a. Prune the skill registry.** 399 skills are registered; this manuscript uses
perhaps five. `database-lookup` alone spends 1,929 characters describing 78 databases that
are irrelevant here. The skills live under `~/.claude/skills` (153 entries) and
`~/.claude/plugins` (480 `SKILL.md` files). Identify the plugin bundles that no manuscript
in `claude-science-library` uses, and disable them at the plugin level rather than deleting
individual skills. Likely candidates for removal, to be confirmed with Seamus before acting:
`development-codebase-tools`, `development-planning`, `development-pr-workflow`,
`development-productivity`, `neuroinformatics`, `grant`, and the finance and molecular
biology skill families. Keep: `scientific-writing`, `citation-management`,
`literature-review`, `research-lookup`, `peer-review`, `scientific-critical-thinking`,
`venue-templates`, `markitdown`, `geomaster`, `geopandas`. This is the single
highest-leverage cost fix and it is a one-time edit.

**Task 0b. Consolidate the CLAUDE.md stack.** Four files load every turn.
`.claude/CLAUDE.md` at the repo root is a 351-character stub that only says "moved" and can
go. The project `CLAUDE.md` has grown to 10.8 kB of accumulated session history; compress it
to current state plus the traps that must not be relitigated, and move the dated session
narrative into `05.tasks/`.

**Task 0c. Repo hygiene.** `04.references` is 139 MB and untracked; confirm it stays out of
git and that the manifest in `04.references/README.md` still describes what is actually
there. Working directory is on a portable SSD, which makes large file operations slow, so
avoid scanning that folder repeatedly. Note there is an untracked `01.manuscript/`,
`docs/`, and several modified tracked files; the repo has only two commits and everything
substantive from this session is uncommitted. **Commit before doing anything else.**

**Cost discipline while working.** Do not re-read the whole 845-line `.qmd` to answer a
narrow question. Do not run broad literature sweeps without a stated budget. Prefer text
extraction over image rendering for PDFs, per the repo rule.

---

## 1. Where the manuscript actually stands

`01.manuscript/ipcc-carbon-gains.qmd` is the master and it renders cleanly in about nine
seconds to a self-contained HTML. Every number is computed at render time from IPCC default
tables encoded in base R. That machinery is sound and is the strongest part of the project.

The document is **563 lines of code against roughly 1,600 words of prose**, and that ratio
is the problem: the analysis is well ahead of the paper.

**Complete.** The global pathway ledger and the net-benefit test. H1 is confirmed and
metric-dependent. At GWP-100 the benefit of rewetting runs 1.26 to 54.54 t CO2e/ha/yr with
no negative case. At GWP-20 it runs −13.17 to 54.40 with five negative rows, all temperate
or boreal: Forest Land boreal poor, boreal rich and temperate; Grassland temperate
nutrient-rich; Peat extraction temperate. Monte Carlo over the published 95% bounds puts
P(benefit > 0) below 0.95 in 5 of 13 rows even at GWP-100. That is the paper.

**Not complete.** Discussion, Conclusions and the entire Ireland section are one-line
placeholder stubs. There are no figures, only tables. And the manuscript has **almost no
in-text citations**: two were inserted by hand this session, against a bibliography of 49.

---

## 2. The critical path, in order

**2a. Cite the manuscript.** This is the binding constraint. The Discussion cannot be
written without it, and the excellent prior-work note at
`docs/science-superpowers/prior-work/2026-07-30-prior-work-note.md` is currently prose in a
markdown file that no reader of the paper will ever see. `04.references/references.bib` was
rebuilt on 2026-07-30 and holds 49 verified entries ready to use.

**Use RStudio's visual editor with Zotero, not hand-written `@keys`.** This is Seamus's
explicit instruction. `apa.csl` stays for now; the Vancouver switch happens at submission
prep, not during drafting. Note Zotero mints its own citation keys, so reconcile against the
existing keys before mass-inserting, or you will get duplicates.

**2b. Add Batjes 2010 to the bibliography.** Identified in full this session from
`04.references/ipcc-guidelines/IPCC-SOCref-Study-Batjes-2010.pdf`:

> Batjes, N.H. (2010). *A global framework of soil organic carbon stocks under native
> vegetation for use with the simple assessment option of the Carbon Benefits Project system
> (Ver. 1.0)*. ISRIC Report 2010/10. Wageningen: ISRIC – World Soil Information. 79 pp.

It is the source of the medians and MAD behind the mean-versus-median section, which
currently computes from a source it cannot cite. Add as `@techreport`.

**2c. Capture three references via the Zotero connector.** These resisted repeated Crossref
and OpenAlex queries across two sessions and are not worth more API spend. Open the
publisher pages and capture them: Zhao et al. (2026) *Communications Earth and Environment*
7:461; Maxwell et al. (2024) *Nature Communications* 15:10265; Arias-Ortiz et al. (2024) on
coastal salinity breakpoints. Arias-Ortiz et al. (2026) on seagrass burial was confirmed to
be **still a preprint**, Research Square DOI 10.21203/rs.3.rs-8462059/v1, so it must not be
cited as peer-reviewed.

**2d. Apply GWP\*.** It is defined in the setup chunk and applied nowhere. The abstract was
narrowed to hide this. Rewetting is a step change in methane and GWP\* is built for exactly
that case, so this is the obvious next result. CGTP (Collins et al. 2020, in the bib) has
never been applied to any wetland in the literature and is the genuinely novel element.

**2e. Propagate uncertainty to the coastal and grassland pathways.** Only the rewetting
benefit has Monte Carlo at present.

**2f. Write the Ireland case.** This is the schedule risk. Nothing in
`02.inputs/README-irish-data-sources.md` has been fetched or verified, the Teagasc SIS API
returned HTTP 500, and the saltmarsh arm may have no published Irish accumulation data at
all. If it does not, fall back to the global factor and state the gap explicitly rather than
quietly filling it. The single most important number to obtain is Irish grassland nitrogen
application rate in kg N/ha/yr, dairy versus drystock, because it drives the nitrogen
crossover.

**2g. Then** Discussion, Conclusions, figures, abstract rewrite (currently 197 words against
a 350-word structured limit), Vancouver CSL, and a Zenodo deposit for the code DOI the
availability declaration requires.

---

## 3. Two things to decide, not to quietly resolve

**The pre-registration gate was skipped.** The pipeline in `CLAUDE.md` is
framing → surveying-prior-work → designing-the-analysis → preregistering-analysis, with no
outcome analysis until pre-registration is complete. The outcome analysis has already run.
Either write the pre-registration retrospectively and say so in the manuscript, or drop the
claim to have followed the gate. Do not leave it ambiguous.

**Chapter 5 has no prior-work coverage.** The survey found nothing on inland wetland mineral
soils, but that looks like a gap in the search rather than an established absence in the
literature. Search it before claiming novelty there.

---

## 4. Literature position, for reference

Roughly 45 verified peer-reviewed papers underpin the project, but coverage is very uneven
and the unevenness is itself a finding.

- **This exact topic**, a cross-pathway greenhouse-gas-weighted net-benefit comparison of
  IPCC countable gains: **nothing exists**. Wilson et al. 2016 is nearest and is bounded to
  inland organic soils. Eight null searches are recorded.
- **Inland organic soils**: well served, ~15 papers, carrying an unreconciled five-way
  contradiction on time-to-climate-benefit from Günther's "immediate" to Schuster's 525
  years.
- **Coastal Chapter 4 Tier 1 factors**: **no peer-reviewed validation exists at all**. This
  is the strongest single justification for the paper. ~13 papers supply independent rates
  to check the defaults against.
- **Improved grassland Chapter 6 factors**: **no critiques exist**. Provenance is a single
  2004 paper (Ogle, Conant and Paustian, 49 studies) unchanged through two revisions. The
  nitrogen crossover is unpublished; nearest precedent is Lugato et al. 2018.
- **Ireland**: essentially one paper, Aitova et al. 2023, which has never been fetched or
  read. This is the thinnest part of the evidence base and it sits under the section that is
  not yet written.

Three papers were added this session that the original survey missed and that a referee
would expect cited: Rosentreter et al. 2021 (*GBC*) and Malerba et al. 2022 (*One Earth*),
both on methane and nitrous oxide complicating blue carbon, and Brennand et al. 2025
(*Carbon Management*) on UK blanket peat restoration carbon costs.

---

## 5. Estimate

The global analysis is about 70% done. The manuscript is closer to 40% of a submittable
article. The gap is prose, citation and the Irish case, not computation.

---

# Addendum, 2026-07-31

Written after the session that rebuilt the manuscript against its exemplar and built the
Ireland section. **Read this addendum before the sections above**, several of which are now
stale.

## 0. Three things that need attention before any writing

**0a. THE MASTER MANUSCRIPT IS NOT IN GIT.** `git ls-files 01.manuscript/` returns nothing.
`ipcc-carbon-gains.qmd`, `04.references/references.bib`, `02.inputs/MANIFEST.md` and the render
are all untracked, and the repo's only two commits are `cfc5939` "Initial commit" and `87e6d07`
"updates". Every result described below exists on one disk, uncommitted. **Do not commit
blindly**: the working tree is mid-reorganisation and `git status` currently shows large
deletions (the whole `04.references/ipcc-guidelines/` PDF set, `02.inputs/batjes-...R`) that are
moves rather than losses. Ask Seamus to confirm the tree has settled, then commit the manuscript,
the bibliography and the docs. This is the highest-risk item in the project and it is not a
science task.

**0b. Two pipeline-gate documents were deleted and are unrecoverable.**
`docs/science-superpowers/questions/2026-07-30-countable-carbon-gains.md`, the **approved
framing**, and `docs/science-superpowers/prior-work/2026-07-30-prior-work-note.md` are gone from
disk. `git log --all --diff-filter=A -- "docs/science-superpowers/*"` confirms they were **never
tracked**, so they cannot be restored from history. The framing document is the record that the
`framing-research-questions` gate was passed. Ask Seamus whether he holds a copy; if not, the
gate record has to be reconstructed from `CLAUDE.md`, which still carries the thesis statement
and the "this paper is not about exclusion" ruling. The surviving prior-work material is
`tasks/EVIDENCE-BASE-2026-07-30.md` and the new Ireland evidence base.

**0c. The tree was reorganised and the entry-point docs now point at nothing.**
`05.tasks/` is now `tasks/`; `02.inputs/README-irish-data-sources.md` is now
`tasks/Irish-data-sources.md`; a new `05.scripts/` holds the Batjes script. Six links in
`CLAUDE.md` and `INDEX.md` are broken (`05.tasks/...`, `README-irish-data-sources`,
`science-superpowers/questions/...`). They were deliberately left unfixed because the move was
still in progress. **Fix them once the tree has settled**, and update the `05.tasks` row in the
INDEX layout table.

## 1. What changed, and what is therefore stale above

**The manuscript was rebuilt against a named structural exemplar: Wilson et al. 2016,
*Mires and Peat* 17(4).** Until 2026-07-30 no model paper had been chosen, only a target
journal, and the draft had grown into a pathway-by-pathway walk through the IPCC tables in
encoding order with lab-notebook headings and empty Discussion and Conclusions. Wilson et al.
encode factors in Methods and drive all of Results to one drained-minus-rewetted table; the
manuscript now does the same. **No computation changed; order and framing did.** Section 1 above
("Where the manuscript actually stands") and the note that the manuscript has no citations are
both obsolete.

Current state: **IMRaD, 5,265 prose words, 39 citations all resolving, no unresolved keys, no
placeholders, renders clean to a self-contained HTML.** Chunk dependency order is load-bearing
after the reorder and is documented in `CLAUDE.md`.

**The Ireland section is built (Results §3.10) and needs no spatial data.** Four results compute
at render time from encoded Irish country-specific factors. The one that carries the paper is
that for nutrient-poor drained grassland the Irish CO2 factor is **4.0x below** Tier 1 while the
CH4 factor is **6.3x above** it, same hectares, same land use, opposite directions: a bias that
confidence intervals cannot express.

## 2. Critical path, revised

**Task 1. ~~Write the CRT-reading script.~~ DONE 2026-08-01, and it CORRECTED the result.**
`05.scripts/prep-irish-crt.py` reads all 35 IRL-CRT-2026-V1.0 workbooks (downloaded from the
EPA, URL in the script docstring, kept at `02.inputs/IRL/CRT/`) and writes
`02.inputs/derived/irish-crt-peat-balance.csv`. In the manuscript as Results, "Ireland's own
inventory, added up".

**The held-out figure was wrong and the corrected one is a better finding.** The review agent
used the **stated** factor of 1.7 t CO2-C/ha/yr from the inventory document; the **implied**
factor in the reporting tables is **3.587 t C/ha**. Corrected result for industrial peat
extraction, 2024, t CO2e/ha/yr: benefit **+6.83 at AR5 GWP-100** (Ireland's own metric),
**+7.02 at AR6 GWP-100**, **−2.89 at AR6 GWP-20**. So the benefit is **positive at GWP-100 and
negative at GWP-20**, a clean sign flip inside a live national inventory, driven by a rewetted
CH4 implied factor 9.3 times the drained one. The near-natural result was right as reported:
**+1.46 t CO2e/ha/yr**, a net source, over 885,022 ha.

**Carry this lesson:** a *stated* factor and an *implied* factor can differ by a factor of two
in the same submission. Compute from the reporting tables. The superseded figure is struck
through in the evidence base §1.5 with the error documented; the correction is §1.5b.

*Original task text follows, for the record.*

**~~Write the CRT-reading script. Highest value, no GIS, no blockers.~~**
Ireland's Common Reporting Tables (`IRL-CRT-2026-V1.0`, 35 annual workbooks, EPA) yield the
single strongest result in the project, and it is currently **held out of the manuscript** under
the never-report-a-number-from-unsaved-code rule, with a callout saying so. Reading implied
factors off the 2024 CRT gives a benefit of rewetting industrial peat extraction of **−0.09
t CO2e/ha/yr at AR5 GWP-100, Ireland's own metric, and −9.81 at GWP-20**; and Ireland's
near-natural peatland turns from a reported CO2 sink into a **net source of about
1.46 t CO2e/ha/yr** once its own reported DOC and CH4 are added. That is the paper's hypothesis
reproduced inside a live national inventory rather than from default tables.

Those figures were derived by a review agent, not by saved code. **Rebuild them in
`05.scripts/` as a committed script that reads the CRT workbooks and writes a small CSV**, then
have the manuscript read the CSV in base R. Do not paste the numbers in. Note the EPA download
works but the UNFCCC mirror sits behind a WAF that returns a JavaScript challenge to curl and to
WebFetch alike; use the EPA copy or ask Seamus for a local one.

While in there, resolve the **unit ambiguity** flagged in the evidence base: NID §6.6.4.2 writes
the rewetted peat-extraction CH4 factors without the "-C", where §6.5.2.4 writes them correctly
as kg CH4-C. The reported IEF of 210.71 fits both a 95.7%-nutrient-rich unconverted reading and a
53.3%-nutrient-rich converted one. If the conversion is genuinely omitted, rewetted CH4 is
understated by a third and the GWP-100 benefit becomes about **−2.05** rather than −0.09.
Resolving it needs the nutrient split of the 44,527 ha from the EPA.

**Task 2. The saltmarsh-by-salinity join. The only genuinely novel Irish spatial analysis.**
No dataset links the NPWS saltmarsh polygons to WFD transitional-waterbody salinity class, so
nobody knows how many Irish hectares fall below the 18 ppt gate that costs 5.23 t CO2e/ha/yr at
AR6 GWP-100 and reverses the tidal marsh pathway's sign. Both layers are public: the Saltmarsh
Monitoring Project shapefiles accompany Irish Wildlife Manuals No. 108, and EPA WFD transitional
waterbodies are on data.gov.ie. Named sub-18-ppt systems to expect are in the evidence base
(Avoca, Erne, Ballysadare, upper Shannon and Fergus). Follow the two-stage rule in
`tasks/Irish-data-sources.md`: spatial work in a saved script writing a CSV, base R in the render.

**Task 3. ~~The SIS re-export.~~ DONE 2026-07-31. No longer blocking.**
The missing geometry and attributes were downloaded from the EPA's public WFS,
`https://gis.epa.ie/geoserver/EPA/wfs`, layer `EPA:SOIL_SISNationalSoils`, `outputFormat=SHAPE-ZIP`,
CC BY 4.0. Verified against the incomplete delivery three ways: the service reported
`numberMatched="25143"`, the delivered `.shx` implies exactly 25,143 features, and the CRS
matches at EPSG:29902. Full provenance and the schema discrepancy between the delivered README
and the WFS field names are in `02.inputs/MANIFEST.md`. Ingest is
`05.scripts/prep-irish-soils.R`, output `02.inputs/derived/irish-soils-area-by-class.csv`.

**The result was better than expected and is now a manuscript section.** `SOC` turned out to be
populated on only **67.7%** of the mapped area, with **92% of the peat blank**, including a single
1,643,401 ha blanket bog unit. That is the paper's structural claim, that there is no reference
stock for peat, visible in the national dataset a compiler would actually reach for. Written up
as Results, "The national soils map has no carbon stock for peat".

**Lesson worth reusing:** when a delivered shapefile is incomplete, check whether the layer is
published on a public OGC service before asking anyone to re-export. The EPA, Teagasc and NPWS
layers are largely on GeoServer or ArcGIS Server, and WFS `GetFeature` with `outputFormat=SHAPE-ZIP`
returns the full dataset. `data.gov.ie`'s CKAN API (`/api/3/action/package_show?id=...`) is the
fastest way to find the service endpoint and confirm the licence.

**Task 4. ~~Obtain the CRCF carbon farming delegated act annex.~~ DONE 2026-07-31, with two
follow-ups.**
Obtained, read, and written into Discussion §4.8 and the Conclusions. It is **C(2026) 4666
final**, 9 July 2026, act 10 pp. plus a 42-page annex. The answer runs the paper's way: Annex
Table 4 permits only models and proxies for soil organic carbon in organic soils, so **IPCC Tier
1 defaults are excluded from exactly the pool this paper is about**; CH4 must be quantified, not
assumed; the post-rewetting methane transient is priced at **10 t CO2e/ha/yr for five years**
absent evidence of no peak; and the crediting horizon is capped by peat exhaustion at 1.0 cm/yr
on bogs and 1.5 on fens. Full extraction in the Ireland evidence base §7b.

Two follow-ups. **(a) Copy both PDFs into `02.inputs/` before the URLs rot.** EUR-Lex and the
transparency register both fail on this document; the working route is the Better Regulation
attachment API, `https://ec.europa.eu/info/law/better-regulation/api/download/090166e5303f9d0c`
for the act and `.../090166e5303f9cd4` for the annex. **(b) Re-check EUR-Lex after ~9 September
2026.** The act has **no CELEX or OJ reference yet**, because its own Article 4 makes entry into
force contingent on publication and it is inside the Article 16(4) scrutiny window. The bib entry
`crcf2026` carries a comment saying to replace it with the published Delegated Regulation number
once one exists. **Do not cite it as an in-force Regulation until then.**

**Task 4b. Obtain Renou-Wilson et al. (2016), *AGEE* 222, 156-170**, the only Irish
drained-versus-rewetted grassland comparison, which underpins the rewetted-grassland factors in
Ireland's inventory. Confirmed **genuinely closed** across thirteen retrieval routes: no
repository copy exists in Unpaywall, OpenAlex, Semantic Scholar, Europe PMC, OpenAIRE, CORE,
BASE, fatcat, UCD's DSpace or Giessen's JLUpub. Needs a subscriber login, interlibrary loan, or a
direct request to Renou-Wilson, who is corresponding author and UCD-based. **Do not substitute
Renou-Wilson et al. (2014) *Biogeosciences* for it silently**: that paper is open and carries the
same CALISTO measurements, but it is two years, three plots, **all drained, no rewetted
treatment**.

**Task 5. Apply GWP\*.** Still defined in the `metrics` chunk and applied to no pathway; the
Limitations section says so explicitly. Rewetting is a step change in a sustained methane flux,
which is the case GWP\* was built for, so this is the obvious next result rather than a loose end.

## 3. Do not redo, and do not undo

- **The counterfactual rule is now structural, not advisory.** The `rewetting` and `drained`
  encoding chunks are **Methods inputs**. Do not move them into Results. Absolute rewetted flux
  is never a finding.
- **Do not restate the corrected coastal claim.** An earlier `CLAUDE.md` said "tidal marsh and
  seagrass both flip to net sources below 18 ppt". Both halves are wrong and the render disproves
  them: seagrass is out of scope for Table 4.14, and mangrove does not flip. **Only tidal marsh
  reverses.** The correction is recorded in `CLAUDE.md`; do not reintroduce the old wording.
- **Do not adjudicate Tuohy vs Aitova.** Two Irish papers from 2023, both feeding the same
  inventory, disagree on the **sign** of rewetting for Irish grassland peat (−0.48 against +21).
  A callout in the manuscript presents the disagreement as the finding. Picking a side destroys
  the point.
- **Use Aitova's corrected national total of 1.9 Mt C/yr**, not the 2.3 that indexed abstracts
  still carry. The PDF is stamped "Data corrected 15 Dec 2023".
- **Ireland reports at AR5** (CH4 = 28, N2O = 265), not AR6. Every comparison with this
  manuscript's ledger must convert.
- **Reproducing Ireland's grassland factor** requires an adjustment factor of **1.14, not
  1.2654**: Ireland places 1.14 in the F_I column, not F_MG, and does not compound it with 1.11.
- The full trap list, with evidence classes and the sources that could not be opened, is in
  `docs/science-superpowers/prior-work/2026-07-30-ireland-evidence-base.md` §6 and §7. **Read it
  before citing any Irish number.**

## 4. Still true from the sections above

Venue constraints (Vancouver references, 350-word structured abstract, archived code DOI, no
colour in tables) are unchanged and verified live on 2026-07-30. `apa.csl` is still in place and
the switch to Vancouver happens at submission prep, not during drafting. Citations in the
manuscript are hand-written `@keys`; the standing decision is RStudio's visual editor with
Zotero, so reconcile before any mass insertion because Zotero mints its own keys. Sole
authorship, and the rule that no design option may put another party on the critical path, both
stand.
