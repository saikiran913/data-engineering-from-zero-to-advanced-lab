# Day 019 Notes

## Set Operation

A set operation combines the results of two or more `SELECT` queries. Day 019 focuses only on `UNION` and `UNION ALL`.

## Vertical Combination

Vertical combination means stacking rows from similar datasets. It is useful when files have the same business meaning and the same output columns.

## UNION ALL

`UNION ALL` keeps every row from every source. Data engineers often use it for raw ingestion because it preserves row counts and makes duplicates visible.

## UNION

`UNION` removes exact duplicate output rows. It compares all selected output values. It does not remove rows just because the same ID appears twice.

## Requirements

- Same number of selected columns.
- Same logical column order.
- Compatible data types in matching positions.
- Explicit column lists are safer than `SELECT *`.

## Column Names

The first `SELECT` normally controls final output column names. Later aliases do not usually rename the final result.

## Source Labels

Use constant labels such as:

- `'UK' AS source_region`
- `'january_orders.csv' AS source_file`
- `'Search' AS source_channel`

Labels support lineage, validation, and troubleshooting.

## Common Uses

- Combine regional files.
- Combine monthly files.
- Combine daily batch files.
- Combine campaign channel datasets.
- Combine website event file parts.
- Combine historical and current datasets.

## Filters

Each `SELECT` can have its own `WHERE` filter. The filters apply before rows are combined.

## ORDER BY and LIMIT

Put final `ORDER BY` and `LIMIT` at the end of the combined query.

## Validation

Before combining, check source row counts, date coverage, missing keys, duplicate-looking keys, and schema compatibility. After combining, compare expected row behaviour. `UNION ALL` should keep all rows. `UNION` may return fewer rows if exact duplicate output rows exist.

## Schema Standardisation

Use aliases to align different source names. Use `NULL AS column_name` when a source lacks a column and a placeholder is appropriate.

## UNION vs JOIN

`UNION` stacks similar rows. `JOIN` connects related columns. They solve different problems.
