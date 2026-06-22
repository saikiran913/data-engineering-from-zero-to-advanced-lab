# Day 009 Notes - Basic SQL for Data Engineers

## What SQL Is

SQL stands for Structured Query Language. It is used to communicate with databases and data warehouses.

A SQL query is an instruction that asks a database for data.

## Why SQL Matters in Data Engineering

Data engineers use SQL to read data, investigate issues, validate tables, prepare transformations, and support reporting teams.

SQL is important because many business datasets are stored in tables.

## Table

A table stores data in rows and columns. Examples include `customers`, `orders`, and `products`.

## Row, Record, Column, and Field

A row is one complete record.

A record is one item of data, such as one customer or one order.

A column is one attribute, such as `country` or `order_amount`.

A field is another word often used for a column or a value in a record.

## SELECT

`SELECT` chooses which columns to return.

```sql
SELECT customer_id, customer_name
FROM customers;
```

## FROM

`FROM` tells SQL which table to read.

```sql
SELECT order_id
FROM orders;
```

## SELECT *

`SELECT *` returns all columns.

It is useful for quick previewing, but use it carefully on large tables.

## LIMIT

`LIMIT` restricts the number of rows returned.

```sql
SELECT *
FROM orders
LIMIT 10;
```

This is helpful for safe previews.

## WHERE

`WHERE` filters rows.

```sql
SELECT *
FROM orders
WHERE payment_status = 'Failed';
```

## Comparison Operators

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equals | `country = 'UK'` |
| `!=` | Not equal | `country != 'UK'` |
| `<>` | Not equal | `country <> 'UK'` |
| `>` | Greater than | `order_amount > 100` |
| `<` | Less than | `price < 50` |
| `>=` | Greater than or equal to | `order_date >= '2026-06-01'` |
| `<=` | Less than or equal to | `price <= 100` |

## Filtering Text

Text values are usually written inside single quotes.

```sql
SELECT *
FROM customers
WHERE customer_status = 'Active';
```

## Filtering Numbers

Numbers do not usually need quotes.

```sql
SELECT *
FROM orders
WHERE order_amount > 500;
```

## Filtering Dates

Dates are commonly written inside quotes.

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01';
```

Date syntax may vary slightly by SQL tool.

## ORDER BY

`ORDER BY` sorts results.

```sql
SELECT *
FROM orders
ORDER BY order_amount DESC;
```

## ASC and DESC

`ASC` means ascending, such as smallest to largest or oldest to newest.

`DESC` means descending, such as largest to smallest or newest to oldest.

## Combining Clauses

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE payment_status = 'Paid'
ORDER BY order_amount DESC
LIMIT 5;
```

This reads orders, filters paid records, sorts by amount, and returns five rows.

## Beginner SQL Execution Order

Think of SQL as:

```text
FROM -> WHERE -> SELECT -> ORDER BY -> LIMIT
```

This helps beginners understand how the query result is built.

## SQL in ETL and ELT

SQL can help filter valid rows, select useful columns, prepare business-ready tables, and support transformations.

## SQL in Data Quality Checks

SQL can help investigate missing values, invalid statuses, unusual amounts, and source-to-target issues. More detailed checks will come in later SQL lessons.

## Common Beginner Mistakes

- Misspelling `SELECT`
- Missing `FROM`
- Forgetting quotes around text
- Using the wrong table name
- Using the wrong column name
- Writing clauses in the wrong order
- Forgetting commas between selected columns
- Using `SELECT *` too often

## How Data Engineers Use SQL Daily

Data engineers use SQL to preview tables, filter records, investigate failed records, check statuses, review date ranges, and support dashboard validation.

