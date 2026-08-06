# Day 032 Query Explanations

## Vertical Purpose of the SQL Files

Day 032 does not ask you to deploy a real staging table. The SQL files use CTEs and SELECT queries to represent each stage safely. Each file answers a different staging question.

| File | Business Question | Source Tables | Operation Used | Output Shape | Expected Row Behaviour | Common Validation | Why It Matters |
|---|---|---|---|---|---|---|---|
| `source-standardisation.sql` | Are raw values consistently mapped? | `raw_customer_orders`, `source_status_mapping` | `LEFT JOIN`, `CASE` | One row per raw event | Row count should stay the same | mapping coverage and row count | Bad mappings create bad business logic |
| `deduplication-stage.sql` | Which event should represent each order? | `raw_customer_orders` | `ROW_NUMBER`, duplicate checks | Ranked events and candidate rows | repeated orders are controlled by a rule | repeated keys and ties | Deduplication must be documented |
| `validation-flag-stage.sql` | Which candidates can move forward? | `staged_customer_orders` | `CASE`, filters, counts | One validated candidate row | every row gets a status and reason | missing flags and reason counts | Review rows stay visible |
| `accepted-review-handoff.sql` | Do accepted plus review rows reconcile? | `staged_customer_orders` | filters, `UNION ALL`, summary CTE | accepted rows, review rows, reconciliation | accepted plus review equals staged | unexplained difference | Prevents silent row loss |
| `clean-layer-handoff.sql` | Is clean output ready for reporting? | `clean_customer_orders`, `staged_customer_orders` | counts, duplicate checks | one clean row per order | clean key should be unique | missing fields and invalid amounts | Clean layer is a contract |
| `reporting-layer-handoff.sql` | Is reporting output at the expected grain? | `clean_customer_orders`, `reporting_customer_order_summary` | aggregation and checks | one row per date and country group | reporting keys should be unique | duplicate grain and total reconciliation | Prevents double counting |
| `checkpoint-reconciliation.sql` | Do stages reconcile? | all business datasets | counts, totals, duplicate checks | checkpoint summaries | differences should be explained | counts, dates, audit fields | Makes pipeline issues easier to locate |
| `staging-debugging-lab.sql` | What went wrong? | all business datasets | targeted diagnostics | issue lists | problematic rows become visible | keys, nulls, totals, mapping | Debugging is stage-by-stage |
| `integrated-staging-workflow.sql` | How does the full lab fit together? | all business datasets | multi-CTE workflow | validated candidates, clean projection, reporting projection | grain changes are intentional | accepted/review and handoff checks | Connects the full workflow |

## Source Standardisation

Business question: Are source status values clear before business logic?

Source tables used: `raw_customer_orders` and `source_status_mapping`.

Operation used: `LEFT JOIN` keeps all raw events, even when a mapping is missing. `CASE` creates simple country groups.

Output shape: one row per source event.

Expected row behaviour: the standardised output should not lose source rows.

Common validation: compare raw row count to mapped row count; check unmapped statuses.

Why it matters: if standardisation is wrong, later deduplication and reporting may look technically correct while carrying wrong meaning.

## Deduplication

Business question: Which event should represent an order?

Source table used: `raw_customer_orders`.

Operation used: `ROW_NUMBER` ranks rows inside each `order_id`.

Output shape: ranked rows first, then one selected candidate per order.

Expected row behaviour: repeated raw events are reduced to a candidate population.

Common validation: check repeated `order_id` values and same-timestamp ties.

Why it matters: `ROW_NUMBER` follows the ordering rule. It does not decide business truth by itself.

## Validation Flags

Business question: Which candidate rows are ready and which need review?

Source table used: `staged_customer_orders`.

Operation used: `CASE` creates validation status and reason.

Output shape: one row per staged candidate with explicit decision fields.

Expected row behaviour: every row has a status and a reason.

Common validation: count rows by validation status and reason.

Why it matters: review rows should remain available for investigation.

## Accepted and Review Handoff

Business question: Can staged rows be separated without losing anything?

Source table used: `staged_customer_orders`.

Operation used: filters and a reconciliation CTE.

Output shape: accepted rows, review rows, and a count summary.

Expected row behaviour: accepted count plus review count should equal staged count.

Common validation: `unexplained_difference` should be zero.

Why it matters: unexplained differences can mean hidden filters or missing business rules.

## Clean Handoff

Business question: Is the clean output safe for downstream use?

Source table used: `clean_customer_orders`.

Operation used: duplicate checks, null checks, amount checks, and count comparison.

Output shape: one row per clean order.

Expected row behaviour: `order_id` should be unique when that is the clean contract.

Common validation: duplicate clean key check and accepted-to-clean count comparison.

Why it matters: reporting should not fix clean-layer mistakes silently.

## Reporting Handoff

Business question: Is the reporting output at the right grain?

Source tables used: `clean_customer_orders` and `reporting_customer_order_summary`.

Operation used: `GROUP BY`, `SUM`, and duplicate-grain checks.

Output shape: one row per date and country group.

Expected row behaviour: reporting keys should be unique.

Common validation: duplicate reporting grain and total reconciliation.

Why it matters: duplicate reporting rows can double count results.

## Common Errors

The SQL files repeatedly check for these risks:

- row multiplication after joins
- duplicate clean keys
- duplicate reporting grain
- null critical fields
- unsupported status values
- missing audit columns
- late-arriving records
- totals that do not reconcile

## UNION ALL Review Queue

`accepted-review-handoff.sql` uses `UNION ALL` to combine review issues. This preserves every issue row. If the same staged row has multiple issue categories in a broader real-world process, `UNION ALL` can keep each issue visible.

## Platform Note

Date functions and timestamp comparisons vary across SQL platforms. The examples use simple text-style timestamp comparisons for beginner practice. In a real system, confirm timestamp data types and platform-specific date functions.
