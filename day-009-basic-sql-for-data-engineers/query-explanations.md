# Day 009 Query Explanations

## Previewing Data

Purpose: quickly inspect a table.

Example pattern:

```sql
SELECT *
FROM customers
LIMIT 10;
```

It reads from `customers`, returns all columns, and shows only a small number of rows. A data engineer uses this before writing transformations or checks.

## Selecting Specific Columns

Purpose: return only columns needed for the task.

Example:

```sql
SELECT customer_id, customer_name, country
FROM customers;
```

This reads from `customers` and returns only customer ID, name, and country. This is better than selecting every column when only a few are needed.

## Filtering by Text

Purpose: find rows where a text column matches a value.

Examples include customers from `UK`, active customers, failed payments, and cancelled orders.

Text values are usually written in single quotes, such as `'Active'`.

## Filtering by Numbers

Purpose: find rows based on numeric values.

Example:

```sql
SELECT *
FROM orders
WHERE order_amount > 500;
```

This reads from `orders`, returns orders where amount is greater than 500, and helps review high-value orders.

## Filtering by Dates

Purpose: find rows inside a date range or after a date.

Example:

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01';
```

Date syntax can vary slightly across SQL tools.

## Sorting Results

Purpose: arrange rows in a useful order.

`ORDER BY order_amount DESC` shows largest orders first.

`ORDER BY signup_date ASC` shows oldest signups first.

## Limiting Results

Purpose: preview safely.

`LIMIT 10` returns only ten rows. This is helpful when a table may be large.

## Combining Multiple Clauses

Purpose: answer more specific questions.

Example:

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE payment_status = 'Paid'
ORDER BY order_amount DESC
LIMIT 5;
```

This reads orders, keeps paid records, sorts by amount, and returns the top five rows.

## How Data Engineers Use These Queries

Data engineers use basic SQL to inspect tables, investigate records, review failed payments, check status values, understand date ranges, and prepare logic for ETL or ELT pipelines.

