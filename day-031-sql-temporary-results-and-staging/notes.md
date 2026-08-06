# Day 031 Notes - Temporary Results and Staging Concepts

## What Is an Intermediate Result?

An intermediate result is data produced between a source and a final output. It may exist only during one query, or it may be saved temporarily or persistently in real systems. It should always have a clear purpose.

## What Is Staging?

Staging is an intermediate area where data is prepared for downstream work. It may standardise names, types, timestamps, or keys. It may preserve source history and audit fields. It should not silently apply undocumented business rules.

## Raw Versus Staged Versus Clean Versus Reporting

| Layer | Main Purpose | Typical Grain | Main Validation |
|---|---|---|---|
| Raw | Preserve source-aligned data | one row per received event | source count, duplicate delivery, audit fields |
| Staging | Prepare and classify rows | one row per selected candidate | accepted count, review count, keys, nulls |
| Clean | Expose trusted business rows | one row per clean entity | uniqueness, valid values, totals |
| Reporting | Serve consumer metrics | one row per report grain | grouped totals, date coverage, duplicate reporting keys |

## CTE as an Intermediate Result

A CTE is a named step inside one SQL statement. It is easy to validate and useful for modelling a stage, but it is not persistent.

## Subquery as an Intermediate Result

A subquery is an embedded step. It is useful for small logic, but deeply nested subqueries can become hard to read.

## Temporary Table Concept

A temporary table concept means storing intermediate data for short-term use. Scope, naming, cleanup, and syntax vary by platform. Day 031 does not teach executable temporary-table commands.

## Staging Table Concept

A staging table concept is usually more persistent than a temporary result and may be part of a pipeline. It requires ownership, lifecycle rules, auditability, and validation.

## Intermediate Grain

Intermediate grain might be one row per source event, one row per order version, one row per current order, one row per customer-day, or one row per reporting period.

## Handoff Contract

Each stage should define input object, input grain, output grain, required columns, business key, filters, accepted criteria, review criteria, audit columns, validation checks, and downstream consumer.

## Validation Checkpoints

Useful checks include source count, accepted count, review count, duplicate count, null count, distinct-key count, total reconciliation, minimum and maximum dates, and status distribution.

## Accepted and Review Outputs

Accepted rows continue to the next stage. Review rows remain visible with an issue reason. Review does not mean deleted.

## Audit Columns

Useful audit columns include `source_file`, `received_at`, `loaded_at`, `updated_at`, `record_version`, `validation_status`, and `validation_reason`.

## Stage Naming

Prefer clear names such as `raw_orders`, `staged_orders`, `clean_orders`, `order_review_queue`, and `daily_order_summary`. Avoid vague names such as `temp1`, `data2`, `final_final`, and `new_table`.

## Stage-Level Validation Workflow

1. Inspect source.
2. Define source grain.
3. Create stage query.
4. Validate stage count.
5. Validate duplicates.
6. Validate nulls.
7. Separate accepted and review rows.
8. Define clean output.
9. Reconcile totals.
10. Define reporting output.
11. Validate reporting grain.
12. Document handoff.

## Temporary Result Versus Staging Table

| Feature | Temporary Result Concept | Staging Table Concept |
|---|---|---|
| Persistence | short-lived or one workflow | more persistent in pipeline design |
| Reuse | limited | reusable by later steps |
| Auditability | varies | should be designed |
| Ownership | often local to query/process | should be defined |
| Cleanup | platform-specific | lifecycle-specific |
| Common use | debugging or repeated step | controlled pipeline handoff |

## Common Mistakes

Common mistakes include staging without purpose, copying raw data without documentation, losing audit columns, silently removing suspicious rows, no grain definition, no accepted-versus-review split, no validation checkpoint, aggregating before deduplication, joining before standardisation, comparing counts at different grains, no total reconciliation, vague stage names, too many tiny stages, and one giant unreadable stage.

## Platform Note

Actual temporary and staging implementations vary across SQL platforms.
