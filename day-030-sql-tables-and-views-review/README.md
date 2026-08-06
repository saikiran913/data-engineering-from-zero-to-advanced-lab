# Day 030 - SQL Tables and Views Review

## Tables, Views, CTEs, Subqueries, Reusable Interfaces, and Data Engineering Workflows

Day 028 introduced views. Day 029 focused on safe view changes. Day 030 compares views with tables, CTEs, subqueries, and reporting interfaces so you can choose the right data interface for a workflow.

## Learning Objectives

By the end of Day 030, you should understand:

- what a table represents
- what a view represents
- how tables, views, CTEs, and subqueries differ
- when stored results may be appropriate
- when reusable query interfaces may be appropriate
- when a one-statement CTE is enough
- when a simple subquery is enough
- how raw, clean, and reporting layers differ
- how grain, consumers, dependencies, freshness, auditability, and history affect interface choice
- why no option is automatically best
- how to document and validate a data-interface decision

## Why Interface Choice Matters

Data engineers make interface choices when storing raw ingestion data, building cleaned reusable datasets, exposing reporting layers, running one-time validation, reducing repeated business logic, supporting dashboards, preserving audit history, and helping analysts work with stable columns.

## Required Warnings

> Tables, views, CTEs, and subqueries solve different problems. The best choice depends on persistence, reuse, grain, freshness, dependencies, consumers, and validation needs.

> A simpler interface is not automatically a better interface. Hiding complexity without documenting business rules and dependencies can make data harder to trust.

> A table or view should not be treated as business-ready only because it has a clean name. Grain, keys, filters, joins, null handling, and validation must still be documented.

> Production creation, replacement, permissions, storage design, refresh scheduling, and deployment are outside the scope of Day 030.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `review-notes.md` | Review interface concepts |
| 2 | `sample-tables.md` | Understand sample datasets |
| 3 | `sample-data/` | Inspect CSV files |
| 4 | `interface-choice-practice.sql` | Practise interface decisions |
| 5 | `table-vs-view-comparison.sql` | Compare stored rows and query definitions |
| 6 | `view-vs-cte-comparison.sql` | Compare reusable and one-query logic |
| 7 | `cte-vs-subquery-comparison.sql` | Compare readable steps and embedded logic |
| 8 | `raw-clean-reporting-layers.sql` | Study layered data thinking |
| 9 | `interface-validation-queries.sql` | Validate interfaces |
| 10 | `dependency-and-consumer-review.sql` | Review consumers and dependencies |
| 11 | `business-question-to-interface.sql` | Translate questions into choices |
| 12 | `decision-casebook.sql` | Review decision metadata |
| 13 | `mini-project.sql` | Design a small interface layer |
| 14 | `data-interface-cheatsheet.md` | Use quick reminders |
| 15 | `practice-questions.md` | Practise and check answers |
| 16 | `beginner-summary.md` and `glossary.md` | Revise key ideas |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| Table | Stores rows with a defined schema |
| View | Stores reusable query logic |
| CTE | Named query step inside one statement |
| Subquery | Query embedded inside another query |
| Persistence | Whether rows or objects remain beyond one query |
| Reusable interface | Shared way to access data or logic |
| Stored result | Rows saved by a load or creation process |
| Query definition | Logic saved or written to produce results |
| Raw layer | Source-aligned history and audit data |
| Clean layer | Standardised data with documented rules |
| Reporting layer | Consumer-focused output |
| Output grain | What one output row represents |
| Consumer | Person, report, pipeline, or query using the interface |
| Dependency | Source object or rule the interface relies on |
| Freshness | How current the output needs to be |
| Auditability | Ability to investigate source and load details |
| Validation | Checks proving the interface is trustworthy |

## Safe-Learning Note

All SQL is non-destructive. No table or view is deployed automatically. DDL examples are conceptual and clearly labelled. Implementation details, persistence behaviour, permissions, and optimiser behaviour vary by SQL platform. Focus on decision logic and validation.

## Navigation

- Previous Day: [Day 029 - SQL View Practice for Data Engineers](../day-029-sql-view-practice-change-safe-design/)
- Next Day: [Day 031 - SQL Temporary Results and Staging Concepts](../day-031-sql-temporary-results-and-staging/)
- [Back to Main Learning Path](../README.md)
