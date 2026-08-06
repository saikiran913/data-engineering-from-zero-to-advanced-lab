# Query Explanations

## Intermediate Result

An intermediate result is a checkpoint between source and final output. It helps make a transformation easier to inspect and validate.

## CTE Staging

CTEs can model staging inside one query. They are useful for source selection, ranking, staging, accepted rows, review rows, and final output.

## Source-to-Stage Validation

Source-to-stage checks compare source row counts, distinct keys, duplicates, nulls, invalid values, timing issues, and source-file distribution.

## Stage-to-Clean Validation

Stage-to-clean checks compare accepted staged rows with clean output. Key uniqueness, nulls, status values, audit columns, and totals matter.

## Clean-to-Reporting Validation

Clean-to-reporting checks focus on totals, grouped counts, date coverage, and reporting grain. Row counts usually differ because reporting data is aggregated.

## Accepted and Review Outputs

Accepted rows continue. Review rows stay visible with a clear reason and severity.

## Grain Changes

Each layer has a grain. Raw events may be one row per delivery. Clean orders may be one row per order. Reporting may be one row per date and group.

## Audit Columns

Audit columns such as `source_file`, `received_at`, and `cleaned_at` help trace where a row came from and when it was processed.

## Checkpoint Summaries

Checkpoint summaries provide `PASS`, `INFO`, or `REVIEW` style outputs that help decide whether a handoff is ready.

## Reporting Reconciliation

Reporting reconciliation compares clean totals and reporting totals. Differences should be investigated or documented.

## Multi-CTE Staging Query

```sql
WITH source_orders AS (
    SELECT event_id, order_id, customer_id, order_amount
    FROM raw_order_events
),
ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY order_id
        ) AS row_num
    FROM source_orders
),
staged_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM ranked_orders
    WHERE row_num = 1
)
SELECT
    order_id,
    customer_id,
    order_amount
FROM staged_orders;
```

`source_orders` selects the input columns. `ranked_orders` adds a sequence. `staged_orders` chooses one candidate per order. The final `SELECT` previews the stage output.

## Method Comparison

| Method | Persists? | Reusable across statements? | Main Use | Main Caution |
|---|---|---|---|---|
| Subquery | No | No | small embedded step | can become hard to read |
| CTE | No | No | readable query stages | not persistent |
| Temporary result concept | varies | limited | repeated short-term use | platform behaviour varies |
| Staging table concept | yes in real pipelines | yes | controlled pipeline handoff | needs ownership and lifecycle |
| Clean table | yes | yes | trusted business grain | still needs validation |
| Reporting table | yes | yes | stored reporting output | freshness and totals need checks |
