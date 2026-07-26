# Sample Tables for Day 025

| Dataset | Purpose | Business Grain | Partition Key | Ordering Columns | Comparison Values |
| --- | --- | --- | --- | --- | --- |
| `customer_order_history.csv` | Order version and customer order history | One order version | `customer_id` or `order_id` | `order_date`, `updated_at`, `version_number` | Status and amount |
| `payment_status_history.csv` | Payment status sequence | One status event | `transaction_id` | `status_sequence`, `status_timestamp` | Status and amount |
| `product_price_history.csv` | Product price history | One product price update | `product_id` | `price_date`, `updated_at` | Unit price |
| `daily_sales_history.csv` | Region daily sales history | One region per sale date | `region` | `sale_date` | Sales and orders |
| `website_event_sequence.csv` | User event sequence | One website event | `user_id` | `event_sequence`, `event_timestamp`, `event_id` | Event name and sequence |
| `row_comparison_rule_examples.csv` | Documentation examples | One rule scenario | Varies | Varies | Varies |

The data includes boundary rows, status changes, price changes, missing dates, sequence gaps, duplicate ordering values, late-arriving data, and null values for review.

## Likely Review Cases

| Dataset | Review Case |
| --- | --- |
| `customer_order_history` | Same timestamp with different version numbers, null amount, late-arriving version |
| `payment_status_history` | Sequence gap, duplicate sequence value, amount change |
| `product_price_history` | Zero previous price, null price, same-day updates |
| `daily_sales_history` | Missing sale dates, zero sales, null sales, late-loaded row |
| `website_event_sequence` | Sequence gap, duplicate sequence number, null event name |
