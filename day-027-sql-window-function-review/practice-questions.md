# Practice Questions

## Section A: Function Recognition

Choose `GROUP BY`, `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, `LEAD`, running total, cumulative count, or moving average.

1. Exactly one highest-spend customer per country.
2. All products tied for highest sales in each category.
3. Dense performance levels for pipelines by issue count.
4. Previous conversions for each campaign.
5. Next known customer status.
6. Total regional sales so far by date.
7. Count of customer activity rows so far.
8. Three-row average campaign spend.
9. One total rejected-record value per pipeline.
10. First activity row per customer.
11. Last known stock value comparison with previous stock.
12. Top three ranks by category, keeping ties.
13. Current row compared with the next sale date.
14. Running maximum customer spend.
15. Average spend for current and previous two rows.

## Section B: Predict the Output

1. Two products have sales of 100. With `RANK`, what rank do they share?
2. If two rows share rank 1 with `RANK`, what rank can the next row receive?
3. If two rows share rank 1 with `DENSE_RANK`, what rank can the next row receive?
4. What does `LAG` return for the first row in a partition?
5. What does `LEAD` return for the last row in a partition?
6. A running total has values 10, 20, 30. What is the final running total?
7. A three-row moving sum sees rows 5 and 10 on the second row. What rows are included?
8. A partition changes from India to UK. Does a running total continue or restart?
9. If `ORDER BY metric_date` has duplicate dates, what risk appears?
10. If a cumulative frame uses current and earlier rows, does it include future rows?
11. If a metric is null, should the row be reviewed?
12. If a query filters source rows before `LAG`, can previous values change?

## Section C: Complete the SQL

1. Rank customers by `total_spend` within `country`.
2. Keep all tied top products within `category`.
3. Compare campaign conversions with the previous metric date.
4. Show next customer status.
5. Calculate running sales by region.
6. Calculate cumulative record count by pipeline.
7. Calculate three-row moving product sales sum.
8. Calculate three-row moving campaign spend average.
9. Aggregate product sales before ranking categories.
10. Create a review queue for null spend.
11. Reconcile final cumulative rejected records.
12. Count rows in a moving frame.
13. Identify first campaign row.
14. Identify last customer activity row.
15. Combine review issues with `UNION ALL`.

## Section D: Debug the SQL

1. `ROW_NUMBER` is used when tied top rows must remain.
2. `RANK` is used when exactly one row is required.
3. A running total has no explicit frame.
4. `LAG` is ordered by campaign id instead of metric date.
5. A window alias is filtered in the same query level.
6. Product rows are ranked before totals are aggregated.
7. Duplicate ordering dates have no tie-breaker.
8. Boundary nulls are flagged as source errors.
9. A moving average is called a three-day average.
10. A partition is missing for customer-level running spend.
11. Final cumulative totals are not reconciled.
12. A query combines many calculations without validation.

## Section E: Design the Workflow

For each question, write the source grain, output grain, partition, ordering, function, tie or boundary policy, frame, and validation.

1. Which customer ranks first in each country?
2. Which products share top sales rank in each category?
3. How did campaign conversions change from the previous date?
4. What is the next known customer status?
5. What is cumulative regional sales?
6. What is a three-row moving campaign spend average?
7. Which pipeline has highest issue count each day?
8. Which final cumulative totals fail reconciliation?
9. Which regional sales rows have duplicate ordering dates?
10. Which question needs only `GROUP BY`?

## Section F: Mini-Case Study

Build a read-only monitoring design for campaign performance:

1. Rank campaigns within channel and country by conversions.
2. Compare each campaign with previous conversions.
3. Create running campaign spend.
4. Create a three-row moving spend average.
5. Build review flags for null spend and large conversion changes.
6. Validate source counts, first rows, duplicate dates, and final running spend.

## Answer Key

### Section A

1. `ROW_NUMBER`
2. `RANK`
3. `DENSE_RANK`
4. `LAG`
5. `LEAD`
6. Running total
7. Cumulative count
8. Moving average
9. `GROUP BY`
10. `ROW_NUMBER`
11. `LAG`
12. `RANK`
13. `LEAD`
14. Cumulative maximum
15. Moving average

### Section B

1. They share the same rank.
2. The next rank can skip to 3.
3. The next rank is 2.
4. Usually `NULL`.
5. Usually `NULL`.
6. 60.
7. The current row and one previous row are included because only two rows exist so far.
8. It restarts.
9. The row sequence may be unclear.
10. No.
11. Yes, if the metric is important to the result.
12. Yes.

### Section C: Example Answers

```sql
-- 1. Rank customers by total spend within country.
SELECT
    country,
    customer_id,
    total_spend,
    ROW_NUMBER() OVER (
        PARTITION BY country
        ORDER BY total_spend DESC, customer_id
    ) AS spend_row_number
FROM customer_activity_metrics;
```

```sql
-- 5. Running sales by region.
SELECT
    region,
    sale_date,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM regional_sales_history;
```

```sql
-- 15. Combine review issues.
SELECT
    'campaign' AS dataset_name,
    campaign_id AS entity_key,
    metric_date AS metric_date,
    'NULL_SPEND' AS issue_type
FROM campaign_metrics_history
WHERE spend IS NULL

UNION ALL

SELECT
    'regional_sales' AS dataset_name,
    region AS entity_key,
    sale_date AS metric_date,
    'NULL_SALES' AS issue_type
FROM regional_sales_history
WHERE total_sales IS NULL;
```

### Section D

1. Use `RANK` if tied top rows must remain.
2. Use `ROW_NUMBER` with a documented tie-breaker if exactly one row is required.
3. Add an explicit `ROWS` frame.
4. Order by the business sequence, usually date.
5. Filter the alias in an outer CTE step.
6. Aggregate first, then rank.
7. Add a tie-breaker such as `loaded_at`.
8. Treat expected boundary nulls separately from source nulls.
9. Call it a three-row average unless the frame truly covers calendar days.
10. Add the correct partition.
11. Compare final running values with source totals.
12. Validate each calculated column separately.
