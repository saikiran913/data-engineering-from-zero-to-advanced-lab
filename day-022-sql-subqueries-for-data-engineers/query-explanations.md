# Query Explanations

## Scalar Comparison

Problem: find rows above or below one calculated value.

The inner query returns one row and one column, such as `AVG(order_amount)`. The outer query compares each row to that value. `NULL` matters if the compared column contains missing values because comparisons with `NULL` do not behave like normal numeric comparisons.

## IN

Problem: filter rows by a list of matching values.

The inner query returns one comparable column, such as customer IDs from `orders`. The outer query keeps customers whose `customer_id` appears in that list. A common mistake is returning multiple columns from the inner query.

## Safe NOT IN

Problem: find values not present in another dataset.

`NOT IN` should filter `NULL` values inside the inner query:

```sql
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);
```

If the inner list contains `NULL`, the result may be unexpected. `NOT EXISTS` is often safer for missing-record checks.

## EXISTS

Problem: check whether at least one matching row exists.

```sql
SELECT *
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

The inner query is connected to the current outer row by the correlation condition.

## NOT EXISTS

Problem: find missing matches.

Line-by-line example:

```sql
SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

`customers AS c` gives the outer table a short alias. `NOT EXISTS` asks for customers where no matching inner row exists. `orders AS o` gives the inner table an alias. `o.customer_id = c.customer_id` connects the inner query to the current customer. Customers with no matching orders are returned.

## FROM-Clause Subquery

Problem: build a temporary table-like result, then filter it.

The inner query often groups data. The outer query filters the grouped columns. The inner result needs an alias on many platforms.

## Validation Subquery

Problem: identify missing or suspicious records without changing source data.

Validation subqueries often use `NOT EXISTS` for missing customers, orders without payments, payments without orders, products without sales, and source records missing from a target.

## Source-Target Reconciliation

Source-target reconciliation compares records expected in a source with records loaded into a target. A beginner-friendly pattern is:

```sql
SELECT s.record_id
FROM source_target_reconciliation AS s
WHERE s.record_type = 'SOURCE'
  AND NOT EXISTS (
      SELECT 1
      FROM source_target_reconciliation AS t
      WHERE t.record_type = 'TARGET'
        AND t.record_id = s.record_id
  );
```

The key used for comparison is `record_id`. The output is a review list, not an automatic deletion or correction list.

## Step-by-Step Query Building

Start with the inner query, run it, inspect the rows, check the columns, then place it inside the outer query. This avoids hiding mistakes inside a larger query.

## Pattern Comparison

| Pattern | Inner Result | Best Beginner Use | Main Risk |
| --- | --- | --- | --- |
| Scalar subquery | One value | Compare rows to an aggregate | Returning many rows |
| `IN` | One-column list | Match values from another table | Returning multiple columns |
| `NOT IN` | One-column list | Missing values when no `NULL` risk | `NULL` changes behaviour |
| `EXISTS` | Matching row check | Related-row existence | Missing correlation |
| `NOT EXISTS` | No matching row check | Missing-record validation | Wrong key |
| `FROM` subquery | Table-like result | Filter grouped results | Missing alias or too much nesting |
