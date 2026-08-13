# Day 036 Practice Questions

## Section A: Concept Checks

1. What is an exception?
2. Why is an exception not always a confirmed defect?
3. What is a review queue?
4. What is a record-level exception?
5. What is a metric-level exception?
6. What is a stage-level exception?
7. Why does every exception need an entity key?
8. What is an issue category?
9. What is an issue type?
10. Why should severity be documented?
11. What is expected value?
12. What is actual value?
13. What is audit context?
14. What is source lineage?
15. What makes a review message useful?
16. Why use `UNION ALL` for combined queues?
17. Why should duplicate exception rows be reviewed?
18. Why can one record have several exception rows?
19. What is affected-record count?
20. What is exception-row count?
21. What is an expected exception?
22. Why must exception SQL remain read-only?

## Section B: Design the Exception Row

For each scenario, define exception level, stage, entity key, category, type, expected value, actual value, severity, and review message.

1. Null customer ID.
2. Null order amount.
3. Negative amount.
4. Unsupported status.
5. Duplicate clean order ID.
6. Source-only order.
7. Clean-only order.
8. Amount mismatch.
9. Status mismatch.
10. Missing report group.
11. Duplicate report group.
12. Null reporting metric.
13. Completed amount mismatch.
14. Unexpected source file.
15. Duplicate exception row.

## Section C: Complete the SQL

Write queries for null-field exception, duplicate-key exception, source-only order, target-only order, amount mismatch, status mismatch, missing report group, reporting duplicate grain, metric mismatch, aligned queue, severity mapping, category mapping, duplicate exception check, summary by category, and summary by severity.

## Section D: Fix the Mistake

1. Issue type says `BAD_DATA`.
2. No entity key is included.
3. Stage name is missing.
4. Severity is random.
5. Expected value is missing.
6. Actual value is missing.
7. Source file is dropped.
8. Review message is vague.
9. `UNION` hides duplicates.
10. Metric and record rows are mixed without level.
11. One issue category contains everything.
12. Duplicate exception rows are ignored.
13. Exception report deletes records.
14. No summary by severity exists.
15. Expected exceptions are treated as confirmed defects.

## Section E: Build the Review Queue

For each scenario, define rule, level, stage, grain, entity key, category, issue type, severity, context, and message.

1. Required customer ID.
2. Required amount.
3. Clean duplicate key.
4. Source missing from clean.
5. Clean-only order.
6. Amount mismatch.
7. Status mismatch.
8. Null reporting metric.
9. Missing reporting group.
10. Unexpected source file.

## Section F: Mini Case Study

Using the supplied files:

1. generate record-level exceptions
2. generate reporting exceptions
3. classify issue categories
4. assign educational severities
5. align output columns
6. combine with `UNION ALL`
7. detect duplicate exception rows
8. enrich with audit context
9. summarise by category and severity
10. produce a final review queue

## Answer Key

### Section A Answers

1. A review item from a validation rule.
2. It may be expected or need business review.
3. A structured list of exceptions.
4. An issue affecting one record.
5. An issue affecting a total or metric.
6. An issue affecting a stage or population.
7. It identifies what to investigate.
8. A stable high-level issue group.
9. A specific issue reason.
10. Severity is a business rule.
11. What the rule expected.
12. What was observed.
13. Audit fields such as timestamps.
14. Source origin fields such as file name.
15. It says what happened and what to review.
16. It preserves all issue rows.
17. They may show rule overlap.
18. One record may fail multiple rules.
19. Count of distinct affected entities.
20. Count of issue rows.
21. A documented review item.
22. Validation should not correct data automatically.

### Section B Guidance

Use `RECORD` for row issues, `METRIC` for totals, and `STAGE` for population or grain issues. Choose stable categories such as `REQUIRED_FIELD`, `DUPLICATE_KEY`, and `CONTROL_TOTAL`.

### Section C Sample Answer

```sql
-- Duplicate clean key exception.
WITH duplicate_orders AS (
    SELECT order_id, COUNT(*) AS row_count
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    'STAGE' AS exception_level,
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'DUPLICATE_KEY' AS issue_category,
    'DUPLICATE_ORDER_ID' AS issue_type,
    1 AS expected_value,
    row_count AS actual_value,
    row_count - 1 AS difference_value,
    'HIGH_REVIEW' AS severity
FROM duplicate_orders;
```

### Section D Answers

Use specific issue types, include entity key and stage, document severity rules, include expected and actual values, keep lineage, write useful review messages, use `UNION ALL`, review duplicates, state exception level, summarise by severity, and never modify data from an exception report.

### Section E and F Guidance

A strong answer creates one row per issue, preserves evidence, uses consistent output columns, combines aligned exception families with `UNION ALL`, and summarises exception rows separately from affected entities.
