# Query Explanations

## ROW_NUMBER Concept

Business question: which version should appear first inside each duplicate group?

Source table: `raw_orders_duplicate_versions`.

Operation used: `ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY updated_at DESC)`.

Output shape: all source rows plus `row_num`.

Validation: compare all ranked rows before filtering to `row_num = 1`.

## PARTITION BY

`PARTITION BY` creates logical groups. For order deduplication, all rows with the same `order_id` are grouped together.

## ORDER BY Inside ROW_NUMBER

The `ORDER BY` inside `OVER` controls row numbering. `DESC` puts newest values first. `ASC` puts earliest values first.

## Latest Record Selection

The latest examples select one row per key using `updated_at DESC` and `loaded_at DESC`. This supports current-state outputs when newest trusted data is the business rule.

## Earliest Record Selection

The earliest examples use `ASC`. This can support original registration, first event, or first captured version use cases.

## Preferred Status

Payment examples use `CASE` in the ordering rule to prefer `SUCCESS`, then `REFUNDED`, then `PENDING`, then `FAILED`. This is an example business preference, not a universal truth.

## Tie-Breakers

Tie-breakers such as `loaded_at` reduce ambiguity when two versions share the same primary timestamp. If no reliable tie-breaker exists, the group should be reviewed.

## Review Flags

Review flags label rows as `KEEP`, `OLDER_VERSION`, or `REVIEW`. They make the query safer because learners can inspect actions before any production rule is applied.

## Composite Business Keys

Campaign metrics use `campaign_id`, `performance_date`, `channel`, and `country` together. Every key column must be included in `PARTITION BY`.

## Validation

Validation queries count duplicate groups, find timestamp ties, check selected uniqueness, and identify groups requiring business review.

## Raw and Clean Layers

The SQL files return selected outputs but do not modify raw data. Raw data remains available for audit and rule changes.
