# Practice Questions

## Section A: Concept Checks

1. What is an intermediate result?
2. What is staging?
3. What is the raw layer?
4. What is the clean layer?
5. What is the reporting layer?
6. How can a CTE model a stage?
7. When is a subquery enough?
8. What is the temporary-table concept?
9. What is the staging-table concept?
10. What is input grain?
11. What is output grain?
12. Why does a business key matter?
13. Why preserve audit columns?
14. What is an accepted record?
15. What is a review record?
16. What is a validation checkpoint?
17. What is reconciliation?
18. What is a handoff?
19. What is lineage?
20. Why do platform differences matter?

## Section B: Choose the Intermediate Method

Choose simple query, subquery, CTE, conceptual temporary result, conceptual staging table, or no extra stage.

1. One-time count of clean orders.
2. Multi-step valid-order transformation inside one query.
3. Small average comparison inside a filter.
4. Reused intermediate result across several later checks.
5. Raw order events prepared for a pipeline handoff.
6. One duplicate investigation.
7. A suspicious-row review queue reused daily.
8. A simple customer lookup.
9. A long transformation that needs readable checkpoints.
10. A stage needed for audit and replay.
11. A small embedded filter.
12. A workflow with too many trivial stages.

## Section C: Complete the SQL

1. Preview raw order events.
2. Rank latest event per order.
3. Add validation status.
4. Select accepted rows.
5. Select review rows.
6. Find duplicate staged order IDs.
7. Count null customer IDs.
8. Compare source distinct orders to stage count.
9. Check clean order key uniqueness.
10. Reconcile clean completed amount to reporting amount.
11. Output audit columns.
12. Build a combined review queue.

## Section D: Fix the Mistake

1. Stage has no purpose.
2. Raw data is copied without documentation.
3. Audit columns are dropped.
4. Suspicious rows disappear silently.
5. Stage grain is not defined.
6. Business key is missing.
7. Accepted and review rows are mixed.
8. No validation checkpoint exists.
9. Aggregation happens before deduplication.
10. Counts are compared at different grains.
11. Stage names are `temp1` and `data2`.
12. Clean data is assumed reporting-ready.

## Section E: Design the Stage

For each scenario, define source layer, source grain, stage purpose, output grain, business key, accepted rule, review rule, audit columns, validation, and downstream handoff.

1. Latest order candidate.
2. Duplicate event review.
3. Null customer ID review.
4. Invalid amount review.
5. Late-arriving event review.
6. Stage to clean order handoff.
7. Clean to reporting aggregation.
8. Reporting grain validation.
9. Review queue handoff.
10. No-extra-stage-needed case.

## Section F: Mini Case Study

Design an order pipeline:

1. Inspect raw events.
2. Define stage logic.
3. Separate accepted and review rows.
4. Create clean orders conceptually.
5. Create reporting summary conceptually.
6. Reconcile counts.
7. Reconcile totals.
8. Document audit columns.
9. Define handoff rules.

## Answer Key

### Section A

1. Data produced between source and final output.
2. A controlled preparation layer.
3. Source-aligned data with audit history.
4. Accepted and standardised business data.
5. Consumer-ready summary or reporting data.
6. By naming each query step inside one statement.
7. When the logic is small and embedded.
8. A platform-specific short-lived stored result idea.
9. A more persistent intermediate pipeline stage concept.
10. What one input row represents.
11. What one output row represents.
12. It supports uniqueness and handoff checks.
13. They support investigation and lineage.
14. A row that meets documented rules.
15. A row that needs investigation.
16. A check before handoff.
17. Comparing counts or totals between stages.
18. Passing output to the next stage.
19. The trace of where data came from.
20. Temporary syntax and behaviour vary by platform.

### Section B

1. Simple query.
2. CTE.
3. Subquery.
4. Conceptual temporary result.
5. Conceptual staging table.
6. Simple query or CTE.
7. Conceptual staging table or review view concept.
8. No extra stage.
9. CTE.
10. Conceptual staging table.
11. Subquery.
12. No extra stage or combine stages.

### Section C: Example SQL

```sql
-- Rank latest event per order.
WITH ranked_events AS (
    SELECT
        event_id,
        order_id,
        customer_id,
        event_timestamp,
        received_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY event_timestamp DESC, received_at DESC
        ) AS row_num
    FROM raw_order_events
)
SELECT
    event_id,
    order_id,
    customer_id,
    event_timestamp,
    received_at
FROM ranked_events
WHERE row_num = 1;
```

```sql
-- Select review rows.
SELECT
    order_id,
    customer_id,
    validation_reason,
    source_file,
    received_at
FROM staged_orders
WHERE validation_status = 'REVIEW';
```

```sql
-- Clean to reporting total reconciliation.
SELECT
    (SELECT SUM(order_amount) FROM clean_orders WHERE order_status = 'COMPLETED') AS clean_total,
    (SELECT SUM(total_completed_amount) FROM reporting_order_summary) AS reporting_total;
```

### Section D

1. Define the stage purpose.
2. Document source, grain, and rules.
3. Preserve audit fields.
4. Create a review output.
5. Define stage grain.
6. Define the business key.
7. Split accepted and review rows.
8. Add checkpoint validation.
9. Deduplicate before aggregation.
10. Align grains before comparing counts.
11. Use clear names.
12. Validate reporting readiness.

### Section E

Good answers include layer, grain, key, accepted criteria, review criteria, audit fields, validation checks, and downstream handoff.

### Section F

A strong design preserves raw events, selects latest order candidates in a CTE, classifies accepted and review rows, keeps audit columns, validates counts and totals, creates clean order output only from accepted rows, aggregates clean rows for reporting, and documents the handoff conditions.
