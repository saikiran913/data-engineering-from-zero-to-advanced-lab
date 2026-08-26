-- Day 038: Constraint Exception Reporting
-- Purpose: Convert constraint-like validation findings into review-queue rows.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Constraint validation only reports issues; it does not define, enable, disable, or change constraints.
-- Grain: one exception row per rule violation.

-- Query 1: combined constraint exception queue.
WITH null_customer_key AS (
    SELECT
        'CUSTOMERS' AS table_name,
        customer_name AS entity_key,
        'PRIMARY_KEY' AS constraint_concept,
        'NULL_CUSTOMER_ID' AS issue_type,
        'customer_id should be non-null' AS expected_rule,
        'customer_id is null' AS actual_result,
        'HIGH_REVIEW' AS severity,
        source_file,
        loaded_at,
        'Customer key is missing.' AS review_message
    FROM customers
    WHERE customer_id IS NULL
),
duplicate_order_key AS (
    SELECT
        'ORDERS' AS table_name,
        order_id AS entity_key,
        'PRIMARY_KEY' AS constraint_concept,
        'DUPLICATE_ORDER_ID' AS issue_type,
        'order_id should be unique' AS expected_rule,
        'order_id appears more than once' AS actual_result,
        'HIGH_REVIEW' AS severity,
        NULL AS source_file,
        NULL AS loaded_at,
        'Order key is duplicated at clean grain.' AS review_message
    FROM orders
    WHERE order_id IS NOT NULL
    GROUP BY order_id
    HAVING COUNT(*) > 1
),
orphan_order AS (
    SELECT
        'ORDERS' AS table_name,
        o.order_id AS entity_key,
        'FOREIGN_KEY' AS constraint_concept,
        'ORPHAN_ORDER_CUSTOMER' AS issue_type,
        'orders.customer_id should match customers.customer_id' AS expected_rule,
        'No matching customer found' AS actual_result,
        'HIGH_REVIEW' AS severity,
        o.source_file,
        o.loaded_at,
        'Order references a customer that is not present in customers.' AS review_message
    FROM orders AS o
    LEFT JOIN customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.customer_id IS NOT NULL
      AND c.customer_id IS NULL
),
bad_order_status AS (
    SELECT
        'ORDERS' AS table_name,
        order_id AS entity_key,
        'CHECK' AS constraint_concept,
        'UNSUPPORTED_ORDER_STATUS' AS issue_type,
        'order_status should be in the documented allowed list' AS expected_rule,
        order_status AS actual_result,
        'REVIEW' AS severity,
        source_file,
        loaded_at,
        'Order status is outside the documented list.' AS review_message
    FROM orders
    WHERE order_status NOT IN ('COMPLETED', 'PENDING', 'CANCELLED', 'REFUNDED')
)
SELECT
    table_name,
    entity_key,
    constraint_concept,
    issue_type,
    expected_rule,
    actual_result,
    severity,
    source_file,
    loaded_at,
    review_message
FROM null_customer_key

UNION ALL

SELECT
    table_name,
    entity_key,
    constraint_concept,
    issue_type,
    expected_rule,
    actual_result,
    severity,
    source_file,
    loaded_at,
    review_message
FROM duplicate_order_key

UNION ALL

SELECT
    table_name,
    entity_key,
    constraint_concept,
    issue_type,
    expected_rule,
    actual_result,
    severity,
    source_file,
    loaded_at,
    review_message
FROM orphan_order

UNION ALL

SELECT
    table_name,
    entity_key,
    constraint_concept,
    issue_type,
    expected_rule,
    actual_result,
    severity,
    source_file,
    loaded_at,
    review_message
FROM bad_order_status;

