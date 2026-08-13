# Day 034 Notes - SQL Control Totals

## What Is a Control Total?

A control total is a simple validation metric calculated on a defined population and compared with another stage or expected value.

Examples include row count, distinct order count, sum of amount, minimum date, maximum date, count by status, and count by source file.

## Why Control Totals Are Useful

Control totals are simple to understand, easy to repeat, easy to compare, useful before deeper row-level investigation, and useful as checkpoint evidence.

## Count Controls

| Function | Meaning | Beginner Reminder |
|---|---|---|
| `COUNT(*)` | Counts all rows | Includes rows with null values |
| `COUNT(column)` | Counts non-null values in that column | Null values are excluded |
| `COUNT(DISTINCT column)` | Counts unique non-null values | Useful for business keys |

## Distinct-Key Controls

A distinct-key control validates business-key coverage. Row count and distinct-key count answer different questions. A source can have 25 rows and 24 distinct orders if one order is duplicated.

Composite keys use more than one column. Reporting grain may be `report_date` plus `country_group`. Multi-column distinct syntax varies, so grouped checks are safer for beginner examples.

## Sum Controls

Sum controls compare numeric totals across stages:

- source amount total
- accepted amount total
- clean amount total
- reporting completed amount
- reporting refund amount

Filters must align. A clean completed amount should be compared with reporting completed amount, not all reporting measures.

## Boundary Controls

Boundary controls use `MIN` and `MAX`.

Examples:

- `MIN(order_date)`
- `MAX(order_date)`
- `MIN(order_amount)`
- `MAX(order_amount)`

Boundaries can reveal missing, shifted, future, or abnormal populations.

## Grouped Controls

Grouped controls compare by date, country group, status, source file, or reporting category. A matching grand total can hide values shifted between groups.

## Stage Reconciliation

| Stage Pair | Expected Relationship |
|---|---|
| Source to stage | May differ because of deduplication and review logic |
| Stage to clean | Accepted rows should usually explain clean rows |
| Clean to reporting | Row counts usually differ because reporting is aggregated |

## Exact-Match Relationships

Examples:

- accepted stage count should equal clean count when clean contains every accepted row exactly once
- completed clean amount should equal reporting completed amount when filters and grouping align

## Expected-Difference Relationships

Examples:

- raw row count is greater than staged distinct-order count because duplicates are removed
- stage count equals accepted plus review
- reporting row count is less than clean row count because reporting is aggregated

## Reconciliation Difference

```text
difference = target control - source control
```

A positive difference means the target control is larger. A negative difference means the target control is smaller.

## Nulls and Controls

`COUNT(column)` ignores nulls. `COUNT(*)` counts rows. `SUM` may return null if there are no rows, depending on platform and context. Use `COALESCE` only when the business meaning is clear.

## Tolerance Concept

Some controls require exact match. Others may allow an approved tolerance or expected business variance. Do not invent thresholds inside SQL.

## Safe Control-Total Workflow

1. Define source population.
2. Define target population.
3. Define grain.
4. Define business key.
5. Align filters.
6. Align date range.
7. Select control.
8. Define expected relationship.
9. Calculate source control.
10. Calculate target control.
11. Calculate difference.
12. Inspect grouped controls.
13. Create exception output.
14. Document result.

## Common Mistakes

- wrong source population
- wrong target population
- mismatched filters
- mismatched date range
- comparing different grains
- using only row count
- not checking distinct keys
- grand total without grouped total
- using `COUNT(column)` without realising nulls are excluded
- using `SUM` without null review
- wrong sign interpretation
- no boundary checks
- no source-file controls
- arbitrary tolerance
- treating expected difference as failure
- treating unexplained difference as acceptable
