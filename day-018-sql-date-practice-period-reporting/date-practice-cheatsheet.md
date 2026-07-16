# Day 018 SQL Date Practice Cheatsheet

Date syntax varies across SQL platforms. These examples use beginner-friendly patterns.

## Monthly Grouping Pattern

```sql
SELECT
    EXTRACT(YEAR FROM date_column) AS report_year,
    EXTRACT(MONTH FROM date_column) AS report_month,
    COUNT(*) AS total_rows
FROM table_name
GROUP BY
    EXTRACT(YEAR FROM date_column),
    EXTRACT(MONTH FROM date_column)
ORDER BY report_year, report_month;
```

## Monthly Sales Pattern

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY
    EXTRACT(YEAR FROM order_date),
    EXTRACT(MONTH FROM order_date);
```

## One-Month Filter Pattern

```sql
WHERE date_column >= '2026-06-01'
AND date_column < '2026-07-01'
```

## Fixed Period Comparison Pattern

Run one query for period A. Run another query for period B. Compare the outputs manually at beginner level.

## Latest Date Check

```sql
SELECT MAX(date_column) AS latest_date
FROM table_name;
```

## Latest Date by Group

```sql
SELECT group_column, MAX(date_column) AS latest_date
FROM table_name
GROUP BY group_column;
```

## Duplicate Summary Check

```sql
SELECT
    period_column,
    group_column,
    COUNT(*) AS row_count
FROM summary_table
GROUP BY period_column, group_column
HAVING COUNT(*) > 1;
```

## Zero-Activity Check

```sql
WHERE total_orders = 0
```

## Low-Total Check

```sql
WHERE total_sales < example_threshold
```

## High-Issue Check

```sql
WHERE failed_payments > example_threshold
```

## Beginner Best Practices

- group by year and month together
- avoid grouping by month alone
- use clear date columns
- document reporting period logic
- check latest date before trusting reports
- check summary table duplicate rows
- use business context for thresholds
- compare complete periods where possible
- remember date functions vary by platform
- avoid advanced comparisons until basics are clear
