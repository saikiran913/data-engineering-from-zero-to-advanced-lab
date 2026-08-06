-- Day 030: Table Versus View Comparison
-- Purpose: Compare stored-row interfaces and reusable query interfaces.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Conceptual DDL only:
-- CREATE TABLE raw_customer_events (...);
-- This is a comment for learning, not an executable production design.

-- Raw event table versus current-state event view.
-- Table grain: one row per event delivery. View grain: one row per event_id.
WITH current_state_event_logic AS (
    SELECT
        event_id,
        customer_id,
        event_type,
        event_timestamp,
        event_value,
        received_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY event_id
            ORDER BY received_at DESC, source_file DESC
        ) AS row_num
    FROM raw_customer_events
)
SELECT
    'raw table keeps history; current-state logic keeps latest event version' AS comparison_note,
    COUNT(*) AS current_state_rows
FROM current_state_event_logic
WHERE row_num = 1;

-- Clean customer table versus customer reporting view.
SELECT
    COUNT(*) AS clean_customer_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids
FROM clean_customers;

-- Stored daily reporting table versus calculated reporting view.
WITH calculated_sales AS (
    SELECT
        order_date AS report_date,
        'All Regions' AS region,
        COUNT(*) AS total_orders,
        SUM(order_amount) AS total_sales
    FROM order_transactions
    WHERE order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY order_date
)
SELECT
    report_date,
    region,
    total_orders,
    total_sales
FROM calculated_sales
ORDER BY report_date;

-- Stable stored snapshot versus live query interface.
SELECT
    MIN(reporting_loaded_at) AS first_loaded_at,
    MAX(reporting_loaded_at) AS latest_loaded_at
FROM daily_sales_reporting;

-- History table versus latest-record view.
SELECT
    order_id,
    COUNT(*) AS order_version_count
FROM order_transactions
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Exception table concept versus exception view logic.
-- An exception table might store review history. An exception view shows current issues.
SELECT
    order_id,
    customer_id,
    order_amount,
    updated_at,
    'CURRENT_ORDER_EXCEPTION' AS exception_type
FROM order_transactions
WHERE customer_id IS NULL
   OR order_amount <= 0;
