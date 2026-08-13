# Day 033 Pipeline Validation Cheatsheet

## Mental Model

Count it, key it, total it, group it, check completeness, compare records, explain differences, and report exceptions.

## Row Count

```sql
SELECT
    COUNT(*) AS row_count
FROM source_order_extract;
```

Use this to confirm that a population exists.

## Source-to-Target Count

```sql
WITH source_count AS (
    SELECT COUNT(*) AS row_count
    FROM source_order_extract
),
target_count AS (
    SELECT COUNT(*) AS row_count
    FROM staged_order_output
)
SELECT
    source_count.row_count AS source_row_count,
    target_count.row_count AS target_row_count,
    target_count.row_count - source_count.row_count AS difference
FROM source_count
CROSS JOIN target_count;
```

Use this to compare populations after defining expected differences.

## Duplicate Key Check

```sql
SELECT
    order_id,
    COUNT(*) AS row_count
FROM clean_order_output
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Use this when clean grain should be one row per order.

## Composite Reporting Grain Check

```sql
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_order_metrics
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1;
```

Use grouped checks for multi-column keys because `COUNT(DISTINCT col1, col2)` varies by platform.

## Control Total

```sql
SELECT
    SUM(order_amount) AS completed_amount
FROM clean_order_output
WHERE order_status = 'COMPLETED';
```

Use this to validate numeric consistency.

## Source-Only Keys

```sql
SELECT
    s.order_id,
    s.source_file
FROM source_order_extract AS s
LEFT JOIN clean_order_output AS c
    ON s.order_id = c.order_id
WHERE c.order_id IS NULL;
```

Review whether missing target rows are expected exclusions.

## Target-Only Keys

```sql
SELECT
    c.order_id,
    c.source_file
FROM clean_order_output AS c
LEFT JOIN source_order_extract AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL;
```

Target-only rows usually require investigation.

## Exception Row

An exception row should show the stage, key, issue type, expected value, actual value, severity, and review message.

## Best Practices

- define source and target populations
- align grain before comparing
- use row counts and key counts
- check duplicates
- compare totals globally and by group
- check dates, categories, files, and nulls
- document expected differences
- send unexplained differences to review
- keep validation SQL read-only
