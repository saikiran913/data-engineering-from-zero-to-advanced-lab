# Real-World Examples

| Scenario | Grain | Partition | Ordering | Measure | Function | Frame | Review Conditions |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Running sales by region | Region-date row | `region` | `sale_date`, `loaded_at` | `total_sales` | `SUM` | Unbounded to current | Nulls, duplicate dates |
| Cumulative customer spending | Order row | `customer_id` | `order_date`, `loaded_at` | `order_amount` | `SUM` | Unbounded to current | Cancelled and duplicate orders |
| Cumulative orders by customer | Order row | `customer_id` | `order_date` | rows | `COUNT` | Unbounded to current | Duplicate order rows |
| Cumulative pipeline records | Pipeline-date row | `pipeline_name` | `load_date` | `records_loaded` | `SUM` | Unbounded to current | Missing dates |
| Cumulative rejected records | Pipeline-date row | `pipeline_name` | `load_date` | `records_rejected` | `SUM` | Unbounded to current | Rejection spikes |
| Three-row moving sales average | Region-date row | `region` | `sale_date` | `total_sales` | `AVG` | 2 preceding to current | Three rows not three days |
| Moving campaign conversions | Campaign-date row | `campaign_id` | `metric_date` | `conversions` | `AVG` | 2 preceding to current | Zero-conversion rows |
| Moving campaign spend | Campaign-date row | `campaign_id` | `metric_date` | `spend` | `AVG` | 2 preceding to current | Null spend |
| Moving load duration | Pipeline-date row | `pipeline_name` | `load_date` | `load_duration_minutes` | `AVG` | 2 preceding to current | Null duration |
| Cumulative inventory sold | Product-date row | `product_id` | `inventory_date` | `units_sold` | `SUM` | Unbounded to current | Duplicate dates |
| Cumulative maximum sales | Region-date row | `region` | `sale_date` | `total_sales` | `MAX` | Unbounded to current | Null measures |
| Cumulative minimum duration | Pipeline-date row | `pipeline_name` | `load_date` | `load_duration_minutes` | `MIN` | Unbounded to current | Zero or null duration |
| Missing-date warning | Date-history row | entity | date | row coverage | Validation | Not a metric | Missing calendar days |
| Duplicate-date warning | Date-history row | entity | date | row count | Validation | Not a metric | Duplicate business dates |

Generic monetary examples can be described as INR in prose. CSV numeric fields stay plain numbers.
