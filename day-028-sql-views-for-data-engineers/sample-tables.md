# Sample Tables for Day 028

Day 028 uses raw source-style datasets and view-definition examples. The data is generic and designed for view design, validation, and dependency thinking.

| Dataset | Purpose | Business Grain | Likely Key | Possible View | Dependency Notes |
|---|---|---|---|---|---|
| `raw_customers` | Customer source rows | One row per customer version | `customer_id`, `updated_at` | `vw_active_customers` | Customer versions must be handled |
| `raw_orders` | Order source rows | One row per order version | `order_id`, `updated_at` | `vw_valid_orders`, `vw_current_orders` | Status and amount rules matter |
| `raw_payments` | Payment attempts | One row per payment attempt | `payment_id` | `vw_successful_payments` | Multiple attempts can multiply rows |
| `product_catalog` | Product reference data | One row per product | `product_id` | `vw_active_products` | Null category and zero price need review |
| `campaign_daily_metrics` | Campaign delivery metrics | One row per delivery load | `campaign_id`, `metric_date`, `channel`, `country`, `loaded_at` | `vw_campaign_daily_reporting` | Later corrected loads need clear rules |
| `view_definition_examples` | View design documentation examples | One row per view idea | `view_name` | Dependency review output | Documentation can be queried |

## Validation Questions

| Dataset | Questions |
|---|---|
| `raw_customers` | Are customer IDs unique? Are active customers current versions? Should `email_address` be exposed? |
| `raw_orders` | Which rows are valid for reporting? Are amounts positive? Are repeated versions handled? |
| `raw_payments` | Which payments succeeded? Do payment amounts match orders? Are unmatched payments visible? |
| `product_catalog` | Are active products priced correctly? Is category populated? |
| `campaign_daily_metrics` | Are duplicate deliveries expected? Which load is latest? Are null spend rows reviewed? |
| `view_definition_examples` | Does each view have purpose, grain, validation, and dependency risk documented? |
