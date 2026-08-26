-- Day 038: Parent-Child Relationship Review
-- Purpose: Review parent and child table relationships using read-only SQL.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports relationship issues; it does not change constraints or data.
-- Relationships: customers to orders, and orders to payments.

-- Query 1: orders per customer, including customers with no orders.
SELECT
    c.customer_id,
    c.customer_status,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NOT NULL
GROUP BY c.customer_id, c.customer_status
ORDER BY c.customer_id;

-- Query 2: customers with no orders.
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_status,
    c.source_file,
    c.loaded_at,
    'CUSTOMER_WITH_NO_ORDERS' AS review_type
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NOT NULL
  AND o.order_id IS NULL;

-- Query 3: orders with no payment.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_amount,
    o.source_file,
    o.loaded_at,
    'ORDER_WITH_NO_PAYMENT' AS review_type
FROM orders AS o
LEFT JOIN payments AS p
    ON o.order_id = p.order_id
WHERE o.order_id IS NOT NULL
  AND p.payment_id IS NULL;

-- Query 4: payments per order.
SELECT
    o.order_id,
    o.order_status,
    COUNT(p.payment_id) AS payment_count
FROM orders AS o
LEFT JOIN payments AS p
    ON o.order_id = p.order_id
WHERE o.order_id IS NOT NULL
GROUP BY o.order_id, o.order_status
ORDER BY o.order_id;

