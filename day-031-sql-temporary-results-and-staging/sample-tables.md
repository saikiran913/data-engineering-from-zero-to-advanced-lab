# Sample Tables for Day 031

Day 031 uses six CSV files to model raw, staged, clean, reporting, validation-rule, and casebook layers.

| File | Purpose | Grain | Key | Stage Role | Validation Questions | Audit Columns | Downstream Use |
|---|---|---|---|---|---|---|---|
| `raw_order_events.csv` | Raw received order events | one row per received order event | `event_id`, `received_at` | raw layer | duplicates, null keys, null amount, negative amount, late receive | `source_file`, `received_at` | staged order candidates |
| `staged_orders.csv` | Selected order candidates with validation status | one row per selected order candidate | `stage_record_id` | staging layer | accepted/review counts, duplicate orders, reasons | `source_file`, `received_at` | clean orders or review queue |
| `clean_orders.csv` | Accepted clean order output | one row per clean order | `order_id` | clean layer | key uniqueness, positive amounts, status values | `source_file`, `received_at`, `cleaned_at` | reporting summary |
| `reporting_order_summary.csv` | Daily reporting output | one row per report date and country group | `report_date`, `country_group` | reporting layer | duplicate grain, null measures, totals | `reporting_loaded_at` | dashboards and reports |
| `staging_validation_rules.csv` | Rule documentation | one row per validation rule | `rule_id` | rule reference | rule coverage, severity | none | stage review |
| `pipeline_stage_casebook.csv` | Design scenarios | one row per case | `case_id` | learning casebook | risks, methods, actions | none | decision practice |

Review rows in the sample data remain visible. They are not removed from source data.
