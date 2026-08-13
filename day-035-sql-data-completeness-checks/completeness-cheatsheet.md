# Day 035 Completeness Cheatsheet

## Required-Field Null Check

```sql
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id_count
FROM source_customer_orders;
```

## Blank Value Check

```sql
SELECT
    order_id,
    country_group
FROM source_customer_orders
WHERE country_group IS NULL
   OR country_group = '';
```

## Missing Expected Key

```sql
SELECT
    e.expected_value AS expected_order_id
FROM expected_records_catalog AS e
LEFT JOIN clean_customer_orders AS c
    ON e.expected_value = c.order_id
WHERE e.expectation_type = 'ORDER_ID'
  AND e.stage_name = 'CLEAN'
  AND c.order_id IS NULL;
```

## Missing Expected Date

```sql
SELECT
    e.expected_date
FROM expected_records_catalog AS e
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
WHERE e.expectation_type = 'REPORT_DATE'
  AND r.report_date IS NULL;
```

## Missing Expected File

```sql
SELECT
    e.source_file
FROM expected_records_catalog AS e
LEFT JOIN source_customer_orders AS s
    ON e.source_file = s.source_file
WHERE e.expectation_type = 'SOURCE_FILE'
  AND s.source_file IS NULL;
```

## Safe Percentage Pattern

```sql
CASE
    WHEN expected_count = 0 THEN NULL
    ELSE 100.0 * matched_count / expected_count
END AS completeness_percentage
```

## Best Practices

- define expected population
- define actual population
- define grain and key
- list required fields
- check dates, categories, statuses, and files
- report unexpected extra records
- handle zero denominators
- keep exception rows
- keep SQL read-only
