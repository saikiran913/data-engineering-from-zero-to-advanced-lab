# Day 040 Notes - SQL Index Fundamentals

## What Is an Index?

An index is an additional structure that can help a database find rows more efficiently for some access patterns.

From the user's perspective, an index is not a second logical copy of the table. A query should return the same logical result whether an index is used or not. The index only affects how the database may find the rows.

Indexes require storage and maintenance.

## Table Scan Versus Index Lookup

A scan means the database examines a larger part of the table conceptually.

An index lookup means the database may use an access structure to narrow candidate rows.

Actual optimizer behaviour varies by SQL platform.

## Selectivity

Selectivity is a beginner-friendly way to ask how narrow a column is:

```text
selectivity approximately equals distinct values / total rows
```

High-selectivity examples:

- `order_id`
- `customer_id` in some datasets
- unique product code

Low-selectivity examples:

- active/inactive flag
- Yes/No flag
- small status list

High selectivity can make a column more interesting as an index candidate, but selectivity alone is not enough.

## Cardinality

Cardinality means the number of distinct values. A column with 36 distinct order IDs in 36 rows has high cardinality. A status column with 4 values has low cardinality.

## Filter Patterns

Useful filter signals include:

- frequently used predicates
- equality filters
- range filters
- date ranges
- exact-key lookups

## Join Patterns

Join columns can be index candidates because joins repeatedly compare key values. For example, orders and customers may join on `customer_id`.

Both sides of a join should be considered conceptually.

## Sorting

`ORDER BY` sorts query results. Some index designs may support sorting, but this is not a universal guarantee.

## Composite Indexes

A composite index is an index over multiple columns. Column order matters conceptually.

If queries often filter by `customer_id` and then `order_date`, a composite candidate might be `customer_id, order_date`. That does not mean the same index helps every possible column order equally.

## Read/Write Trade-Off

Indexes can help some reads. They can also add:

- storage overhead
- maintenance work for inserts, updates, and deletes
- operational complexity

## Over-Indexing

Over-indexing means having too many indexes, duplicate or overlapping indexes, or unused indexes. This can hurt write-heavy workloads.

## Primary and Unique Keys

Many relational systems create supporting indexes for primary or unique constraints. Behaviour varies by platform, so do not assume universal implementation.

## Operational Databases Versus Analytical Warehouses

Operational row-store systems commonly use indexes.

Analytical systems may instead use:

- partition pruning
- clustering
- columnar storage
- sort or distribution strategies
- metadata pruning

This lesson avoids platform-specific tuning.

## Query Workload Thinking

Index design should start from:

- frequent queries
- important queries
- filter patterns
- join patterns
- sort patterns
- read/write balance
- table size
- selectivity

## Safe Index-Selection Workflow

1. Identify important workload.
2. Identify table grain.
3. Profile candidate columns.
4. Inspect selectivity.
5. Count filter frequency.
6. Count join frequency.
7. Inspect sort frequency.
8. Consider read/write balance.
9. Identify candidate indexes.
10. Reject weak candidates.
11. Consider composite patterns.
12. Validate with platform tools in real systems.
13. Avoid speculative over-indexing.

## Common Mistakes

- indexing every column
- indexing every `WHERE` column
- ignoring write cost
- ignoring table size
- ignoring selectivity
- automatically indexing low-cardinality flags
- creating duplicate or overlapping indexes
- ignoring composite column order
- assuming sort usage is guaranteed
- assuming indexes are useful in all warehouses
- assuming primary key behaviour is identical everywhere
- using no workload evidence
- using no platform context
- treating indexes as a substitute for good SQL
- ignoring stale or unused indexes conceptually

