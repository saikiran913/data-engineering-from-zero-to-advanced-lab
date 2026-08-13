# Day 033 Practice Questions

## Section A: Concept Checks

1. What is pipeline validation?
2. Why are row counts useful?
3. Why are row counts not enough?
4. What is a distinct-key count?
5. What is a duplicate key?
6. What is a control total?
7. Why compare grouped totals?
8. What is completeness?
9. Name three completeness dimensions.
10. What is a source-only key?
11. What is a target-only key?
12. What is an expected difference?
13. What is an unexplained difference?
14. Why should tolerance not be guessed?
15. What is an exception report?
16. What is severity?
17. What is validation evidence?
18. What is checkpoint validation?
19. Why must grain be aligned before comparison?
20. What should happen after a failed check?
21. Why should exception reports not modify data?
22. What is reporting grain in this lesson?

## Section B: Choose the Validation

Choose one or more validation types and give a short reason.

1. A source file might be missing.
2. A clean table may contain two rows for one order.
3. Reporting completed amount looks too low.
4. A source order does not appear in clean output.
5. A clean order has no source record.
6. Reporting has two rows for the same date and country.
7. A metric column is blank.
8. Date 2026-02-09 is missing from source data.
9. A status category disappeared.
10. Source and stage counts differ.
11. Clean and reporting global totals match, but one region looks wrong.
12. Accepted and review rows do not add up to staged rows.
13. A target amount differs from staged amount.
14. A row count query passes, but duplicates are suspected.
15. A business wants a small allowed difference in INR totals.

## Section C: Complete the SQL

Write queries for:

1. source count
2. target count
3. distinct order count
4. duplicate order check
5. reporting composite-key check
6. source-only orders
7. target-only orders
8. amount mismatch
9. status mismatch
10. total reconciliation
11. grouped total reconciliation
12. null completeness
13. file completeness
14. exception queue
15. validation summary

## Section D: Fix the Mistake

1. A validation uses only row count.
2. A query compares raw event count to reporting row count directly.
3. A check has no expected-difference rule.
4. A clean table is not checked for duplicate keys.
5. A reporting table is not checked for duplicate composite keys.
6. A global total check hides a group-level mismatch.
7. Nulls are all treated as failures without business meaning.
8. Source-only rows are ignored.
9. Target-only rows are ignored.
10. A tolerance is invented in SQL.
11. Exceptions are removed from the output.
12. Validation uses an incomplete source date range.
13. Source and target date filters differ.
14. A zero-row exception result is trusted without checking query logic.
15. Failed validation automatically changes data.

## Section E: Design the Validation Rule

For each scenario, define source population, target population, grains, business key, validation type, expected difference, severity, exception output, and evidence.

1. Source to stage row movement.
2. Accepted and review reconciliation.
3. Clean order uniqueness.
4. Clean amount versus staged amount.
5. Clean completed total versus reporting completed total.
6. Reporting grouped totals.
7. Expected source-file delivery.
8. Expected date coverage.
9. Source-only key investigation.
10. Target-only key investigation.

## Section F: Mini Case Study

Using the supplied files:

1. compare source and stage counts
2. validate accepted-review reconciliation
3. validate clean keys
4. find source-only and target-only keys
5. reconcile amounts
6. reconcile grouped metrics
7. check completeness
8. build exception output
9. create validation summary
10. recommend whether downstream review is required

## Answer Key

### Section A Answers

1. Pipeline validation checks whether data moved correctly and completely.
2. They show whether expected volumes are present.
3. Counts can match while keys or values differ.
4. It counts unique business keys.
5. A key appearing more often than expected.
6. A numeric total used as validation evidence.
7. Grouped totals reveal issues hidden by grand totals.
8. Completeness checks whether required data is present.
9. Key, date, file, category, and null completeness are examples.
10. A key in source but not target.
11. A key in target but not source.
12. A documented difference caused by business rules.
13. A mismatch with no documented reason.
14. Tolerance is a business rule.
15. A report of records or metrics needing investigation.
16. A label showing importance of an issue.
17. Query output used to support a validation conclusion.
18. Validation at a pipeline stage boundary.
19. Different grains make counts and totals misleading.
20. Send the issue to review with evidence.
21. Validation should investigate, not alter data.
22. One row per report date and country group.

### Section B Answers

1. File completeness.
2. Duplicate check and distinct-key count.
3. Control-total and grouped reconciliation.
4. Source-only key comparison.
5. Target-only key comparison.
6. Reporting composite-key duplicate check.
7. Null completeness.
8. Date completeness.
9. Category completeness.
10. Row-count validation with expected-difference review.
11. Grouped reconciliation.
12. Accepted-review reconciliation.
13. Source-target value comparison.
14. Distinct-key count and duplicate check.
15. Documented tolerance rule and total reconciliation.

### Section C Sample Answers

```sql
-- Source count.
SELECT COUNT(*) AS source_row_count
FROM source_order_extract;
```

```sql
-- Duplicate clean orders.
SELECT order_id, COUNT(*) AS row_count
FROM clean_order_output
GROUP BY order_id
HAVING COUNT(*) > 1;
```

```sql
-- Source-only orders.
SELECT s.order_id, s.source_file
FROM source_order_extract AS s
LEFT JOIN clean_order_output AS c
    ON s.order_id = c.order_id
WHERE c.order_id IS NULL;
```

```sql
-- Target-only orders.
SELECT c.order_id, c.source_file
FROM clean_order_output AS c
LEFT JOIN source_order_extract AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL;
```

```sql
-- Reporting composite-key check.
SELECT report_date, country_group, COUNT(*) AS row_count
FROM reporting_order_metrics
GROUP BY report_date, country_group
HAVING COUNT(*) > 1;
```

```sql
-- Completed total reconciliation.
WITH clean_total AS (
    SELECT SUM(order_amount) AS completed_amount
    FROM clean_order_output
    WHERE order_status = 'COMPLETED'
),
report_total AS (
    SELECT SUM(total_completed_amount) AS completed_amount
    FROM reporting_order_metrics
)
SELECT
    c.completed_amount AS clean_completed_amount,
    r.completed_amount AS reporting_completed_amount,
    r.completed_amount - c.completed_amount AS difference
FROM clean_total AS c
CROSS JOIN report_total AS r;
```

### Section D Answers

1. Add key, total, completeness, and exception checks.
2. Align grain or compare through documented aggregation.
3. Document expected differences before judging result.
4. Add `GROUP BY order_id HAVING COUNT(*) > 1`.
5. Group by `report_date` and `country_group`.
6. Add grouped reconciliation.
7. Define which nulls are acceptable.
8. Add source-only checks.
9. Add target-only checks.
10. Document tolerance outside the query logic.
11. Preserve exceptions for investigation.
12. Define complete source population.
13. Align date ranges.
14. Inspect query logic and representative samples.
15. Keep validation read-only and send failures to review.

### Section E and F Guidance

A strong answer defines populations, grains, keys, expected differences, check type, severity, and exception evidence. Downstream review is required when high-severity checks show unexplained duplicate keys, target-only rows, missing accepted rows, metric mismatches, or null reporting metrics.
