-- Day 031: Stage to Clean Validation
-- Purpose: Validate staged accepted records before clean-layer handoff.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Stage accepted count.
SELECT COUNT(*) AS stage_accepted_count
FROM staged_orders
WHERE validation_status = 'ACCEPTED';

-- Clean row count.
SELECT COUNT(*) AS clean_row_count
FROM clean_orders;

-- Key uniqueness.
SELECT
    order_id,
    COUNT(*) AS clean_order_count
FROM clean_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Null critical columns.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount
FROM clean_orders
WHERE customer_id IS NULL
   OR order_status IS NULL
   OR order_amount IS NULL;

-- Invalid amount review.
SELECT
    order_id,
    order_amount
FROM clean_orders
WHERE order_amount <= 0;

-- Status standardisation check.
SELECT
    order_status,
    COUNT(*) AS row_count
FROM clean_orders
GROUP BY order_status
ORDER BY order_status;

-- Audit-column availability.
SELECT
    order_id,
    source_file,
    received_at,
    cleaned_at
FROM clean_orders
WHERE source_file IS NULL
   OR received_at IS NULL
   OR cleaned_at IS NULL;

-- Stage-to-clean total reconciliation.
SELECT
    (SELECT SUM(order_amount) FROM staged_orders WHERE validation_status = 'ACCEPTED') AS stage_accepted_total,
    (SELECT SUM(order_amount) FROM clean_orders) AS clean_total,
    (SELECT SUM(order_amount) FROM clean_orders)
      - (SELECT SUM(order_amount) FROM staged_orders WHERE validation_status = 'ACCEPTED') AS difference;

-- Records excluded from clean output.
SELECT
    stage_record_id,
    order_id,
    validation_status,
    validation_reason
FROM staged_orders
WHERE validation_status = 'REVIEW';

-- Clean-output summary.
WITH checks AS (
    SELECT
        'STAGE_ACCEPTED_TO_CLEAN_COUNT' AS check_name,
        (SELECT COUNT(*) FROM staged_orders WHERE validation_status = 'ACCEPTED') AS stage_value,
        (SELECT COUNT(*) FROM clean_orders) AS clean_value,
        'Accepted staged records should reconcile to clean rows when grain matches.' AS review_message
    UNION ALL
    SELECT
        'STAGE_ACCEPTED_TO_CLEAN_TOTAL',
        (SELECT SUM(order_amount) FROM staged_orders WHERE validation_status = 'ACCEPTED'),
        (SELECT SUM(order_amount) FROM clean_orders),
        'Accepted staged amount should reconcile to clean amount.'
)
SELECT
    check_name,
    stage_value,
    clean_value,
    clean_value - stage_value AS difference,
    CASE WHEN stage_value = clean_value THEN 'PASS' ELSE 'REVIEW' END AS status,
    review_message
FROM checks;
