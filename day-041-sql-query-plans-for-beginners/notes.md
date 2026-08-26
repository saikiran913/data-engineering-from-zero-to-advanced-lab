# Day 041 Notes - SQL Query Plans for Beginners

## What Is a Query Plan?

A query plan is the database's chosen strategy for producing a query result. When you write SQL, you describe the result you want. The database decides how to access tables, apply filters, combine rows, sort results, and calculate summaries.

A beginner can think of a query plan as a route map. The final result is the destination. The plan steps describe how the database expects to get there.

## Why the Database Needs a Plan

The same SQL result can often be produced in more than one way. A database may be able to read a whole table, use an available access path, filter early, filter later, join tables in different orders, or sort at different stages.

The optimizer chooses a plan using available information such as table size, data distribution, filters, joins, and available indexes. This choice is not magic. It is an informed estimate.

## What Is `EXPLAIN`?

`EXPLAIN` is a general term for asking a database to show planning information for a query. Different platforms use different syntax and output formats. Some show text. Some show rows in a table. Some show JSON. Some show graphical plans.

Conceptual examples:

```sql
-- PLATFORM-SPECIFIC EXAMPLE - REVIEW BEFORE USE
-- EXPLAIN
-- SELECT order_id
-- FROM orders
-- WHERE order_id = 'OP5001';
```

## `EXPLAIN` Versus `EXPLAIN ANALYZE`

`EXPLAIN` often shows estimated planning information. Analyze-style variants may execute the query and then show execution information. Exact behaviour varies by platform.

Use caution with any analyze-style command, especially on expensive queries or production systems. Day 041 stays conceptual and read-only.

## Plan Tree Mental Model

Simplified plan:

```text
Final Result
└── Sort
    └── Join
        ├── Scan Customers
        └── Filter Orders
            └── Scan Orders
```

Read bottom-up to see where rows come from. Read top-down to see how the final result is produced.

## Table Scan

A table scan reads a table or a substantial portion of a table. It is not automatically bad. A small table scan can be efficient. A large scan may also be reasonable if the query genuinely needs most rows.

The useful beginner question is not "Is there a scan?" The better question is "Does this scan make sense for the query purpose and expected row count?"

## Index Access Concept

An index lookup or index access path can narrow row access. It may help when a filter is selective, such as searching for one order ID in a large table.

An index is not guaranteed to be used. The optimizer may still choose a scan if it estimates that a scan is cheaper or more appropriate.

## Filter Operator

A filter operator applies `WHERE` logic and removes rows that do not match. Estimated rows before and after a filter are useful clues. A selective filter usually leaves fewer rows for later work.

## Join Operator

A join operator combines rows from inputs. Join key quality and input sizes matter. If one customer has many orders, joining customers to orders can produce many joined rows.

Row multiplication is not automatically wrong, but it must match the business question.

## Sort Operator

A sort operator orders rows. Sorting a small result is usually simple. Sorting a large intermediate result can require more work. Some access paths may reduce sort work conceptually, but this depends on the platform and plan.

## Aggregate Operator

An aggregate operator groups and summarises rows using functions such as `COUNT`, `SUM`, `AVG`, `MIN`, or `MAX`. Aggregation can reduce output rows, but the database may still need to process many input rows first.

## Estimated Rows

Estimated rows are the optimizer's expected row counts. They may differ from actual rows. Poor estimates can affect plan choice conceptually, which is why statistics and data distribution matter.

## Cost Awareness

Cost is an internal estimate of work. It is useful as a relative clue inside the same database environment and query context. It is not milliseconds, and it should not be compared across different database systems.

## Statistics Concept

Statistics are metadata about data distribution. They help the optimizer estimate how many rows a filter or join may return. Stale or inaccurate information can contribute to poor estimates. Statistics maintenance is outside Day 041 scope.

## Plan Comparison Workflow

1. Define the query purpose.
2. Identify the source tables.
3. Inspect scans and lookups.
4. Inspect filters.
5. Inspect joins.
6. Inspect sorts.
7. Inspect aggregates.
8. Compare estimated rows.
9. Compare relative cost only within the same environment.
10. Identify major differences.
11. Avoid declaring one operator bad automatically.
12. Validate with actual workload evidence later.

## Common Mistakes

- labelling every scan as bad
- assuming every lookup is good
- treating cost as time
- comparing costs across platforms
- treating estimated rows as actual rows
- blaming one operator without context
- over-optimising small-table scans
- reading a plan without knowing query purpose
- ignoring join row multiplication
- ignoring large sorts
- ignoring aggregate input size
- running analyze-style commands carelessly
- assuming every platform shows the same plan output
- ignoring data or statistics changes after a plan changes

