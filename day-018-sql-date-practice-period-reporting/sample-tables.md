# Sample Tables for Day 018

Day 018 uses simple CSV files for monthly reporting, date quality checks, and fixed-period comparisons.

## orders

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `order_id` | Order identifier | Preserve as key |
| `customer_id` | Customer identifier | Sample relationship concept |
| `order_date` | Date the order happened | Daily and monthly sales reporting |
| `order_datetime` | Exact order date and time | Timestamp awareness |
| `order_amount` | Order value | Sales totals |
| `order_status` | Order state | Cancelled and returned checks |
| `payment_status` | Payment state | Paid sales and failed payment checks |
| `country` | Order country | Country-month reporting |

## campaign_performance

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `performance_date` | Date marketing metrics belong to | Campaign daily and monthly reporting |
| `campaign_id` | Campaign identifier | Campaign examples |
| `channel` | Marketing channel | Channel-month reporting |
| `country` | Campaign country | Country reporting |
| `impressions` | Ad views | Monthly totals |
| `clicks` | Clicks | Monthly totals |
| `cost` | Marketing spend | Cost checks |
| `conversions` | Conversion count | Zero conversion checks |
| `revenue` | Revenue | Low revenue checks |

## website_events

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `event_id` | Event identifier | Preserve as key |
| `user_id` | User identifier | Event activity examples |
| `event_date` | Date event happened | Daily and monthly event reports |
| `event_timestamp` | Exact event date and time | Timestamp awareness |
| `event_type` | Type of event | Purchase and signup counts |
| `page_name` | Website page | Page activity examples |
| `country` | User country | Country-level reporting |

## pipeline_runs

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `pipeline_name` | Pipeline name | Monthly pipeline checks |
| `run_date` | Date pipeline ran | Freshness checks |
| `run_timestamp` | Exact run time | Monitoring context |
| `status` | Run state | Failed and skipped run checks |
| `records_processed` | Number of rows processed | Zero-record checks |
| `source_file_date` | Date represented by source data | Source freshness |
| `completed_at` | Completion time | Incomplete run checks |

## daily_sales_summary

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `summary_date` | Date represented by daily row | Daily quality checks |
| `country` | Country | Date-country grain |
| `total_orders` | Order count | Zero-activity checks |
| `total_sales` | Sales amount | Low sales checks |
| `paid_orders` | Paid order count | Payment summary |
| `failed_payments` | Failed payment count | High issue checks |
| `cancelled_orders` | Cancelled order count | Operations checks |

## monthly_sales_summary

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `summary_year` | Reporting year | Monthly period |
| `summary_month` | Reporting month | Monthly period |
| `country` | Country | Country-month grain |
| `total_orders` | Monthly order count | Zero-month checks |
| `total_sales` | Monthly sales | Low monthly sales checks |
| `paid_orders` | Monthly paid orders | Paid sales checks |
| `failed_payments` | Monthly failed payments | High failed payment checks |
| `cancelled_orders` | Monthly cancelled orders | Cancellation checks |

## monthly_campaign_summary

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `summary_year` | Reporting year | Monthly period |
| `summary_month` | Reporting month | Monthly period |
| `channel` | Marketing channel | Channel-month grain |
| `country` | Country | Channel-country-month grain |
| `total_impressions` | Monthly impressions | Marketing report |
| `total_clicks` | Monthly clicks | Marketing report |
| `total_cost` | Monthly cost | Cost checks |
| `total_conversions` | Monthly conversions | Zero conversion checks |
| `total_revenue` | Monthly revenue | Revenue checks |
