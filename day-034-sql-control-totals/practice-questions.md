# Day 034 Practice Questions

## Section A: Concept Checks

1. What is a control total?
2. Why are control totals useful?
3. What does `COUNT(*)` count?
4. What does `COUNT(order_amount)` exclude?
5. What does `COUNT(DISTINCT order_id)` measure?
6. Why do row counts and distinct-key counts answer different questions?
7. What is a sum control?
8. What is a boundary control?
9. Why are `MIN` and `MAX` useful?
10. What is a grouped control?
11. Why can a grand total be misleading?
12. What is stage reconciliation?
13. What should accepted plus review reconcile to?
14. Why do clean and reporting row counts usually differ?
15. What is an exact-match relationship?
16. What is an expected difference?
17. What is an unexplained difference?
18. Why must filters align?
19. Why must date ranges align?
20. How can nulls affect controls?
21. What is source-file control?
22. Why should tolerances not be guessed?

## Section B: Choose the Control

Choose row count, distinct-key count, sum, min, max, grouped count, grouped sum, or accepted-review reconciliation.

1. Confirm the source file has rows.
2. Check how many unique orders arrived.
3. Find duplicate clean orders.
4. Compare completed amount from clean to reporting.
5. Compare earliest source date to earliest clean date.
6. Compare latest clean date to latest reporting date.
7. Count orders by source file.
8. Compare amount by country group.
9. Confirm staged rows are either accepted or review.
10. Check pending order count.
11. Check refund amount.
12. Check reporting duplicate date and country group.
13. Find minimum order amount.
14. Find maximum order amount.
15. Compare status distribution.

## Section C: Complete the SQL

Write queries for:

1. source row count
2. distinct source order count
3. accepted count
4. review count
5. accepted plus review reconciliation
6. clean total amount
7. reporting completed amount
8. reporting refund amount
9. minimum source order date
10. maximum clean order date
11. source-file count
12. grouped country amount total
13. grouped status count
14. stage-clean count difference
15. control summary

## Section D: Fix the Mistake

1. A control does not define population.
2. A control does not define grain.
3. Source uses completed rows but target uses all rows.
4. Source and target use different date ranges.
5. A row count uses `COUNT(order_amount)` by mistake.
6. No distinct-key check is used.
7. No sum control is used.
8. No boundary control is used.
9. No grouped control is used.
10. Only grand total is checked.
11. Nulls are ignored.
12. Accepted plus review does not equal stage.
13. A key appears in accepted and review.
14. Source-file coverage is ignored.
15. Difference sign is interpreted backwards.

## Section E: Design the Control Rule

For each scenario, define source population, target population, grain, filter, control type, measure, grouping, expected relationship, expected difference, severity, and evidence.

1. Source row count.
2. Source distinct orders.
3. Stage accepted-review reconciliation.
4. Stage-to-clean count.
5. Stage-to-clean amount.
6. Clean-to-reporting completed amount.
7. Clean-to-reporting grouped amount.
8. Source date boundary.
9. Source-file distribution.
10. Reporting duplicate grain.

## Section F: Mini Case Study

Using the supplied files:

1. count source rows
2. count distinct source orders
3. reconcile stage accepted and review
4. reconcile stage and clean counts
5. reconcile clean and reporting amounts
6. compare date boundaries
7. compare grouped totals
8. investigate mismatches
9. build control summary
10. recommend review status

## Answer Key

### Section A Answers

1. A simple validation metric calculated on a defined population.
2. They are easy evidence for stage checks.
3. All rows.
4. Null values in `order_amount`.
5. Unique non-null order IDs.
6. Row count counts rows; distinct-key count counts unique business keys.
7. A numeric total such as `SUM(order_amount)`.
8. A minimum or maximum value check.
9. They show earliest, latest, smallest, and largest boundaries.
10. A control calculated by a dimension.
11. Group issues can cancel each other out.
12. Comparing controls between stages.
13. Total staged rows.
14. Reporting is aggregated.
15. A comparison where values should be equal.
16. A documented difference caused by business rules.
17. A difference needing review.
18. Different filters compare different populations.
19. Different date ranges create unfair comparisons.
20. `COUNT(column)` ignores nulls and sums may need null review.
21. Count or total by source file.
22. Tolerance is a business rule.

### Section B Answers

1. row count
2. distinct-key count
3. distinct-key count or duplicate check
4. sum
5. min
6. max
7. grouped count
8. grouped sum
9. accepted-review reconciliation
10. count
11. sum
12. grouped count
13. min
14. max
15. grouped count

### Section C Sample Answers

```sql
-- Source row count.
SELECT COUNT(*) AS source_row_count
FROM source_sales_extract;
```

```sql
-- Distinct source orders.
SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM source_sales_extract
WHERE order_id IS NOT NULL;
```

```sql
-- Accepted-review reconciliation.
SELECT
    COUNT(*) AS stage_count,
    SUM(CASE WHEN validation_status = 'ACCEPTED' THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN validation_status = 'REVIEW' THEN 1 ELSE 0 END) AS review_count
FROM staged_sales_output;
```

```sql
-- Stage-clean count difference.
WITH accepted_stage AS (
    SELECT COUNT(*) AS row_count
    FROM staged_sales_output
    WHERE validation_status = 'ACCEPTED'
),
clean_count AS (
    SELECT COUNT(*) AS row_count
    FROM clean_sales_output
)
SELECT
    clean_count.row_count - accepted_stage.row_count AS difference
FROM accepted_stage
CROSS JOIN clean_count;
```

```sql
-- Grouped country amount total.
SELECT
    country_group,
    SUM(order_amount) AS amount_total
FROM clean_sales_output
GROUP BY country_group;
```

### Section D Answers

1. Define source and target populations.
2. Define what one row represents.
3. Align filters.
4. Align date ranges.
5. Use `COUNT(*)` for rows and separate null checks.
6. Add distinct-key and duplicate checks.
7. Add amount totals.
8. Add `MIN` and `MAX`.
9. Add grouped counts or sums.
10. Add group-level evidence.
11. Count nulls separately.
12. Investigate unexplained stage difference.
13. Check validation-status overlap by key.
14. Count by source file.
15. Use target minus source consistently.

### Section E and F Guidance

A strong answer defines populations, grain, filters, measure, expected relationship, expected difference, severity, and evidence. If controls fail with unexplained differences, recommend review before downstream use.
