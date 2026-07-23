# Day 023 CTE Cheatsheet

## Basic Definition

A CTE is a named query result used inside one SQL statement.

## Single CTE Template

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;
```

## Multiple CTE Template

```sql
WITH first_step AS (
    SELECT ...
),
second_step AS (
    SELECT ...
    FROM first_step
)
SELECT *
FROM second_step;
```

## CTE With Aggregation

```sql
WITH customer_totals AS (
    SELECT customer_id, SUM(order_amount) AS total_order_value
    FROM raw_orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals;
```

## CTE With Join

```sql
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE order_amount > 0
)
SELECT c.customer_id, c.customer_name, v.order_id
FROM customers AS c
JOIN valid_orders AS v
    ON c.customer_id = v.customer_id;
```

## CTE With ROW_NUMBER

```sql
WITH ranked_orders AS (
    SELECT
        order_id,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC
        ) AS row_num
    FROM raw_orders
)
SELECT *
FROM ranked_orders
WHERE row_num = 1;
```

## CTE Validation Template

```sql
WITH invalid_records AS (
    SELECT order_id, source_file
    FROM raw_orders
    WHERE customer_id IS NULL
       OR order_amount <= 0
)
SELECT *
FROM invalid_records;
```

## Source-Target Reconciliation Template

```sql
WITH source_data AS (
    SELECT record_id, record_value
    FROM source_records
),
target_data AS (
    SELECT record_id, record_value
    FROM target_records
)
SELECT s.record_id
FROM source_data AS s
LEFT JOIN target_data AS t
    ON s.record_id = t.record_id
WHERE t.record_id IS NULL;
```

## Naming Checklist

- Use a clear step name.
- Keep one purpose per CTE.
- Place steps in dependency order.
- Use correct commas.
- Include the final query.

## Validation Checklist

- Run each step separately.
- Check row counts.
- Check nulls.
- Check duplicates.
- Reconcile totals.
- Confirm final filters.

## When to Use a Subquery Instead

Use a subquery when the task is small and the nested version is easier to read.

## When to Consider a View or Table

Consider a view or table when the result must be reused across multiple statements or stored. Day 023 does not teach creation syntax.
