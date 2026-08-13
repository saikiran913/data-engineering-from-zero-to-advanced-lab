# Day 037 Practice Questions

## Section A: Concept Checks

1. What is a schema?
2. What is a schema contract?
3. Why are required columns important?
4. How is an optional column different from a required column?
5. What is a missing column?
6. What is an unexpected column?
7. Why is an unexpected column not automatically a defect?
8. What is a data-type mismatch?
9. Why can `DECIMAL` changing to `TEXT` be risky?
10. What is nullability metadata?
11. Why are nullability metadata and actual null values different checks?
12. Why is column order a weak contract?
13. What is schema drift?
14. What is an additive schema change?
15. What is a potentially breaking schema change?
16. Why can a renamed column break SQL?
17. Why can a removed column break consumers?
18. Why can `SELECT *` consumers be affected by added columns?
19. What is semantic drift?
20. Why do key columns need special attention?
21. Why should schema versions be documented?
22. Why should schema validation produce reports rather than migrations?

## Section B: Classify the Change

Classify each as no change, additive change, missing required, missing optional, type change, nullability change, possible rename, position-only change, or semantic-review required.

1. `order_currency` appears in V2 but is not in the expected schema.
2. `customer_id` is missing from V2.
3. `customer_identifier` appears when `customer_id` disappears.
4. `order_amount` changes from `DECIMAL` to `TEXT`.
5. `order_status` changes from non-nullable to nullable.
6. `order_date` moves from position 4 to position 3.
7. `order_id` is still present as `TEXT`.
8. `source_file` is missing from V2.
9. `audit_loaded_by` appears in V2.
10. `loaded_at` changes from `TIMESTAMP` to `DATE`.
11. `country_group` keeps the same name and type but the grouping definition changes.
12. An optional description column is absent.
13. `source_batch_id` appears in V1.
14. A required key column disappears.
15. `order_date` changes from `DATE` to `TIMESTAMP`.

## Section C: Complete the SQL

1. Write a query to list missing required columns in V2.
2. Write a query to list unexpected columns in V2.
3. Write a query to show exact type matches in V2.
4. Write a query to show type mismatches in V2.
5. Write a query to show nullability mismatches in V2.
6. Write a query to show possible rename evidence for `customer_id`.
7. Write a query to count added columns in V2.
8. Write a query to count expected columns missing from V2.
9. Write a query to compare V1 and V2 column names.
10. Write a query to list `SELECT *` consumers.
11. Write a query to list consumers expecting `order_amount`.
12. Write a schema exception row for missing `source_file`.
13. Write a summary by validation-rule severity.
14. Write a query to count high-sensitivity consumers.
15. Write a query to list required expected columns.

## Section D: Fix the Mistake

1. A query checks only `observed_order_schema_v2` and says the schema is valid.
2. A query treats every unexpected column as a confirmed defect.
3. A query assumes `customer_identifier` definitely means `customer_id`.
4. A query ignores required and optional flags.
5. A query ignores data types.
6. A query ignores nullability.
7. A query compares only column positions.
8. A query ignores consumers.
9. A query uses schema validation to alter a table.
10. A query uses vague issue categories.
11. A query has no severity.
12. A query has no review message.
13. A query says a schema match proves values are correct.
14. A query ignores schema version.
15. A query hides exceptions with duplicate removal.

## Section E: Design the Schema Contract

For each scenario, define dataset purpose, grain, business key, expected columns, required flags, types, nullability, consumer sensitivity, and review rules.

1. Daily order reporting dataset.
2. Customer lookup dataset.
3. Payment summary dataset.
4. Source file audit dataset.
5. Product inventory extract.
6. Website event feed.
7. Campaign performance report.
8. Refund transaction dataset.
9. Validation exception queue.
10. Fixed-column external extract.

## Section F: Mini Case Study

Using the supplied files:

1. Compare expected schema with V1.
2. Compare expected schema with V2.
3. Identify missing required columns.
4. Identify unexpected columns.
5. Identify type changes.
6. Identify nullability changes.
7. Review possible renames.
8. Identify affected consumers.
9. Build schema exception output.
10. Build validation summary.

## Answer Key

### Section A Answers

1. A schema is the structure of a dataset.
2. A schema contract is the documented expected structure for consumers.
3. Required columns are important because downstream logic expects them.
4. Optional columns may be absent if documented; required columns must exist.
5. A missing column is expected but not observed.
6. An unexpected column is observed but not in the expected contract.
7. It may be an intentional additive change.
8. A data-type mismatch means expected and observed type labels differ.
9. Numeric calculations may fail or sort incorrectly.
10. Nullability metadata says whether a column may contain nulls.
11. Metadata describes structure; actual null checks inspect data values.
12. Position changes can affect fragile exports and `SELECT *` consumers.
13. Schema drift is structural difference between expected and observed schema.
14. An additive change adds a column or structure.
15. A breaking change can break downstream consumers.
16. SQL referring to the old name may fail.
17. Consumers expecting the removed column may fail.
18. Added columns can change the output shape.
19. Semantic drift is a meaning change that may not appear structurally.
20. Key columns define identity, joins, grouping, and grain.
21. Versions help compare and trace changes.
22. Validation should report issues; migration is a separate controlled process.

### Section B Answers

| # | Classification | Reason |
|---|---|---|
| 1 | Additive change | New non-contract column appears |
| 2 | Missing required | `customer_id` is required |
| 3 | Possible rename | Similar new name appears when old name disappears |
| 4 | Type change | `DECIMAL` became `TEXT` |
| 5 | Nullability change | Non-nullable became nullable |
| 6 | Position-only change | Name may remain but position changed |
| 7 | No change | Name and type still match |
| 8 | Missing required | `source_file` is required |
| 9 | Additive change | New audit-like column appears |
| 10 | Type change | Timestamp detail may be lost |
| 11 | Semantic-review required | Meaning changed without structural proof |
| 12 | Missing optional | Optional expected column is absent |
| 13 | Additive change | New V1 column appears |
| 14 | Missing required | Key columns are high risk |
| 15 | Type change | Date became timestamp |

### Section C Sample Answers

```sql
-- 1. Missing required columns in V2.
SELECT
    e.column_name
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.required_flag = 'Yes'
  AND o.column_name IS NULL;
```

```sql
-- 2. Unexpected columns in V2.
SELECT
    o.column_name
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;
```

```sql
-- 3 and 4. Type comparison in V2.
SELECT
    e.column_name,
    e.expected_data_type,
    o.observed_data_type,
    CASE
        WHEN e.expected_data_type = o.observed_data_type THEN 'MATCH'
        ELSE 'REVIEW'
    END AS type_status
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name;
```

```sql
-- 5. Nullability mismatches.
SELECT
    e.column_name,
    e.nullable_flag AS expected_nullable_flag,
    o.nullable_flag AS observed_nullable_flag
FROM expected_order_schema AS e
JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE e.nullable_flag <> o.nullable_flag;
```

```sql
-- 6. Possible rename evidence.
SELECT
    'customer_id' AS missing_expected_column,
    'customer_identifier' AS unexpected_observed_column,
    'POSSIBLE_RENAME_REVIEW' AS issue_type;
```

```sql
-- 7. Count added columns in V2.
SELECT
    COUNT(*) AS added_column_count
FROM observed_order_schema_v2 AS o
LEFT JOIN expected_order_schema AS e
    ON o.column_name = e.column_name
WHERE e.column_name IS NULL;
```

```sql
-- 8. Count expected columns missing from V2.
SELECT
    COUNT(*) AS missing_expected_column_count
FROM expected_order_schema AS e
LEFT JOIN observed_order_schema_v2 AS o
    ON e.column_name = o.column_name
WHERE o.column_name IS NULL;
```

```sql
-- 9. V1 and V2 column-name comparison.
WITH all_columns AS (
    SELECT column_name FROM observed_order_schema_v1
    UNION
    SELECT column_name FROM observed_order_schema_v2
)
SELECT
    a.column_name,
    v1.column_name AS v1_column,
    v2.column_name AS v2_column
FROM all_columns AS a
LEFT JOIN observed_order_schema_v1 AS v1
    ON a.column_name = v1.column_name
LEFT JOIN observed_order_schema_v2 AS v2
    ON a.column_name = v2.column_name;
```

```sql
-- 10. SELECT-star consumers.
SELECT
    consumer_id,
    consumer_name
FROM schema_consumer_catalog
WHERE select_star_usage = 'Yes';
```

```sql
-- 11. Consumers expecting order_amount.
SELECT
    consumer_id,
    consumer_name
FROM schema_consumer_catalog
WHERE required_columns LIKE '%order_amount%';
```

```sql
-- 12. Schema exception row for missing source_file.
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
WHERE e.column_name = 'source_file'
  AND o.column_name IS NULL;
```

```sql
-- 13. Summary by rule severity.
SELECT
    severity,
    COUNT(*) AS rule_count
FROM schema_validation_rules
GROUP BY severity;
```

```sql
-- 14. High-sensitivity consumer count.
SELECT
    COUNT(*) AS high_sensitivity_consumer_count
FROM schema_consumer_catalog
WHERE change_sensitivity = 'High';
```

```sql
-- 15. Required expected columns.
SELECT
    column_name,
    expected_data_type
FROM expected_order_schema
WHERE required_flag = 'Yes'
ORDER BY expected_position;
```

### Section D Answers

1. Compare expected and observed schemas.
2. Mark unexpected columns as review first.
3. Use possible-rename review and require human confirmation.
4. Include `required_flag`.
5. Compare expected and observed types.
6. Compare expected and observed nullable flags.
7. Compare by column name and report position separately.
8. Use the consumer catalog.
9. Keep SQL read-only.
10. Use controlled issue categories.
11. Add severity.
12. Add clear review messages.
13. Run value-level validation separately.
14. Include source version and observed timestamp.
15. Use `UNION ALL` for exception queues and investigate duplicates separately.

### Section E Answer Guidance

A strong contract should include purpose, grain, key columns, required columns, optional columns, expected types, nullability, business meaning, consumer sensitivity, and review rules. Answers may vary by business requirement.

### Section F Answer Guidance

Expected results should identify that V1 mostly matches the expected schema with an additive `source_batch_id`, while V2 has missing required columns, unexpected columns, type changes, nullability changes, position changes, and possible rename evidence. Consumer impact should highlight `SELECT *` consumers, high-sensitivity consumers, and consumers expecting `customer_id`, `source_file`, `order_amount`, `order_date`, or `loaded_at`.

