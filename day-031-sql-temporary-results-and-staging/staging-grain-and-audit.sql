-- Day 031: Staging Grain and Audit
-- Purpose: Review grain and auditability across raw, staged, clean, and reporting layers.
-- Safety: Read-only SELECT examples only. No temporary or staging object is deployed automatically.

-- Source grain: one row per received order event.
SELECT COUNT(*) AS raw_event_rows
FROM raw_order_events;

-- Stage grain: one row per selected order candidate.
SELECT COUNT(*) AS staged_order_candidates
FROM staged_orders;

-- Clean grain: one row per clean order.
SELECT COUNT(*) AS clean_order_rows
FROM clean_orders;

-- Reporting grain: one row per report date and country group.
SELECT COUNT(*) AS reporting_rows
FROM reporting_order_summary;

-- Key validation per stage.
SELECT event_id, COUNT(*) AS raw_event_delivery_count
FROM raw_order_events
GROUP BY event_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS staged_order_count
FROM staged_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS clean_order_count
FROM clean_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Audit-column check.
SELECT
    stage_record_id,
    order_id,
    source_file,
    received_at
FROM staged_orders
WHERE source_file IS NULL
   OR received_at IS NULL;

-- Source-file lineage and received-time lineage.
SELECT
    source_file,
    COUNT(*) AS staged_rows,
    MIN(received_at) AS first_received_at,
    MAX(received_at) AS latest_received_at
FROM staged_orders
GROUP BY source_file
ORDER BY source_file;

-- Selected-record lineage.
SELECT
    order_id,
    latest_event_type,
    validation_status,
    validation_reason,
    source_file,
    received_at,
    event_timestamp
FROM staged_orders
ORDER BY order_id, received_at;

-- Grain-change documentation.
SELECT
    'raw_order_events' AS layer_name,
    'one row per received order event' AS documented_grain
UNION ALL
SELECT 'staged_orders', 'one row per selected order candidate'
UNION ALL
SELECT 'clean_orders', 'one row per clean order'
UNION ALL
SELECT 'reporting_order_summary', 'one row per report date and country group';

-- Accidental row-multiplication review.
SELECT
    report_date,
    country_group,
    COUNT(*) AS reporting_rows
FROM reporting_order_summary
GROUP BY report_date, country_group
HAVING COUNT(*) > 1;

-- Audit-review summary.
SELECT
    'MISSING_STAGE_AUDIT_FIELDS' AS check_name,
    COUNT(*) AS issue_count,
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'REVIEW' END AS status,
    'Staged records should preserve source_file and received_at.' AS review_message
FROM staged_orders
WHERE source_file IS NULL
   OR received_at IS NULL;
