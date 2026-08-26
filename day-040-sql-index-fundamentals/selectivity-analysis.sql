-- Day 040: Selectivity Analysis
-- Purpose: Estimate selectivity for candidate columns using read-only SQL.
-- Safety: All executable SQL is read-only and SELECT-based.
-- No index is created or dropped by this file.
-- Workload context: column cardinality and selectivity are signals, not final decisions.
-- Candidate columns: order_id, customer_id, order_status, country_group, signup_date.

-- Query 1: total rows in orders workload.
SELECT
    COUNT(*) AS total_rows
FROM orders_workload;

-- Query 2: distinct values for order candidate columns.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids,
    COUNT(DISTINCT order_status) AS distinct_statuses,
    COUNT(DISTINCT country_group) AS distinct_country_groups
FROM orders_workload;

-- Query 3: simple selectivity percentages for orders.
WITH stats AS (
    SELECT
        COUNT(*) AS total_rows,
        COUNT(DISTINCT order_id) AS distinct_order_ids,
        COUNT(DISTINCT customer_id) AS distinct_customer_ids,
        COUNT(DISTINCT order_status) AS distinct_statuses,
        COUNT(DISTINCT country_group) AS distinct_country_groups
    FROM orders_workload
)
SELECT
    total_rows,
    CASE WHEN total_rows = 0 THEN NULL ELSE 100.0 * distinct_order_ids / total_rows END
        AS order_id_selectivity_percentage,
    CASE WHEN total_rows = 0 THEN NULL ELSE 100.0 * distinct_customer_ids / total_rows END
        AS customer_id_selectivity_percentage,
    CASE WHEN total_rows = 0 THEN NULL ELSE 100.0 * distinct_statuses / total_rows END
        AS order_status_selectivity_percentage,
    CASE WHEN total_rows = 0 THEN NULL ELSE 100.0 * distinct_country_groups / total_rows END
        AS country_group_selectivity_percentage
FROM stats;

-- Query 4: profile catalog summary.
SELECT
    table_name,
    column_name,
    total_rows,
    distinct_values,
    CASE
        WHEN total_rows = 0 THEN NULL
        ELSE 100.0 * distinct_values / total_rows
    END AS selectivity_percentage,
    selectivity_band,
    'Selectivity is one signal, not an index decision.' AS review_message
FROM column_profile_catalog
ORDER BY table_name, column_name;

-- Query 5: high-selectivity examples.
SELECT
    table_name,
    column_name,
    distinct_values,
    total_rows,
    selectivity_band
FROM column_profile_catalog
WHERE selectivity_band = 'HIGH'
ORDER BY table_name, column_name;

-- Query 6: low-selectivity examples.
SELECT
    table_name,
    column_name,
    distinct_values,
    total_rows,
    selectivity_band
FROM column_profile_catalog
WHERE selectivity_band = 'LOW'
ORDER BY table_name, column_name;

