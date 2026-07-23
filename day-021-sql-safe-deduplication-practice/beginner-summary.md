# Beginner Summary

Day 021 moves from duplicate investigation into safe duplicate resolution thinking. Day 020 showed how to find repeated keys and inspect duplicate-looking records. Day 021 introduces `ROW_NUMBER`, which helps choose one row from a duplicate group when a business rule has already been defined.

The most important idea is simple: investigate first. A repeated record may be accidental, but it may also be a valid status history, a late-arriving correction, a retried event, a reprocessed file, or a newer version of the same business record. If rows are removed before the reason is understood, useful history can be lost.

`ROW_NUMBER` is a window function. In this lesson, that means it looks across related rows and assigns a sequence number to each row without collapsing the rows into one summary. `PARTITION BY` creates the related groups. If the business key is `order_id`, then all versions of the same order are placed into one group. Numbering restarts for each order.

`ORDER BY` inside `ROW_NUMBER` decides which row receives number 1. If the rule is to keep the latest order version, the query may order by `updated_at DESC` and then `loaded_at DESC`. If the rule is to keep the earliest event, the query may order by `event_timestamp ASC`. The ordering direction must match the business rule.

A tie-breaker matters when two rows have the same main ordering value. If two order versions have the same `updated_at`, `loaded_at` can help decide which arrived later. If no reliable tie-breaker exists, the record group should be reviewed rather than automatically resolved.

Some rules are not simple latest or earliest rules. Payment data is a common example. A business may prefer `SUCCESS` over `PENDING`, `FAILED`, or `REFUNDED`, even when timestamps are close together. In SQL, a `CASE` expression inside the window ordering can implement that documented status priority.

The mental model is: place all versions of one order into one folder, sort that folder according to the rule, number the records from 1, then review whether record 1 is genuinely the intended record. Repeat that for each business key.

Raw history should remain available. The raw layer preserves what arrived from the source. The clean layer applies documented rules. The business-ready layer exposes trusted selected records. Keeping audit columns such as `source_file`, `loaded_at`, and original timestamps helps explain decisions later.

After selecting records, validate the output. Check that there is one selected row per business key where expected, review unresolved ties, and reconcile important totals. A deduplicated output is only useful if the rule is correct and testable.

Final warning: ROW_NUMBER can help select one record per duplicate group, but it does not decide the correct business rule by itself. The business rule decides what should be kept. ROW_NUMBER only helps implement that rule.

Day 022 will introduce SQL subqueries for data engineers. Day 021 already uses simple CTE or subquery-style patterns to filter ranked rows, and Day 022 will expand the learner's ability to build queries in stages.
