-- Day 038: Foreign-Key-Like Validation
-- Purpose: Find child rows whose parent keys do not exist.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not delete orphan records.
-- Relationship: customers parent to orders child through customer_id.
-- Relationship: orders parent to payments child through order_id.

-- Query 1: parent customer keys that are duplicated.
SELECT
    customer_id,
    COUNT(*) AS parent_row_count
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Query 2: orders with customer IDs not found in customers.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_amount,
    o.source_file,
    o.loaded_at,
    'ORPHAN_ORDER_CUSTOMER' AS issue_type
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.customer_id IS NOT NULL
  AND c.customer_id IS NULL;

-- Query 3: orders with null customer IDs.
SELECT
    order_id,
    customer_id,
    order_status,
    source_file,
    loaded_at,
    'NULL_CHILD_KEY' AS issue_type
FROM orders
WHERE customer_id IS NULL;

-- Query 4: parent order keys that are duplicated.
SELECT
    order_id,
    COUNT(*) AS parent_row_count
FROM orders
WHERE order_id IS NOT NULL
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Query 5: payments with order IDs not found in orders.
SELECT
    p.payment_id,
    p.order_id,
    p.payment_status,
    p.payment_amount,
    p.source_file,
    p.loaded_at,
    'ORPHAN_PAYMENT_ORDER' AS issue_type
FROM payments AS p
LEFT JOIN orders AS o
    ON p.order_id = o.order_id
WHERE p.order_id IS NOT NULL
  AND o.order_id IS NULL;

