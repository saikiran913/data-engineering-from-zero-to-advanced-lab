# Data Quality Checks Using Aggregations

Aggregation helps data engineers validate datasets. A single count, total, minimum, maximum, or grouped summary can quickly show whether data looks complete and reasonable.

## Row Count Checks

```sql
SELECT COUNT(*) AS total_rows
FROM orders;
```

Row counts help check whether expected data arrived. If a daily order file usually has around 10,000 rows but today's table has only 20 rows, that may indicate a loading issue.

## Non-Null Checks

`COUNT(column_name)` can show how many rows have values in an important column.

```sql
SELECT COUNT(email) AS customers_with_email
FROM customers;
```

If total rows are much higher than the non-null count, some values may be missing. This is useful for columns such as email, order date, payment status, or country.

## Status Distribution Checks

Grouping by status shows how records are distributed.

```sql
SELECT payment_status, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_status;
```

Unusual status counts can reveal issues. For example, a sudden increase in `Failed` payments may require investigation.

## Date Freshness Checks

`MAX(date_column)` can show the latest date in a dataset.

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

This helps check whether new data arrived. If today's batch should include yesterday's orders but the latest date is older, the pipeline may be delayed.

## Total Amount Checks

`SUM` can check total numeric amounts.

```sql
SELECT SUM(order_amount) AS total_order_amount
FROM orders;
```

Totals can be compared between source and target systems. If the source sales total and target sales total are different, a data engineer investigates the pipeline.

## Min and Max Range Checks

`MIN` and `MAX` show the range of values.

```sql
SELECT
  MIN(order_amount) AS lowest_order_amount,
  MAX(order_amount) AS highest_order_amount
FROM orders;
```

This helps identify unusual values. A very high maximum or a negative minimum may need review, depending on the business rules.

## Group-Level Quality Checks

Grouping by country, channel, or status can reveal missing or unexpected groups.

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country;
```

If a country that normally appears every day suddenly has zero records, there may be a source issue, filter issue, or late file.

## Beginner Data Quality Checklist with Aggregations

- Count total rows.
- Count important non-null columns.
- Check latest date.
- Check total amount.
- Check minimum value.
- Check maximum value.
- Count records by status.
- Count records by country.
- Compare summaries with expected business patterns.
- Document what is normal and what is unusual.
