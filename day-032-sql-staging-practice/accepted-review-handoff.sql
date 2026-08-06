-- Day 032: Accepted and Review Handoff Practice
-- Purpose: Separate accepted and review populations while reconciling counts.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: accepted population for clean handoff.
-- Input grain: one staged candidate.
-- Output grain: one accepted staged candidate.
-- Business key: order_id.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    order_date,
    country_group,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED'
ORDER BY
    order_date,
    order_id;

-- Query 2: review population for investigation.
-- Input grain: one staged candidate.
-- Output grain: one review staged candidate.
-- Business key: stage_record_id.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    order_date,
    country_group,
    validation_reason,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'REVIEW'
ORDER BY
    validation_reason,
    order_id;

-- Query 3: accepted and review reconciliation.
-- Input grain: staged population.
-- Output grain: one reconciliation row.
-- Business key: not applicable.
WITH population_counts AS (
    SELECT
        COUNT(*) AS staged_count,
        SUM(
            CASE
                WHEN validation_status = 'ACCEPTED' THEN 1
                ELSE 0
            END
        ) AS accepted_count,
        SUM(
            CASE
                WHEN validation_status = 'REVIEW' THEN 1
                ELSE 0
            END
        ) AS review_count
    FROM staged_customer_orders
)
SELECT
    staged_count,
    accepted_count,
    review_count,
    staged_count - accepted_count - review_count AS unexplained_difference
FROM population_counts;

-- Query 4: combined review queue with issue categories.
-- Input grain: one staged candidate.
-- Output grain: one review queue row.
-- Business key: stage_record_id.
SELECT
    stage_record_id,
    order_id,
    validation_reason AS issue_category,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE validation_status = 'REVIEW'
UNION ALL
SELECT
    stage_record_id,
    order_id,
    'MISSING_AUDIT_COLUMN_CHECK' AS issue_category,
    source_event_id,
    source_file,
    received_at
FROM staged_customer_orders
WHERE source_event_id IS NULL
   OR source_file IS NULL
   OR received_at IS NULL
ORDER BY
    issue_category,
    order_id;

-- Query 5: accepted rows by order status.
-- Input grain: one accepted staged candidate.
-- Output grain: one row per standard status.
-- Business key: standard_status.
SELECT
    standard_status,
    COUNT(*) AS accepted_row_count,
    SUM(order_amount) AS accepted_amount_total
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED'
GROUP BY
    standard_status
ORDER BY
    standard_status;
