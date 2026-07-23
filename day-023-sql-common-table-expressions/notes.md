# Notes - SQL Common Table Expressions

## What Is a CTE?

CTE stands for Common Table Expression. It is a named query result written with `WITH`. The final query can reference that name.

```sql
WITH active_customers AS (
    SELECT
        customer_id,
        customer_name,
        country
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
SELECT *
FROM active_customers;
```

`WITH` starts the CTE section. `active_customers` is the CTE name. The query inside parentheses defines the result. The final `SELECT` reads from that result.

## Why Use a CTE?

CTEs help break complex logic into stages, give each stage a meaningful name, reduce repeated code, improve review and debugging, separate business rules, and create clear validation steps.

## Basic CTE Structure

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

Every CTE statement needs a final query. Without the final query, the SQL statement is incomplete.

## CTE as a Temporary Named Result

A CTE is not a saved table. It is not available after the statement finishes. It does not require table creation and it does not change source data.

## Single CTE

A single CTE is useful when one preparation step makes the final query clearer, such as filtering valid orders before sorting or aggregating them.

## Multiple CTEs

Multiple CTEs are separated by commas:

```sql
WITH valid_orders AS (
    SELECT ...
),
customer_totals AS (
    SELECT ...
)
SELECT *
FROM customer_totals;
```

## CTE Dependency

Later CTEs can reference earlier CTEs. A common sequence is:

1. Filter valid orders.
2. Aggregate customer totals.
3. Return high-value customers.

The order matters because a CTE cannot reference a later CTE that has not been defined yet.

## Final Query

The final query consumes the prepared CTE results. It is where the final columns, filters, sorting, and output shape are chosen.

## CTE Versus Subquery

| Topic | CTE | Subquery |
| --- | --- | --- |
| Readability | Named steps at the top | Logic may be nested |
| Naming | Each step can be named | Usually unnamed |
| Reuse in one statement | Easier to reference | Often repeated or nested |
| Debugging | Steps can be tested separately | Inner query can be tested separately |
| Small simple query | May be unnecessary | Often simpler |
| Larger staged query | Often clearer | Can become hard to read |

Neither is always better. Choose based on correctness, readability, platform, and team standards.

## CTE Versus Permanent Table

A permanent table stores data and remains available after a statement. A CTE does not store data by itself and disappears when the statement finishes.

## CTE Versus View

A view is a saved database object that can be reused across statements. A CTE is not saved and is limited to one statement. View creation syntax is not part of Day 023.

## CTE and Performance

Readability does not guarantee speed. SQL platforms may optimise CTEs differently. Beginners should focus first on correctness, validation, and clarity. Advanced performance tuning is out of scope.

## Validating a CTE

1. Write the first CTE query separately.
2. Run it as a normal query.
3. Check columns.
4. Check row count.
5. Check nulls.
6. Check duplicates.
7. Add the next CTE.
8. Validate again.
9. Run the final query.
10. Reconcile totals.

## CTE Naming

Good names include `valid_orders`, `paid_orders`, `customer_totals`, `missing_target_records`, and `review_queue`.

Avoid names such as `cte1`, `temp`, `data`, and `final2`.

## CTE Ordering

Put CTEs in logical dependency order: source filtering, cleaning, deduplication, enrichment, aggregation, validation, and final output.

## Common Mistakes

- Forgetting the final query.
- Missing comma between CTEs.
- Extra comma before final `SELECT`.
- Referencing a later CTE too early.
- Using unclear names.
- Creating duplicate column names.
- Not qualifying ambiguous columns.
- Assuming CTEs are permanent.
- Assuming CTEs always improve performance.
- Building too many tiny steps.
- Building one giant unreadable step.
- Not validating intermediate results.
- Hiding wrong business rules behind clear formatting.

## Recursive CTE Note

Recursive CTEs exist, but they are not part of Day 023.
