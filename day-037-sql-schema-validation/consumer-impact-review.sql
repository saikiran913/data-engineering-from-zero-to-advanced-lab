-- Day 037: Consumer Impact Review
-- Purpose: Identify consumers that may be affected by schema changes.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Consumer review does not update queries, reports, or schema objects.
-- Expected schema version: expected_order_schema.
-- Observed schema version: observed_order_schema_v2.
-- Comparison key: consumer metadata and schema-change categories.

-- Query 1: inspect the consumer catalog.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    required_columns,
    expected_types,
    expected_grain,
    select_star_usage,
    change_sensitivity,
    owner_role
FROM schema_consumer_catalog
ORDER BY consumer_id;

-- Query 2: consumers using SELECT star.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    select_star_usage,
    change_sensitivity,
    owner_role,
    'SELECT_STAR_SCHEMA_CHANGE_RISK' AS issue_type,
    'REVIEW' AS severity,
    'Consumer may be affected when columns are added, removed, or reordered.' AS review_message
FROM schema_consumer_catalog
WHERE select_star_usage = 'Yes'
ORDER BY consumer_id;

-- Query 3: high-sensitivity consumers.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    required_columns,
    change_sensitivity,
    owner_role,
    'HIGH_SENSITIVITY_CONSUMER' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'Consumer is marked high sensitivity and should be reviewed for schema drift.' AS review_message
FROM schema_consumer_catalog
WHERE change_sensitivity = 'High'
ORDER BY consumer_id;

-- Query 4: consumers that mention customer_id in required columns.
-- This is a simple text search in the supplied educational catalog.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    required_columns,
    'CUSTOMER_ID_CONSUMER_RISK' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'customer_id is missing from V2 and this consumer expects it.' AS review_message
FROM schema_consumer_catalog
WHERE required_columns LIKE '%customer_id%'
ORDER BY consumer_id;

-- Query 5: consumers that mention order_amount in required columns.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    expected_types,
    'ORDER_AMOUNT_TYPE_CHANGE_RISK' AS issue_type,
    'HIGH_REVIEW' AS severity,
    'order_amount changed from DECIMAL to TEXT in V2 and may affect numeric logic.' AS review_message
FROM schema_consumer_catalog
WHERE required_columns LIKE '%order_amount%'
ORDER BY consumer_id;

