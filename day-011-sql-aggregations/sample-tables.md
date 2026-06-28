# Sample Tables for Day 011

This lesson uses five simple business tables:

1. `customers`
2. `orders`
3. `products`
4. `campaigns`
5. `campaign_performance`

## customers table

The `customers` table stores basic customer information.

| Column Name | Simple Meaning | Example Value | Aggregation Use |
| --- | --- | --- | --- |
| customer_id | Unique customer identifier | C001 | Count customers |
| customer_name | Generic customer label | Customer A | Not usually aggregated |
| country | Customer country | UK | Group customers by country |
| city | Customer city | London | Group customers by city later |
| signup_date | Date customer signed up | 2026-01-05 | Find earliest or latest signup |
| email | Customer email value | customer.a@example.com | Count non-null emails |
| customer_status | Customer state | Active | Count customers by status |
| marketing_opt_in | Marketing permission | true | Count opt-in groups |

## orders table

The `orders` table stores customer order activity.

| Column Name | Simple Meaning | Example Value | Aggregation Use |
| --- | --- | --- | --- |
| order_id | Unique order identifier | O1001 | Count orders |
| customer_id | Customer linked to order | C001 | Count orders by customer later |
| order_date | Date order was placed | 2026-02-01 | Group sales by date |
| order_amount | Order value | 125.50 | Sum, average, min, max |
| order_status | Order state | Delivered | Count orders by status |
| payment_status | Payment state | Paid | Filter or group payment outcomes |
| country | Order country | UK | Group sales by country |
| delivery_date | Date delivered | 2026-02-04 | Count delivered rows |

## products table

The `products` table stores product catalog data.

| Column Name | Simple Meaning | Example Value | Aggregation Use |
| --- | --- | --- | --- |
| product_id | Unique product identifier | P001 | Count products |
| product_name | Product label | Wireless Mouse | Not usually aggregated |
| category | Product category | Electronics | Group products by category |
| price | Product price | 29.99 | Average, min, max |
| is_active | Whether product is active | true | Filter active products |
| stock_status | Stock state | In Stock | Count by stock status |

## campaigns table

The `campaigns` table stores marketing campaign setup information.

| Column Name | Simple Meaning | Example Value | Aggregation Use |
| --- | --- | --- | --- |
| campaign_id | Unique campaign identifier | CMP001 | Count campaigns |
| campaign_name | Campaign label | Spring Search UK | Not usually aggregated |
| channel | Marketing channel | Search | Group budget by channel |
| country | Campaign country | UK | Group budget by country |
| start_date | Campaign start date | 2026-02-01 | Find earliest start |
| end_date | Campaign end date | 2026-02-28 | Count campaigns with end dates |
| campaign_status | Campaign state | Active | Count campaigns by status |
| budget | Planned spend | 2500.00 | Sum, average, min, max |

## campaign_performance table

The `campaign_performance` table stores daily marketing performance.

| Column Name | Simple Meaning | Example Value | Aggregation Use |
| --- | --- | --- | --- |
| performance_date | Reporting date | 2026-02-01 | Group by day or find latest date |
| campaign_id | Campaign identifier | CMP001 | Count performance rows |
| channel | Marketing channel | Search | Group metrics by channel |
| country | Campaign country | UK | Group metrics by country |
| impressions | Times ads were shown | 12000 | Sum impressions |
| clicks | Click count | 650 | Sum or average clicks |
| cost | Amount spent | 320.50 | Sum or average cost |
| conversions | Conversion count | 32 | Sum conversions |
| revenue | Revenue generated | 1850.00 | Sum or average revenue |

## How These Tables Support Aggregation Practice

- `customers` helps count customers by country and status.
- `orders` helps calculate order counts, sales totals, averages, minimums, and maximums.
- `products` helps count products by category and stock status.
- `campaigns` helps summarise budgets by channel and country.
- `campaign_performance` helps summarise impressions, clicks, cost, conversions, and revenue.

JOINs are not covered today. Each example uses one table at a time.
