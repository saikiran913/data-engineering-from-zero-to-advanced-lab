# Sample Tables for Day 013

This lesson uses six simple business tables:

1. `customers`
2. `orders`
3. `products`
4. `order_items`
5. `campaigns`
6. `campaign_performance`

## customers table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| customer_id | Unique customer ID | C001 | Primary key |
| customer_name | Customer label | Customer A | Customer detail |
| country | Customer country | UK | Reporting detail |
| city | Customer city | London | Reporting detail |
| signup_date | Signup date | 2026-03-01 | Customer attribute |
| email | Email value | customer.a@example.com | Customer attribute |
| customer_status | Customer state | Active | Filtering detail |

## orders table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| order_id | Unique order ID | O3001 | Primary key |
| customer_id | Customer for the order | C001 | Foreign key to customers |
| order_date | Order date | 2026-03-01 | Order attribute |
| order_amount | Order value | 125.50 | Metric |
| order_status | Order state | Delivered | Filtering detail |
| payment_status | Payment state | Paid | Filtering detail |
| country | Order country | UK | Reporting detail |

## products table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| product_id | Unique product ID | P001 | Primary key |
| product_name | Product label | Wireless Mouse | Product detail |
| category | Product category | Electronics | Reporting detail |
| price | Product price | 29.99 | Metric |
| is_active | Active flag | true | Filtering detail |

## order_items table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| order_item_id | Unique order item row | OI001 | Primary key |
| order_id | Related order | O3001 | Foreign key to orders |
| product_id | Related product | P001 | Foreign key to products |
| quantity | Number of units | 2 | Metric |
| unit_price | Price per unit | 29.99 | Metric |

## campaigns table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| campaign_id | Unique campaign ID | CMP201 | Primary key |
| campaign_name | Campaign label | Spring Search UK | Campaign detail |
| channel | Marketing channel | Search | Reporting detail |
| country | Campaign country | UK | Reporting detail |
| campaign_status | Campaign state | Active | Filtering detail |
| budget | Planned spend | 2500.00 | Metric |

## campaign_performance table

| Column Name | Simple Meaning | Example Value | Relationship Use |
| --- | --- | --- | --- |
| performance_date | Performance date | 2026-03-01 | Reporting date |
| campaign_id | Related campaign | CMP201 | Foreign key to campaigns |
| channel | Marketing channel | Search | Reporting detail |
| country | Country | UK | Reporting detail |
| impressions | Ad views | 12000 | Metric |
| clicks | Click count | 640 | Metric |
| cost | Spend amount | 320.50 | Metric |
| conversions | Conversion count | 32 | Metric |
| revenue | Revenue amount | 1850.00 | Metric |

## Relationship Summary

| Relationship | Join Condition | Type |
| --- | --- | --- |
| Customers to orders | `c.customer_id = o.customer_id` | One customer to many orders |
| Orders to order items | `o.order_id = oi.order_id` | One order to many order items |
| Products to order items | `p.product_id = oi.product_id` | One product to many order items |
| Campaigns to performance | `ca.campaign_id = cp.campaign_id` | One campaign to many performance rows |
