# Naming and Structure Guide

## Name by Purpose

Good CTE names:

- `valid_orders`
- `latest_orders`
- `customer_totals`
- `missing_target_records`
- `reconciliation_summary`

Avoid names such as:

- `cte1`
- `temp`
- `x`
- `final_data2`

## One Responsibility Per CTE

A CTE should ideally perform one understandable step. For example, one CTE filters valid orders and another aggregates customer totals.

## Logical Order

Recommended order:

1. Source filtering
2. Cleaning
3. Deduplication
4. Enrichment
5. Aggregation
6. Validation
7. Final output

## Column Selection

Select the columns needed for the next step. Repeated `SELECT *` can hide extra columns and make review harder.

## Audit Columns

Keep useful audit fields such as `source_file`, `updated_at`, `loaded_at`, and original status when they help explain where a record came from.

## Comments

Short section comments can explain the business purpose of each step without making the SQL noisy.

## CTE Count

Too many CTEs can reduce readability. Use enough steps to make the logic clear, but avoid splitting every tiny filter into a separate name.

## Rule-Documentation Table

| CTE Name | Input | Purpose | Output Grain | Validation |
| --- | --- | --- | --- | --- |
| `valid_orders` | `raw_orders` | Keep usable order rows | One row per raw order version | Count valid and rejected rows |
| `latest_orders` | `ranked_orders` | Keep latest version | One row per order | Check duplicate groups |
| `customer_totals` | `valid_orders` | Summarise order value | One row per customer | Reconcile total amount |
| `missing_target_records` | Source and target records | Find source-only records | One row per missing source record | Count missing records |

Output grain means what one row represents.
