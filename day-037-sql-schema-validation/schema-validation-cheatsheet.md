# Day 037 Schema Validation Cheatsheet

## Missing Required Column

```sql
SELECT
    e.column_name,
    'MISSING_REQUIRED_COLUMN' AS issue_type
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL;
```

Meaning: required contract column is absent from the observed schema.

## Unexpected Column

```sql
SELECT
    o.column_name,
    'UNEXPECTED_COLUMN' AS issue_type
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;
```

Meaning: observed column is not documented in the expected contract.

## Type Mismatch

```sql
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.expected_data_type <> o.observed_data_type;
```

Meaning: type labels differ and need review.

## Nullability Mismatch

```sql
SELECT
    e.column_name,
    e.nullable_flag AS expected_nullable_flag,
    o.nullable_flag AS observed_nullable_flag
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.nullable_flag <> o.nullable_flag;
```

Meaning: nullability metadata differs from the contract.

## Possible Rename Review

```sql
SELECT
    'customer_id' AS missing_expected_column,
    'customer_identifier' AS unexpected_observed_column,
    'POSSIBLE_RENAME_REVIEW' AS issue_type;
```

Meaning: similar names may indicate a rename, but SQL should not decide semantic equivalence automatically.

## Schema Exception Row

```sql
SELECT
    'SCHEMA' AS exception_level,
    e.column_name AS entity_key,
    'MISSING_COLUMN' AS issue_category,
    'MISSING_REQUIRED_COLUMN' AS issue_type,
    e.expected_data_type AS expected_value,
    'COLUMN_NOT_PRESENT' AS actual_value,
    'HIGH_REVIEW' AS severity
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL;
```

## Pre-Exception Checklist

| Item | Question |
|---|---|
| Rule | What structural expectation is being checked? |
| Stage | Which source or interface is being checked? |
| Level | Is this schema, column, consumer, or summary level? |
| Grain | Is there one row per column, change, or consumer? |
| Entity key | Which column or consumer is affected? |
| Category | What family of issue is this? |
| Issue type | What exact rule failed? |
| Expected value | What did the contract expect? |
| Actual value | What was observed? |
| Difference | What changed? |
| Severity | How urgent is the review? |
| Source context | Which version or file showed the change? |
| Review message | What should the reviewer do next? |

## Beginner Best Practices

- compare expected and observed schemas explicitly
- treat missing required columns as high review
- review optional columns separately
- review unexpected columns before rejecting them
- do not rely on column order as the primary contract
- check type and nullability changes
- document possible renames as uncertain
- review consumer impact
- keep schema validation read-only
- never hide schema drift by changing objects automatically

