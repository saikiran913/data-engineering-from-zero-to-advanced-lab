# Day 035 - SQL Data Completeness Checks

## Required Fields, Missing Keys, Expected Records, Date Coverage, and File Coverage

Day 034 checked control totals. Day 035 asks whether all expected data is present. Completeness is one validation dimension, not the whole definition of data quality.

Completeness means more than "the table has rows". A dataset can have rows and still be missing required fields, expected keys, dates, categories, files, or reporting groups.

## Learning Objectives

By the end of Day 035, you should understand:

- what data completeness means
- the difference between field completeness and record completeness
- why required columns need explicit rules
- why null counts and blank-string checks matter
- how to detect missing business keys and unexpected extra records
- how to compare expected and actual key populations
- how to validate date, category, status, and source-file coverage
- how to detect missing expected dates without recursive date generation
- how to calculate simple completeness percentages safely
- how to avoid divide-by-zero errors
- how to separate expected exclusions from unexplained gaps
- how to create completeness exception outputs and summaries
- why completeness checks should remain read-only

## Why Completeness Matters

Data engineers use completeness checks to identify missing business keys, required-field nulls, missing reporting dates, missing source files, missing categories, dropped records between stages, accepted rows missing from clean output, missing reporting groups, and clear review queues.

## Required Warnings

> Completeness checks answer whether expected data is present. They do not prove that the values themselves are correct.

> A null is not automatically an error. Whether a field is required depends on the business rule for that column and dataset grain.

> Missing records must be interpreted in context. Some rows may be intentionally excluded by documented filters, deduplication, or review rules.

> Completeness checks should identify gaps and exceptions for investigation. They should not invent missing values or automatically modify source data.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Learn completeness concepts |
| 2 | `sample-tables.md` | Understand sample data and expected records |
| 3 | `sample-data/` | Inspect CSV files |
| 4 | `required-field-completeness.sql` | Check required fields |
| 5 | `missing-key-checks.sql` | Find source-only and target-only keys |
| 6 | `expected-record-checks.sql` | Compare expected and actual records |
| 7 | `date-coverage-checks.sql` | Validate expected dates |
| 8 | `category-and-status-coverage.sql` | Validate category and status coverage |
| 9 | `source-file-completeness.sql` | Validate expected source files |
| 10 | `stage-completeness-reconciliation.sql` | Reconcile stage completeness |
| 11 | `completeness-percentages.sql` | Calculate safe coverage percentages |
| 12 | `completeness-exception-reporting.sql` | Build exception reports |
| 13 | `completeness-summary.sql` | Build completeness summary |
| 14 | `completeness-debugging-lab.sql` | Debug misleading checks |
| 15 | `integrated-completeness-workflow.sql` | Run an integrated workflow |
| 16 | `completeness-cheatsheet.md` | Review reusable patterns |
| 17 | `practice-questions.md` | Complete self-study questions |
| 18 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Files

| File | Purpose | Recommended Order |
|---|---|---|
| `README.md` | Day 035 landing page | 1 |
| `notes.md` | Detailed completeness notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `required-field-completeness.sql` | Null and blank required-field checks | 4 |
| `missing-key-checks.sql` | Missing and unexpected key checks | 5 |
| `expected-record-checks.sql` | Expected-versus-actual records | 6 |
| `date-coverage-checks.sql` | Date coverage checks | 7 |
| `category-and-status-coverage.sql` | Status and category coverage | 8 |
| `source-file-completeness.sql` | Source-file coverage | 9 |
| `stage-completeness-reconciliation.sql` | Stage completeness comparison | 10 |
| `completeness-percentages.sql` | Safe percentage calculations | 11 |
| `completeness-exception-reporting.sql` | Completeness exception queue | 12 |
| `completeness-summary.sql` | Summary evidence | 13 |
| `completeness-debugging-lab.sql` | Debugging practice | 14 |
| `integrated-completeness-workflow.sql` | End-to-end workflow | 15 |
| `query-explanations.md` | SQL explanations | 16 |
| `completeness-cheatsheet.md` | Quick reference | 17 |
| `completeness-rule-design-guide.md` | Rule design guide | 18 |
| `common-mistakes.md` | Common mistakes | 19 |
| `real-world-examples.md` | Generic scenarios | 20 |
| `beginner-summary.md` | Plain-language recap | 21 |
| `glossary.md` | Alphabetical glossary | 22 |
| `practice-questions.md` | Questions and answer key | 23 |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Completeness | Expected data is present |
| Required field | A column that must be populated by rule |
| Optional field | A column where missing values may be allowed |
| Missing key | Expected business key not found |
| Expected record | Record that should exist |
| Actual record | Record found in the dataset |
| Date coverage | Expected dates are represented |
| Category coverage | Expected groups or categories are represented |
| Source-file coverage | Expected files are represented |
| Completeness percentage | Matched expected records divided by expected records |
| Expected exclusion | Missing row explained by a documented rule |
| Unexplained gap | Missing or extra data needing review |
| Completeness exception | Evidence row for a gap |
| Completeness summary | Compact status of checks |

## Safe-Learning Note

All executable SQL is read-only. No missing values are generated or filled automatically. Missing records are reviewed rather than invented. Completeness rules require business context. Production alerting, automated quality tooling, scheduling, and backfill remain out of scope.

Blank-string handling, date casting, multi-column distinct syntax, and percentage casting vary across platforms. Day 035 keeps examples simple and portable where possible.

## Navigation

- Previous Day: [Day 034 - SQL Control Totals for Data Engineers](../day-034-sql-control-totals/)
- Next Day: [Day 036 - SQL Exception Reporting: Review Queues, Severity Levels, and Investigable Data-Quality Outputs](../day-036-sql-exception-reporting/)
- [Back to Main Learning Path](../README.md)
