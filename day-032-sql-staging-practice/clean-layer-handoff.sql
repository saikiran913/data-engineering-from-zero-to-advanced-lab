-- Day 032: Clean-Layer Handoff Practice
-- Purpose: Validate one-row-per-order clean output before reporting.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No staging or temporary object is deployed.

-- Query 1: inspect clean handoff rows.
-- Input grain: one clean order.
-- Output grain: one clean order.
-- Business key: order_id.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    order_date,
    country_group,
    source_event_id,
    source_file,
    received_at,
    cleaned_at
FROM clean_customer_orders
ORDER BY
    order_date,
    order_id;

-- Query 2: validate clean key uniqueness.
-- Input grain: one clean order.
-- Output grain: one duplicate order key if found.
-- Business key: order_id.
SELECT
    order_id,
    COUNT(*) AS clean_row_count
FROM clean_customer_orders
GROUP BY
    order_id
HAVING COUNT(*) > 1
ORDER BY
    order_id;

-- Query 3: find clean rows with missing critical fields.
-- Input grain: one clean order.
-- Output grain: one problematic clean order.
-- Business key: order_id.
SELECT
    order_id,
    customer_id,
    order_status,
    order_amount,
    order_date,
    country_group
FROM clean_customer_orders
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR order_status IS NULL
   OR order_amount IS NULL
   OR order_date IS NULL
   OR country_group IS NULL
ORDER BY
    order_id;

-- Query 4: find invalid clean amounts.
-- Input grain: one clean order.
-- Output grain: one clean order with invalid amount.
-- Business key: order_id.
SELECT
    order_id,
    order_status,
    order_amount,
    source_event_id,
    source_file
FROM clean_customer_orders
WHERE order_amount < 0
ORDER BY
    order_id;

-- Query 5: compare accepted staged rows to clean rows.
-- Input grain: accepted staged and clean populations.
-- Output grain: one reconciliation row.
-- Business key: order_id.
WITH accepted_count AS (
    SELECT
        COUNT(*) AS row_count
    FROM staged_customer_orders
    WHERE validation_status = 'ACCEPTED'
),
clean_count AS (
    SELECT
        COUNT(*) AS row_count
    FROM clean_customer_orders
)
SELECT
    accepted_count.row_count AS accepted_stage_count,
    clean_count.row_count AS clean_order_count,
    accepted_count.row_count - clean_count.row_count AS count_difference
FROM accepted_count
CROSS JOIN clean_count;

-- Query 6: clean amount totals by status.
-- Input grain: one clean order.
-- Output grain: one row per clean order status.
-- Business key: order_status.
SELECT
    order_status,
    COUNT(*) AS order_count,
    SUM(order_amount) AS amount_total
FROM clean_customer_orders
GROUP BY
    order_status
ORDER BY
    order_status;
