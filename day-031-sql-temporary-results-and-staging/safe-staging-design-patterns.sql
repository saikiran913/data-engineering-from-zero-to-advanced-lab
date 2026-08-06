-- Day 031: Safe Staging Design Patterns
-- Purpose: Show safe, readable staging patterns using SELECT-based examples.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Pattern 1: One clear purpose per stage.
SELECT
    'staged_orders' AS stage_name,
    'select latest order candidate and classify accepted or review rows' AS purpose;

-- Pattern 2: Explicit input and output grain.
SELECT
    'raw_order_events' AS input_object,
    'one row per received order event' AS input_grain,
    'staged_orders' AS output_object,
    'one row per selected order candidate' AS output_grain;

-- Pattern 3: Preserve audit columns.
SELECT
    order_id,
    source_file,
    received_at
FROM staged_orders;

-- Pattern 4: Separate accepted and review rows.
SELECT validation_status, COUNT(*) AS row_count
FROM staged_orders
GROUP BY validation_status;

-- Pattern 5: Validate before handoff.
SELECT
    order_id,
    COUNT(*) AS clean_order_count
FROM clean_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Pattern 6: Deduplicate before aggregation.
WITH selected_orders AS (
    SELECT
        order_id,
        order_amount,
        order_status
    FROM clean_orders
)
SELECT
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS order_total
FROM selected_orders
GROUP BY order_status;

-- Pattern 7: Standardise before joining.
SELECT
    order_id,
    CASE
        WHEN latest_event_type = 'ORDER_COMPLETED' THEN 'COMPLETED'
        WHEN latest_event_type = 'ORDER_REFUNDED' THEN 'REFUNDED'
        WHEN latest_event_type = 'ORDER_REFUND_REQUESTED' THEN 'REFUND_REQUESTED'
        ELSE 'STATUS_REVIEW'
    END AS standard_order_status
FROM staged_orders;

-- Pattern 8: Aggregate only after clean grain is established.
SELECT
    order_date,
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS order_amount_total
FROM clean_orders
GROUP BY order_date, order_status;

-- Pattern 9: Keep review reasons explicit.
SELECT
    order_id,
    validation_status,
    validation_reason
FROM staged_orders
WHERE validation_status = 'REVIEW';

-- Pattern 10: Reconcile totals between stages.
SELECT
    (SELECT SUM(order_amount) FROM staged_orders WHERE validation_status = 'ACCEPTED') AS stage_total,
    (SELECT SUM(order_amount) FROM clean_orders) AS clean_total;

-- Pattern 11: Avoid unnecessary stages.
SELECT
    case_id,
    business_question,
    recommended_action
FROM pipeline_stage_casebook
WHERE intermediate_method = 'no-extra-stage-needed';

-- Pattern 12: Use clear stage names.
SELECT
    stage_name,
    rule_name,
    severity
FROM staging_validation_rules
ORDER BY stage_name, rule_id;
