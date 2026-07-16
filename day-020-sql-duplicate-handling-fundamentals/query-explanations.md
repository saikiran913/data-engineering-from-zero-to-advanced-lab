# Query Explanations

This file explains:

- `distinct-practice.sql`
- `duplicate-investigation-queries.sql`
- `business-key-checks.sql`
- `safe-dedup-thinking.sql`

## What DISTINCT Does

Purpose: return unique output rows for selected columns.

Table used: all sample tables.

Key checked: none; `DISTINCT` checks selected output combinations.

Expected result: repeated output combinations appear once.

Why it matters: useful for lists such as countries, statuses, methods, and source files.

## DISTINCT on One Column

Purpose: list unique values in one column.

Example: unique countries from `raw_orders_with_duplicates`.

Expected result: each country appears once.

## DISTINCT on Multiple Columns

Purpose: list unique combinations.

Example: `order_status` plus `payment_status`.

Expected result: each status combination appears once.

## What DISTINCT Does Not Do

`DISTINCT` does not deduplicate by business key automatically. If the same `order_id` has different values in selected columns, both output rows remain.

## GROUP BY and HAVING for Duplicate Investigation

Purpose: count rows by suspected key and keep groups with count greater than 1.

Table used: orders, payments, events, contacts, and campaign performance.

Expected result: repeated keys requiring review.

## Exact Duplicate Rows

Purpose: group by all important selected columns and count rows.

Expected result: rows where all selected values repeat.

Why it matters: exact duplicates often indicate retry loads or repeated file ingestion.

## Duplicate Business Keys

Purpose: find repeated identifiers such as `order_id`, `transaction_id`, `event_id`, or composite campaign keys.

Expected result: business keys that appear more than expected.

## Business Keys

A business key identifies a business record. It may be one column or several columns.

## Normal Repetition

Some repetition is expected:

- `customer_id` in orders
- `user_id` in events
- `campaign_id` across dates
- `order_id` across payment attempts

## Suspicious Repetition

Repeated `transaction_id`, repeated `event_id`, or repeated campaign/date/channel/country can be suspicious.

## Source File Investigation

`source_file` helps identify retry files, repeated loads, and late-arriving corrections.

## Duplicates After UNION ALL

Rows remain visible after `UNION ALL`. This is useful for raw ingestion because duplicate source records are not hidden.

## Duplicate-Looking Rows After Joins

One-to-many relationships can repeat values after joins. A customer appearing in many order rows may be normal.

## Safe Deduplication Thinking

Day 020 investigates duplicates but does not remove them. Safe deduplication requires business rules, source investigation, and documented keep logic.

## How Data Engineers Use These Queries

Data engineers use duplicate checks for dashboard validation, pipeline investigation, source troubleshooting, staging table checks, business-ready layer design, and deduplication rule documentation.
