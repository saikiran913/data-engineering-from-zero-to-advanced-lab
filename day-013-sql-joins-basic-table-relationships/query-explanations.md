# Query Explanations for Day 013

## Basic INNER JOIN

`INNER JOIN` returns matching rows from both tables. The purpose is to combine related data when a matching key exists in both tables. For example, joining `customers` and `orders` on `customer_id` returns customers who have matching orders. This matters because many reporting datasets need matched business details.

## Basic LEFT JOIN

`LEFT JOIN` keeps all rows from the left table and adds matching rows from the right table. If no match exists, right-side columns appear as `NULL`. This is useful when the purpose is to keep all customers, all products, or all campaigns while checking whether related rows exist.

## ON Condition

The `ON` condition tells SQL which rows connect. For customers and orders, the condition is `c.customer_id = o.customer_id`. If the wrong columns are used, the query can return incorrect results.

## Table Aliases

Aliases make join queries easier to read. Instead of writing `customers.customer_id` every time, the query can use `customers AS c` and then write `c.customer_id`. Aliases also help avoid ambiguous column names.

## Customers and Orders

The customer-order relationship is usually one-to-many. One customer can place many orders. Queries that join `customers` and `orders` can show customer names beside order IDs, order amounts, and payment statuses.

## Orders and Order Items

One order can have many order item rows. The join condition is `o.order_id = oi.order_id`. This lets a data engineer see the line-level detail behind each order.

## Products and Order Items

`order_items.product_id` connects to `products.product_id`. Joining these tables adds product names, categories, and product status to order item rows.

## Campaigns and Campaign Performance

`campaign_performance.campaign_id` connects to `campaigns.campaign_id`. Joining these tables adds campaign names, status, budget, and channel details to performance rows.

## Missing Relationship Checks

`LEFT JOIN` with `IS NULL` finds missing matches. For example, orders with missing customers are found by starting from `orders`, left joining `customers`, and filtering where `c.customer_id IS NULL`. This is a common data quality pattern.

## Multiple Table Joins

Simple chain joins follow relationship paths such as customers to orders to order items to products. Each join uses its own `ON` condition. Multiple joins can create more rows when one-to-many relationships exist.

## Joins with Beginner Aggregations

After joining, beginner aggregations can count or sum data. For example, join customers to orders, then count orders by customer. Join campaigns to performance, then sum revenue by campaign name.

## How Data Engineers Use These Queries

Data engineers use joins for enrichment, validation, broken relationship investigation, reporting preparation, dashboard data preparation, row count investigation, and source-to-target understanding. For each query, check the purpose, tables used, join type, join condition, expected result, and why the result matters.
