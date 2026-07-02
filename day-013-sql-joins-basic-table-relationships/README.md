# Day 013 - SQL JOINs for Data Engineers: INNER JOIN, LEFT JOIN, and Basic Table Relationships

## Learning Goal

By the end of Day 013, you should understand why data is stored in multiple related tables, what primary keys and foreign keys mean, how basic table relationships work, and how `INNER JOIN` and `LEFT JOIN` combine related data. You will also learn how joins help data engineers find missing relationships, enrich raw data, and prepare business-ready datasets.

SQL syntax may vary slightly across tools such as BigQuery, PostgreSQL, SQL Server, MySQL, and SQLite. The examples here use simple ANSI-style SQL.

## Connection to Previous SQL Lessons

- Day 009 introduced reading data from one table.
- Day 010 introduced filtering rows.
- Day 011 introduced aggregations.
- Day 012 introduced `HAVING` and summary checks.
- Day 013 now explains how to combine related tables using SQL JOINs.

## Why Data Is Stored in Multiple Tables

Companies usually do not store everything in one huge table. They split data into tables that represent different business entities.

| Table | Stores |
| --- | --- |
| `customers` | Customer details |
| `orders` | Order details |
| `products` | Product details |
| `order_items` | Products inside each order |

This avoids repeating the same information many times, keeps data organized, makes updates easier, separates different business entities, supports cleaner data modeling, and helps maintain data quality.

## What is a Table Relationship?

A table relationship means rows in one table are connected to rows in another table using common values. For example, `customers.customer_id` connects to `orders.customer_id`. One customer can have many orders.

## Primary Key

A primary key is a column that uniquely identifies each row in a table. Primary keys should usually be unique and not null.

| Table | Primary Key | Meaning |
| --- | --- | --- |
| `customers` | `customer_id` | One unique customer |
| `orders` | `order_id` | One unique order |
| `products` | `product_id` | One unique product |
| `order_items` | `order_item_id` | One unique order item row |
| `campaigns` | `campaign_id` | One unique campaign |

## Foreign Key

A foreign key is a column in one table that points to a primary key in another table.

| Child Table | Foreign Key | Parent Table | Parent Key |
| --- | --- | --- | --- |
| `orders` | `customer_id` | `customers` | `customer_id` |
| `order_items` | `order_id` | `orders` | `order_id` |
| `order_items` | `product_id` | `products` | `product_id` |
| `campaign_performance` | `campaign_id` | `campaigns` | `campaign_id` |

## Parent Table and Child Table

The parent table stores the main entity. The child table stores related details. `customers` is a parent table and `orders` is a child table because one customer can have many orders.

## One-to-Many Relationship

One-to-many means one row in a parent table can connect to many rows in a child table.

```text
customers
customer_id = C001
  |
  v
orders
order_id = O1001
order_id = O1002
order_id = O1003
```

Another example: one order can have many order items.

## One-to-One Relationship

One-to-one means one row connects to one related row. For example, one employee may have one employee profile. Day 013 mainly focuses on one-to-many relationships because they are very common in data engineering.

## Many-to-Many Relationship

Many-to-many means rows on both sides can connect to many rows on the other side. One order can contain many products, and one product can appear in many orders. `order_items` acts as a bridge table between `orders` and `products`.

## What is a SQL JOIN?

A `JOIN` combines rows from two tables based on a related column. For example, joining `customers` and `orders` using `customer_id` lets you see order details together with customer details.

## Basic JOIN Structure

```sql
SELECT
  table1.column_name,
  table2.column_name
FROM table1
INNER JOIN table2
ON table1.common_column = table2.common_column;
```

`FROM` starts with the first table, `JOIN` adds another table, and `ON` explains how the tables are connected. The `table.column` format avoids confusion when both tables have columns with the same name.

## Why Use Table Aliases?

Aliases make queries shorter and easier to read.

```sql
SELECT
  c.customer_id,
  c.customer_name,
  o.order_id,
  o.order_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

Here, `c` means `customers` and `o` means `orders`.

## INNER JOIN

`INNER JOIN` returns only matching rows from both tables. If a customer has orders, the customer appears with those orders. If a customer has no orders, that customer does not appear in the `INNER JOIN` result.

```sql
SELECT
  c.customer_id,
  c.customer_name,
  o.order_id,
  o.order_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

SQL reads customer rows, reads order rows, checks where customer IDs match, and returns only matching pairs.

## INNER JOIN Diagram

```text
customers table        orders table
customer_id = C001  <-> customer_id = C001
customer_id = C002  <-> customer_id = C002
customer_id = C999      no match

INNER JOIN keeps only matching rows.
```

## LEFT JOIN

`LEFT JOIN` returns all rows from the left table and matching rows from the right table. If there is no match, right table columns return as `NULL`.

```sql
SELECT
  c.customer_id,
  c.customer_name,
  o.order_id,
  o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;
```

A customer with no orders still appears because `customers` is the left table.

## LEFT JOIN Diagram

```text
Left table: customers
Right table: orders

Customer with matching order -> order details appear
Customer without matching order -> order columns show NULL
```

`LEFT JOIN` is very useful for data quality investigations.

## INNER JOIN vs LEFT JOIN

| Feature | INNER JOIN | LEFT JOIN |
| --- | --- | --- |
| Returns matching rows | Yes | Yes |
| Keeps unmatched left table rows | No | Yes |
| Shows NULLs for missing matches | No | Yes |
| Useful for business-ready matched data | Yes | Yes |
| Useful for finding missing relationships | Less useful | Very useful |
| Example question | Which customers placed orders? | Which customers have no orders? |

## Example 1: Customers with Orders

Business question: Which customers placed orders?

```sql
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

## Example 2: All Customers and Their Orders

Business question: Which customers have orders and which customers do not?

```sql
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;
```

## Example 3: Orders with Missing Customer Records

```sql
SELECT o.order_id, o.customer_id, c.customer_name
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

This finds orders where `customer_id` does not match any customer record. This connects to Day 008 broken relationship checks.

## Example 4: Order Items with Product Details

```sql
SELECT oi.order_item_id, oi.order_id, p.product_name, oi.quantity
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;
```

This shows products included in order item rows.

## Example 5: Order Items with Missing Product Records

```sql
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
```

This checks if `order_items` contains product IDs that do not exist in `products`.

## Example 6: Campaigns with Performance Data

```sql
SELECT ca.campaign_id, ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id;
```

This helps find campaigns that have or do not have performance data.

## Joining More Than Two Tables at a Beginner Level

Real reporting often needs multiple joins, but Day 013 keeps this simple.

```sql
SELECT
  c.customer_name,
  o.order_id,
  oi.product_id,
  oi.quantity
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id;
```

This follows the chain from customers to orders to order items.

## Joins and Data Quality

| Data Quality Question | Join Type Usually Used | Why |
| --- | --- | --- |
| Orders with missing customers | `LEFT JOIN` | Finds child rows without parent rows |
| Order items with missing products | `LEFT JOIN` | Finds missing reference data |
| Performance rows with unknown campaigns | `LEFT JOIN` | Finds unknown campaign IDs |
| Customers with no orders | `LEFT JOIN` | Keeps all customers for review |
| Products never ordered | `LEFT JOIN` | Keeps all products for review |
| Campaigns with no performance data | `LEFT JOIN` | Finds inactive or missing activity |

## Joins and ETL/ELT

Data engineers use joins to combine orders with customer country, combine order items with product category, combine campaign performance with campaign details, build reporting tables for dashboards, and enrich raw event data with reference data.

## Joins and Aggregations

Joins and aggregations are often used together. For example, join `order_items` with `products`, then count order items by product category.

```sql
SELECT p.category, COUNT(*) AS total_order_items
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.category;
```

## Common Beginner Mistakes

1. Forgetting the `ON` condition.
2. Joining on the wrong column.
3. Confusing `INNER JOIN` and `LEFT JOIN`.
4. Starting from the wrong left table in a `LEFT JOIN`.
5. Not using table aliases.
6. Selecting columns without table prefixes when names are duplicated.
7. Thinking `LEFT JOIN` always finds only missing records.
8. Forgetting that one customer can have many orders, creating multiple result rows.
9. Expecting joins to automatically remove duplicates.
10. Not checking row counts before and after joins.
11. Filtering the right table in `WHERE` after a `LEFT JOIN` without understanding the effect.
12. Joining tables only because columns have the same name, without understanding the business relationship.

## Role of a Data Engineer

| JOIN Task | Data Engineering Use |
| --- | --- |
| Combine customer and order data | Enrich order records |
| Combine product and order item data | Add product details to transactions |
| Find missing customer references | Validate relationships |
| Find missing product references | Detect broken reference data |
| Enrich transaction data | Build reporting outputs |
| Build reporting tables | Support dashboards |
| Validate relationships | Improve data quality |
| Investigate row count changes | Understand join effects |
| Support dashboard logic | Provide reliable datasets |
| Prepare analytics-ready datasets | Help analysts work faster |
| Document table relationships | Make data easier to use |
| Work with analysts and business users | Confirm business meaning |

## Beginner Analogy: School Student and Exam Tables

A `students` table may contain `student_id` and `student_name`. An `exam_results` table may contain `student_id`, `subject`, and `marks`. A join connects student details with exam results using `student_id`. An `INNER JOIN` shows students who have results. A `LEFT JOIN` from students shows all students, including students without results.

## Beginner Analogy: Customer and Order Receipts

The customer list is the people registered in a shop. Order receipts are purchases made. `INNER JOIN` shows only customers who purchased. `LEFT JOIN` shows all customers, including customers who did not purchase.

## Key Takeaways

- Data is often split into related tables.
- A primary key uniquely identifies a row.
- A foreign key points to a related table.
- Parent tables store main entities.
- Child tables store related details.
- One-to-many relationships are common.
- `JOIN` combines related tables.
- `ON` defines how tables connect.
- Table aliases make join queries easier to read.
- `INNER JOIN` returns matching rows only.
- `LEFT JOIN` keeps all rows from the left table.
- `LEFT JOIN` can expose missing matches as `NULL`.
- `INNER JOIN` can hide unmatched records.
- Joins can increase row counts in one-to-many relationships.
- Data engineers use joins for enrichment, validation, and reporting.

## Next Day Preview

Day 014 will explain more SQL JOIN practice, including multiple joins, join filtering, and common join mistakes.

## Navigation

- Previous: [Day 012 - SQL GROUP BY with HAVING and Data Quality Summary Checks](../day-012-sql-group-by-having-data-quality-checks/)
- Next: Day 014 - SQL JOIN Practice and Common Join Mistakes - Coming Soon
- [Back to Main Learning Path](../README.md)
