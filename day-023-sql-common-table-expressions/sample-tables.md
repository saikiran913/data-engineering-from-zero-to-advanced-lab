# Sample Tables for Day 023

Day 023 uses six CSV datasets designed for CTE practice: filtering, cleaning, aggregation, deduplication, joins, validation, reconciliation, and exception reporting.

## Dataset Summary

| Dataset | Purpose | Key | Likely CTE Steps |
| --- | --- | --- | --- |
| `raw_orders.csv` | Raw order records with versions and issues | `order_id` | Rank, keep latest, filter valid, aggregate |
| `customers.csv` | Customer reference data | `customer_id` | Active customer filter, joins |
| `payments.csv` | Payment attempts | `payment_id` | Successful payments, unmatched payments |
| `daily_sales.csv` | Daily product sales | `sale_date`, `product_id` | Clean sales, aggregate daily totals |
| `source_records.csv` | Source-side reconciliation records | `record_id` | Source counts, source totals, missing target |
| `target_records.csv` | Target-side reconciliation records | `record_id` | Target counts, target totals, extra target |

## raw_orders.csv

| Column | Meaning |
| --- | --- |
| `order_id` | Order identifier |
| `customer_id` | Customer linked to the order |
| `order_date` | Business order date |
| `order_status` | Order status |
| `order_amount` | Order value |
| `updated_at` | Source update timestamp |
| `source_file` | File where the row came from |

Data-quality issues include repeated order versions, null customer IDs, zero amount, negative amount, cancelled and refunded statuses, and an order customer missing from `customers.csv`.

## customers.csv

Includes active and inactive customers, customers with orders, customers without orders, multiple countries, and generic customer labels.

## payments.csv

Includes successful, failed, pending, and refunded payments; multiple attempts for one order; a payment without a matching order; and a payment amount mismatch.

## daily_sales.csv

Includes valid sales, a null customer ID, zero quantity, negative amount, high-sales days, low-sales days, and repeated product-date combinations.

## source_records.csv and target_records.csv

These support missing-record checks, extra-target checks, value mismatches, status mismatches, count reconciliation, and total reconciliation.

| Validation Question | Useful CTE Pattern |
| --- | --- |
| Which source records are missing in target? | `source_data`, `target_data`, `missing_target_records` |
| Which target records are not in source? | `target_data`, `source_data`, `missing_source_records` |
| Which values differ? | `matched_records` |
| Do counts match? | `source_summary`, `target_summary` |
| Do totals match? | `source_summary`, `target_summary` |
