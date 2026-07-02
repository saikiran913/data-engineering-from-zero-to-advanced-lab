# Day 012 Notes - GROUP BY, HAVING, and Summary Checks

## Quick GROUP BY Review

`GROUP BY` creates one summary row for each unique value, or each unique combination of values. For example, grouping orders by `country` creates one row per country. Grouping by `order_date` and `country` creates one row for each date and country combination.

## What HAVING Means

`HAVING` filters grouped results after aggregation. It is usually used after `GROUP BY` when the filter depends on an aggregated value such as `COUNT(*)`, `SUM(order_amount)`, `AVG(price)`, `MIN(order_amount)`, or `MAX(order_amount)`.

## Why HAVING Exists

`WHERE` can filter source rows, but it cannot filter a grouped total such as "countries where total sales are above 1000" because that total does not exist until after grouping. `HAVING` solves this problem.

## WHERE vs HAVING

- `WHERE` is a row-level filter.
- `HAVING` is a group-level filter.
- `WHERE` happens before `GROUP BY`.
- `HAVING` happens after `GROUP BY`.

Example: use `WHERE payment_status = 'Paid'` to keep only paid rows before calculating sales. Use `HAVING SUM(order_amount) > 1000` to keep only groups whose total sales are above 1000.

## SQL Logical Order

Beginner logical order:

1. `FROM`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `ORDER BY`
7. `LIMIT`

## HAVING with COUNT

Use `HAVING COUNT(*) > number` to keep groups above a row-count threshold. This can find countries with many orders, statuses with many records, or IDs that appear more than once.

## HAVING with SUM

Use `HAVING SUM(numeric_column) > number` or `HAVING SUM(numeric_column) < number` to keep groups based on totals. This helps find high revenue channels or low sales days.

## HAVING with AVG

Use `HAVING AVG(numeric_column) > number` to keep groups based on averages. This can find countries where average order value is high or categories where average product price is high.

## HAVING with MIN and MAX

`HAVING MIN(column_name)` and `HAVING MAX(column_name)` filter groups by smallest or largest values. `MAX(date_column)` can support freshness thinking, while minimum and maximum amounts can reveal unusual ranges.

## GROUP BY with Multiple Columns

Multiple grouping columns create summaries for combinations:

```sql
SELECT order_date, country, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date, country
HAVING COUNT(*) > 2;
```

## WHERE + GROUP BY + HAVING

These clauses often work together. `WHERE` keeps the relevant input rows, `GROUP BY` summarises them, and `HAVING` keeps only summary groups that cross a threshold.

## ORDER BY and LIMIT

After `HAVING`, use `ORDER BY` to sort the final grouped results. Use `LIMIT` to show only a small number of rows.

## Duplicate Checks

Duplicate-style checks usually group by an identifier and keep counts above 1:

```sql
SELECT order_id, COUNT(*) AS record_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Repeated values are not automatically wrong. A data engineer must confirm the business rule.

## Repeated Email Checks

Repeated email checks should remove missing email values first:

```sql
SELECT email, COUNT(*) AS email_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

## Status Distribution Checks

Grouping by `order_status`, `payment_status`, `customer_status`, or `campaign_status` helps show whether a status appears unusually often.

## Daily Summary Checks

Daily summary checks help validate batch output. Examples include zero-order groups, high failed payments, high cancelled orders, or low total sales.

## Technical and Business Summary Checks

Technical checks ask whether data arrived and loaded correctly. Business checks ask whether numbers look reasonable. Both are important.

## Common Mistakes

- Using `WHERE COUNT(*) > 1`.
- Forgetting `GROUP BY`.
- Using `HAVING` for simple row filters.
- Selecting columns not included in `GROUP BY`.
- Using `SELECT *` in grouped queries.
- Setting thresholds without business context.

## How Data Engineers Use HAVING

Data engineers use `HAVING` to investigate duplicate keys, repeated values, high or low metrics, suspicious statuses, zero-activity groups, dashboard drops, and pipeline validation results.
