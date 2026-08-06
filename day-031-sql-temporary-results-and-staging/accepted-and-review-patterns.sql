-- Day 031: Accepted and Review Patterns
-- Purpose: Keep accepted rows and review rows visible with explicit reasons.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Null-key review.
SELECT
    'ORDER_STAGE' AS stage_name,
    order_id AS entity_key,
    'NULL_KEY' AS rule_name,
    customer_id AS source_value,
    'HIGH_REVIEW' AS severity,
    'Customer ID or order ID is missing.' AS review_message
FROM staged_orders
WHERE order_id IS NULL
   OR customer_id IS NULL;

-- Invalid-amount review.
SELECT
    'ORDER_STAGE' AS stage_name,
    order_id AS entity_key,
    'INVALID_AMOUNT' AS rule_name,
    order_amount AS source_value,
    'HIGH_REVIEW' AS severity,
    'Order amount should be positive and present.' AS review_message
FROM staged_orders
WHERE order_amount IS NULL
   OR order_amount <= 0;

-- Duplicate-key review.
SELECT
    'ORDER_STAGE' AS stage_name,
    order_id AS entity_key,
    'DUPLICATE_ORDER_CANDIDATE' AS rule_name,
    COUNT(*) AS source_value,
    'HIGH_REVIEW' AS severity,
    'More than one staged candidate exists for the same order.' AS review_message
FROM staged_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Missing-timestamp review.
SELECT
    'ORDER_STAGE' AS stage_name,
    order_id AS entity_key,
    'MISSING_TIMESTAMP' AS rule_name,
    event_timestamp AS source_value,
    'REVIEW' AS severity,
    'Event timestamp is required for sequence decisions.' AS review_message
FROM staged_orders
WHERE event_timestamp IS NULL;

-- Unsupported-status review.
SELECT
    order_id,
    latest_event_type,
    validation_reason
FROM staged_orders
WHERE validation_reason = 'UNSUPPORTED_STATUS';

-- Late-arriving-record review.
SELECT
    order_id,
    event_timestamp,
    received_at,
    'RECEIVED_BEFORE_EVENT_TIME' AS review_reason
FROM staged_orders
WHERE received_at < event_timestamp;

-- Accepted output.
SELECT
    order_id,
    customer_id,
    latest_event_type,
    order_amount,
    event_timestamp,
    source_file,
    received_at
FROM staged_orders
WHERE validation_status = 'ACCEPTED';

-- Review output.
SELECT
    order_id,
    customer_id,
    latest_event_type,
    order_amount,
    validation_reason,
    source_file,
    received_at
FROM staged_orders
WHERE validation_status = 'REVIEW';

-- Combined review queue.
SELECT
    'ORDER_STAGE' AS stage_name,
    order_id AS entity_key,
    validation_reason AS rule_name,
    validation_reason AS issue_type,
    order_amount AS source_value,
    CASE
        WHEN validation_reason IN ('NULL_CUSTOMER_ID', 'INVALID_AMOUNT') THEN 'HIGH_REVIEW'
        ELSE 'REVIEW'
    END AS severity,
    'Record requires investigation before clean-layer handoff.' AS review_message
FROM staged_orders
WHERE validation_status = 'REVIEW';

-- Validation summary.
SELECT
    validation_status,
    validation_reason,
    COUNT(*) AS record_count
FROM staged_orders
GROUP BY validation_status, validation_reason
ORDER BY validation_status, validation_reason;
