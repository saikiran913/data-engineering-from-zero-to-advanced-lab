# Index Selection Guide

## Start with Workload

Index thinking begins with the queries that actually matter. A column name alone is not enough.

## Identify Important Queries

Prioritise queries that are frequent, important, and user-facing or pipeline-critical.

## Identify Tables

Understand table grain, size, and read/write balance before considering candidates.

## Identify Filter Columns

Look for columns used repeatedly in `WHERE` clauses.

## Identify Join Columns

Review columns used to connect parent and child or fact and dimension-style data.

## Identify Sort Columns

Review common `ORDER BY` patterns, especially for recent-data reports.

## Profile Cardinality

Count distinct values. High-cardinality columns often narrow rows better than low-cardinality flags.

## Estimate Selectivity

Selectivity is approximately distinct values divided by total rows.

## Review Table Size

Small tables may not need extra access structures. Larger tables require more evidence-based thinking.

## Review Read/Write Balance

Read-heavy tables may benefit from indexes. Write-heavy tables can pay extra maintenance cost.

## Consider Existing Keys

Primary and unique constraints may have supporting indexes in many relational systems, but behaviour varies.

## Consider Composite Patterns

Composite candidates are useful only when the workload commonly filters columns together. Column order matters conceptually.

## Reject Weak Candidates

Reject or defer candidates driven only by rare queries, low-selectivity columns, small tables, or speculative tuning.

## Validate in Platform Tools Later

Real tuning requires platform-specific query plans, table size, data distribution, and testing.

## Reusable Index-Candidate Template

| Field | Example |
|---|---|
| Table | `orders_workload` |
| Grain | One row per order |
| Candidate columns | `customer_id, order_date` |
| Query pattern | Customer order history |
| Filter type | Equality plus date range |
| Join use | `customer_id` may join to customers |
| Sort use | `order_date` |
| Selectivity | Medium |
| Frequency | High |
| Importance | High |
| Read/write pattern | Read-heavy |
| Expected benefit | Faster targeted history lookups conceptually |
| Write/storage trade-off | Extra maintenance and storage |
| Platform caveat | Validate with query plans in real systems |
| Review status | Strong educational candidate |

