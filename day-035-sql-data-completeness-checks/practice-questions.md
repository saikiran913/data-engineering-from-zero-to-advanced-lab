# Day 035 Practice Questions

## Section A: Concept Checks

1. What does completeness mean?
2. Why does completeness not prove correctness?
3. What is field completeness?
4. What is record completeness?
5. What is a required field?
6. What is an optional field?
7. Why are nulls not automatically errors?
8. Why check blank strings?
9. What is a missing key?
10. What is an unexpected record?
11. Why compare expected and actual records?
12. Why are min and max dates not enough?
13. What is category coverage?
14. What is status coverage?
15. What is source-file coverage?
16. What is a completeness percentage?
17. Why handle zero denominators?
18. How can duplicates distort percentages?
19. What is an expected exclusion?
20. What is an unexplained gap?
21. Why preserve exception evidence?
22. Why should missing data not be fabricated?

## Section B: Choose the Completeness Check

Choose null check, blank check, missing-key check, expected-record check, date coverage, category coverage, status coverage, file coverage, or coverage percentage.

1. `customer_id` is required.
2. `country_group` contains empty text.
3. An expected clean order is absent.
4. A clean order has no staged source.
5. A reporting date is missing.
6. A country group is absent from reporting.
7. A new source status appears.
8. A daily source file is missing.
9. You need percent of expected clean orders present.
10. A null reporting metric appears.
11. Expected statuses must be represented.
12. Date-country group coverage is required.
13. Source rows have duplicate order IDs.
14. Accepted stage rows should reach clean.
15. A missing row is explained by review exclusion.

## Section C: Complete the SQL

Write queries for null required field, blank required field, missing source order, missing clean order, unexpected clean order, expected date, missing date, expected country group, missing status, missing file, source-only key, target-only key, completeness percentage, exception queue, and completeness summary.

## Section D: Fix the Mistake

1. Every null is marked as an error.
2. Blank strings are ignored.
3. Expected population is not defined.
4. Source rows are compared to reporting rows directly.
5. Duplicate expected records inflate percentage.
6. Duplicate actual records inflate coverage.
7. Only min and max dates are checked.
8. Category coverage is skipped.
9. File coverage is skipped.
10. Source-only records are ignored.
11. Target-only records are ignored.
12. A percentage is shown without issue rows.
13. Divide-by-zero is possible.
14. Expected exclusions are not documented.
15. Missing rows are generated instead of reported.

## Section E: Design the Completeness Rule

For each scenario, define expected population, actual population, grain, key, required fields, expected values, exclusions, duplicate handling, severity, exception output, and evidence.

1. Required customer IDs.
2. Expected clean order IDs.
3. Accepted-to-clean coverage.
4. Expected reporting dates.
5. Expected date-country groups.
6. Expected source files.
7. Expected source statuses.
8. Null reporting metrics.
9. Unexpected clean-only records.
10. Blank country groups.

## Section F: Mini Case Study

Using the supplied files:

1. identify required fields
2. validate source keys
3. validate stage keys
4. validate accepted-to-clean coverage
5. validate expected report dates
6. validate expected country groups
7. validate expected source files
8. calculate simple coverage percentages
9. build exception output
10. create completeness summary

## Answer Key

### Section A Answers

1. Expected data is present.
2. Values can be present but wrong.
3. Required columns are populated.
4. Expected rows or keys exist.
5. A field that must be populated by rule.
6. A field allowed to be missing.
7. Requiredness depends on business meaning.
8. Blank text may act like missing data.
9. An expected key not found.
10. A record found where it was not expected.
11. To identify gaps and extras.
12. Middle dates can be missing.
13. Expected categories are present.
14. Expected statuses are present.
15. Expected files are present.
16. Matched expected records divided by expected records.
17. To avoid invalid percentage logic.
18. They can inflate actual matches.
19. Missing data explained by a documented rule.
20. Missing or extra data needing review.
21. Review needs reproducible details.
22. Validation should report gaps, not alter data.

### Section B Answers

1. null check
2. blank check
3. expected-record check
4. target-only key check
5. date coverage
6. category coverage
7. status coverage
8. file coverage
9. coverage percentage
10. null check
11. status coverage
12. category/date coverage
13. duplicate handling before percentage
14. missing-key check
15. expected-exclusion review

### Section C Sample Answers

```sql
-- Missing expected clean orders.
SELECT e.expected_value AS expected_order_id
FROM expected_records_catalog AS e
LEFT JOIN clean_customer_orders AS c
    ON e.expected_value = c.order_id
WHERE e.expectation_type = 'ORDER_ID'
  AND e.stage_name = 'CLEAN'
  AND c.order_id IS NULL;
```

```sql
-- Null required source fields.
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id_count
FROM source_customer_orders;
```

```sql
-- Missing expected report dates.
SELECT e.expected_date
FROM expected_records_catalog AS e
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
WHERE e.expectation_type = 'REPORT_DATE'
  AND r.report_date IS NULL;
```

### Section D Answers

Define requiredness, check blanks, define expected populations, align grain, deduplicate where needed, explicitly check middle dates, add category and file coverage, inspect source-only and target-only rows, pair percentages with exception lists, guard zero denominators, document expected exclusions, and never fabricate missing data.

### Section E and F Guidance

A strong answer defines expected and actual populations, grain, key, required fields, expected values, exclusions, duplicate handling, severity, exception output, and evidence. Any unexplained gaps should receive `REVIEW` status before downstream use.
