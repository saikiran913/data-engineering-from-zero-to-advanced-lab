# Day 011 Notes - SQL Aggregations

## What Aggregation Means

Aggregation means summarising many rows into one or more useful numbers. Instead of reading every order, customer, product, or campaign row manually, SQL can calculate totals, counts, averages, lowest values, and highest values.

Aggregations help answer questions like:

- How many rows are in this table?
- How much sales did we make?
- What is the average order amount?
- What is the earliest or latest date?
- How many records exist for each status?

## Why Aggregation Matters

Data engineers work with large datasets. Business teams usually need summary answers rather than every raw row. Aggregations help turn raw data into metrics used by dashboards, reports, validation checks, and monitoring processes.

## COUNT

`COUNT` counts rows or values.

```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

`COUNT(*)` counts every row returned by the query.

```sql
SELECT COUNT(email) AS customers_with_email
FROM customers;
```

`COUNT(column_name)` counts only rows where that column has a non-null value.

## SUM

`SUM` adds numeric values.

```sql
SELECT SUM(order_amount) AS total_sales
FROM orders;
```

Use `SUM` for values such as sales, costs, revenue, impressions, clicks, conversions, and budgets.

## AVG

`AVG` calculates the average value.

```sql
SELECT AVG(order_amount) AS average_order_amount
FROM orders;
```

Average means total divided by count. Use it only when an average makes business sense.

## MIN

`MIN` finds the smallest value.

```sql
SELECT MIN(price) AS lowest_product_price
FROM products;
```

It can also find the earliest date.

## MAX

`MAX` finds the largest value.

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

It can also find the latest date, which is useful for data freshness checks.

## Aliases for Aggregation Columns

Aliases make output columns readable.

```sql
SELECT COUNT(*) AS total_customers
FROM customers;
```

Without the alias, the output column may have a tool-specific expression name. Clear aliases help reporting teams understand results.

## GROUP BY

`GROUP BY` creates one summary per unique group value.

```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country;
```

This returns one row per country. Each row contains the country and the number of orders in that country.

## Grouping by One Column

Beginner aggregation usually starts with one grouping column:

- `country` for regional summaries.
- `order_status` or `payment_status` for operational summaries.
- `category` for product summaries.
- `channel` for marketing summaries.
- `order_date` or `performance_date` for daily summaries.

## WHERE with GROUP BY

`WHERE` filters rows before aggregation.

```sql
SELECT country, SUM(order_amount) AS paid_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY country;
```

This means SQL first keeps only paid orders, then groups those rows by country, then adds the order amounts within each country.

## ORDER BY with Aggregation

`ORDER BY` sorts the final summary result.

```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
ORDER BY total_sales DESC;
```

This helps show the largest totals first.

## Beginner Logical Order

Think through aggregation queries in this order:

1. `FROM` - choose the table.
2. `WHERE` - filter input rows.
3. `GROUP BY` - create groups.
4. `SELECT` - display group columns and summary metrics.
5. `ORDER BY` - sort the final result.
6. `LIMIT` - return only a small number of rows if needed.

## Aggregation in Dashboards

Dashboards rarely show every raw record. They usually show metrics such as total sales, average order value, orders by status, revenue by channel, and active customers by country. These are aggregation results.

## Aggregation in ETL/ELT

An ETL/ELT process may transform detailed rows into summary tables. For example, a pipeline may create daily sales, product category summaries, or campaign performance summaries.

## Aggregation in Data Quality Checks

Day 008 introduced data quality. Aggregations help validate:

- Total row counts.
- Counts by status.
- Latest available dates.
- Total sales or revenue.
- Minimum and maximum values.
- Source-to-target totals.

## Common Mistakes

- Using `SELECT *` with `GROUP BY`.
- Selecting a column that is not grouped or aggregated.
- Confusing `COUNT(*)` with `COUNT(column_name)`.
- Forgetting that `WHERE` runs before `GROUP BY`.
- Trying to average text fields.
- Forgetting aliases.
- Assuming cancelled or refunded orders should always be included.
- Expecting grouped results to show every original row.

## Daily Data Engineering Use

A data engineer may use aggregations to check if a pipeline loaded the right number of rows, compare source and target totals, prepare dashboard metrics, monitor daily trends, and investigate unexpected changes in business numbers.
