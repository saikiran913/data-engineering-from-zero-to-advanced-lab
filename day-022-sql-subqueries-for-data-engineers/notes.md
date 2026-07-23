# Notes - SQL Subqueries for Data Engineers

## What Is a Subquery?

A subquery is a query inside another query. The inner query produces a result, and the outer query uses that result.

```sql
SELECT *
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);
```

The inner query answers: what is the average order amount? The outer query answers: which orders are above that average?

## Inner Query and Outer Query

```text
Outer query
└── Inner query
```

Beginners can reason about the inner query as if it produces a result first. The SQL engine may optimise execution differently, but this mental model helps you write and test the query safely.

## Why Use Subqueries?

Subqueries are useful when you need to filter by another query result, check whether related rows exist, compare with an aggregate, create an intermediate table-like result, build logic in stages, or validate pipeline outputs.

## Where Subqueries Can Appear

Day 022 focuses on three beginner locations:

| Location | Example Use |
| --- | --- |
| `WHERE` | Filter orders above the average order amount |
| `FROM` | Build customer totals, then filter those totals |
| Selected expression | Show the overall average beside every order |

## Scalar Subquery

A scalar subquery returns one row and one column. It can be used with operators such as `=`, `>`, `<`, `>=`, and `<=`.

```sql
SELECT *
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);
```

If a scalar subquery returns many rows, the outer query cannot safely compare one value to many values.

## Multi-Row Subquery

A multi-row subquery returns multiple values. It is commonly used with `IN`.

```sql
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
```

For beginner `IN` examples, the subquery should return one comparable column.

## IN

`IN` asks whether a value appears in a list returned by the inner query. It is useful for matching identifiers from another table, such as customers who placed orders.

## NOT IN and NULL Risk

`NOT IN` asks whether a value is not in the returned list. It can behave unexpectedly when the inner query returns `NULL`.

If the subquery returns:

```text
C001
C002
NULL
```

then `NOT IN` may not return the rows beginners expect. A safer pattern filters out `NULL` values:

```sql
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);
```

For missing-record checks, `NOT EXISTS` is often clearer and safer.

## EXISTS

`EXISTS` checks whether at least one matching row exists. The selected literal, such as `1`, is not the important part.

```sql
SELECT *
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

The condition `o.customer_id = c.customer_id` connects the inner query to the current outer customer row.

## NOT EXISTS

`NOT EXISTS` finds outer rows with no matching inner rows.

```sql
SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

This pattern is common for finding missing customers, missing payments, missing target records, and products with no sales.

## Correlated Subquery

A correlated subquery refers to a value from the current outer row. In the `EXISTS` example, the inner query uses `c.customer_id` from the outer query. The result depends on which customer row is currently being checked.

## Subquery in the FROM Clause

A subquery in `FROM` acts like a temporary table-like result.

```sql
SELECT
    customer_id,
    total_order_value
FROM (
    SELECT
        customer_id,
        SUM(order_amount) AS total_order_value
    FROM orders
    GROUP BY customer_id
) AS customer_totals
WHERE total_order_value > 500;
```

Many platforms require an alias such as `customer_totals`.

## Subquery Versus JOIN

| Question | Subquery Approach | JOIN Approach |
| --- | --- | --- |
| Customers with orders | `IN` or `EXISTS` | Join customers to orders |
| Customers without orders | `NOT EXISTS` | Left join and filter missing matches |
| Products that were sold | `EXISTS` | Join products to sales |
| Missing target records | `NOT EXISTS` | Anti-join style validation |

Both approaches may be valid. Choose the one that is correct and easiest for the team to read.

## Subquery Versus CTE

Subqueries and CTEs both split logic into stages. CTEs often improve readability for larger queries because the intermediate steps are named. Day 023 will focus on CTEs directly.

## Run the Inner Query First

Use this workflow:

1. Write the inner query.
2. Run it alone.
3. Check row count.
4. Check column count.
5. Check `NULL` values.
6. Insert it into the outer query.
7. Validate the final output.

## Common Mistakes

- Returning multiple columns when one is expected.
- Returning multiple rows for a scalar subquery.
- Forgetting the correlation condition.
- Using `NOT IN` with `NULL`.
- Using the wrong key.
- Forgetting aliases.
- Nesting too many levels.
- Not validating the inner query.
- Comparing incompatible data types.
- Hiding logic inside an unreadable query.
- Using a subquery where a simple filter is enough.
- Assuming a subquery is always faster.

## Platform Note

Subqueries are widely supported, but exact syntax, optimisation, and error messages can vary by SQL platform.
