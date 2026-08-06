-- Day 031: Checkpoint Validation Workflows
-- Purpose: Practise stage checkpoints with clear grain, accepted rules, review rules, and handoff notes.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Workflow 1: Raw events to staged orders.
-- Input layer: raw. Input grain: one row per received order event.
-- Output layer: stage. Output grain: one row per selected order candidate.
SELECT
    COUNT(DISTINCT order_id) AS raw_distinct_orders,
    (SELECT COUNT(*) FROM staged_orders) AS staged_order_candidates
FROM raw_order_events;

-- Workflow 2: Staged orders to clean orders.
-- Accepted criteria: validation_status = ACCEPTED.
SELECT
    (SELECT COUNT(*) FROM staged_orders WHERE validation_status = 'ACCEPTED') AS accepted_stage_count,
    (SELECT COUNT(*) FROM clean_orders) AS clean_order_count;

-- Workflow 3: Clean orders to reporting summary.
-- Reporting row counts differ because reporting is aggregated.
SELECT
    order_status,
    COUNT(*) AS clean_order_count,
    SUM(order_amount) AS clean_order_total
FROM clean_orders
GROUP BY order_status;

-- Workflow 4: Duplicate investigation checkpoint.
SELECT
    order_id,
    COUNT(*) AS staged_candidate_count
FROM staged_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Workflow 5: Invalid amount review checkpoint.
SELECT
    stage_record_id,
    order_id,
    order_amount,
    validation_reason
FROM staged_orders
WHERE order_amount IS NULL
   OR order_amount <= 0;

-- Workflow 6: Late-arriving record checkpoint.
SELECT
    stage_record_id,
    order_id,
    event_timestamp,
    received_at,
    'TIMING_REVIEW' AS checkpoint_status
FROM staged_orders
WHERE received_at < event_timestamp;

-- Workflow 7: Reporting total reconciliation.
SELECT
    (SELECT SUM(order_amount) FROM clean_orders WHERE order_status = 'COMPLETED') AS clean_completed_total,
    (SELECT SUM(total_completed_amount) FROM reporting_order_summary) AS reporting_completed_total,
    (SELECT SUM(total_completed_amount) FROM reporting_order_summary)
      - (SELECT SUM(order_amount) FROM clean_orders WHERE order_status = 'COMPLETED') AS difference;

-- Checkpoint-design checklist.
SELECT
    'DEFINE_INPUT_GRAIN' AS checklist_item
UNION ALL
SELECT 'DEFINE_OUTPUT_GRAIN'
UNION ALL
SELECT 'PRESERVE_AUDIT_COLUMNS'
UNION ALL
SELECT 'SEPARATE_ACCEPTED_AND_REVIEW_ROWS'
UNION ALL
SELECT 'VALIDATE_COUNTS_KEYS_NULLS_TOTALS_DATES'
UNION ALL
SELECT 'DOCUMENT_HANDOFF_CONDITIONS';
