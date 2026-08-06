-- Day 032: Staging Debugging Lab
-- Purpose: Practise finding problems in multi-stage staging logic.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Debug 1: Risky pattern - counting after a mapping join without checking row count.
-- The safer query compares raw and mapped counts.
WITH raw_count AS (
    SELECT COUNT(*) AS row_count
    FROM raw_customer_orders
),
mapped_count AS (
    SELECT COUNT(*) AS row_count
    FROM raw_customer_orders AS r
    LEFT JOIN source_status_mapping AS m
        ON r.raw_status = m.source_status
)
SELECT
    raw_count.row_count AS raw_count,
    mapped_count.row_count AS mapped_count,
    raw_count.row_count - mapped_count.row_count AS difference
FROM raw_count
CROSS JOIN mapped_count;

-- Debug 2: Check whether any status mapping unexpectedly multiplies rows.
-- Input grain: one mapping row.
-- Output grain: one duplicated mapping key if found.
-- Business key: source_status.
SELECT
    source_status,
    COUNT(*) AS mapping_row_count
FROM source_status_mapping
GROUP BY
    source_status
HAVING COUNT(*) > 1
ORDER BY
    source_status;

-- Debug 3: Detect clean key duplication.
-- If this returns rows, the clean handoff does not satisfy one row per order.
SELECT
    order_id,
    COUNT(*) AS row_count
FROM clean_customer_orders
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Debug 4: Detect reporting grain duplication.
-- If this returns rows, reporting consumers may double count.
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

-- Debug 5: Find review rows that lost their reason.
SELECT
    stage_record_id,
    order_id,
    validation_status,
    validation_reason
FROM staged_customer_orders
WHERE validation_status = 'REVIEW'
  AND validation_reason IS NULL
ORDER BY
    stage_record_id;

-- Debug 6: Find accepted rows with obvious critical-field issues.
SELECT
    stage_record_id,
    order_id,
    customer_id,
    standard_status,
    order_amount,
    validation_status
FROM staged_customer_orders
WHERE validation_status = 'ACCEPTED'
  AND (
      order_id IS NULL
      OR customer_id IS NULL
      OR standard_status IS NULL
      OR order_amount IS NULL
      OR order_amount < 0
  )
ORDER BY
    stage_record_id;

-- Debug 7: Inspect same-timestamp order events before trusting ranking.
SELECT
    order_id,
    event_timestamp,
    COUNT(*) AS event_count
FROM raw_customer_orders
GROUP BY
    order_id,
    event_timestamp
HAVING COUNT(*) > 1
ORDER BY
    order_id,
    event_timestamp;

-- Debug 8: Find reporting rows with null measures.
SELECT
    report_date,
    country_group,
    completed_order_count,
    total_completed_amount,
    refund_order_count,
    total_refund_amount,
    pending_order_count
FROM reporting_customer_order_summary
WHERE completed_order_count IS NULL
   OR total_completed_amount IS NULL
   OR refund_order_count IS NULL
   OR total_refund_amount IS NULL
   OR pending_order_count IS NULL
ORDER BY
    report_date,
    country_group;
