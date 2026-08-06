# Sample Tables for Day 029

Day 029 uses source-style datasets plus consumer and change-case metadata. The data is designed for dependency checks, old-versus-new comparisons, and regression-style reporting validation.

| File | Purpose | Grain | Key | Relationships | Consumer Impact | Likely Change Cases |
|---|---|---|---|---|---|---|
| `customers_source.csv` | Customer versions | One row per customer version | `customer_id`, `updated_at` | Joins to orders by `customer_id` | Customer reports and country summaries | status filter, null country, email exposure |
| `orders_source.csv` | Order versions | One row per order version | `order_id`, `updated_at` | Joins to customers and payments | Revenue reports and order details | status filter, amount rule, current order logic |
| `payments_source.csv` | Payment attempts | One row per payment attempt | `payment_id` | Joins to orders by `order_id` | Finance and exception reports | join grain, payment status rules |
| `campaign_metrics_source.csv` | Campaign deliveries | One row per campaign load | campaign-date-channel-country-load | Used for campaign reporting | Campaign dashboards | latest-load logic, null spend, aggregation grain |
| `view_consumers.csv` | Consumer inventory | One row per consumer-view relationship | `consumer_id` | References view names | Shows change sensitivity | column contract and consumer review |
| `view_change_cases.csv` | Change scenarios | One row per proposed change | `case_id` | References view names | Shows possible impact | add, rename, remove, filter, join, grain, dependency |

## Validation Questions

| Dataset | Questions |
|---|---|
| `customers_source` | Are customer IDs duplicated by version? Which customers changed status? Are country and email populated? |
| `orders_source` | Which order IDs have repeated versions? Which rows are excluded by valid-order logic? |
| `payments_source` | Which orders have multiple payment attempts? Which payments do not match an order? |
| `campaign_metrics_source` | Which campaign-date keys have corrected later loads? Are null spend rows reviewed? |
| `view_consumers` | Which consumers are high sensitivity? Which columns are required? |
| `view_change_cases` | Which changes may be breaking? What validation is required? |
