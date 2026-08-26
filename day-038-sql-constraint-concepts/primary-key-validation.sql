-- Day 038: Primary-Key-Like Validation
-- Purpose: Validate whether candidate key columns are non-null and unique.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define or change constraints.
-- Table grain: customers one row per customer, orders one row per order, payments one row per payment.
-- Candidate keys: customer_id, order_id, payment_id.

-- Query 1: customer key summary.
SELECT
    COUNT(*) AS row_count,
    COUNT(customer_id) AS non_null_customer_id_count,
    COUNT(DISTINCT customer_id) AS distinct_customer_id_count
FROM customers;

-- Query 2: duplicate customer IDs.
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Query 3: null customer IDs.
SELECT
    customer_id,
    customer_name,
    source_file,
    loaded_at
FROM customers
WHERE customer_id IS NULL;

-- Query 4: order key summary.
SELECT
    COUNT(*) AS row_count,
    COUNT(order_id) AS non_null_order_id_count,
    COUNT(DISTINCT order_id) AS distinct_order_id_count
FROM orders;

-- Query 5: duplicate order IDs.
SELECT
    order_id,
    COUNT(*) AS row_count
FROM orders
WHERE order_id IS NOT NULL
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Query 6: null order IDs.
SELECT
    order_id,
    customer_id,
    order_date,
    source_file,
    loaded_at
FROM orders
WHERE order_id IS NULL;

-- Query 7: payment key summary.
SELECT
    COUNT(*) AS row_count,
    COUNT(payment_id) AS non_null_payment_id_count,
    COUNT(DISTINCT payment_id) AS distinct_payment_id_count
FROM payments;

-- Query 8: duplicate payment IDs.
SELECT
    payment_id,
    COUNT(*) AS row_count
FROM payments
WHERE payment_id IS NOT NULL
GROUP BY payment_id
HAVING COUNT(*) > 1;

-- Query 9: null payment IDs.
SELECT
    payment_id,
    order_id,
    payment_status,
    source_file,
    loaded_at
FROM payments
WHERE payment_id IS NULL;

