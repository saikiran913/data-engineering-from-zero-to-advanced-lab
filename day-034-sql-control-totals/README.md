# Day 034 - SQL Control Totals for Data Engineers

## Counts, Sums, Boundaries, Stage Reconciliation, and Validation Evidence

Day 033 reviewed broad pipeline validation. Day 034 zooms in on control totals: compact validation metrics that help confirm whether stage changes are expected.

A control total is useful only when the source population, target population, grain, filters, grouping, and expected relationship are clear.

## Learning Objectives

By the end of Day 034, you should understand:

- what a control total is and why it matters
- the difference between row counts and distinct-key counts
- when `COUNT(*)`, `COUNT(column)`, and `COUNT(DISTINCT column)` are appropriate
- why multi-column key counts need portable grouped patterns
- how `SUM` validates numeric measures
- how `MIN` and `MAX` validate boundaries
- how date and value boundaries reveal missing, shifted, or unusual data
- how status, country, and source-file counts work as controls
- how to reconcile source to stage, stage to clean, and clean to reporting
- how accepted and review populations should reconcile
- how grouped totals reveal issues hidden by grand totals
- how to calculate reconciliation differences
- how to identify exact-match controls and expected-difference controls
- why tolerances should not be invented
- why failed checks should lead to investigation, not automatic correction

## Why Control Totals Matter

Control totals help data engineers confirm that a file loaded completely, deduplication removed the expected number of rows, accepted plus review populations reconcile, numeric totals remain explainable, reporting aggregates match clean data, date boundaries are correct, grouped totals make sense, and stage differences are documented.

## Required Warnings

> A control total is only meaningful when the source population, target population, grain, filters, and expected relationship are defined consistently.

> Matching one total does not prove that all records are correct. A grand total can match while individual groups, keys, dates, or categories are wrong.

> Differences are not automatically failures. Deduplication, review exclusions, business filters, and aggregation can create expected differences that must be documented.

> Control totals should produce validation evidence. They should not automatically modify source or target data.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Learn control-total concepts |
| 2 | `sample-tables.md` | Understand the sample data and deliberate issues |
| 3 | `sample-data/` | Inspect CSV files |
| 4 | `count-controls.sql` | Practise row counts and accepted/review counts |
| 5 | `distinct-key-controls.sql` | Practise distinct keys and duplicate checks |
| 6 | `sum-controls.sql` | Practise amount controls |
| 7 | `boundary-controls.sql` | Practise min and max controls |
| 8 | `grouped-control-totals.sql` | Practise grouped counts and sums |
| 9 | `source-to-stage-reconciliation.sql` | Reconcile source to stage |
| 10 | `stage-to-clean-reconciliation.sql` | Reconcile stage to clean |
| 11 | `clean-to-reporting-reconciliation.sql` | Reconcile clean to reporting |
| 12 | `accepted-review-controls.sql` | Validate accepted and review populations |
| 13 | `control-total-summary.sql` | Build a control-total summary |
| 14 | `control-total-debugging-lab.sql` | Debug misleading controls |
| 15 | `integrated-control-total-workflow.sql` | Run an integrated workflow |
| 16 | `control-total-cheatsheet.md` | Review reusable patterns |
| 17 | `practice-questions.md` | Complete self-study questions |
| 18 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Files

| File | Purpose | Recommended Order |
|---|---|---|
| `README.md` | Day 034 landing page | 1 |
| `notes.md` | Detailed control-total notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `count-controls.sql` | Count controls | 4 |
| `distinct-key-controls.sql` | Distinct-key controls | 5 |
| `sum-controls.sql` | Sum controls | 6 |
| `boundary-controls.sql` | Date and value boundaries | 7 |
| `grouped-control-totals.sql` | Grouped controls | 8 |
| `source-to-stage-reconciliation.sql` | Source-stage reconciliation | 9 |
| `stage-to-clean-reconciliation.sql` | Stage-clean reconciliation | 10 |
| `clean-to-reporting-reconciliation.sql` | Clean-reporting reconciliation | 11 |
| `accepted-review-controls.sql` | Accepted/review checks | 12 |
| `control-total-summary.sql` | Summary evidence | 13 |
| `control-total-debugging-lab.sql` | Debugging practice | 14 |
| `integrated-control-total-workflow.sql` | End-to-end workflow | 15 |
| `query-explanations.md` | SQL explanations | 16 |
| `control-total-cheatsheet.md` | Quick reference | 17 |
| `control-rule-design-guide.md` | Control-rule design | 18 |
| `common-mistakes.md` | Common mistakes | 19 |
| `real-world-examples.md` | Generic scenarios | 20 |
| `beginner-summary.md` | Plain-language recap | 21 |
| `glossary.md` | Alphabetical glossary | 22 |
| `practice-questions.md` | Questions and answer key | 23 |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Control total | A simple validation metric |
| Count control | A row-count metric |
| Distinct-key control | A unique-key metric |
| Sum control | A numeric total metric |
| Boundary control | A minimum or maximum value check |
| Grouped control | A control calculated by group |
| Exact match | Source and target controls should be equal |
| Expected difference | Difference explained by documented rules |
| Unexplained difference | Difference needing review |
| Reconciliation difference | Target control minus source control |
| Source population | Input rows used in the control |
| Target population | Output rows used in the control |
| Stage reconciliation | Comparing controls between pipeline stages |
| Validation evidence | Query output that supports review |

## Safe-Learning Note

All executable SQL is read-only. No source or target data is modified. Failed checks lead to review. No arbitrary tolerance is used. Actual production thresholds require documented business rules.

Multi-column `COUNT(DISTINCT ...)`, date casting, and decimal casting vary across platforms. Day 034 uses grouped patterns where possible.

## Navigation

- Previous Day: [Day 033 - SQL Pipeline Validation Review](../day-033-sql-pipeline-validation-review/)
- Next Day: [Day 035 - SQL Data Completeness Checks](../day-035-sql-data-completeness-checks/)
- [Back to Main Learning Path](../README.md)
