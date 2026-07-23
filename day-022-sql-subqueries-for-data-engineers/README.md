# Day 022 - SQL Subqueries for Data Engineers

Filtering, validation, existence checks, and step-by-step query building.

## Learning Goal

By the end of Day 022, you should understand what a subquery is, how an inner query and outer query work together, how to use subqueries with `WHERE`, `IN`, `NOT IN`, `EXISTS`, `NOT EXISTS`, scalar comparisons, and `FROM`-clause table results, and how these patterns support Data Engineering validation.

## Connection to Day 021

Day 021 used an intermediate ranked result and an outer filtering step to keep the correct duplicate version. Day 022 expands that idea directly: one query can produce a result, and another query can use that result.

Think of Day 021 as practice with staged SQL thinking. Day 022 gives that idea a formal name: subqueries.

## Required Warnings

> A subquery is not automatically better than a JOIN or a CTE. The best choice depends on the problem, readability, platform, and team standards. Beginners should first focus on correctness and clarity.

> Before using a subquery inside a larger query, run the inner query by itself and confirm that it returns the expected rows and columns.

## Why Subqueries Matter for Data Engineers

Data engineers often need to answer questions where one result helps filter or validate another result:

- Which customers placed orders?
- Which customers never placed orders?
- Which orders are above the average order value?
- Which products were never sold?
- Which source records are missing from a target table?
- Did a pipeline load all expected keys?
- Are source and target totals different?
- Can a complex query be built in clear, testable stages?

Subqueries help turn these questions into smaller steps.

## Suggested Learning Order

1. Read `notes.md`.
2. Review `sample-tables.md`.
3. Inspect the CSV files in `sample-data/`.
4. Run `subquery-concept.sql`.
5. Run `where-subqueries-practice.sql`.
6. Study `IN` and `NOT IN`.
7. Study `EXISTS` and `NOT EXISTS`.
8. Study scalar subqueries.
9. Study `FROM`-clause subqueries.
10. Run validation examples.
11. Complete step-by-step query-building exercises.
12. Review the cheat sheet.
13. Complete practice questions.
14. Read the summary and glossary.

## Files in This Folder

| File | Purpose | Order |
| --- | --- | --- |
| `README.md` | Main lesson | 1 |
| `notes.md` | Detailed conceptual notes | 2 |
| `sample-tables.md` | Dataset documentation | 3 |
| `subquery-concept.sql` | First subquery examples | 4 |
| `where-subqueries-practice.sql` | `WHERE` subquery practice | 5 |
| `in-and-not-in-subqueries.sql` | `IN`, `NOT IN`, and `NULL` safety | 6 |
| `exists-and-not-exists-practice.sql` | Existence and missing-record checks | 7 |
| `scalar-subqueries.sql` | One-value subqueries | 8 |
| `from-clause-subqueries.sql` | Table-like subquery results | 9 |
| `validation-subqueries.sql` | Data quality and reconciliation checks | 10 |
| `step-by-step-query-building.sql` | Beginner workflow examples | 11 |
| `query-explanations.md` | Explanation of query patterns | 12 |
| `subquery-cheatsheet.md` | Quick reference | 13 |
| `common-mistakes.md` | Common errors and safer approaches | 14 |
| `real-world-examples.md` | Practical Data Engineering scenarios | 15 |
| `beginner-summary.md` | End-of-day summary | 16 |
| `glossary.md` | Simple definitions | 17 |
| `practice-questions.md` | Exercises and answer key | 18 |

## Main Concepts

| Concept | Simple Meaning |
| --- | --- |
| Subquery | A query inside another query |
| Inner query | The query placed inside the larger query |
| Outer query | The query that uses the inner query result |
| Scalar subquery | A subquery that returns one value |
| Table subquery | A subquery in `FROM` that acts like a temporary result table |
| Correlated subquery | An inner query that refers to the current row of the outer query |
| `IN` | Checks whether a value is in a list returned by the subquery |
| `NOT IN` | Checks whether a value is not in a list, but needs care with `NULL` |
| `EXISTS` | Checks whether at least one matching row exists |
| `NOT EXISTS` | Checks whether no matching row exists |
| Source table | The table where data is expected to come from |
| Target table | The table where loaded or processed data is expected to appear |
| Reconciliation | Comparing source and target data |
| Missing record | A record found in one dataset but not another |

## Simple Mental Model

First answer a smaller question:

```sql
SELECT AVG(order_amount)
FROM orders;
```

Then use that answer in a bigger question:

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);
```

The inner query returns the average. The outer query returns orders above that average.

## Safe-Learning Note

All SQL in Day 022 is read-only. No source data is changed. Validation results should be investigated before decisions are made. Exact syntax and performance can vary slightly between SQL platforms.

## Navigation

- Previous: [Day 021 - SQL Safe Deduplication Practice](../day-021-sql-safe-deduplication-practice/)
- Next: [Day 023 - SQL Common Table Expressions for Data Engineers](../day-023-sql-common-table-expressions/)
- [Back to Main Learning Path](../README.md)
