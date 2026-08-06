# Query Explanations

## Dependency Mapping

Business purpose: identify which source objects and consumers are connected to a view. The SQL uses `view_consumers` and `view_change_cases` because metadata catalog syntax varies across platforms.

## Consumer Mapping

Consumer mapping shows who may be affected. High-sensitivity consumers require extra review because their reports or extracts may depend on exact columns, grain, and metrics.

## Row-Count Comparison

Row-count checks compare old and proposed logic. If the count changes, decide whether the change is expected or needs review.

## Key-Uniqueness Comparison

Key checks confirm whether the output still matches expected grain. If a one-row-per-order view has duplicate `order_id` values, the grain may have changed.

## Old-Versus-New Output Comparison

Old logic is written as one CTE. Proposed logic is written as another CTE. The final query compares counts, totals, keys, and samples without changing a production object.

## Column-Contract Review

Column contracts include names, meanings, types, null behaviour, and required fields. Renaming `completed_order_amount` to `revenue_amount` may break consumers even if the SQL runs.

## Grain Review

Grain review asks what one row represents. One row per order is not the same as one row per order-payment attempt.

## Join-Impact Review

Join changes can retain more rows, remove rows, or multiply rows. Adding payments to orders can create several rows for one order.

## Filter-Impact Review

Filter changes alter business meaning. Completed-only orders and completed-plus-refunded-like orders answer different questions.

## Aggregation-Impact Review

Aggregation changes can alter output grain. Moving from order rows to customer summaries changes row count while totals may still reconcile.

## Regression-Validation Summary

Regression summaries separate `PASS`, `EXPECTED_CHANGE`, and `REVIEW`. Expected differences should be documented, not ignored.

## Line-by-Line Old/New CTE Example

```sql
WITH old_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_view_logic AS (
    SELECT order_id, customer_id, order_status, order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT
    (SELECT COUNT(*) FROM old_view_logic) AS old_count,
    (SELECT COUNT(*) FROM new_view_logic) AS new_count;
```

`old_view_logic` represents current behaviour. `new_view_logic` represents the proposed change. The final `SELECT` compares output size before any production object is changed.

## Change Comparison Table

| Change type | Main validation | Typical risk |
|---|---|---|
| Add column | Consumer contract review | Fixed schemas can change |
| Rename column | Required-column check | Reports can fail |
| Remove column | Consumer inventory | Required fields disappear |
| Filter change | Row count and excluded rows | Business meaning changes |
| Join change | Duplicate-key and unmatched checks | Rows multiply or disappear |
| Aggregation change | Grain and total reconciliation | Output grain changes |
| Null handling | Null count and distribution | Grouping and filters change |
