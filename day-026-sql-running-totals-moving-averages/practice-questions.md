# Practice Questions

## Section A: Concept Checks

1. What is a running total?
2. What is a cumulative count?
3. What is a cumulative average?
4. What is a moving sum?
5. What is a moving average?
6. What does a window frame define?
7. What does `ROWS` mean?
8. What does `UNBOUNDED PRECEDING` mean?
9. What does `CURRENT ROW` mean?
10. What does `PARTITION BY` do?
11. Why is ordering important?
12. Why do early moving-window rows have smaller frames?
13. Why can missing dates mislead row-based windows?
14. Why can duplicate dates double-count?
15. Why should final cumulative totals be reconciled?
16. How are null and zero different?
17. When should `GROUP BY` be used instead?
18. Why does a moving average not explain cause?

## Section B: Predict the Output

For values `10, 20, 30`, the running total is `10, 30, 60`.

Predict running total, cumulative count, cumulative average, two-row moving sum, and three-row moving average for:

1. `5, 10, 15`
2. `100, 0, 50`
3. `20, NULL, 40`
4. Partition A `1, 2`; Partition B `10, 20`
5. `3, 3, 3, 3`
6. `50, 25, 25`
7. `100, -10, 20`
8. One-row partition `9`
9. `10, 20, 30, 40`
10. `0, 0, 100`

## Section C: Complete the SQL

1. Region running sales.
2. Customer cumulative spend.
3. Cumulative pipeline loads.
4. Cumulative rejection count.
5. Three-row sales moving average.
6. Three-row campaign moving sum.
7. Moving duration average.
8. Cumulative maximum.
9. Cumulative minimum.
10. Frame row count.
11. Final-total reconciliation.
12. Duplicate-date review.

## Section D: Choose the Metric

Choose `GROUP BY`, running total, cumulative count, cumulative average, moving sum, moving average, `LAG`, or `LEAD`:

1. One row per region total.
2. Sales total so far by region.
3. Number of loads so far.
4. Average duration so far.
5. Average of recent three rows.
6. Previous day's sales.
7. Next payment status.
8. Recent three-row conversion sum.
9. Final total by customer.
10. Highest value so far.

## Section E: Fix the Mistake

1. Missing `ORDER BY`.
2. Missing `PARTITION BY`.
3. Using default frame without understanding it.
4. Confusing three rows with three days.
5. Ignoring duplicate dates.
6. Ignoring missing dates.
7. Wrong grain.
8. Running total before deduplication.
9. Nulls replaced with zero blindly.
10. Zero treated as missing.
11. Not reconciling final totals.
12. Moving average used as proof of cause.

## Section F: Design the Workflow

For each scenario, define grain, partition, ordering, measure, frame, null policy, missing-date policy, and validation checks:

1. Running sales by region.
2. Cumulative customer spending.
3. Cumulative pipeline records.
4. Three-row sales moving average.
5. Moving campaign spend.
6. Moving load duration.
7. Cumulative inventory sold.
8. Duplicate-date review.

## Answer Key

Section A: running totals and cumulative metrics use a frame from the start through the current row. Moving metrics use a limited recent frame. `PARTITION BY` restarts calculations, and explicit `ROWS` frames make the calculation clearer.

Section B: for `5, 10, 15`, running total is `5, 15, 30`; cumulative count is `1, 2, 3`; cumulative average is `5, 7.5, 10`; two-row moving sum is `5, 15, 25`; three-row moving average is `5, 7.5, 10`.

Section C sample:

```sql
SELECT
    sale_date,
    region,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date, loaded_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM daily_sales_metrics;
```

Section D: use `GROUP BY` for one summary row per group, running totals for total so far, moving averages for recent-row smoothing, and `LAG`/`LEAD` for previous or next row comparisons.

Section E: fix mistakes by adding partition/order columns, using explicit frames, checking grain, reviewing nulls and zeroes separately, validating missing and duplicate dates, and reconciling final cumulative values.
