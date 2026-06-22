# Day 009 Beginner Summary

SQL stands for Structured Query Language. It is a language used to communicate with databases and data warehouses. Data engineers use SQL because much of the business data they work with is stored in tables. SQL helps them read data, filter records, sort results, investigate issues, validate data, and support reports and dashboards.

A table stores data in rows and columns. A row is one complete record, such as one customer, one order, or one product. A column is one field or attribute, such as `customer_id`, `country`, `order_amount`, or `signup_date`. Understanding tables, rows, and columns is the foundation for learning SQL.

The first SQL keyword from this lesson is `SELECT`. `SELECT` tells SQL which columns you want to see. For example, you can select `customer_id` and `customer_name` from a customer table. You can also use `SELECT *` to return all columns. This is useful for quick previewing, but it should be used carefully on large tables because it may read more data than needed.

The second keyword is `FROM`. `FROM` tells SQL which table to read from. For example, `FROM customers` means the query reads data from the customers table. A basic SQL query usually starts with `SELECT` and `FROM`.

The `WHERE` clause filters rows. It helps you ask more specific questions, such as "show customers from the UK" or "show orders where payment status is Failed." Text values are usually written inside single quotes, such as `'Active'` or `'Cancelled'`. Numeric values usually do not need quotes, such as `order_amount > 500`.

The `ORDER BY` clause sorts results. `ASC` means ascending, such as smallest to largest or oldest to newest. `DESC` means descending, such as largest to smallest or newest to oldest. Sorting is useful when reviewing high-value orders, newest customers, or cheapest products.

The `LIMIT` clause returns only a small number of rows. This is very helpful when previewing data. Data engineers often use `LIMIT` before exploring a new table so they do not accidentally return too much data.

These clauses can work together. A query can select specific columns, read from a table, filter rows with `WHERE`, sort results with `ORDER BY`, and preview only a few rows with `LIMIT`.

SQL supports data investigation. For example, a data engineer can find failed payments, review cancelled orders, look at high-value orders, check active customers, and preview tables before building transformations. SQL also connects to ETL and ELT because it can be used to filter valid rows and prepare business-ready data. It connects to data quality because SQL can help investigate missing values, unexpected statuses, unusual amounts, and source-to-target issues in future lessons.

In daily work, data engineers often begin with simple SQL before doing anything complex. They may preview a source table, check the available columns, filter a few rows, sort recent records, and confirm that the data looks reasonable. This careful first step helps avoid wrong assumptions. For example, before building a pipeline from an orders table, a data engineer may first look at order statuses, payment statuses, order dates, and order amounts.

The sample tables in this lesson are intentionally simple. The `customers` table stores customer details, the `orders` table stores order activity, and the `products` table stores product information. Today you are not joining these tables together yet. The goal is to become comfortable reading one table at a time. Once this feels natural, later lessons will add more filtering, combining data, summaries, and quality checks.

Before Day 010, remember this: SQL is not something to rush. Start by reading tables safely. Learn how to select columns, filter rows, sort results, and limit output. These small skills become the base for more powerful data engineering work later.
