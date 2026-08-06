# Day 031 Staging Cheatsheet

## Layer Definitions

| Layer | Meaning |
|---|---|
| Raw | source-aligned data with audit history |
| Staging | prepared intermediate data |
| Clean | accepted business-ready rows at documented grain |
| Reporting | aggregated or consumer-ready output |
| Review queue | suspicious rows with issue reasons |

## CTE Staging Template

```sql
WITH source_rows AS (
    SELECT column1, column2
    FROM source_table
),
staged_rows AS (
    SELECT column1, column2
    FROM source_rows
)
SELECT column1, column2
FROM staged_rows;
```

## Accepted/Review Template

```sql
SELECT
    entity_key,
    validation_status,
    validation_reason
FROM staged_rows
WHERE validation_status = 'REVIEW';
```

## Count Reconciliation

```sql
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_rows,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_rows
FROM staged_orders;
```

## Key and Total Checks

```sql
SELECT order_id, COUNT(*) AS row_count
FROM clean_orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

```sql
SELECT SUM(order_amount) AS total_amount
FROM clean_orders;
```

## Audit-Column Checklist

- `source_file`
- `received_at`
- `loaded_at`
- `updated_at`
- `cleaned_at`
- `validation_status`
- `validation_reason`

## Stage-Handoff Checklist

- input object
- input grain
- output grain
- business key
- required columns
- audit columns
- accepted rule
- review rule
- validation
- consumer
