# Sample Tables for Day 033

Day 033 uses six CSV files to practise pipeline validation across source, stage, clean, reporting, rule, and case-review datasets.

## Dataset Overview

| File | Purpose | Grain | Key | Pipeline Stage | Known Validation Issues |
|---|---|---|---|---|---|
| `source_order_extract.csv` | Source extract for validation | One row per extracted source record | `source_record_id` | Source | duplicate order, nulls, zero and negative amounts, source-only record, date issue |
| `staged_order_output.csv` | Staged validation output | One staged candidate per order, with deliberate exceptions | `stage_record_id` | Stage | accepted and review rows, duplicate stage key, missing source file, changed amount, stage-only row |
| `clean_order_output.csv` | Clean output for downstream use | Intended one row per clean order | `order_id` | Clean | duplicate order ID, missing accepted order, amount mismatch |
| `reporting_order_metrics.csv` | Reporting metrics | One row per report date and country group | `report_date`, `country_group` | Reporting | missing group, duplicate reporting key, incorrect total, null metric |
| `validation_rule_catalog.csv` | Validation rules | One row per validation rule | `rule_id` | Documentation | rule examples and expected messages |
| `pipeline_validation_cases.csv` | Validation casebook | One row per validation scenario | `case_id` | Review | expected and unexplained differences |

## source_order_extract.csv

| Detail | Description |
|---|---|
| Columns | `source_record_id`, `order_id`, `customer_id`, `order_status`, `order_date`, `order_amount`, `country_group`, `source_file`, `extracted_at` |
| Control totals | row count, distinct order count, total order amount, completed amount |
| Completeness questions | Are all expected files, dates, statuses, and country groups present? Are critical fields null? |
| Audit columns | `source_file`, `extracted_at` |

## staged_order_output.csv

| Detail | Description |
|---|---|
| Columns | `stage_record_id`, `order_id`, `customer_id`, `standard_status`, `order_date`, `order_amount`, `country_group`, `source_file`, `validation_status`, `validation_reason`, `staged_at` |
| Control totals | staged count, accepted count, review count, accepted amount total |
| Completeness questions | Do accepted plus review rows reconcile? Are source files preserved? |
| Audit columns | `source_file`, `staged_at` |

## clean_order_output.csv

| Detail | Description |
|---|---|
| Columns | `order_id`, `customer_id`, `order_status`, `order_date`, `order_amount`, `country_group`, `source_file`, `cleaned_at` |
| Control totals | clean row count, distinct order count, completed amount, refund amount |
| Completeness questions | Is `order_id` unique? Are accepted source orders represented? |
| Audit columns | `source_file`, `cleaned_at` |

## reporting_order_metrics.csv

| Detail | Description |
|---|---|
| Columns | `report_date`, `country_group`, `completed_order_count`, `total_completed_amount`, `refund_order_count`, `total_refund_amount`, `pending_order_count`, `reporting_loaded_at` |
| Control totals | completed count, completed amount, refund count, refund amount, pending count |
| Completeness questions | Is reporting grain unique? Are metrics populated? |
| Audit columns | `reporting_loaded_at` |

## validation_rule_catalog.csv

This file describes beginner validation checks such as row counts, duplicate keys, null keys, source-only keys, target-only keys, amount totals, grouped totals, date completeness, category completeness, and reporting grain checks.

## pipeline_validation_cases.csv

This casebook helps learners decide which validation checks fit each situation. It includes exact matches, deduplication differences, review exclusions, aggregation differences, total reconciliation, grouped reconciliation, key mismatch, completeness failure, expected exclusion, unexplained difference, duplicate targets, null metrics, and grand-total-only risk.
