# Sample Tables for Day 012

This lesson uses six simple business tables:

1. `customers`
2. `orders`
3. `products`
4. `campaigns`
5. `campaign_performance`
6. `daily_order_summary`

## customers table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| customer_id | Unique customer identifier | C001 | Count customers |
| customer_name | Generic customer label | Customer A | Display only |
| country | Customer country | UK | Group customers by country |
| city | Customer city | London | Discuss missing values |
| signup_date | Signup date | 2026-02-01 | Date range checks |
| email | Customer email | customer.a@example.com | Repeated email checks |
| customer_status | Customer state | Active | Status distribution checks |
| marketing_opt_in | Marketing permission | true | Group opt-in values |

## orders table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| order_id | Order identifier | O1001 | Duplicate-style checks |
| customer_id | Customer identifier | C001 | Count orders |
| order_date | Order date | 2026-02-01 | Group by date |
| order_amount | Order value | 125.50 | Sum, avg, min, max |
| order_status | Order state | Delivered | Status distribution |
| payment_status | Payment state | Paid | Failed payment checks |
| country | Order country | UK | Group by country |
| delivery_date | Delivery date | 2026-02-04 | Missing delivery discussion |

## products table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| product_id | Product identifier | P001 | Count products |
| product_name | Product label | Wireless Mouse | Display only |
| category | Product category | Electronics | Group by category |
| price | Product price | 29.99 | Average, min, max |
| is_active | Active flag | true | Filter active/inactive products |
| stock_status | Stock state | Low Stock | Stock distribution |

## campaigns table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| campaign_id | Campaign identifier | CMP001 | Count campaigns |
| campaign_name | Campaign label | Spring Search UK | Display only |
| channel | Marketing channel | Search | Group by channel |
| country | Campaign country | UK | Group by country |
| start_date | Start date | 2026-02-01 | Date checks |
| end_date | End date | 2026-02-28 | Date checks |
| campaign_status | Campaign state | Active | Status distribution |
| budget | Planned spend | 2500.00 | Sum and avg budgets |

## campaign_performance table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| performance_date | Reporting date | 2026-02-01 | Group by date |
| campaign_id | Campaign identifier | CMP001 | Count performance rows |
| channel | Marketing channel | Search | Group by channel |
| country | Campaign country | UK | Group by country |
| impressions | Ad views | 12000 | Sum impressions |
| clicks | Click count | 640 | Sum clicks |
| cost | Spend amount | 320.50 | Cost thresholds |
| conversions | Conversion count | 32 | Sum conversions |
| revenue | Revenue amount | 1850.00 | Revenue thresholds |

## daily_order_summary table

| Column Name | Simple Meaning | Example Value | HAVING / Summary Use |
| --- | --- | --- | --- |
| summary_date | Summary date | 2026-02-01 | Group by date |
| country | Country | UK | Group by country |
| total_orders | Daily order count | 42 | Zero-order checks |
| total_sales | Daily sales total | 4200.00 | Low or high sales checks |
| failed_payments | Failed payment count | 3 | High failed payment checks |
| cancelled_orders | Cancelled order count | 2 | High cancellation checks |

## How These Tables Support Day 012

- `customers` supports repeated email and status checks.
- `orders` supports duplicate ID, count, total, average, and status checks.
- `products` supports category and inactive product checks.
- `campaigns` supports channel and status checks.
- `campaign_performance` supports revenue, cost, and date summaries.
- `daily_order_summary` supports daily data quality checks.

Each query uses one table at a time.
