# Day 012 SQL HAVING Cheatsheet

## Basic GROUP BY

```sql
SELECT group_column, COUNT(*) AS total_rows
FROM table_name
GROUP BY group_column;
```

## Basic HAVING

```sql
SELECT group_column, COUNT(*) AS total_rows
FROM table_name
GROUP BY group_column
HAVING COUNT(*) > 5;
```

## WHERE vs HAVING

| Use | WHERE | HAVING |
| --- | --- | --- |
| Filter type | Row-level filter | Group-level filter |
| Timing | Before aggregation | After aggregation |
| Example | Keep only paid rows | Keep countries above 1000 sales |

## HAVING with COUNT

```sql
HAVING COUNT(*) > number
```

## HAVING with SUM

```sql
HAVING SUM(numeric_column) > number
```

## HAVING with AVG

```sql
HAVING AVG(numeric_column) > number
```

## HAVING with MIN

```sql
HAVING MIN(numeric_column) < number
```

## HAVING with MAX

```sql
HAVING MAX(numeric_column) > number
```

## Duplicate Check Pattern

```sql
SELECT id_column, COUNT(*) AS record_count
FROM table_name
GROUP BY id_column
HAVING COUNT(*) > 1;
```

## Repeated Email Check Pattern

```sql
SELECT email, COUNT(*) AS email_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

## Multiple Grouping Columns

```sql
SELECT date_column, country, COUNT(*) AS total_rows
FROM table_name
GROUP BY date_column, country
HAVING COUNT(*) > 1;
```

## Common Data Quality HAVING Patterns

| Question | Pattern |
| --- | --- |
| Which IDs appear more than once? | `GROUP BY id_column HAVING COUNT(*) > 1` |
| Which dates have zero orders? | `GROUP BY date, country HAVING SUM(total_orders) = 0` |
| Which countries have unusually high failed payments? | `GROUP BY country HAVING SUM(failed_payments) > threshold` |
| Which channels have high cost? | `GROUP BY channel HAVING SUM(cost) > threshold` |
| Which groups have low sales? | `GROUP BY group_column HAVING SUM(total_sales) < threshold` |
| Which categories have too many inactive records? | Filter inactive rows, then group category and use `HAVING COUNT(*) > threshold` |

## Beginner Best Practices

- Use `WHERE` for row-level filters.
- Use `HAVING` for group-level filters.
- Do not use `SELECT *` with `GROUP BY`.
- Give clear aliases.
- Use business context for thresholds.
- Test grouped query before adding `HAVING`.
- Use `ORDER BY` to make summaries easier to read.
- Check whether duplicate-looking values are truly errors.
- Document summary validation rules.
