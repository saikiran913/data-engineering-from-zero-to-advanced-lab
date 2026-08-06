# Sample Tables for Day 032

Day 032 uses six CSV files. They represent a small staging lab where raw customer order events are standardised, deduplicated, validated, handed to a clean layer, and summarised for reporting.

## Dataset Overview

| File | Stage Role | Grain | Key | Expected Issues |
|---|---|---|---|---|
| `raw_customer_orders.csv` | Raw source input | One row per received source order event | `source_event_id` | repeated orders, status variation, nulls, invalid amounts, tie, late arrival |
| `source_status_mapping.csv` | Mapping reference | One row per raw source status | `source_status` | unsupported status and review-required mappings |
| `staged_customer_orders.csv` | Staged candidate output | One row per staged order candidate | `stage_record_id` | accepted and review candidates |
| `clean_customer_orders.csv` | Clean handoff output | One row per clean order | `order_id` | no intended duplicate order IDs |
| `reporting_customer_order_summary.csv` | Reporting handoff output | One row per report date and country group | `report_date`, `country_group` | one duplicate reporting-grain case and one null measure |
| `staging_handoff_cases.csv` | Documentation examples | One row per handoff case | `case_id` | risks and validation checks |

## raw_customer_orders.csv

| Detail | Description |
|---|---|
| Purpose | Represents raw order events received from source files |
| Input or output grain | Input grain: one row per received source order event |
| Key | `source_event_id` |
| Stage role | Raw input for standardisation and candidate selection |
| Audit columns | `source_file`, `received_at` |
| Expected issues | multiple records per order, repeated deliveries, several raw status formats, null customer ID, null amount, negative amount, zero amount, unsupported status, same timestamp tie, late-arriving record, multiple countries |

Columns: `source_event_id`, `order_id`, `customer_id`, `raw_status`, `event_timestamp`, `order_amount`, `country_code`, `source_file`, `received_at`

Validation questions:

- How many raw events were received?
- Which statuses do not map cleanly?
- Which rows have missing critical fields?
- Which orders have more than one event?
- Which rows arrived after their business event date?

## source_status_mapping.csv

| Detail | Description |
|---|---|
| Purpose | Maps raw status values to standard statuses |
| Grain | One row per raw source status |
| Key | `source_status` |
| Stage role | Reference input for standardisation |
| Audit columns | Not applicable in this small reference file |
| Expected issues | unsupported and review-required status values |

Columns: `source_status`, `standard_status`, `is_supported`, `reporting_category`, `review_required`

## staged_customer_orders.csv

| Detail | Description |
|---|---|
| Purpose | Shows candidate rows after standardisation, deduplication, and validation |
| Grain | One row per staged order candidate |
| Key | `stage_record_id` |
| Stage role | Accepted and review handoff practice |
| Audit columns | `source_event_id`, `source_file`, `received_at` |
| Expected issues | null-key review, invalid-amount review, unsupported-status review, tie review, late-arriving review |

Columns: `stage_record_id`, `order_id`, `customer_id`, `standard_status`, `order_amount`, `order_date`, `country_group`, `source_event_id`, `source_file`, `received_at`, `validation_status`, `validation_reason`

## clean_customer_orders.csv

| Detail | Description |
|---|---|
| Purpose | Represents accepted, clean order records |
| Grain | One row per clean order |
| Key | `order_id` |
| Stage role | Clean-layer handoff |
| Audit columns | `source_event_id`, `source_file`, `received_at`, `cleaned_at` |
| Expected issues | no intended duplicate order IDs |

Columns: `order_id`, `customer_id`, `order_status`, `order_amount`, `order_date`, `country_group`, `source_event_id`, `source_file`, `received_at`, `cleaned_at`

## reporting_customer_order_summary.csv

| Detail | Description |
|---|---|
| Purpose | Represents reporting-ready aggregated order metrics |
| Grain | One row per report date and country group |
| Key | `report_date`, `country_group` |
| Stage role | Reporting-layer handoff |
| Audit columns | `reporting_loaded_at` |
| Expected issues | one duplicate reporting-grain case and one null measure |

Columns: `report_date`, `country_group`, `completed_order_count`, `total_completed_amount`, `refund_order_count`, `total_refund_amount`, `pending_order_count`, `reporting_loaded_at`

## staging_handoff_cases.csv

| Detail | Description |
|---|---|
| Purpose | Documents example staging and handoff decisions |
| Grain | One row per handoff case |
| Key | `case_id` |
| Stage role | Documentation and design review |
| Audit columns | `required_audit_columns` describes expected audit fields |
| Expected issues | count mismatch, total mismatch, missing audit field, unresolved tie, unnecessary stages |

Columns: `case_id`, `stage_name`, `input_grain`, `output_grain`, `business_key`, `accepted_rule`, `review_rule`, `required_audit_columns`, `validation_check`, `downstream_handoff`, `main_risk`

## Schema Compatibility and Handoff Map

| Movement | Input Grain | Output Grain | Main Validation |
|---|---|---|---|
| Raw to standardised | One row per event | One row per event with mapped status | Source count should remain stable |
| Standardised to candidate | One row per event | One candidate row per order | Candidate key should be controlled |
| Candidate to accepted/review | One candidate row per order | Accepted plus review populations | Counts should reconcile |
| Accepted to clean | Accepted candidate rows | One clean row per order | Clean `order_id` should be unique |
| Clean to reporting | One clean row per order | One row per date and country group | Totals should reconcile |
