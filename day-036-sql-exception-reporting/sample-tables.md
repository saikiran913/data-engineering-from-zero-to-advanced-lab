# Sample Tables for Day 036

Day 036 uses six CSV files to practise investigation-friendly exception reporting.

## Dataset Overview

| File | Purpose | Grain | Key | Known Exception Scenarios | Useful Investigation Fields |
|---|---|---|---|---|---|
| `source_order_data.csv` | Source order records | One source record | `source_record_id` | duplicate order, null customer, null amount, negative amount, unsupported status, source-only order | `source_file`, `extracted_at`, `order_date` |
| `clean_order_data.csv` | Clean order output | Intended one row per order | `order_id` | duplicate order, clean-only order, amount mismatch, status mismatch, null country group | `source_file`, `cleaned_at` |
| `reporting_order_data.csv` | Reporting metrics | One report date and country group | `report_date`, `country_group` | duplicate reporting grain, missing group, unexpected group, incorrect totals, null metric | `reporting_loaded_at` |
| `exception_rule_catalog.csv` | Rule reference | One rule | `rule_id` | severity and category examples | `review_message` |
| `expected_reporting_catalog.csv` | Expected reporting groups | One expected report group | `expectation_id` | missing and unexpected reporting groups | `review_note` |
| `exception_casebook.csv` | Scenario guide | One case | `case_id` | record, metric, stage, info, review, high review cases | `investigation_context` |

## Shared Exception Output Shape

| Column | Meaning |
|---|---|
| `exception_level` | Record, metric, or stage |
| `stage_name` | Where the issue was found |
| `entity_key` | Affected order, group, file, or metric |
| `issue_category` | Stable issue family |
| `issue_type` | Specific issue |
| `expected_value` | What was expected |
| `actual_value` | What was observed |
| `difference_value` | Numeric or text difference when useful |
| `severity` | Rule-based review priority |
| `source_file` | Source lineage where available |
| `record_date` | Business or reporting date |
| `review_message` | Investigation-friendly explanation |
