-- Day 038: Check-Rule-Like Validation
-- Purpose: Validate allowed values and range rules using read-only SQL.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define or change constraints.
-- Expected rules: statuses should use documented values; numeric values should meet documented ranges.

-- Query 1: unsupported order statuses.
SELECT
    order_id,
    order_status,
    order_amount,
    source_file,
    loaded_at,
    'UNSUPPORTED_ORDER_STATUS' AS issue_type
FROM orders
WHERE order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED');

-- Query 2: order amount range review.
SELECT
    order_id,
    order_status,
    order_amount,
    source_file,
    loaded_at,
    'ORDER_AMOUNT_RANGE_REVIEW' AS issue_type
FROM orders
WHERE order_amount < 0;

-- Query 3: zero order amount review.
SELECT
    order_id,
    order_status,
    order_amount,
    source_file,
    loaded_at,
    'ZERO_ORDER_AMOUNT_REVIEW' AS issue_type
FROM orders
WHERE order_amount = 0;

-- Query 4: unsupported payment statuses.
SELECT
    payment_id,
    order_id,
    payment_status,
    payment_amount,
    source_file,
    loaded_at,
    'UNSUPPORTED_PAYMENT_STATUS' AS issue_type
FROM payments
WHERE payment_status NOT IN ('PAID', 'PENDING', 'FAILED', 'REFUNDED');

-- Query 5: payment amount range review.
SELECT
    payment_id,
    order_id,
    payment_status,
    payment_amount,
    source_file,
    loaded_at,
    'PAYMENT_AMOUNT_RANGE_REVIEW' AS issue_type
FROM payments
WHERE payment_amount < 0;

-- Query 6: product status and price review.
SELECT
    product_id,
    product_code,
    product_status,
    unit_price,
    source_file,
    loaded_at,
    CASE
        WHEN product_status NOT IN ('ACTIVE', 'INACTIVE', 'DISCONTINUED')
        THEN 'UNSUPPORTED_PRODUCT_STATUS'
        WHEN unit_price <= 0
        THEN 'PRODUCT_PRICE_RANGE_REVIEW'
        ELSE 'NO_REVIEW'
    END AS issue_type
FROM products
WHERE product_status NOT IN ('ACTIVE', 'INACTIVE', 'DISCONTINUED')
   OR unit_price <= 0;

