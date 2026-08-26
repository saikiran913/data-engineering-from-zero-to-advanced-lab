# Day 042 Notes - SQL Performance Habits

## What Is Query Performance?

Query performance is about how much work a database performs to return a result. It depends on data volume, query shape, storage, optimizer choices, statistics, indexes, and workload. Day 042 focuses on habits that reduce unnecessary work while preserving correctness.

## Projection

Projection means choosing columns.

```sql
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_performance_sample;
```

This is clearer than using:

```sql
SELECT *
FROM orders_performance_sample;
```

Explicit columns create a smaller logical output, clearer contracts, and less accidental column carrying. Depending on the platform, they may also reduce processing or network transfer, especially with wide datasets. Do not assume universal physical savings in every engine.

## Column Pruning

Column pruning means keeping only columns needed downstream. It is helpful for wide tables, long CTE chains, stable reports, and pipeline handoffs.

## Filtering

Filtering means keeping only the rows needed for the business question. Common filters include business period, status, region, channel, and exact key lookup.

## Early Filtering

Early filtering reduces inputs before joins or aggregations when the result is logically the same. It must be done carefully. Moving a filter across an outer join or aggregation can change the result.

## Row Pruning

Row pruning means reducing the row population before expensive later steps. A query that needs August completed orders should not carry irrelevant cancelled orders through every step.

## Join Reduction

Join reduction means reviewing whether each join has a purpose. A join is needed when it contributes a required column, filter, business rule, or validation relationship.

An unnecessary join adds work and can introduce duplicate rows. Never remove a join until its business role is understood.

## Row Multiplication

Row multiplication happens when a join returns more rows than one input. This is expected in one-to-many relationships such as orders to order items. It is risky when the expected output grain is one row per order but the query returns one row per item line.

## Dedup Before Join

Deduplication before a join can help only when duplicate source rows are not meaningful and a clear business rule exists. Do not blindly apply `DISTINCT` before a join.

## Aggregation Strategy

Pre-aggregation can reduce join size when downstream logic needs only aggregated grain. For example, item lines can be aggregated to order level before joining to orders when the final output needs one row per order.

Pre-aggregation is wrong when it loses required detail. If the report needs order-level rows, aggregating to customer level too early changes the business meaning.

## Repeated Aggregation

The same grouping repeated in multiple branches can make SQL harder to read and may create repeated work. A reusable CTE can improve clarity. Actual physical reuse varies by SQL platform.

## DISTINCT

`DISTINCT` is legitimate when the business question asks for unique output values. It is dangerous when used to hide a bad join or undefined output grain. It can also add work.

## ORDER BY

`ORDER BY` should have a purpose. Final output ordering can be meaningful for reports or top-N queries. Intermediate sorting is usually not meaningful unless a platform-specific construct requires it.

## Repeated Expressions

Repeated calculations, such as the same `CASE` expression in several places, add complexity. Deriving the value once in a clear CTE can improve maintainability.

## CTE Performance Caution

A CTE is primarily a readability tool. Some platforms inline CTEs, some may materialise them, and behaviour can vary by query. Do not claim that a CTE is inherently faster or slower.

## Naive Versus Improved Query

Compare versions by asking:

- do they return the same business result?
- do they preserve grain?
- do they use fewer columns?
- do they use fewer rows?
- do they remove unnecessary joins?
- do they avoid unnecessary sorts?
- do they reduce repeated logic?
- have counts, keys, totals, and grouped outputs been validated?

## Safe Performance-Improvement Workflow

1. Define business result.
2. Define grain.
3. List required columns.
4. List required rows.
5. Identify joins.
6. Remove unnecessary joins cautiously.
7. Reduce join inputs.
8. Inspect row multiplication.
9. Decide aggregation stage.
10. Remove unnecessary `DISTINCT`.
11. Remove unnecessary `ORDER BY`.
12. Reduce repeated work.
13. Validate old versus new output.
14. Inspect plan evidence conceptually.

