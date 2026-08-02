# NPWS Saltmarsh Monitoring Project

**Source.** National Parks and Wildlife Service, Saltmarsh Monitoring Project 2006–2008,
national resource layer revised 2011.
`https://www.npws.ie/sites/default/files/general/saltmarsh-monitoring-project-2006-2008.zip`,
downloaded 2026-08-01 (9,226,970 bytes).

**Dimensions.** 13,071 polygons · 7,788 ha total · **EPSG:29902**.

**Key fields.** `H_EU_Code` (Annex I habitat code, with a `Potential` prefix for desk-mapped
polygons), `HABITAT`, `SMP_SITE`, `COUNTY`, `AREA__HA_`.

**Three strata that must not be conflated.** Annex I **confirmed** 2,268 ha (field surveyed);
Annex I **potential** 1,903 ha (desk-mapped, never visited, kept separate); **Spartina sward**
1,343 ha (introduced, no Annex code, but still vegetated tidal marsh and so countable under a
Tier 1 reading that makes no species distinction); **mudflat/sandflat** 428 ha (code 1140, an
Annex I habitat but **not** saltmarsh, excluded from every total); other non-Annex 1,846 ha.
Confirmed plus potential brackets McCorry & Ryle's published 3,774 ha.

**Applied by** `05.scripts/prep-irish-saltmarsh-salinity.R` →
`derived/irish-saltmarsh-salinity.csv`, joined to the water bodies in `../WaterBodies/`.
