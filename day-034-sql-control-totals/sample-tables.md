# Sample Tables for Day 034

Day 034 uses six CSV files to practise control totals across source, stage, clean, reporting, rule, and reconciliation case datasets.

## Dataset Overview

| File | Purpose | Grain | Key | Stage | Known Control-Total Issues | Useful Controls |
|---|---|---|---|---|---|---|
| `source_sales_extract.csv` | Source sales extract | One extracted source record | `source_record_id` | Source | duplicate order, null amount, zero amount, negative amount, source-only order, boundary date issue | row count, distinct order count, min/max date, status count, source-file count |
| `staged_sales_output.csv` | Staged sales output | One staged candidate, with deliberate exceptions | `stage_record_id` | Stage | accepted and review rows, duplicate candidate, changed amount, missing source file, stage-only row | accepted/review counts, amount totals |
| `clean_sales_output.csv` | Clean sales output | Intended one clean row per order | `order_id` | Clean | duplicate key, missing accepted order, amount mismatch, target-only row | row count, distinct order count, sums, boundaries |
| `reporting_sales_summary.csv` | Reporting summary | One report date and country group | `report_date`, `country_group` | Reporting | duplicate reporting key, incorrect amount total, null metric, missing group | grouped sums, report grain, null metric |
| `control_total_rules.csv` | Control rule catalogue | One control rule | `control_id` | Documentation | examples for count, sum, boundary, grouped controls | rule review |
| `reconciliation_cases.csv` | Casebook | One reconciliation scenario | `case_id` | Review | expected and unexplained differences | case selection |

## Expected Relationships

| Stage Pair | Expected Relationship |
|---|---|
| Source to stage | Differences may exist because of duplicate source records and review logic |
| Stage accepted to clean | Accepted rows should usually explain clean output |
| Clean to reporting | Counts usually differ because reporting aggregates clean rows |
| Accepted and review | Accepted plus review should equal staged rows |
| Reporting grain | One row per `report_date` and `country_group` |

## Control Questions

- Do source rows and distinct source orders tell different stories?
- Do accepted and review rows explain all staged rows?
- Do clean rows duplicate the clean business key?
- Do clean completed totals reconcile to reporting completed totals?
- Do grouped totals reveal a mismatch hidden by grand totals?
- Do min and max dates show boundary shifts?
- Does source-file distribution look complete?
