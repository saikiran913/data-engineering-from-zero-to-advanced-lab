# Sample Tables for Day 022

Day 022 uses six small CSV datasets. They are generic, public-friendly, and designed to support subquery practice.

## Dataset Summary

| Dataset | Purpose | Likely Key | Subquery Use Cases |
| --- | --- | --- | --- |
| `customers.csv` | Customer reference data | `customer_id` | Customers with or without orders |
| `orders.csv` | Order transactions | `order_id` | Orders above average, customer filtering |
| `payments.csv` | Payment attempts | `payment_id` | Orders with successful payments, missing payments |
| `products.csv` | Product reference data | `product_id` | Products sold or never sold |
| `daily_sales.csv` | Daily product sales | `sale_date`, `product_id`, `customer_id` | Product sales checks and daily totals |
| `source_target_reconciliation.csv` | Simplified source-target validation | `record_type`, `record_id` | Missing and mismatched record checks |

## customers.csv

| Column | Meaning |
| --- | --- |
| `customer_id` | Customer identifier |
| `customer_name` | Generic label such as Customer A |
| `country` | Customer country |
| `customer_status` | Active or inactive status |
| `signup_date` | Date the customer signed up |

The data includes active and inactive customers, multiple countries, customers with orders, and customers without orders.

## orders.csv

| Column | Meaning |
| --- | --- |
| `order_id` | Order identifier |
| `customer_id` | Customer linked to the order |
| `order_date` | Order date |
| `order_status` | Order status |
| `order_amount` | Order value |

The data includes multiple orders for some customers, a `NULL` customer ID for `NOT IN` discussion, cancelled orders, paid-like orders, high values, and low values.

## payments.csv

| Column | Meaning |
| --- | --- |
| `payment_id` | Payment attempt identifier |
| `order_id` | Order linked to the payment |
| `payment_status` | SUCCESS, FAILED, or PENDING |
| `payment_amount` | Payment amount |
| `payment_date` | Payment date |

The data includes successful payments, failed payments, pending payments, an order with multiple payment attempts, orders with no payment row, and one payment referencing an unknown order.

## products.csv

| Column | Meaning |
| --- | --- |
| `product_id` | Product identifier |
| `product_name` | Generic product label |
| `category` | Product category |
| `unit_price` | Product price |
| `product_status` | Active or inactive product status |

Some products appear in `daily_sales.csv`, while others do not. Because `orders.csv` does not contain product details, product exercises use `daily_sales.csv`.

## daily_sales.csv

| Column | Meaning |
| --- | --- |
| `sale_date` | Date of sale |
| `product_id` | Product sold |
| `customer_id` | Customer linked to the sale |
| `quantity` | Units sold |
| `sales_amount` | Total sales amount |

The data supports product sales checks, daily total calculations, customer activity checks, and `NULL` customer validation.

## source_target_reconciliation.csv

| Column | Meaning |
| --- | --- |
| `record_type` | SOURCE or TARGET |
| `record_id` | Record identifier |
| `source_system` | Generic source system |
| `target_system` | Generic target system |
| `source_value` | Value from source context |
| `target_value` | Value from target context |
| `load_date` | Load date |

This simplified dataset includes matching records, source-only records, target-only records, mismatched values, and a null target value.

## Validation Questions

| Question | Useful Pattern |
| --- | --- |
| Which customers placed orders? | `IN` or `EXISTS` |
| Which customers never placed orders? | `NOT EXISTS` |
| Which orders have no payment row? | `NOT EXISTS` |
| Which products were never sold? | `NOT EXISTS` |
| Which orders are above average? | Scalar subquery |
| Which source records are missing in the target? | Correlated `NOT EXISTS` |
