# Day 032 Notes - SQL Staging Practice

## The Staging Workflow

A staging workflow is a controlled path from raw source records to clean business data and then to reporting-ready output.

| Step | What Happens | Beginner Question |
|---|---|---|
| 1. Inspect raw source | Count rows, inspect dates, check source files | What did we receive? |
| 2. Standardise fields | Map raw statuses, group countries, align names | Do values mean the same thing? |
| 3. Define candidate grain | Decide what one candidate row represents | One row per event or one row per order? |
| 4. Deduplicate | Choose one candidate using a documented rule | Which version should represent the order? |
| 5. Add validation flags | Mark rows as accepted or review | Can this row move forward? |
| 6. Separate accepted and review rows | Keep good rows and suspicious rows visible | What needs investigation? |
| 7. Create clean output | Prepare stable rows for downstream use | Is the clean key unique? |
| 8. Aggregate reporting output | Build summaries after clean grain is stable | What does one report row represent? |
| 9. Reconcile checkpoints | Compare counts, keys, dates, and totals | Did anything change unexpectedly? |
| 10. Document handoffs | Describe grain, rules, audit fields, and limits | Can another person use this safely? |

## Source Standardisation

Raw values are often inconsistent. One source may send `complete`, another may send `completed`, and another may send `paid`. Before applying business rules, data engineers standardise these values.

Standardisation should:

- preserve the original raw value
- add the standard value
- keep audit columns such as `source_file` and `received_at`
- handle unmapped values clearly
- keep null handling explicit
- avoid silently changing business meaning

For example, `raw_status` should remain available even after `standard_status` is created. This helps with troubleshooting and source conversations.

## Candidate Grain

Grain means what one row represents.

| Layer | Example Grain |
|---|---|
| Raw source | One row per received source order event |
| Standardised stage | One row per received source order event with mapped values |
| Ranked stage | One row per order event with a ranking value |
| Candidate stage | One selected candidate row per order |
| Clean layer | One clean row per order |
| Reporting layer | One row per report date and country group |

If the grain is unclear, validation becomes confusing.

## Deduplication Stage

Deduplication means choosing records according to a rule. It does not mean guessing the truth.

A documented rule may say:

- business key: `order_id`
- ordering rule: latest `event_timestamp`
- tie-breaker: latest `received_at`, then `source_event_id`
- unresolved tie: send to review
- raw preservation: keep `source_event_id`, `source_file`, and `received_at`

`ROW_NUMBER` implements the rule. It does not invent the rule. If the rule is wrong, the result can still be wrong.

## Validation Flags

Validation flags make decisions visible. A beginner-friendly pattern is:

- `ACCEPTED` for rows ready for the next stage
- `REVIEW` for rows needing investigation

Validation reasons should be explicit:

- `NULL_ORDER_ID`
- `NULL_CUSTOMER_ID`
- `NULL_ORDER_AMOUNT`
- `NEGATIVE_ORDER_AMOUNT`
- `UNSUPPORTED_STATUS`
- `UNRESOLVED_TIE`
- `READY_FOR_CLEAN`

Severity can be documented separately. Day 032 keeps the executable SQL simple and uses one main status and one main reason.

## Accepted Handoff

Accepted rows satisfy the documented rules for this stage. That does not mean the data is perfect forever. It means the row is allowed to move to the next defined step.

Accepted output should still preserve:

- business key
- standardised fields
- important measures
- source event ID
- source file
- received timestamp

## Review Handoff

Review rows are not deleted silently. They are kept available for investigation.

Review rows help answer:

- Which rule failed?
- Which source file produced the row?
- Is the issue a source issue, mapping issue, or business-rule issue?
- Can the row be fixed later?

## Clean-Layer Handoff

A clean handoff should describe:

- stable key
- clean grain
- standardised status
- valid measures
- selected audit columns
- known limitations

For this lab, the clean grain is one row per clean order.

## Reporting-Layer Handoff

Only aggregate after the clean grain is established. Reporting rows should have a clear grain, such as one row per `report_date` and `country_group`.

Measure definitions must be clear:

- completed order count
- total completed amount
- refund order count
- total refund amount
- pending order count

Reporting totals should be reconciled against the clean layer.

## Checkpoint Reconciliation

Checkpoint reconciliation compares stage outputs.

Equal row counts are not always expected. For example, raw events may have many rows per order, while clean output may have one row per order. In that case, distinct keys and totals may be more meaningful than raw row counts.

Useful checkpoint checks include:

- source row count
- standardised row count
- candidate row count
- accepted row count
- review row count
- clean row count
- reporting row count
- duplicate clean keys
- duplicate reporting grain
- missing critical fields
- date coverage
- amount totals

Accepted rows and review rows should reconcile to the defined staged population. Unexplained differences require investigation.

## Handoff Contract

A handoff contract is simple documentation that tells the next stage what it is receiving.

| Contract Field | Meaning |
|---|---|
| Stage name | Name of the handoff |
| Purpose | Why the stage exists |
| Source object | Input dataset |
| Input grain | What one input row means |
| Output grain | What one output row means |
| Key | Business key or reporting key |
| Required columns | Columns the next stage expects |
| Audit columns | Source traceability columns |
| Accepted rule | Rule for rows allowed forward |
| Review rule | Rule for rows held for review |
| Validation checks | Checks that should pass |
| Downstream consumer | Next stage or team |
| Known limitations | What the output does not guarantee |

## Debugging Multi-Stage SQL

Debug one stage at a time:

1. Run the first CTE logic alone.
2. Inspect row count.
3. Inspect grain.
4. Inspect keys.
5. Inspect nulls.
6. Inspect duplicates.
7. Inspect totals.
8. Inspect sample rows.
9. Add the next stage only after the previous stage makes sense.

This prevents one giant query from hiding the source of the problem.

## Common Mistakes

- standardising after joins
- deduplicating after aggregation
- selecting the latest load instead of the latest business event without review
- losing original status
- losing source file
- accepting records with null keys
- treating all negative values as errors without business context
- combining multiple issues into an unclear flag
- missing accepted and review reconciliation
- allowing clean rows to duplicate the clean key
- allowing reporting rows to duplicate the reporting grain
- not reconciling totals
- making one CTE do too many jobs
- creating too many CTEs with no clear purpose
- failing to document the handoff
- downstream logic reapplying different rules
