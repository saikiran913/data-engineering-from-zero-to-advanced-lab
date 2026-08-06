# Day 028 - SQL Views for Data Engineers

## Reusable Queries, Clean Interfaces, Reporting Layers, Validation, and Dependencies

Day 028 introduces SQL views. Days 024 to 027 focused on logic inside one SQL statement, especially window functions and validation. Day 028 moves one step further: it shows how a useful query can be saved as a named, reusable query definition.

A CTE lasts for one statement. A view can be referenced by later statements, like a table in a `SELECT`.

## Learning Objectives

By the end of Day 028, you should understand:

- what a SQL view is
- what `CREATE VIEW` does
- why a view can be queried like a table
- why the underlying query still matters
- why a standard view usually stores logic, not copied rows
- how views differ from tables, CTEs, subqueries, and materialized views
- how to create simple, joined, aggregated, and CTE-based views
- how to expose clean columns and stable aliases
- why every view needs a documented output grain
- why audit columns and dependency notes matter
- why `SELECT *` is risky in reusable views
- how to validate row counts, uniqueness, nulls, totals, and business rules
- when a view is useful and when a simpler query may be better

## Why Views Matter for Data Engineers

Views help data engineers expose a clean interface over raw or complex data. They can hide unnecessary source complexity, standardise business logic, reduce repeated joins, present stable column names, simplify analyst queries, and create consistent validation targets.

Views often support clean, semantic, and reporting layers. They do not create a complete reporting system by themselves, but they can provide a practical bridge between raw tables and business-ready outputs.

## Required Warnings

> A standard SQL view usually stores a query definition, not a separate copy of the source rows. The result is evaluated from the underlying objects when the view is queried, although platform behaviour can vary.

> A view can simplify access to data, but it does not automatically improve performance, guarantee data quality, or enforce the correct business rule.

> Views depend on underlying tables, columns, and other views. Upstream schema or logic changes can break a view or change its results.

> A view may help limit exposed columns or simplify access, but security and permission behaviour varies by SQL platform. Do not assume that creating a view alone provides complete data protection.

## Suggested Learning Order

| Order | File | Purpose |
|---|---|---|
| 1 | `notes.md` | Learn the core view concepts |
| 2 | `sample-tables.md` | Understand the sample data |
| 3 | `sample-data/` | Inspect the CSV source files |
| 4 | `view-concept.sql` | Study the first view definition |
| 5 | `simple-view-practice.sql` | Create single-source view examples |
| 6 | `joined-view-practice.sql` | Study view joins and grain risks |
| 7 | `aggregated-view-practice.sql` | Build summary views |
| 8 | `cte-based-view-practice.sql` | Use CTEs inside view definitions |
| 9 | `reporting-layer-views.sql` | Design clean reporting interfaces |
| 10 | `view-validation-queries.sql` | Validate views against source logic |
| 11 | `view-dependency-review.sql` | Review upstream dependencies |
| 12 | `safe-view-design-patterns.sql` | Learn safer design patterns |
| 13 | `view-cheatsheet.md` | Use quick templates |
| 14 | `practice-questions.md` | Practise and check answers |
| 15 | `beginner-summary.md` and `glossary.md` | Revise the lesson |

## Main Concepts

| Concept | Simple Meaning |
|---|---|
| View | A named reusable query definition |
| View definition | The SQL logic saved behind a view name |
| Base table | A source table used by the view |
| Derived column | A calculated or renamed output column |
| Dependency | A source object or column the view relies on |
| Reporting layer | A cleaner interface for reports and analysts |
| Clean interface | A view with intentional columns and names |
| Output grain | What one view row represents |
| Audit column | A column such as `updated_at` or `source_file` used for investigation |
| Schema stability | Keeping column names and meanings reliable for consumers |
| Consumer | A person, report, or query that uses the view |
| Materialized view | A special view-like object that may store results physically |
| Reusable query | SQL logic that can be referenced again |
| Business rule | The agreed rule behind filters, joins, or calculations |

## Safe-Learning Note

The SQL files define examples only. No database object is deployed by this repository. No source data is modified. View definitions should be reviewed before execution, and existing object names must be checked before creating a view. Production permissions, ownership, and replacement behaviour require platform-specific review.

Exact `CREATE VIEW` syntax, permissions, replacement behaviour, naming rules, and ordering behaviour vary across SQL platforms.

## Navigation

- Previous Day: [Day 027 - SQL Window Function Review](../day-027-sql-window-function-review/)
- Next Day: [Day 029 - SQL View Practice for Data Engineers](../day-029-sql-view-practice-change-safe-design/)
- [Back to Main Learning Path](../README.md)
