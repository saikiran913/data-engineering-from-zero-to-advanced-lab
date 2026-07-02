# Day 013 Notes - SQL JOINs and Basic Table Relationships

## Why Data Is Stored in Multiple Tables

Data is usually split into multiple tables because each table represents a different business entity. A customer, order, product, order item, campaign, and campaign performance row are different things. Splitting data avoids repeated values, makes updates easier, keeps data organized, and supports cleaner reporting.

## Table Relationships

A relationship means rows in one table connect to rows in another table through key columns. For example, `orders.customer_id` connects to `customers.customer_id`.

## Primary Key

A primary key uniquely identifies each row in a table. Examples include `customers.customer_id`, `orders.order_id`, `products.product_id`, `order_items.order_item_id`, and `campaigns.campaign_id`.

## Foreign Key

A foreign key is a column that points to a primary key in another table. For example, `orders.customer_id` points to `customers.customer_id`. Foreign keys help connect related tables.

## Parent and Child Tables

The parent table stores the main entity. The child table stores related details. `customers` is a parent table and `orders` is a child table. One customer can have many orders.

## Relationship Types

One-to-one means one row connects to one related row. One-to-many means one parent row connects to many child rows. Many-to-many means both sides can connect to many rows. `order_items` bridges orders and products because one order can include many products and one product can appear in many orders.

## What SQL JOIN Means

A `JOIN` combines rows from two tables using a related column. A join does not guess the relationship. The query writer must specify the connection using `ON`.

## Basic JOIN Syntax

```sql
SELECT a.column_name, b.column_name
FROM table_a AS a
INNER JOIN table_b AS b
ON a.key_column = b.key_column;
```

## ON Condition

The `ON` condition tells SQL which rows from the two tables belong together. A wrong `ON` condition can create incorrect results.

## Table Aliases

Aliases are short names for tables. Use `customers AS c`, `orders AS o`, `products AS p`, `order_items AS oi`, `campaigns AS ca`, and `campaign_performance AS cp`. Prefixing columns with aliases makes queries clearer.

## INNER JOIN

`INNER JOIN` returns only rows where both tables match. Customers without orders do not appear in a customer-to-orders `INNER JOIN`.

## LEFT JOIN

`LEFT JOIN` keeps all rows from the left table and adds matching rows from the right table. If no match exists, right table columns show `NULL`.

## INNER JOIN vs LEFT JOIN

Use `INNER JOIN` when you only want matched data. Use `LEFT JOIN` when you want to keep all rows from the first table or investigate missing matches.

## Common Join Paths

- Customers to orders: `c.customer_id = o.customer_id`
- Orders to order items: `o.order_id = oi.order_id`
- Products to order items: `p.product_id = oi.product_id`
- Campaigns to performance: `ca.campaign_id = cp.campaign_id`

## Joins for Data Quality

Joins help find orders with missing customers, order items with missing products, products never ordered, customers with no orders, campaigns without performance, and performance rows with unknown campaigns.

## Joins for ETL/ELT

ETL/ELT pipelines often use joins to enrich raw transaction data. Examples include adding customer country to orders, product category to order items, and campaign names to campaign performance.

## Row Counts and Joins

Joins can increase row counts. If one customer has three orders, joining customers to orders can create three rows for that customer. Data engineers check row counts before and after joins.

## Common Mistakes

- Missing the `ON` condition.
- Joining the wrong columns.
- Using `INNER JOIN` when unmatched records must be reviewed.
- Using the wrong left table in a `LEFT JOIN`.
- Not prefixing columns.
- Expecting joins to remove duplicate-looking rows automatically.
- Ignoring `NULL` values after a `LEFT JOIN`.
