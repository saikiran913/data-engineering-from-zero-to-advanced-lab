# Day 038 Constraint Cheatsheet

## Primary-Key-Like Check

```sql
SELECT
    COUNT(*) AS row_count,
    COUNT(customer_id) AS non_null_key_count,
    COUNT(DISTINCT customer_id) AS distinct_key_count
FROM customers;
```

Meaning: a primary-key-like rule needs requiredness and uniqueness.

## Duplicate Key Check

```sql
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

## Null Key Check

```sql
SELECT
    customer_id,
    customer_name
FROM customers
WHERE customer_id IS NULL;
```

## Foreign-Key-Like Check

```sql
SELECT
    o.order_id,
    o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;
```

Meaning: keep unmatched child rows for review.

## Unique Rule Check

```sql
SELECT
    product_code,
    COUNT(*) AS row_count
FROM products
WHERE product_code IS NOT NULL
GROUP BY product_code
HAVING COUNT(*) > 1;
```

## Check-Like Rule

```sql
SELECT
    order_id,
    order_status
FROM orders
WHERE order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED');
```

## Not-Null Rule

```sql
SELECT
    order_id,
    order_date
FROM orders
WHERE order_date IS NULL;
```

## Conceptual Constraint Syntax

These are comments only in Day 038:

```sql
-- PRIMARY KEY (...)
-- FOREIGN KEY (...) REFERENCES ...
-- UNIQUE (...)
-- CHECK (...)
-- NOT NULL
```

## Best Practices

- document table grain
- check key nulls and duplicates
- check parent uniqueness before relationship checks
- use left joins to find orphans
- preserve audit context
- create exception outputs
- do not auto-delete violations
- remember enforcement varies by platform

