# Ireland's Common Reporting Tables, 2026 submission

**Source.** EPA, downloaded **2026-08-01** from
`https://www.epa.ie/publications/monitoring--assessment/climate-change/air-emissions/IRL-CRT-2026-V1.0.zip`
(40,816,340 bytes). **The UNFCCC mirror sits behind a WAF that returns a JavaScript challenge
to automated fetchers; use the EPA copy.**

**Dimensions.** 35 annual workbooks, **1990–2024**, 61 sheets each. Tables used: **4.D**
(wetlands, on-site soil carbon stock change) and **4(II)** (emissions and removals from
drainage and rewetting).

**Metrics.** Ireland reports at **AR5 GWP-100**: CH4 = 28, N2O = 265. Not AR6. Every comparison
with the manuscript's ledger must convert.

**Use implied factors, not stated ones.** An earlier derivation used the 1.7 t CO2-C/ha/yr
factor the inventory *document* states for industrial peat extraction. The **implied** factor in
the tables for 2024 is **3.587 t C/ha**, more than twice as large, and the difference reverses
the sign of the result at GWP-100. Implied factors are emissions divided by area, so they
reconcile with the totals actually reported.

**Completeness gap, reported not smoothed.** Industrial peat extraction is 62.68 kha in Table
4.D but 34.66 kha in Table 4(II). The 28.02 kha difference carries an on-site CO2 term but no
CH4 and no N2O.

**Applied by** `05.scripts/prep-irish-crt.py` → `derived/irish-crt-peat-balance.csv`. Yields the
paper's strongest national result: rewetting industrial peat extraction is worth **+6.83 t
CO2e/ha/yr at Ireland's own AR5 GWP-100 and −2.89 at AR6 GWP-20**, a sign flip inside a live
national inventory.
