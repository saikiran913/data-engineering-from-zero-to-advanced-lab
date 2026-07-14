# Sample Tables for Day 017

Day 017 uses simple CSV files to practise date filtering, date parts, freshness checks, and daily reporting.

## orders

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `order_id` | Order identifier | Preserve as key |
| `customer_id` | Customer identifier | Connect order to customer conceptually |
| `order_date` | Date the order happened | Date filtering and daily reporting |
| `order_datetime` | Exact order date and time | Timestamp-style filtering discussion |
| `order_amount` | Order value | Daily sales totals |
| `order_status` | Order state | Status filtering |
| `payment_status` | Payment state | Paid and failed payment reports |
| `country` | Order country | Country-level reporting |

## customers

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `customer_id` | Customer identifier | Preserve as key |
| `customer_name` | Generic customer label | Sample data only |
| `signup_date` | Date the customer signed up | Signup trends |
| `signup_datetime` | Exact signup date and time | Timestamp discussion |
| `country` | Customer country | Country-level summaries |
| `customer_status` | Customer state | Filtering and grouping |

## campaign_performance

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `performance_date` | Date the marketing metrics belong to | Daily and monthly campaign reporting |
| `campaign_id` | Campaign identifier | Campaign-level grouping |
| `channel` | Marketing channel | Channel-level reporting |
| `country` | Campaign country | Country-level reporting |
| `impressions` | Number of ad views | Daily performance totals |
| `clicks` | Number of clicks | Daily performance totals |
| `cost` | Marketing spend | Cost reporting |
| `conversions` | Number of conversions | Conversion reporting |
| `revenue` | Revenue from campaign activity | Revenue reporting |

## website_events

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `event_id` | Event identifier | Preserve as key |
| `user_id` | User identifier | User activity examples |
| `event_date` | Date the event happened | Daily event counts |
| `event_timestamp` | Exact event date and time | Timestamp discussion |
| `event_type` | Type of action | Event-type reporting |
| `page_name` | Website page | Page-level examples |
| `country` | User country | Country-level event reports |

## pipeline_runs

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `pipeline_name` | Name of the data pipeline | Pipeline monitoring |
| `run_date` | Date the pipeline ran | Freshness by pipeline |
| `run_timestamp` | Exact pipeline start time | Run investigation |
| `status` | Run state | Success, failed, running, or skipped checks |
| `records_processed` | Number of rows processed | Zero-record checks |
| `source_file_date` | Date represented by the source file | Source freshness |
| `completed_at` | Completion time | Completion checks |

## daily_sales_summary

| Column Name | Simple Meaning | Practice Use |
| --- | --- | --- |
| `summary_date` | Date represented by the summary row | Dashboard freshness |
| `country` | Country in the summary | Country-level daily reporting |
| `total_orders` | Total order count | Daily summary checks |
| `total_sales` | Total sales amount | Sales reporting |
| `paid_orders` | Count of paid orders | Payment summary |
| `failed_payments` | Count of failed payments | Payment quality check |
| `cancelled_orders` | Count of cancelled orders | Operations check |

## Date Column Reminder

Choose the date column that matches the business question. For example, daily order sales should use `order_date`, while pipeline monitoring should use `run_date` or `run_timestamp`.
