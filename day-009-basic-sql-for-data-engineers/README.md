# Day 009 - Basic SQL for Data Engineers: Tables, SELECT, WHERE, ORDER BY, and LIMIT

## Learning Goal

By the end of Day 009, you will understand what SQL is, why data engineers use it, what tables, rows, and columns are, and how to read, filter, sort, and preview data using `SELECT`, `FROM`, `WHERE`, `ORDER BY`, and `LIMIT`.

## Connection to Previous Days

- Day 004 introduced databases, warehouses, and tables.
- Day 005 introduced ETL and ELT, where SQL is often used for transformation.
- Day 008 introduced data quality, where SQL is often used to check data.
- Day 009 starts basic SQL for reading and investigating data.

## What is SQL?

SQL stands for Structured Query Language.

SQL is used to communicate with databases and data warehouses. A SQL query is a question or instruction written in SQL.

Data engineers use SQL to:

- Read data
- Filter data
- Clean data
- Transform data
- Validate data
- Investigate issues
- Prepare data for reports
- Support analysts and dashboards

Exact SQL syntax may vary slightly across tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite. The ideas in this lesson are widely used.

## Why SQL is Important for Data Engineers

SQL is one of the most important skills for data engineers.

Examples:

- Checking if yesterday's orders arrived
- Finding duplicate customer records in later lessons
- Filtering failed payments
- Reviewing cancelled orders
- Checking country-wise data
- Previewing tables before transformation
- Validating source and target data

## What is a Table?

A table stores data in rows and columns.

| customer_id | customer_name | country | signup_date |
| --- | --- | --- | --- |
| 101 | Customer A | UK | 2026-01-05 |
| 102 | Customer B | India | 2026-01-12 |

- Each row is one record.
- Each column is one attribute.
- Column names describe the data.
- Tables are stored in databases and warehouses.

## Rows and Columns

A row is one complete record. In a student marks table, one row may describe one student's marks. In a customer table, one row may describe one customer.

A column is one field or attribute. Examples include `customer_id`, `country`, `order_amount`, and `signup_date`.

## Basic SQL Query Structure

```sql
SELECT column_name
FROM table_name;
```

`SELECT` means what columns we want to see.

`FROM` means which table we are reading from.

## SELECT

`SELECT` chooses the columns to return.

```sql
SELECT customer_id, customer_name
FROM customers;
```

```sql
SELECT country
FROM customers;
```

```sql
SELECT *
FROM customers;
```

`SELECT *` means all columns. It is useful for quick learning, but data engineers should be careful with it on very large tables.

## FROM

`FROM` tells SQL where the data comes from.

```sql
SELECT order_id, order_amount
FROM orders;
```

This reads `order_id` and `order_amount` from the `orders` table.

## LIMIT

`LIMIT` previews a small number of rows.

```sql
SELECT *
FROM orders
LIMIT 10;
```

`LIMIT` is common in BigQuery, PostgreSQL, MySQL, and SQLite. Some SQL systems use different syntax.

## WHERE

`WHERE` filters rows.

```sql
SELECT *
FROM customers
WHERE country = 'UK';
```

```sql
SELECT *
FROM orders
WHERE payment_status = 'Failed';
```

```sql
SELECT *
FROM orders
WHERE order_amount > 100;
```

| Operator | Meaning | Example |
| --- | --- | --- |
| `=` | Equals | `country = 'UK'` |
| `!=` | Not equal | `country != 'UK'` |
| `<>` | Not equal | `country <> 'UK'` |
| `>` | Greater than | `order_amount > 100` |
| `<` | Less than | `price < 50` |
| `>=` | Greater than or equal to | `order_date >= '2026-06-01'` |
| `<=` | Less than or equal to | `price <= 100` |

## Filtering Text Values

Text values are usually written inside single quotes.

```sql
SELECT *
FROM customers
WHERE customer_status = 'Active';
```

```sql
SELECT *
FROM orders
WHERE order_status = 'Cancelled';
```

## Filtering Numeric Values

Numbers do not usually need quotes.

```sql
SELECT *
FROM orders
WHERE order_amount > 500;
```

```sql
SELECT *
FROM products
WHERE price <= 100;
```

## Filtering Dates

Dates are often written inside quotes. Date syntax can vary slightly across SQL tools.

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-06-01';
```

```sql
SELECT *
FROM customers
WHERE signup_date < '2026-01-01';
```

## ORDER BY

`ORDER BY` sorts results.

```sql
SELECT *
FROM orders
ORDER BY order_amount DESC;
```

```sql
SELECT *
FROM customers
ORDER BY signup_date ASC;
```

`ASC` means ascending. `DESC` means descending.

## Combining WHERE, ORDER BY, and LIMIT

```sql
SELECT order_id, customer_id, order_amount, order_status
FROM orders
WHERE payment_status = 'Paid'
ORDER BY order_amount DESC
LIMIT 5;
```

This query reads from `orders`, keeps only paid orders, sorts them by largest amount first, and shows only five rows.

## SQL Query Execution Order at a Beginner Level

SQL is written in one order, but logically understood like this:

```text
FROM -> WHERE -> SELECT -> ORDER BY -> LIMIT
```

1. SQL reads the table from `FROM`.
2. It filters rows using `WHERE`.
3. It selects columns using `SELECT`.
4. It sorts using `ORDER BY`.
5. It limits the final output using `LIMIT`.

## Basic Data Engineering Investigation Examples

### Example 1: Preview customer data

```sql
SELECT *
FROM customers
LIMIT 10;
```

This helps a data engineer quickly inspect the customer table.

### Example 2: Find active customers

```sql
SELECT customer_id, customer_name, country
FROM customers
WHERE customer_status = 'Active';
```

This returns only active customers.

### Example 3: Find failed payments

```sql
SELECT order_id, customer_id, order_amount, payment_status
FROM orders
WHERE payment_status = 'Failed';
```

This helps investigate payment issues.

### Example 4: Find high-value orders

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > 500
ORDER BY order_amount DESC;
```

This shows large orders first.

### Example 5: Find cancelled orders

```sql
SELECT order_id, customer_id, order_status
FROM orders
WHERE order_status = 'Cancelled';
```

This helps review cancelled activity.

## SQL and Data Quality

SQL helps check data quality. In future lessons, SQL will help find missing values, duplicate records, invalid statuses, high or negative amounts, and source-to-target mismatches.

For today, focus on reading, filtering, sorting, and previewing data.

## SQL and ETL/ELT

SQL can be used in transformations.

Examples:

- Filter valid rows
- Select needed columns
- Prepare business-ready tables
- Clean values
- Create reporting outputs

## Common Beginner Mistakes

1. Forgetting semicolon
2. Misspelling column names
3. Misspelling table names
4. Forgetting quotes around text values
5. Using quotes around numbers unnecessarily
6. Using `SELECT *` on very large tables
7. Forgetting `WHERE` and reading too much data
8. Confusing rows and columns
9. Sorting without understanding `ASC` and `DESC`
10. Expecting SQL syntax to be exactly identical in every tool

## Role of a Data Engineer

| SQL Task | Data Engineering Use |
| --- | --- |
| Preview table | Understand data before processing |
| Filter records | Focus on relevant rows |
| Investigate failed records | Review failed payments or cancelled orders |
| Check status values | Confirm expected business statuses |
| Find high-value transactions | Review important orders |
| Review date ranges | Check recent or old records |
| Prepare transformation logic | Select columns and filters for pipelines |
| Support dashboard validation | Check data behind reports |
| Investigate data issues | Find suspicious records |
| Document logic | Explain how data is selected |

## Beginner Analogy: Asking Questions to a Spreadsheet

A table is like a spreadsheet. SQL is like asking the spreadsheet questions.

Examples:

- Show me all customers from the UK.
- Show me orders above 500.
- Show me failed payments.
- Show me latest orders.
- Show me only five rows first.

## Key Takeaways

- SQL stands for Structured Query Language.
- SQL is used to communicate with databases and warehouses.
- A table stores data in rows and columns.
- A row is one record.
- A column is one field.
- `SELECT` chooses columns.
- `FROM` chooses the table.
- `WHERE` filters rows.
- `ORDER BY` sorts results.
- `ASC` sorts ascending.
- `DESC` sorts descending.
- `LIMIT` previews a small number of rows.
- SQL helps data engineers investigate data.
- SQL supports ETL, ELT, and data quality work.
- Start simple and build confidence slowly.

## Next Day Preview

Day 010 will explain SQL filtering in more detail using `WHERE`, `AND`, `OR`, `IN`, `BETWEEN`, `LIKE`, and `IS NULL`.

## Navigation

- Previous: [Day 008 - Data Quality Fundamentals](../day-008-data-quality-fundamentals/)
- Next: Day 010 - SQL Filtering with WHERE, AND, OR, IN, BETWEEN, LIKE, and IS NULL - Coming Soon
- [Back to Main Learning Path](../README.md)

