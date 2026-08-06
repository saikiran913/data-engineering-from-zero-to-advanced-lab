-- Day 032: Checkpoint Reconciliation Practice
-- Purpose: Compare counts, keys, dates, and totals across stages.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: source row count.
-- Input grain: one raw event.
-- Output grain: one count row.
-- Business key: not applicable.
SELECT
    COUNT(*) AS raw_event_count
FROM raw_customer_orders;

-- Query 2: staged row count.
SELECT
    COUNT(*) AS staged_candidate_count
FROM staged_customer_orders;

-- Query 3: clean row count.
SELECT
    COUNT(*) AS clean_order_count
FROM clean_customer_orders;

-- Query 4: reporting row count.
SELECT
    COUNT(*) AS reporting_row_count
FROM reporting_customer_order_summary;

-- Query 5: accepted and review count reconciliation.
-- Input grain: one staged candidate.
-- Output grain: one reconciliation row.
-- Business key: not applicable.
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
    ) AS review_count,
    COUNT(*)
        - SUM(
            CASE
                WHEN validation_status = 'ACCEPTED' THEN 1
                ELSE 0
            END
        )
        - SUM(
            CASE
                WHEN validation_status = 'REVIEW' THEN 1
                ELSE 0
            END
        ) AS unexplained_difference
FROM staged_customer_orders;

-- Query 6: raw distinct order count.
SELECT
    COUNT(order_id) AS non_null_order_id_rows
FROM raw_customer_orders;

-- Query 7: clean key uniqueness check.
SELECT
    order_id,
    COUNT(*) AS row_count
FROM clean_customer_orders
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 8: reporting grain uniqueness check.
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_customer_order_summary
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;

-- Query 9: source date coverage.
SELECT
    MIN(event_timestamp) AS earliest_event_timestamp,
    MAX(event_timestamp) AS latest_event_timestamp,
    MIN(received_at) AS earliest_received_at,
    MAX(received_at) AS latest_received_at
FROM raw_customer_orders;

-- Query 10: clean date coverage.
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM clean_customer_orders;

-- Query 11: total order amount by clean status.
SELECT
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS amount_total
FROM clean_customer_orders
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 12: review reason count.
SELECT
    validation_reason,
    COUNT(*) AS review_count
FROM staged_customer_orders
WHERE validation_status = 'REVIEW'
GROUP BY
    validation_reason
ORDER BY
    validation_reason;

-- Query 13: audit column presence in staged data.
SELECT
    COUNT(*) AS missing_audit_row_count
FROM staged_customer_orders
WHERE source_event_id IS NULL
   OR source_file IS NULL
   OR received_at IS NULL;

-- Query 14: audit column presence in clean data.
SELECT
    COUNT(*) AS missing_clean_audit_row_count
FROM clean_customer_orders
WHERE source_event_id IS NULL
   OR source_file IS NULL
   OR received_at IS NULL
   OR cleaned_at IS NULL;
