-- Day 029: Dependency Checks
-- Purpose: Review upstream dependencies and downstream consumers for view changes.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Source-object inventory using documented change cases.
SELECT DISTINCT
    view_name,
    current_definition_summary,
    proposed_change_summary
FROM view_change_cases
ORDER BY view_name;

-- Source-column inventory example.
SELECT
    'vw_customer_sales_summary' AS view_name,
    'orders_source' AS source_object,
    'order_id, customer_id, order_status, order_amount, order_date, updated_at' AS source_columns,
    'one row per customer' AS expected_output_grain;

-- Consumer inventory.
SELECT
    view_name,
    consumer_id,
    consumer_type,
    consumer_name,
    required_columns,
    expected_grain,
    change_sensitivity,
    owner_role
FROM view_consumers
ORDER BY view_name, consumer_id;

-- View-to-view dependency example using documented metadata.
SELECT
    'vw_customer_country_summary' AS view_name,
    'vw_active_customers' AS upstream_view,
    'country, customer_id' AS required_columns,
    'Keep this chain shallow and documented.' AS review_message;

-- Dependency-risk review with consumer counts.
SELECT
    c.view_name,
    COUNT(*) AS consumer_count,
    SUM(CASE WHEN c.change_sensitivity = 'HIGH' THEN 1 ELSE 0 END) AS critical_consumer_count,
    MAX(ch.main_risk) AS dependency_risk,
    CASE
        WHEN SUM(CASE WHEN c.change_sensitivity = 'HIGH' THEN 1 ELSE 0 END) > 0 THEN 'Review high-sensitivity consumers before changing this view.'
        ELSE 'Review documented consumers before changing this view.'
    END AS review_message
FROM view_consumers AS c
LEFT JOIN view_change_cases AS ch
    ON c.view_name = ch.view_name
GROUP BY c.view_name
ORDER BY c.view_name;

-- Missing dependency review: consumers without a documented change case.
SELECT
    c.view_name,
    c.consumer_name,
    'NO_CHANGE_CASE_DOCUMENTED' AS review_issue
FROM view_consumers AS c
LEFT JOIN view_change_cases AS ch
    ON c.view_name = ch.view_name
WHERE ch.view_name IS NULL
ORDER BY c.view_name, c.consumer_name;

-- Duplicate dependency records.
SELECT
    view_name,
    consumer_name,
    COUNT(*) AS consumer_record_count
FROM view_consumers
GROUP BY view_name, consumer_name
HAVING COUNT(*) > 1;

-- Practice tasks:
-- 1. Pick one view and list its upstream objects.
-- 2. Count high-sensitivity consumers.
-- 3. Explain why a dependency chain increases review risk.
