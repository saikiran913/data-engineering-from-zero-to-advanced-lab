-- Day 038: Not-Null-Like Validation
-- Purpose: Validate required fields using read-only SQL.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define or change constraints.
-- Expected rule: required key and reporting fields should not be null.

-- Query 1: missing customer IDs.
SELECT
    COUNT(*) AS missing_customer_id_count
FROM customers
WHERE customer_id IS NULL;

-- Query 2: customer rows with missing IDs.
SELECT
    customer_id,
    customer_name,
    source_file,
    loaded_at
FROM customers
WHERE customer_id IS NULL;

-- Query 3: order required-field checks.
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    source_file,
    loaded_at,
    CASE
        WHEN order_id IS NULL THEN 'NULL_ORDER_ID'
        WHEN customer_id IS NULL THEN 'NULL_CUSTOMER_ID'
        WHEN order_date IS NULL THEN 'NULL_ORDER_DATE'
        ELSE 'NO_REVIEW'
    END AS issue_type
FROM orders
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR order_date IS NULL;

-- Query 4: payment required-field checks.
SELECT
    payment_id,
    order_id,
    payment_amount,
    payment_date,
    source_file,
    loaded_at,
    CASE
        WHEN payment_id IS NULL THEN 'NULL_PAYMENT_ID'
        WHEN payment_amount IS NULL THEN 'NULL_PAYMENT_AMOUNT'
        WHEN payment_date IS NULL THEN 'NULL_PAYMENT_DATE'
        ELSE 'NO_REVIEW'
    END AS issue_type
FROM payments
WHERE payment_id IS NULL
   OR payment_amount IS NULL
   OR payment_date IS NULL;

-- Query 5: product code required-field checks.
SELECT
    product_id,
    product_code,
    product_name,
    source_file,
    loaded_at,
    'NULL_PRODUCT_CODE' AS issue_type
FROM products
WHERE product_code IS NULL;

