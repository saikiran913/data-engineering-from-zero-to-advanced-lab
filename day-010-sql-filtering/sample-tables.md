# Sample Tables for Day 010

This lesson uses four simple business tables:

1. `customers`
2. `orders`
3. `products`
4. `campaigns`

The sample CSV files are stored in [sample-data](sample-data/).

## customers Table

The `customers` table stores customer information.

| Column Name | Simple Meaning | Example Value | Useful Filtering Example |
| --- | --- | --- | --- |
| customer_id | Unique customer identifier | 101 | `customer_id = 101` |
| customer_name | Customer display name | Customer A | `customer_name LIKE 'Customer%'` |
| country | Customer country | UK | `country IN ('UK', 'India')` |
| city | Customer city | London | `city IS NULL` |
| signup_date | Date customer signed up | 2026-01-05 | `signup_date BETWEEN '2026-01-01' AND '2026-06-30'` |
| email | Customer email address | customer.a@example.com | `email IS NOT NULL` |
| customer_status | Customer status | Active | `customer_status = 'Active'` |
| marketing_opt_in | Marketing permission | true | `marketing_opt_in = true` |

Blank CSV fields may be loaded as `NULL` depending on SQL tool configuration.

## orders Table

| Column Name | Simple Meaning | Example Value | Useful Filtering Example |
| --- | --- | --- | --- |
| order_id | Unique order identifier | 6001 | `order_id = 6001` |
| customer_id | Customer who placed order | 101 | `customer_id = 101` |
| order_date | Date of order | 2026-06-01 | `order_date = '2026-06-01'` |
| order_amount | Order value | 120.50 | `order_amount > 500` |
| order_status | Order lifecycle status | Delivered | `order_status IN ('Cancelled', 'Returned')` |
| payment_status | Payment result | Paid | `payment_status = 'Failed'` |
| country | Order country | UK | `country = 'UK'` |
| delivery_date | Delivery date | 2026-06-04 | `delivery_date IS NULL` |

## products Table

| Column Name | Simple Meaning | Example Value | Useful Filtering Example |
| --- | --- | --- | --- |
| product_id | Unique product identifier | P100 | `product_id = 'P100'` |
| product_name | Product display name | Laptop Stand | `product_name LIKE '%Book%'` |
| category | Product category | Electronics | `category IN ('Electronics', 'Books')` |
| price | Product price | 45.00 | `price BETWEEN 20 AND 100` |
| is_active | Whether product is active | true | `is_active = true` |
| stock_status | Stock availability | In Stock | `stock_status IN ('Out of Stock', 'Low Stock')` |

## campaigns Table

| Column Name | Simple Meaning | Example Value | Useful Filtering Example |
| --- | --- | --- | --- |
| campaign_id | Unique campaign identifier | C001 | `campaign_id = 'C001'` |
| campaign_name | Campaign display name | Summer Sale Search | `campaign_name LIKE '%Sale%'` |
| channel | Marketing channel | Search | `channel IN ('Search', 'Social')` |
| country | Campaign country | UK | `country = 'UK'` |
| start_date | Campaign start date | 2026-06-01 | `start_date >= '2026-06-01'` |
| end_date | Campaign end date | 2026-06-30 | `end_date IS NULL` |
| campaign_status | Campaign status | Active | `campaign_status = 'Active'` |
| budget | Campaign budget | 5000 | `budget BETWEEN 1000 AND 5000` |

## How These Tables Support Filtering Practice

- `customers` helps practice country, status, email, and `NULL` filters.
- `orders` helps practice amount, date, status, and payment filters.
- `products` helps practice category, price, active flag, stock status, and `LIKE` filters.
- `campaigns` helps practice channel, country, status, date range, and name pattern filters.

Joins and aggregations are not covered today.

