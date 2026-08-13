# Day 034 Control Total Cheatsheet

## Row Count

```sql
SELECT COUNT(*) AS row_count
FROM source_sales_extract;
```

Use when you need to count all rows.

## Non-Null Count

```sql
SELECT COUNT(order_amount) AS non_null_amount_count
FROM source_sales_extract;
```

Use when you need to count populated values. Remember that nulls are excluded.

## Distinct-Key Count

```sql
SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM source_sales_extract
WHERE order_id IS NOT NULL;
```

Use when you need unique business-key coverage.

## Duplicate Key Check

```sql
SELECT order_id, COUNT(*) AS row_count
FROM clean_sales_output
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Use when output grain should be one row per key.

## Sum Control

```sql
SELECT SUM(order_amount) AS completed_amount
FROM clean_sales_output
WHERE order_status = 'COMPLETED';
```

Use to reconcile important numeric measures.

## Boundary Control

```sql
SELECT
    MIN(order_date) AS minimum_order_date,
    MAX(order_date) AS maximum_order_date
FROM clean_sales_output;
```

Use to check date or value boundaries.

## Grouped Control

```sql
SELECT
    order_date,
    country_group,
    SUM(order_amount) AS amount_total
FROM clean_sales_output
GROUP BY
    order_date,
    country_group;
```

Use to reveal problems hidden by grand totals.

## Difference Direction

```text
difference = target control - source control
```

Positive means target is larger. Negative means target is smaller.

## Best Practices

- define source population
- define target population
- define grain
- align filters
- align date ranges
- choose the right control
- document expected relationship
- review grouped controls
- preserve evidence
- keep SQL read-only
