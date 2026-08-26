-- Day 038: Integrated Constraint Validation Workflow
-- Purpose: Combine key, relationship, domain, range, and required-field checks.
-- Safety: All executable SQL is read-only and SELECT-based.
-- This workflow reports violations only; it does not create or change constraints.
-- Grain: one exception row per constraint-like issue.

WITH customer_key_nulls AS (
    SELECT
        'customers' AS table_name,
        customer_name AS entity_key,
        'PRIMARY_KEY' AS constraint_concept,
        'NULL_CUSTOMER_ID' AS issue_type,
        'HIGH_REVIEW' AS severity,
        source_file,
        loaded_at,
        'customer_id should be non-null.' AS review_message
    FROM customers
    WHERE customer_id IS NULL
),
order_key_duplicates AS (
    SELECT
        'orders' AS table_name,
        order_id AS entity_key,
        'PRIMARY_KEY' AS constraint_concept,
        'DUPLICATE_ORDER_ID' AS issue_type,
        'HIGH_REVIEW' AS severity,
        NULL AS source_file,
        NULL AS loaded_at,
        'order_id should be unique.' AS review_message
    FROM orders
    WHERE order_id IS NOT NULL
    GROUP BY order_id
    HAVING COUNT(*) > 1
),
order_customer_orphans AS (
    SELECT
        'orders' AS table_name,
        o.order_id AS entity_key,
        'FOREIGN_KEY' AS constraint_concept,
        'ORPHAN_ORDER_CUSTOMER' AS issue_type,
        'HIGH_REVIEW' AS severity,
        o.source_file,
        o.loaded_at,
        'orders.customer_id does not match a customer.' AS review_message
    FROM orders AS o
    LEFT JOIN customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.customer_id IS NOT NULL
      AND c.customer_id IS NULL
),
payment_order_orphans AS (
    SELECT
        'payments' AS table_name,
        payment_id AS entity_key,
        'FOREIGN_KEY' AS constraint_concept,
        'ORPHAN_PAYMENT_ORDER' AS issue_type,
        'HIGH_REVIEW' AS severity,
        p.source_file,
        p.loaded_at,
        'payments.order_id does not match an order.' AS review_message
    FROM payments AS p
    LEFT JOIN orders AS o
        ON p.order_id = o.order_id
    WHERE p.order_id IS NOT NULL
      AND o.order_id IS NULL
),
bad_order_status AS (
    SELECT
        'orders' AS table_name,
        order_id AS entity_key,
        'CHECK' AS constraint_concept,
        'UNSUPPORTED_ORDER_STATUS' AS issue_type,
        'REVIEW' AS severity,
        source_file,
        loaded_at,
        'order_status is outside the documented list.' AS review_message
    FROM orders
    WHERE order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED')
),
missing_product_code AS (
    SELECT
        'products' AS table_name,
        product_id AS entity_key,
        'NOT_NULL' AS constraint_concept,
        'NULL_PRODUCT_CODE' AS issue_type,
        'HIGH_REVIEW' AS severity,
        source_file,
        loaded_at,
        'product_code is required for product lookup.' AS review_message
    FROM products
    WHERE product_code IS NULL
)
SELECT
    table_name,
    entity_key,
    constraint_concept,
    issue_type,
    severity,
    source_file,
    loaded_at,
    review_message
FROM customer_key_nulls

UNION ALL

SELECT table_name, entity_key, constraint_concept, issue_type, severity, source_file, loaded_at, review_message
FROM order_key_duplicates

UNION ALL

SELECT table_name, entity_key, constraint_concept, issue_type, severity, source_file, loaded_at, review_message
FROM order_customer_orphans

UNION ALL

SELECT table_name, entity_key, constraint_concept, issue_type, severity, source_file, loaded_at, review_message
FROM payment_order_orphans

UNION ALL

SELECT table_name, entity_key, constraint_concept, issue_type, severity, source_file, loaded_at, review_message
FROM bad_order_status

UNION ALL

SELECT table_name, entity_key, constraint_concept, issue_type, severity, source_file, loaded_at, review_message
FROM missing_product_code;

-- Summary: rules by concept after reviewing the exception queue.
SELECT
    constraint_concept,
    COUNT(*) AS documented_rule_count
FROM constraint_rules
GROUP BY constraint_concept
ORDER BY constraint_concept;
