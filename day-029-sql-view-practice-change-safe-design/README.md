# Day 029 - SQL View Practice for Data Engineers

## Dependency Checks, Reporting Validation, Regression Checks, and Change-Safe Design

Day 028 introduced SQL views as reusable query definitions. Day 029 treats views as shared data interfaces. A shared interface has upstream dependencies, downstream consumers, column contracts, grain expectations, and validation needs.

## Learning Objectives

By the end of Day 029, you should understand:

- what a view dependency is
- what an upstream dependency is
- what a downstream consumer is
- why views act like interfaces
- why column names and meanings form a contract
- how to document source objects, consumers, and output grain
- how to validate row counts, keys, nulls, totals, and dates
- how to compare old and new view outputs
- how to identify breaking and lower-risk changes
- why joins, filters, aggregations, and grain changes need careful review
- why adding a column can still affect `SELECT *` consumers
- how to build regression-style validation summaries
- why production changes need controlled review outside this lesson

## Why Change-Safe View Design Matters

A view change can make a dashboard stop loading, change a report total unexpectedly, break a query with a renamed column, duplicate rows after a join, remove records after a filter change, alter totals after a grain change, or spread impact through a view-on-view dependency chain.

## Required Warnings

> A view is a reusable data interface. Changing its columns, grain, filters, joins, or business logic can affect downstream reports and users even when the SQL still runs successfully.

> Adding a column may look harmless, but consumers that rely on SELECT * or fixed column positions can still be affected.

> A successful query is not proof that a view change is safe. Compare old and new outputs using row counts, keys, nulls, totals, and representative samples.

> View changes should be reviewed, tested, documented, and communicated before production deployment. Day 029 covers the SQL review concepts only, not deployment workflows.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Learn view-change safety concepts |
| 2 | `sample-tables.md` | Understand the source and metadata files |
| 3 | `sample-data/` | Inspect the CSV data |
| 4 | `dependency-checks.sql` | Map dependencies and consumers |
| 5 | `reporting-validation.sql` | Validate reporting outputs |
| 6 | `old-vs-new-view-comparison.sql` | Compare old and proposed logic |
| 7 | `column-contract-validation.sql` | Review column contracts |
| 8 | `grain-and-key-validation.sql` | Validate output grain and keys |
| 9 | `join-change-impact.sql` | Study join-change risks |
| 10 | `filter-change-impact.sql` | Study filter-change risks |
| 11 | `aggregation-change-impact.sql` | Study aggregation-change risks |
| 12 | `change-safe-view-patterns.sql` | Learn safer patterns |
| 13 | `regression-review-workflow.sql` | Complete an end-to-end review |
| 14 | `view-change-cheatsheet.md` | Use quick templates |
| 15 | `practice-questions.md` | Practise and review answers |
| 16 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Upstream dependency | Source table, column, view, type, or grain used by a view |
| Downstream consumer | Report, extract, query, application, or view that uses a view |
| Column contract | Expected column names, meanings, types, and null behaviour |
| Breaking change | A change that may stop or alter consumer results |
| Lower-risk change | A change that still needs review but is less likely to break consumers |
| Regression check | A check that compares expected old behaviour with proposed new behaviour |
| Output grain | What one row represents |
| Business key | Column or columns expected to identify a row |
| Reconciliation | Comparing totals between old and new logic |
| Representative sample | Small row-level sample used to inspect actual differences |
| Change impact | What may happen because of a proposed view change |
| Consumer-safe design | Designing changes with consumers and validation in mind |
| Dependency chain | A path from sources through views to consumers |
| Reporting validation | Checks that help confirm a report-facing view is trustworthy |

## Safe-Learning Note

No production view is changed. SQL files contain examples and comparison queries only. No object is dropped or replaced. Deployment is outside scope. Change safety always requires platform and team review in real environments.

Metadata inspection and view-replacement syntax vary across SQL platforms.

## Navigation

- Previous Day: [Day 028 - SQL Views for Data Engineers](../day-028-sql-views-for-data-engineers/)
- Next Day: [Day 030 - SQL Tables and Views Review](../day-030-sql-tables-and-views-review/)
- [Back to Main Learning Path](../README.md)
