# Sample Tables for Day 026

| Dataset | Purpose | Business Grain | Partition Key | Ordering Columns | Measures |
| --- | --- | --- | --- | --- | --- |
| `daily_sales_metrics.csv` | Regional sales metrics | One region per sale/load row | `region` | `sale_date`, `loaded_at` | `total_sales`, `total_orders`, `refund_amount` |
| `customer_order_metrics.csv` | Customer order metrics | One order row | `customer_id` | `order_date`, `loaded_at`, `order_id` | `order_amount` |
| `product_inventory_history.csv` | Inventory history | One product-date/load row | `product_id` | `inventory_date`, `loaded_at` | `stock_on_hand`, `units_received`, `units_sold` |
| `campaign_daily_metrics.csv` | Campaign performance | One campaign-date row | `campaign_id` | `metric_date`, `loaded_at` | `impressions`, `clicks`, `conversions`, `spend` |
| `pipeline_load_metrics.csv` | Pipeline load metrics | One pipeline-date row | `pipeline_name` | `load_date` | `records_loaded`, `records_rejected`, `load_duration_minutes` |
| `cumulative_metric_rule_examples.csv` | Rule examples | One rule scenario | Varies | Varies | Varies |

## Review Cases

The data includes missing dates, duplicate business dates, zero values, null values, enough rows for three-row moving windows, and grouped totals suitable for reconciliation.
