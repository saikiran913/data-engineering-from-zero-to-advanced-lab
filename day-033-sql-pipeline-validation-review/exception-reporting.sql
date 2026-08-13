-- Day 033: Exception Reporting
-- Purpose: Preserve records and metrics that need investigation.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Validation queries do not modify source or target data.

-- Query 1: exception queue for duplicate clean order IDs.
-- Source population: clean_order_output.
-- Target population: exception output.
-- Source grain: one clean order.
-- Target grain: one exception per duplicate key.
-- Business key: order_id.
WITH duplicate_clean_orders AS (
    SELECT
        order_id,
        COUNT(*) AS row_count
    FROM clean_order_output
    GROUP BY
        order_id
    HAVING COUNT(*) > 1
)
SELECT
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'DUPLICATE_ORDER_ID' AS check_type,
    1 AS expected_value,
    row_count AS actual_value,
    row_count - 1 AS difference,
    'HIGH_REVIEW' AS severity,
    'Clean order grain should be one row per order.' AS review_message
FROM duplicate_clean_orders;

-- Query 2: exception queue for target-only clean rows.
WITH target_only AS (
    SELECT
        c.order_id,
        c.order_amount,
        c.source_file
    FROM clean_order_output AS c
    LEFT JOIN source_order_extract AS s
        ON c.order_id = s.order_id
    WHERE s.order_id IS NULL
)
SELECT
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'TARGET_ONLY_ORDER' AS check_type,
    0 AS expected_value,
    1 AS actual_value,
    1 AS difference,
    'HIGH_REVIEW' AS severity,
    'Clean order exists without a matching source order.' AS review_message,
    source_file,
    order_amount
FROM target_only;

-- Query 3: exception queue for null reporting metrics.
SELECT
    'REPORTING' AS stage_name,
    report_date || '|' || country_group AS entity_key,
    'NULL_REPORTING_METRIC' AS check_type,
    0 AS expected_value,
    1 AS actual_value,
    1 AS difference,
    'MEDIUM_REVIEW' AS severity,
    'Reporting metric columns should not be null.' AS review_message,
    reporting_loaded_at
FROM reporting_order_metrics
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL;

-- Query 4: combined exception queue.
-- Note: string concatenation operator may vary by SQL platform.
WITH duplicate_clean_orders AS (
    SELECT
        order_id,
        COUNT(*) AS row_count
    FROM clean_order_output
    GROUP BY
        order_id
    HAVING COUNT(*) > 1
),
target_only AS (
    SELECT
        c.order_id
    FROM clean_order_output AS c
    LEFT JOIN source_order_extract AS s
        ON c.order_id = s.order_id
    WHERE s.order_id IS NULL
),
null_reporting AS (
    SELECT
        report_date,
        country_group
    FROM reporting_order_metrics
    WHERE completed_order_count IS NULL
       OR total_completed_amount IS NULL
       OR refund_order_count IS NULL
       OR total_refund_amount IS NULL
       OR pending_order_count IS NULL
)
SELECT
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'DUPLICATE_ORDER_ID' AS check_type,
    'HIGH_REVIEW' AS severity,
    'Clean order grain should be one row per order.' AS review_message
FROM duplicate_clean_orders
UNION ALL
SELECT
    'CLEAN' AS stage_name,
    order_id AS entity_key,
    'TARGET_ONLY_ORDER' AS check_type,
    'HIGH_REVIEW' AS severity,
    'Clean order exists without a matching source order.' AS review_message
FROM target_only
UNION ALL
SELECT
    'REPORTING' AS stage_name,
    report_date || '|' || country_group AS entity_key,
    'NULL_REPORTING_METRIC' AS check_type,
    'MEDIUM_REVIEW' AS severity,
    'Reporting metric columns should not be null.' AS review_message
FROM null_reporting
ORDER BY
    stage_name,
    check_type,
    entity_key;
