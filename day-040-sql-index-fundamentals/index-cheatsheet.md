# Day 040 Index Cheatsheet

## Index Mental Model

An index is an additional access structure that may help the database find rows for some query patterns. It does not change query meaning.

## Good Candidate Signals

- frequent lookup
- frequent join
- useful selectivity
- important workload
- large enough table
- stable query pattern

## Caution Signals

- write-heavy table
- low-cardinality column
- rare query
- small table
- overlapping indexes
- warehouse platform
- no query-plan evidence yet

## Single-Column Candidate Checklist

| Question | Why it matters |
|---|---|
| Is the column filtered often? | Workload frequency matters |
| Is the query important? | Important queries deserve more attention |
| Is selectivity useful? | Narrow filters can be stronger |
| Is the table large enough? | Small tables may not need indexes |
| Is the workload write-heavy? | Writes may pay maintenance cost |

## Composite Candidate Checklist

- columns are commonly filtered together
- leading column matches common query pattern
- column order is intentional
- candidate does not duplicate another index conceptually
- real systems still need platform evidence

## Read/Write Trade-Off Checklist

- read benefit
- write maintenance
- storage overhead
- workload frequency
- table size
- platform behaviour
- unused or overlapping index risk

## Conceptual Index Syntax

```sql
-- CONCEPTUAL ONLY - DO NOT RUN
-- CREATE INDEX idx_orders_customer_date
--     ON orders (customer_id, order_date);
```

Day 040 does not create, drop, rebuild, or deploy indexes.

