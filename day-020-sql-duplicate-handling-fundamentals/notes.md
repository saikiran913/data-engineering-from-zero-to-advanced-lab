# Day 020 Notes

## Duplicate

A duplicate means a record or value appears more than expected. Expected uniqueness depends on business rules and table grain.

## Exact Duplicate Row

An exact duplicate row has the same values in every selected column. Exact duplicates often come from retry loads or loading the same file twice.

## Duplicate Business Key

A duplicate business key means the expected identifying column appears more than once. Examples include repeated `order_id`, `transaction_id`, or `event_id`.

## Normal Repetition

Repeated values are not always wrong:

- one customer can have many orders
- one user can create many website events
- one order can have multiple payment attempts
- one campaign can have rows for many dates

## DISTINCT

`DISTINCT` returns unique output rows for the selected columns. It does not automatically keep one row per business key.

## GROUP BY and HAVING

Use `GROUP BY` with `COUNT(*)` to count rows per key. Use `HAVING COUNT(*) > 1` to show repeated keys.

## Business Key

A business key identifies a business record. It can be one column or multiple columns.

## Composite Key

A composite key uses multiple columns. Campaign performance may be unique by `performance_date`, `campaign_id`, `channel`, and `country`.

## Source File

`source_file` helps trace where a row came from. It is important when duplicate rows come from retry loads or repeated file ingestion.

## Safe Deduplication Thinking

Do not remove raw records blindly. First identify the key, count repeats, inspect records, compare values, check source information, ask whether repetition is expected, and document the rule.
