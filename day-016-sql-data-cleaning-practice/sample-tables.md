# Sample Tables for Day 016

This lesson uses messy raw data to practise `CASE` expressions, derived columns, and business-ready outputs.

## raw_customers

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| customer_id | Customer identifier | Preserve as key |
| customer_name | Customer name | Trim and clean |
| country | Customer country | Standardise country |
| city | Customer city | Handle blanks |
| signup_date | Signup date | Preserve |
| email | Email address | Trim and lowercase |
| customer_status | Customer status | Standardise status |
| marketing_opt_in | Marketing permission | Standardise boolean-like values |

## raw_orders

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| order_id | Order identifier | Preserve as key |
| customer_id | Customer identifier | Preserve |
| order_date | Order date | Preserve |
| order_amount | Order value | Create order value band |
| order_status | Order state | Clean status |
| payment_status | Payment state | Clean status and health label |
| country | Order country | Standardise country |

## raw_products

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| product_id | Product identifier | Preserve |
| product_name | Product name | Trim |
| category | Product category | Standardise category |
| price | Product price | Create price band |
| is_active | Active flag | Standardise boolean-like value |
| stock_status | Stock state | Standardise stock status |

## raw_campaigns

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| campaign_id | Campaign identifier | Preserve |
| campaign_name | Campaign name | Trim |
| channel | Marketing channel | Standardise channel |
| country | Campaign country | Standardise country |
| campaign_status | Campaign state | Standardise status |
| budget | Campaign budget | Create budget band |

## raw_campaign_performance

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| performance_date | Performance date | Preserve |
| campaign_id | Campaign identifier | Preserve |
| channel | Channel | Standardise channel |
| country | Country | Standardise country |
| impressions | Ad views | Preserve |
| clicks | Clicks | Preserve |
| cost | Spend | Cost band and performance label |
| conversions | Conversion count | Conversion label |
| revenue | Revenue | Revenue band and performance label |

## business_ready_output_examples

This file describes example raw-to-business-ready conversion rules.

| Column Name | Simple Meaning |
| --- | --- |
| source_table | Raw table |
| raw_columns | Source columns |
| business_ready_columns | Output columns |
| business_rule | Rule used |
| example_output | Example result |
