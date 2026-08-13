# Day 033 - SQL Pipeline Validation Review

## Row Counts, Control Totals, Completeness, Reconciliation, and Exception Reporting

Day 032 built staged transformations and handoffs. Day 033 asks the next practical question: did the data move from source to destination correctly, completely, and in line with the documented business rules?

Validation should produce evidence, not assumptions. A query finishing successfully does not automatically mean the pipeline result is correct.

## Learning Objectives

By the end of Day 033, you should understand:

- what pipeline validation means
- why row counts matter
- why row counts alone are not enough
- what a control total is
- how numeric control totals support reconciliation
- how distinct-key counts support validation
- how duplicate keys affect trust
- how accepted and review populations should reconcile
- how to compare source and target counts
- how to compare source and target totals
- how to compare grouped totals
- how to validate date, category, source-file, key, and null completeness
- how to detect source-only and target-only records
- how to distinguish expected differences from unexplained differences
- how to create exception reports and validation summaries
- why `PASS` must be based on a clearly defined rule
- why failed checks should lead to review rather than automatic correction

## Why Pipeline Validation Matters

Data engineers validate pipelines to detect lost records, duplicate records, missing business keys, incorrect totals, missing dates, missing categories, missing source files, unmatched joins, and reporting errors. Validation also creates evidence before downstream users trust a dataset.

## Required Warnings

> Matching row counts do not prove that two datasets are equivalent. Keys, totals, completeness, duplicates, dates, categories, and representative records should also be validated.

> A difference is not automatically an error. Some differences are expected because of documented filtering, deduplication, business rules, or aggregation. Expected differences must be explained and reconciled.

> Validation thresholds and tolerances are business rules. They should be documented rather than guessed inside SQL.

> Exception reports identify records or metrics that need investigation. They should not automatically delete, overwrite, or correct source data.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Understand pipeline validation concepts |
| 2 | `sample-tables.md` | Review source, stage, clean, reporting, rule, and case files |
| 3 | `sample-data/` | Inspect the CSV inputs |
| 4 | `row-count-validation.sql` | Compare source, stage, clean, and reporting counts |
| 5 | `key-and-duplicate-validation.sql` | Check distinct keys and duplicates |
| 6 | `control-total-validation.sql` | Compare numeric totals |
| 7 | `completeness-validation.sql` | Check nulls, dates, categories, and files |
| 8 | `source-target-reconciliation.sql` | Find source-only and target-only records |
| 9 | `grouped-reconciliation.sql` | Compare totals by date, group, status, and file |
| 10 | `exception-reporting.sql` | Build record-level and metric-level exceptions |
| 11 | `validation-summary.sql` | Create a validation summary |
| 12 | `pipeline-checkpoint-review.sql` | Review validation case decisions |
| 13 | `validation-debugging-lab.sql` | Debug misleading validation results |
| 14 | `integrated-validation-workflow.sql` | Run the full validation workflow |
| 15 | `pipeline-validation-cheatsheet.md` | Review reusable patterns |
| 16 | `practice-questions.md` | Complete self-study questions |
| 17 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Files

| File | Purpose | Recommended Order |
|---|---|---|
| `README.md` | Day 033 landing page | 1 |
| `notes.md` | Detailed validation notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `row-count-validation.sql` | Row-count checks | 4 |
| `key-and-duplicate-validation.sql` | Distinct-key and duplicate checks | 5 |
| `control-total-validation.sql` | Numeric control totals | 6 |
| `completeness-validation.sql` | Null, date, category, and file completeness | 7 |
| `source-target-reconciliation.sql` | Source-only and target-only records | 8 |
| `grouped-reconciliation.sql` | Grouped metric reconciliation | 9 |
| `exception-reporting.sql` | Exception queue examples | 10 |
| `validation-summary.sql` | Validation status summaries | 11 |
| `pipeline-checkpoint-review.sql` | Casebook review queries | 12 |
| `validation-debugging-lab.sql` | Debugging practice | 13 |
| `integrated-validation-workflow.sql` | End-to-end validation workflow | 14 |
| `query-explanations.md` | SQL explanations | 15 |
| `pipeline-validation-cheatsheet.md` | Quick reference | 16 |
| `validation-rule-design-guide.md` | Rule design guidance | 17 |
| `common-mistakes.md` | Beginner mistakes and safer checks | 18 |
| `real-world-examples.md` | Generic validation scenarios | 19 |
| `beginner-summary.md` | Plain-language recap | 20 |
| `glossary.md` | Alphabetical definitions | 21 |
| `practice-questions.md` | Questions and answer key | 22 |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Validation check | A query that tests whether data meets a rule |
| Source population | Records being checked from the input side |
| Target population | Records being checked from the output side |
| Row-count reconciliation | Comparing row counts between populations |
| Distinct-key count | Counting unique business keys |
| Duplicate key | A key appearing more often than expected |
| Control total | A numeric total used as validation evidence |
| Grouped control total | A control total by date, status, file, or group |
| Completeness | Checking whether required data is present |
| Exception | A record or metric needing investigation |
| Expected difference | A documented difference caused by rules |
| Unexplained difference | A mismatch with no documented reason |
| Review queue | Exceptions preserved for investigation |
| Validation summary | A compact result showing check status and evidence |

## Safe-Learning Note

All executable SQL is read-only. No source or target data is modified. Differences are investigated rather than automatically corrected. Thresholds are examples only when used. Validation rules require business context. Production monitoring, orchestration, alerting, and automated test frameworks remain out of scope.

`COUNT(DISTINCT col1, col2)` syntax varies across SQL platforms. Day 033 uses grouped CTEs for portable multi-column distinct-key validation.

## Navigation

- Previous Day: [Day 032 - SQL Staging Practice for Data Engineers](../day-032-sql-staging-practice/)
- Next Day: [Day 034 - SQL Control Totals for Data Engineers](../day-034-sql-control-totals/)
- [Back to Main Learning Path](../README.md)
