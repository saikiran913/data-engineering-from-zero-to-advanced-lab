# Day 036 Exception Reporting Cheatsheet

## Exception Row Shape

Useful columns:

- `exception_level`
- `stage_name`
- `entity_key`
- `issue_category`
- `issue_type`
- `expected_value`
- `actual_value`
- `difference_value`
- `severity`
- `source_file`
- `record_date`
- `review_message`

## Required-Field Exception

```sql
SELECT
    'RECORD' AS exception_level,
    'SOURCE' AS stage_name,
    order_id AS entity_key,
    'REQUIRED_FIELD' AS issue_category,
    'NULL_CUSTOMER_ID' AS issue_type,
    'NON_NULL_CUSTOMER_ID' AS expected_value,
    'NULL' AS actual_value,
    NULL AS difference_value,
    'HIGH_REVIEW' AS severity,
    source_file,
    order_date AS record_date,
    'Customer ID is missing.' AS review_message
FROM source_order_data
WHERE customer_id IS NULL;
```

## Duplicate-Key Exception

```sql
SELECT
    order_id,
    COUNT(*) AS row_count
FROM clean_order_data
GROUP BY order_id
HAVING COUNT(*) > 1;
```

## Summary Pattern

```sql
SELECT
    stage_name,
    issue_category,
    severity,
    COUNT(*) AS exception_row_count,
    COUNT(DISTINCT entity_key) AS affected_entity_count
FROM exception_queue
GROUP BY
    stage_name,
    issue_category,
    severity;
```

## Best Practices

- use stable issue categories
- use specific issue types
- include an entity key
- include expected and actual values where useful
- include audit context
- write clear review messages
- keep one row per issue
- combine aligned outputs with `UNION ALL`
- investigate duplicate exception rows
- keep SQL read-only
