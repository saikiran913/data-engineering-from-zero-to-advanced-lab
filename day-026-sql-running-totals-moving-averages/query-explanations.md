# Query Explanations

## Running Totals

Business question: what is the total so far? Use `SUM(...) OVER` with `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`.

## Cumulative Counts, Averages, Minimums, and Maximums

Use `COUNT`, `AVG`, `MIN`, or `MAX` with the same cumulative frame. The first row usually reflects only the first row's value.

## Moving Sums and Moving Averages

Use a limited frame such as `ROWS BETWEEN 2 PRECEDING AND CURRENT ROW`. Early rows have fewer available rows.

## Partitioned and Global Calculations

Partitioned calculations restart by group. Global calculations have no `PARTITION BY`.

## Line-by-Line Example

```sql
WITH sales_metrics AS (
    SELECT
        sale_date,
        region,
        total_sales,
        SUM(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_sales,
        AVG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date, loaded_at
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_row_moving_average
    FROM daily_sales_metrics
)
SELECT *
FROM sales_metrics;
```

The CTE keeps source rows visible. The first window calculates sales so far by region. The second calculates an average over the current row and up to two previous rows. Validation should compare final running totals to grouped totals.

| Metric | Frame Start | Frame End | Main Purpose |
| --- | --- | --- | --- |
| Running total | Unbounded preceding | Current row | Total so far |
| Cumulative count | Unbounded preceding | Current row | Count so far |
| Moving sum | N preceding | Current row | Recent row total |
| Moving average | N preceding | Current row | Recent row average |
