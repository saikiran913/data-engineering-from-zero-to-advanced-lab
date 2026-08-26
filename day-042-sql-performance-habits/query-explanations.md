# Query Explanations

Day 042 SQL files practise reducing unnecessary work while preserving business meaning.

## Core Habits

| Habit | Potential benefit | Main correctness risk |
|---|---|---|
| Projection | Fewer columns and clearer output contract | Removing a column needed downstream |
| Filtering | Fewer irrelevant rows | Changing the business population |
| Row pruning | Smaller later steps | Filtering too early or with the wrong date |
| Column pruning | Narrower intermediate results | Breaking a later calculation |
| Join reduction | Less join work and fewer duplication risks | Removing hidden business logic |
| Pre-aggregation | Smaller join input | Losing required detail grain |
| `DISTINCT` review | Avoid hiding duplicate causes | Removing meaningful rows |
| Sort reduction | Avoid unnecessary ordering work | Removing required report order |
| Repeated-work reduction | Clearer reusable logic | Assuming CTEs are always faster |

## Projection

Business purpose: return only required columns.

Performance idea: avoid carrying wide rows through the query.

Correctness risk: downstream users may depend on a removed column.

Validation required: compare the expected column contract.

## Filtering

Business purpose: keep only the required date period, status, region, key, or channel.

Performance idea: fewer rows move into joins, sorts, and aggregations.

Correctness risk: moving a filter can change an outer join or aggregation.

Validation required: compare row counts, min/max dates, totals, and grouped outputs.

## Join Reduction

Business purpose: join only when a table contributes required columns, filters, rules, or validation.

Performance idea: fewer joins can reduce work and duplication risk.

Correctness risk: a join may encode a hidden eligibility rule.

Validation required: compare counts and confirm business logic.

## Row Multiplication

Business purpose: understand output grain after a join.

Performance idea: avoid accidental expansion when one row per business key is required.

Correctness risk: one-to-many joins may be valid, so row growth is not automatically wrong.

Validation required: compare `COUNT(*)` with `COUNT(DISTINCT business_key)`.

## Pre-Aggregation

Business purpose: aggregate a lower-grain table to the needed grain.

Performance idea: reduce rows before a join.

Correctness risk: aggregating too early can lose row-level detail.

Validation required: document grain before and after.

## DISTINCT

Business purpose: return unique values when the business question asks for them.

Performance idea: avoid unnecessary duplicate-removal work.

Correctness risk: `DISTINCT` may hide a bad join.

Validation required: investigate why duplicates appear.

## Sorting

Business purpose: order final output only when needed.

Performance idea: unnecessary sorts can add work.

Correctness risk: removing an order required by a report or top-N query changes behaviour.

Validation required: confirm the consumer's ordering requirement.

## Repeated Work and CTE Reuse

Business purpose: write clearer reusable logic.

Performance idea: avoid repeating the same aggregate or expression.

Correctness risk: CTE physical behaviour varies by platform.

Validation required: compare outputs and inspect plan evidence later.

## Line-by-Line Pair Explanation

Example: `SELECT *` versus explicit projection.

```sql
SELECT *
FROM orders_performance_sample
WHERE order_id = 'PO1001';
```

- `SELECT *` asks for every column.
- `FROM orders_performance_sample` reads the order sample.
- `WHERE order_id = 'PO1001'` keeps one order.

Improved version:

```sql
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_id = 'PO1001';
```

- the filter is the same
- the business key is the same
- the output contract is smaller and clearer
- the rewrite is equivalent only if the removed columns are not required

