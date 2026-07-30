# Reference manifest

Provenance and citability of everything in this folder. Third-party PDFs are not
committed to git; this manifest records what they are and where they came from.

## Citability warnings

| File | Problem |
|---|---|
| `ipcc-guidelines/IPCC-2013-Kyoto-Supplement-Overview.pdf` | **Second Order Draft, stamped "DO NOT CITE OR QUOTE".** Not citable. At least two statements differ substantively from the final: it describes the 2006 organic soil definition as simplifying and excluding the FAO Histosol thickness criterion, where the final says it largely follows FAO; and it cites Decision 16/CMP.1 para 21 where the final cites Decision 2/CMP.7 para 26. Use `IPCC-2013-Kyoto-Supplement.pdf` instead. |

## IPCC guidance

Retrieved from `ipcc-nggip.iges.or.jp`. The three marked **added 2026-07-30** were
downloaded during design review, because the collection covered grassland and cropland
but was missing every wetland chapter, which is where the flux-based methods live.

| File | What it is |
|---|---|
| `IPCC-2013-Wetlands-Supplement.pdf` | **Added 2026-07-30.** 2013 Supplement: Wetlands. 354pp. The source of every organic-soil emission factor this project depends on. The 2019 Refinement Ch6 defers to its section 2.2 five separate times. |
| `IPCC-2006-V4-Ch7-Wetlands.pdf` | **Added 2026-07-30.** 2006 Guidelines Vol 4 Ch7. |
| `IPCC-2019-V4-Ch7-Wetlands.pdf` | **Added 2026-07-30.** 2019 Refinement Ch7, wetlands and flooded land. |
| `IPCC-2019-V4-Ch2-Generic-Methodologies.pdf` | Equation 2.25 (mineral soil stock change), Equation 2.26 (organic soil flux), Table 2.3 SOCref defaults with sample sizes. The uncertainty predictor for H2 comes from here. |
| `IPCC-2019-V4-Ch6-Grassland.pdf` | Table 6.2 stock change factors. Only the mineral-soil section was refined; organic soils say "No refinement" throughout. |
| `IPCC-2019-V4-Ch5-Cropland.pdf` | The Tier 2 steady-state method, cropland only. |
| `IPCC-2019-V4-Ch1-Introduction-Overview.pdf` | Managed Land Proxy; Table 1.2 footnote confirming Tier 1 and 2 estimate only annual flux from organic soils. |
| `IPCC-2019-V4-Ch3-Consistent-Land-Representation.pdf` | Land representation Approaches 1 to 3. |
| `IPCC-2019-V4-Ch4-Forestland.pdf`, `-Ch8-Settlements.pdf`, `-Annex1-Mapping-Tables.pdf`, `-Overview-of-Changes.pdf` | Refinement supporting chapters. Annex 1 is the change log and settles what was actually refined. |
| `IPCC-2006-V4-*` | 2006 Guidelines, Vol 4. The Refinement supplements these rather than replacing them, so both are needed. |
| `IPCC-2013-Kyoto-Supplement.pdf` | Final, citable. Wetland Drainage and Rewetting as an elected activity. Defers to the Wetlands Supplement for all factors and equations. Section 1.4 states that WDR has no baseline scenario and no project boundary, which constrains what can be claimed about project-scale application. |
| `IPCC-2003-GPG-LULCFC.pdf` | Good Practice Guidance for LULUCF. |
| `IPCC-1997-V3-Ch5-Forestry-*.pdf` | 1996 Guidelines. Relevant because the UNFCCC DI interface still uses this category tree for non-Annex I. |
| `IPCC-2021-AR6-*` | AR6 WG1 Ch7 and annexes. Radiative forcing and GWP context. |
| `IPCC-2010-Erata-*.pdf` | Erratum on land, climate and soil carbon classification. |
| `IPCC-ISFL-SOC-Guidance.pdf` | BioCarbon Fund ISFL soil carbon guidance. **Not an IPCC document** despite the filename. Bridges national accounting to baseline-and-credit programmes, which is exactly the gap the KP Supplement leaves open. |
| `IPCC-SOCref-Study-Batjes-2010.pdf`, `-2011-Updates.pdf` | The underlying studies behind Table 2.3 SOCref defaults. Needed to test the defaults on their own terms. |

## Jurisdictional reports

ART TREES documents for Ecuador. Note that these are two different document families,
not successive drafts: the 2024 report is MAATE's submission to ART, the 2025 documents
are Ricardo/Winrock technical assistance under the UK DESNZ LEAF programme.

| File | What it is |
|---|---|
| `reports/Ecuador_TREES-Monitoring-Report-FINAL-Julio 2024_english.pdf` | MAATE monitoring report, July 2024. Excludes soil organic carbon entirely, on the stated grounds that there are no peer-reviewed studies for the nine forest types, despite soil having been sampled in both national forest inventory cycles. Páramo is mapped to Grassland and coded non-accountable in every transition. |
| `reports/Ecuador_TREES_Emissions-Update-Report_07142025.*` | Emissions update, issued 16/07/2025. Shorter version. |
| `reports/Ecuador_TREES_Emissions-Update-Report_07162025.pdf` | Same issue date, superset of the above, adds Appendix IV including an unused Forest-to-Grassland Tier 1 matrix. |
| `reports/Ecuador_TREES_Emissions-Update-Report_07302025.docx` | The TREES §4.5 significance analysis. Quotes the pool-scope rule verbatim, and classifies peat soil carbon as a primary pool (mandatory) and mineral soil carbon as secondary (excludable below 3%). This asymmetry is the clearest single illustration of the paper's thesis. Contains arithmetic that does not reconcile with the 2024 report and should not be quoted uncritically. |

Note for disclosure: Seamus Murphy is a named author on the 2025 emissions update
reports. If Ecuador appears as a worked case in the manuscript, this is a conflict of
interest requiring declaration.

## Style assets

`apa.csl`, `style-formal.docx`. Retain until the venue's actual citation style is
verified.
