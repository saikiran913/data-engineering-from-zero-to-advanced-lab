-- Day 036: Exception Summary Reporting
-- Purpose: Summarise review queue rows by stage, category, type, and severity.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: summary from a simple exception queue.
WITH exception_queue AS (
    SELECT 'SOURCE' AS stage_name, order_id AS entity_key, 'REQUIRED_FIELD' AS issue_category, 'NULL_CUSTOMER_ID' AS issue_type, 'HIGH_REVIEW' AS severity
    FROM source_order_data
    WHERE customer_id IS NULL
    UNION ALL
    SELECT 'SOURCE', order_id, 'VALUE_MISMATCH', 'NEGATIVE_ORDER_AMOUNT', 'REVIEW'
    FROM source_order_data
    WHERE order_amount < 0
    UNION ALL
    SELECT 'CLEAN', order_id, 'DUPLICATE_KEY', 'DUPLICATE_ORDER_ID', 'HIGH_REVIEW'
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    stage_name,
    issue_category,
    issue_type,
    severity,
    COUNT(*) AS exception_row_count,
    COUNT(DISTINCT entity_key) AS affected_entity_count
FROM exception_queue
GROUP BY stage_name, issue_category, issue_type, severity
ORDER BY severity, stage_name, issue_category, issue_type;

-- Query 2: summary by severity only.
WITH exception_queue AS (
    SELECT order_id AS entity_key, 'HIGH_REVIEW' AS severity
    FROM source_order_data
    WHERE customer_id IS NULL
    UNION ALL
    SELECT order_id, 'REVIEW'
    FROM source_order_data
    WHERE order_amount < 0
    UNION ALL
    SELECT order_id, 'HIGH_REVIEW'
    FROM clean_order_data
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
SELECT
    severity,
    COUNT(*) AS exception_row_count,
    COUNT(DISTINCT entity_key) AS affected_entity_count
FROM exception_queue
GROUP BY severity
ORDER BY severity;
