# Basic Table Relationships for Data Engineers

## Why Relationships Matter

Data engineering often requires combining related datasets. Relationships explain how tables connect and how data should be joined safely.

## Entity

An entity is a real-world object or concept represented in data. Examples include customer, order, product, campaign, and payment.

## Primary Key

A primary key uniquely identifies a row in a table. `customers.customer_id` identifies one customer. `orders.order_id` identifies one order.

## Foreign Key

A foreign key points to a primary key in another table. `orders.customer_id` points to `customers.customer_id`.

## Parent and Child Tables

The parent table stores the main thing. The child table stores related detail. `customers` is a parent table and `orders` is a child table.

## One-to-One Relationship

One-to-one means one row connects to one related row. Example: one employee and one employee profile.

## One-to-Many Relationship

One-to-many is very common:

- One customer -> many orders.
- One order -> many order items.
- One campaign -> many performance rows.

## Many-to-Many Relationship

One order can include many products. One product can appear in many orders. `order_items` connects them and acts as a bridge table.

## Relationship Map for Sample Data

```text
customers
customer_id
  |
  v
orders
customer_id

orders
order_id
  |
  v
order_items
order_id

products
product_id
  |
  v
order_items
product_id

campaigns
campaign_id
  |
  v
campaign_performance
campaign_id
```

## What Happens When Relationships Break?

Broken relationships can happen when an order points to a missing customer, an order item points to a missing product, or campaign performance points to a missing campaign. Dashboards may miss names or categories, reporting tables may lose records, and `INNER JOIN` may hide unmatched records. `LEFT JOIN` can expose missing matches.

## Relationship Documentation

Data engineers should document table name, primary key, foreign key, related table, relationship type, business meaning, expected match behavior, and known exceptions.

| Table Name | Primary Key | Foreign Key | Related Table | Relationship Type | Business Meaning | Expected Match Behavior | Known Exceptions |
| --- | --- | --- | --- | --- | --- | --- | --- |
| orders | order_id | customer_id | customers | One customer to many orders | Orders belong to customers | Most orders should match a customer | Some test rows may not match |
