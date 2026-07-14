# Day 017 SQL Date Cheatsheet

SQL date syntax varies by platform. These patterns are beginner-friendly starting points.

## Filter One Date

```sql
SELECT *
FROM table_name
WHERE date_column = '2026-06-15';
```

## Filter Date Range with BETWEEN

```sql
WHERE date_column BETWEEN '2026-06-01' AND '2026-06-30';
```

`BETWEEN` usually includes both boundary dates.

## Filter Date Range with >= and <

```sql
WHERE date_column >= '2026-06-01'
AND date_column < '2026-07-01';
```

This is useful because the end boundary is clear and avoids accidentally including the next period.

## Sort by Date

```sql
ORDER BY date_column ASC
```

```sql
ORDER BY date_column DESC
```

## Latest Date

```sql
SELECT MAX(date_column) AS latest_date
FROM table_name;
```

## Earliest Date

```sql
SELECT MIN(date_column) AS earliest_date
FROM table_name;
```

## Daily Summary

```sql
SELECT
    date_column,
    COUNT(*) AS total_rows
FROM table_name
GROUP BY date_column
ORDER BY date_column;
```

## Daily Sales Summary

```sql
SELECT
    order_date,
    COUNT(*) AS total_orders,
    SUM(order_amount) AS total_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

## Date Parts

```sql
EXTRACT(YEAR FROM date_column)
EXTRACT(MONTH FROM date_column)
EXTRACT(DAY FROM date_column)
```

Syntax varies by platform.

## Freshness Check

```sql
SELECT MAX(date_column) AS latest_available_date
FROM table_name;
```

## Beginner Best Practices

- understand what each date column means
- choose the correct reporting date
- check latest available date
- check missing dates
- check future dates
- use `>=` and `<` for clean ranges
- be careful with timestamps
- group by date, not timestamp, for daily summaries
- document date logic
- remember date functions vary by SQL platform
