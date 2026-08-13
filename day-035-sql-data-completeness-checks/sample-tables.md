# Sample Tables for Day 035

Day 035 uses six CSV files to practise completeness checks across source, stage, clean, reporting, rule, and expectation datasets.

## Dataset Overview

| File | Purpose | Grain | Key | Pipeline Stage | Known Completeness Issues |
|---|---|---|---|---|---|
| `source_customer_orders.csv` | Source customer orders | One source record | `source_record_id` | Source | duplicate order, null customer, null date, null amount, blank country group, extra source record |
| `staged_customer_orders.csv` | Staged order candidates | One staged candidate | `stage_record_id` | Stage | review rows, missing required fields, stage-only record, missing source file |
| `clean_customer_orders.csv` | Clean customer orders | One clean order | `order_id` | Clean | accepted order missing, clean-only order, null country group |
| `reporting_customer_orders.csv` | Reporting order metrics | One report date and country group | `report_date`, `country_group` | Reporting | missing date, missing group, unexpected group, null metric, duplicate grain |
| `completeness_rules.csv` | Completeness rules | One rule | `rule_id` | Documentation | required field and expected-population examples |
| `expected_records_catalog.csv` | Expected records and values | One expectation | `expectation_id` | Expectations | expected orders, dates, groups, statuses, files, and required fields |

## Expected Field Examples

| Stage | Required Fields |
|---|---|
| Source | `order_id`, `customer_id`, `order_date`, `source_file` |
| Stage | `order_id`, `standard_status`, `validation_status`, `staged_at` |
| Clean | `order_id`, `customer_id`, `order_status`, `order_date`, `country_group` |
| Reporting | `report_date`, `country_group`, metric columns |

## Completeness Questions

- Which required source fields are null?
- Which fields are blank rather than null?
- Which expected clean orders are missing?
- Which clean orders are unexpected?
- Which expected reporting dates are missing?
- Which expected date-country groups are missing?
- Which expected source files are missing?
- Which reporting metric columns are null?
