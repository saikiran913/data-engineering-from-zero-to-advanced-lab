# Day 028 SQL View Cheatsheet

## Simple View

```sql
CREATE VIEW vw_active_customers AS
SELECT
    customer_id,
    customer_name,
    country
FROM raw_customers
WHERE customer_status = 'ACTIVE';
```

## Joined View

```sql
CREATE VIEW vw_order_customer_details AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.customer_name
FROM raw_orders AS o
JOIN raw_customers AS c
    ON o.customer_id = c.customer_id;
```

## Aggregate View

```sql
CREATE VIEW vw_customer_sales_summary AS
SELECT
    customer_id,
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_order_amount
FROM raw_orders
WHERE order_status = 'COMPLETED'
  AND order_amount > 0
GROUP BY customer_id;
```

## CTE-Based Latest-Record View

```sql
CREATE VIEW vw_current_orders AS
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC
        ) AS row_num
    FROM raw_orders
)
SELECT
    order_id,
    customer_id,
    order_status,
    updated_at
FROM ranked_orders
WHERE row_num = 1;
```

## Review Queue View

```sql
CREATE VIEW vw_order_review AS
SELECT
    order_id,
    'INVALID_ORDER_AMOUNT' AS issue_type
FROM raw_orders
WHERE order_amount <= 0;
```

## Querying and Validating

```sql
SELECT
    customer_id,
    completed_order_amount
FROM vw_customer_sales_summary
ORDER BY completed_order_amount DESC;
```

```sql
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM vw_customer_sales_summary
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

```sql
SELECT SUM(order_amount) AS source_total
FROM raw_orders
WHERE order_status = 'COMPLETED'
  AND order_amount > 0;
```

```sql
SELECT SUM(completed_order_amount) AS view_total
FROM vw_customer_sales_summary;
```

## Design Checklist

- name
- business purpose
- source objects
- source grain
- output grain
- explicit columns
- stable aliases
- joins
- null policy
- audit columns
- excluded columns
- dependencies
- validation
- consumer expectations

Platform note: exact `CREATE VIEW` syntax, permissions, replacement behaviour, naming rules, and ordering behaviour vary.
