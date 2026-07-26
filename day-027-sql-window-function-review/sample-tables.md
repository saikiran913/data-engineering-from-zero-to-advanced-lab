# Sample Tables for Day 027

Day 027 uses history-style datasets. Each dataset contains repeated entities across dates so learners can practice ranking, row comparison, cumulative metrics, moving metrics, and validation.

## Dataset Summary

| File | Purpose | Business Grain | Review Risks |
|---|---|---|---|
| `customer_activity_metrics.csv` | Customer activity over time | One row per customer per activity date and load | Tied spend, status changes, zero spend, null spend, duplicate date |
| `product_performance_history.csv` | Product metrics by date | One row per product per metric date and load | Tied sales, stock changes, null stock, missing dates |
| `campaign_metrics_history.csv` | Campaign metrics by channel and country | One row per campaign per metric date | Tied conversions, missing dates, null spend, zero conversions |
| `pipeline_quality_history.csv` | Data pipeline quality over time | One row per pipeline per load date and version | Changing issues, zero-record load, null duration, duplicate date |
| `regional_sales_history.csv` | Region-level sales history | One row per region per sale date and load | Tied sales, missing dates, duplicate date, null sales |
| `window_function_casebook.csv` | Function-choice examples | One row per learning case | Some cases need windows; one needs only `GROUP BY` |

## Customer Activity Metrics

Columns: `customer_id`, `country`, `activity_date`, `orders_count`, `total_spend`, `customer_status`, `loaded_at`

This table supports ranking customers inside each country, comparing customer status over time, calculating running spend, and reviewing duplicate dates with different load times.

Possible partition: `customer_id` or `country`.

Possible ordering: `activity_date`, `loaded_at`, or `total_spend`.

## Product Performance History

Columns: `product_id`, `category`, `metric_date`, `units_sold`, `total_sales`, `stock_on_hand`, `loaded_at`

This table supports top-product ranking, previous stock comparison, running units sold, moving sales totals, and null-stock review.

Possible partition: `category` or `product_id`.

Possible ordering: `total_sales DESC`, `metric_date`, `loaded_at`.

## Campaign Metrics History

Columns: `campaign_id`, `channel`, `country`, `metric_date`, `impressions`, `clicks`, `conversions`, `spend`, `loaded_at`

This table supports campaign ranking, previous-day conversion comparison, running spend, moving click average, and null-spend review.

Possible partition: `channel, country` or `campaign_id`.

Possible ordering: `conversions DESC`, `metric_date`.

## Pipeline Quality History

Columns: `pipeline_name`, `load_date`, `records_received`, `records_loaded`, `records_rejected`, `quality_issue_count`, `load_duration_minutes`

This table supports pipeline issue ranking, previous issue count, cumulative rejected records, moving duration average, and zero-load review.

Possible partition: `load_date` or `pipeline_name`.

Possible ordering: `quality_issue_count DESC`, `load_date`.

## Regional Sales History

Columns: `region`, `sale_date`, `total_orders`, `total_sales`, `refund_amount`, `loaded_at`

This table supports regional ranking, previous sales comparison, running sales, moving sales average, missing-date review, and null-sales review.

Possible partition: `region`.

Possible ordering: `sale_date`, `total_sales DESC`.

## Window Function Casebook

Columns: `case_id`, `business_question`, `input_grain`, `partition_columns`, `order_columns`, `recommended_function`, `frame_definition`, `tie_or_boundary_policy`, `validation_check`

This file is a guide for matching questions to SQL patterns.

## Compatibility and Review Map

| Dataset | Ranking Questions | Row Comparison Questions | Cumulative Questions | Main Validation |
|---|---|---|---|---|
| Customer activity | Top customer by country | Previous or next status | Running spend | Boundary rows and null spend |
| Product performance | Top products by category | Previous stock | Moving sales | Ties and duplicate dates |
| Campaign metrics | Top campaigns by channel-country | Previous conversions | Running spend | Null spend and missing dates |
| Pipeline quality | Highest issue pipelines by day | Previous issue count | Cumulative rejected rows | Reconciliation |
| Regional sales | Top or bottom sales dates | Previous sales date | Running sales | Missing dates and null sales |
