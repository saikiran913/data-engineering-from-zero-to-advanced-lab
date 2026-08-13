-- Day 036: Exception Deduplication Review
-- Purpose: Identify repeated exception rows without hiding distinct issue types.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Exception queries do not modify or correct data.

-- Query 1: duplicate conceptual exception keys in a combined queue.
WITH exception_queue AS (
    SELECT
        'SOURCE' AS stage_name,
        order_id AS entity_key,
        'NULL_CUSTOMER_ID' AS issue_type
    FROM source_order_data
    WHERE customer_id IS NULL
    UNION ALL
    SELECT
        'SOURCE' AS stage_name,
        order_id AS entity_key,
        'NULL_CUSTOMER_ID' AS issue_type
    FROM source_order_data
    WHERE customer_id IS NULL
)
SELECT
    stage_name,
    entity_key,
    issue_type,
    COUNT(*) AS exception_row_count
FROM exception_queue
GROUP BY stage_name, entity_key, issue_type
HAVING COUNT(*) > 1
ORDER BY stage_name, entity_key, issue_type;

-- Query 2: one record with multiple issue types should remain separate.
WITH issue_queue AS (
    SELECT order_id AS entity_key, 'NULL_CUSTOMER_ID' AS issue_type
    FROM source_order_data
    WHERE customer_id IS NULL
    UNION ALL
    SELECT order_id AS entity_key, 'NEGATIVE_ORDER_AMOUNT' AS issue_type
    FROM source_order_data
    WHERE order_amount < 0
    UNION ALL
    SELECT order_id AS entity_key, 'UNSUPPORTED_STATUS' AS issue_type
    FROM source_order_data
    WHERE order_status IN ('UNKNOWN', 'FAILED')
)
SELECT
    entity_key,
    COUNT(*) AS exception_row_count,
    COUNT(DISTINCT issue_type) AS distinct_issue_type_count
FROM issue_queue
GROUP BY entity_key
ORDER BY entity_key;
