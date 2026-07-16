# Beginner Summary

Day 019 introduces SQL set operations for the first time. A set operation combines the results of multiple `SELECT` queries. This lesson focuses only on `UNION` and `UNION ALL`, because these are the most common beginner patterns for combining similar datasets.

Similar datasets are often stored separately in data engineering. A company might receive one order file per region, one file per month, one campaign table per channel, or one website event export split into multiple parts. Each file may have the same columns and the same business meaning, but the rows are stored separately. `UNION` and `UNION ALL` solve this by stacking rows vertically into one result.

Vertical combination means rows from one dataset are placed above or below rows from another dataset. This is different from a `JOIN`. A `JOIN` connects related columns from different tables, usually through matching keys. A `UNION` stacks similar rows. Regional order files are a good example: UK orders and India orders have the same order columns, so they can be stacked into one combined order result.

`UNION ALL` combines multiple query results and keeps every row. If the same row appears twice, both copies remain. This is why data engineers often prefer `UNION ALL` for raw ingestion and staging work. At that stage, every source record should be preserved. Duplicate rows may be a data quality issue, but hiding them too early can make investigation harder.

`UNION` also combines query results, but it removes exact duplicate output rows. Exact duplicate means every selected output value is the same. If two rows have the same `order_id` but different `order_amount`, they are not exact duplicates. `UNION` keeps both rows. This is a critical distinction: `UNION` is not key-based deduplication. It does not automatically keep one row per business key. Safe business-key deduplication will be covered in a later lesson.

For `UNION` operations to work correctly, each `SELECT` must return the same number of columns. The columns must also be in the same logical order. SQL matches columns by position, not by name. If the first query selects `order_id`, `order_date`, and `order_amount`, the second query should use that same logical order. Placing `order_amount` underneath `order_date` creates incorrect output or errors.

Corresponding columns also need compatible data types. IDs should align with IDs, dates with dates, amounts with amounts, and text statuses with text statuses. Some SQL platforms try to convert mismatched values automatically, while others reject the query. The safer habit is to align columns explicitly.

The first `SELECT` normally controls the final output column names. If the first query uses `order_id AS combined_order_id`, the combined result uses that name, even if later queries use a different alias.

Source labels are important in data engineering. Adding values such as `'UK' AS source_region`, `'january_orders.csv' AS source_file`, or `'Search' AS source_channel` helps trace where each row came from. This supports validation, troubleshooting, and lineage.

Day 019 practises regional data combination, monthly file combination, campaign channel combination, and website event file combination. It also introduces validation checks: count source rows, check date coverage, inspect missing values, look for repeated IDs, and confirm schemas before combining.

Before Day 020, remember this: use `UNION ALL` when you need to preserve all source records, use `UNION` only when exact duplicate output row removal is intentional, keep schemas aligned, add source labels, and validate row counts before trusting combined datasets.
