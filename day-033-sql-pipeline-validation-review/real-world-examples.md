# Real-World Examples for Day 033

| # | Scenario | Source Population | Target Population | Source Grain | Target Grain | Validation Type | Expected Difference | Exception Output | Evidence |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Source file received | Daily order extract | Source table | One file row | One source row | Row count | None if full file loaded | Missing file rows | file name and count |
| 2 | Raw duplicate order | Source extract | Stage output | One source event | One candidate order | Distinct-key count | duplicate source rows may reduce | duplicate order IDs | order ID counts |
| 3 | Accepted/review split | Stage output | Stage decisions | One staged candidate | accepted plus review | Reconciliation | no unexplained difference | missing status row | status counts |
| 4 | Clean output readiness | Accepted stage | Clean output | One accepted row | One clean order | Source-target keys | review rows excluded | accepted source-only keys | order IDs |
| 5 | Target-only clean row | Source extract | Clean output | One source record | One clean order | Target-only key | none expected | target-only order | order and file |
| 6 | Completed amount reporting | Clean output | Reporting metrics | One clean order | date and group | Control total | aggregation only | amount mismatch | expected and actual amounts |
| 7 | Refund totals | Clean output | Reporting metrics | One clean order | date and group | Control total | aggregation only | refund mismatch | refund totals |
| 8 | Group-level mismatch | Clean output | Reporting metrics | One clean order | date and group | Grouped reconciliation | none after grouping | group mismatch row | date, group, totals |
| 9 | Missing source file | Expected files | Received source files | One expected file | One received file | File completeness | none unless documented | missing file | file name |
| 10 | Missing business date | Expected date range | Source dates | One date | source date | Date completeness | business calendar rules | missing date | date value |
| 11 | Missing category | Expected statuses | Source statuses | One expected status | source status | Category completeness | none unless inactive | missing status | category |
| 12 | Null customer ID | Source extract | Source extract | One source row | exception row | Null completeness | depends on column rule | null-key row | source record |
| 13 | Duplicate clean key | Clean output | Clean output | One clean row | one key group | Duplicate key | none expected | duplicate key | order ID |
| 14 | Duplicate reporting grain | Reporting metrics | Reporting metrics | One report row | one date and group | Composite key | none expected | duplicate reporting key | report key |
| 15 | Null reporting metric | Reporting metrics | Reporting metrics | One report row | exception row | Null completeness | none expected | null metric row | report row |
| 16 | Expected review exclusion | Stage output | Clean output | One staged candidate | one clean order | Expected difference | review rows excluded | only unexplained missing rows | validation reason |
| 17 | Amount mismatch | Stage output | Clean output | One accepted row | one clean row | Value comparison | none unless documented | mismatch row | staged and clean amount |
| 18 | Status mismatch | Stage output | Clean output | One accepted row | one clean row | Value comparison | none unless documented | mismatch row | staged and clean status |
| 19 | Grand-total-only risk | Clean output | Reporting metrics | One clean order | report group | Grouped reconciliation | global total may hide issues | group mismatch | grouped totals |
| 20 | Validation sign-off | All checkpoints | Validation summary | many checks | one summary row per check | Summary | all high checks pass or reviewed | review status rows | check ID and message |

## Practical Reminder

Validation does not make data correct by itself. It makes evidence visible so a data engineer can decide whether the next handoff is safe.
