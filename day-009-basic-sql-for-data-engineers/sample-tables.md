# Sample Tables for Day 009

This lesson uses three simple business tables:

1. `customers`
2. `orders`
3. `products`

The sample CSV files are stored in [sample-data](sample-data/).

## customers Table

The `customers` table stores customer information.

| Column Name | Simple Meaning | Example Value |
| --- | --- | --- |
| customer_id | Unique customer identifier | 101 |
| customer_name | Customer display name | Customer A |
| country | Customer country | UK |
| signup_date | Date the customer signed up | 2026-01-05 |
| email | Customer email address | customer.a@example.com |
| customer_status | Customer status | Active |

## orders Table

The `orders` table stores purchase and order activity.

| Column Name | Simple Meaning | Example Value |
| --- | --- | --- |
| order_id | Unique order identifier | 5001 |
| customer_id | Customer who placed the order | 101 |
| order_date | Date of the order | 2026-06-01 |
| order_amount | Order value | 120.50 |
| order_status | Order lifecycle status | Delivered |
| payment_status | Payment result | Paid |
| country | Order country | UK |

## products Table

The `products` table stores product information.

| Column Name | Simple Meaning | Example Value |
| --- | --- | --- |
| product_id | Unique product identifier | P100 |
| product_name | Product display name | Laptop Stand |
| category | Product category | Electronics |
| price | Product price | 45.00 |
| is_active | Whether product is active | true |

## How These Tables Are Used

- `customers` stores customer information.
- `orders` stores purchase and order activity.
- `products` stores product information.

Joins are not covered today. Future lessons will connect these tables.

