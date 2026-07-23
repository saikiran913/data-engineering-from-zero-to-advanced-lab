# Day 022 SQL Subquery Cheatsheet

## Basic Definition

A subquery is a query inside another query. The inner query solves a smaller step. The outer query uses the result.

## Scalar Subquery Template

```sql
SELECT *
FROM table_name
WHERE numeric_column > (
    SELECT AVG(numeric_column)
    FROM table_name
);
```

Use this when the inner query returns one value.

## IN Template

```sql
SELECT *
FROM table_a
WHERE key_column IN (
    SELECT key_column
    FROM table_b
);
```

Use this when the inner query returns a one-column list.

## Safe NOT IN Template

```sql
SELECT *
FROM table_a
WHERE key_column NOT IN (
    SELECT key_column
    FROM table_b
    WHERE key_column IS NOT NULL
);
```

Filter out `NULL` values inside the subquery.

## EXISTS Template

```sql
SELECT *
FROM table_a AS a
WHERE EXISTS (
    SELECT 1
    FROM table_b AS b
    WHERE b.key_column = a.key_column
);
```

Use this to check whether at least one matching row exists.

## NOT EXISTS Template

```sql
SELECT *
FROM table_a AS a
WHERE NOT EXISTS (
    SELECT 1
    FROM table_b AS b
    WHERE b.key_column = a.key_column
);
```

Use this for missing-record checks.

## FROM-Clause Subquery Template

```sql
SELECT grouped_key, total_value
FROM (
    SELECT
        grouped_key,
        SUM(value_column) AS total_value
    FROM table_name
    GROUP BY grouped_key
) AS grouped_result
WHERE total_value > 100;
```

The subquery in `FROM` should have an alias.

## Run-Inner-Query-First Checklist

- Run the inner query alone.
- Confirm row count.
- Confirm column count.
- Check `NULL` values.
- Confirm matching data types.
- Use the correct business key.
- Add clear aliases.
- Keep nesting shallow.
- Validate totals.
- Document the business purpose.

## When to Consider a JOIN

Consider a join when you need columns from both tables in the final output.

## When to Consider a CTE

Consider a CTE when the query has several steps and named intermediate results would make it easier to read. Day 023 covers CTEs in detail.
