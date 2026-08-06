-- Day 029: Column Contract Validation
-- Purpose: Treat view columns as a contract for downstream consumers.
-- Safety: Read-only examples only. No production view is deployed or replaced.

-- Required-column checklist from consumer metadata.
SELECT
    view_name,
    consumer_name,
    required_columns,
    expected_grain,
    change_sensitivity
FROM view_consumers
ORDER BY view_name, consumer_name;

-- Missing required columns concept.
-- Metadata inspection varies by platform, so expected and proposed columns are documented here.
WITH expected_columns AS (
    SELECT 'vw_customer_sales_summary' AS view_name, 'customer_id' AS required_column
    UNION ALL SELECT 'vw_customer_sales_summary', 'completed_order_count'
    UNION ALL SELECT 'vw_customer_sales_summary', 'completed_order_amount'
),
proposed_columns AS (
    SELECT 'vw_customer_sales_summary' AS view_name, 'customer_id' AS proposed_column
    UNION ALL SELECT 'vw_customer_sales_summary', 'completed_order_count'
    UNION ALL SELECT 'vw_customer_sales_summary', 'revenue_amount'
)
SELECT
    e.view_name,
    e.required_column,
    CASE WHEN p.proposed_column IS NULL THEN 'MISSING_IN_PROPOSED_OUTPUT' ELSE 'PRESENT' END AS column_status
FROM expected_columns AS e
LEFT JOIN proposed_columns AS p
    ON e.view_name = p.view_name
   AND e.required_column = p.proposed_column;

-- New-column impact and SELECT star risk.
SELECT
    view_name,
    consumer_name,
    'ADD_COLUMN' AS change_type,
    CASE
        WHEN change_sensitivity = 'HIGH' THEN 'MEDIUM_REVIEW'
        ELSE 'LOW_REVIEW'
    END AS impact_level,
    'Review fixed schemas and SELECT star consumers before adding columns.' AS review_action
FROM view_consumers
WHERE view_name = 'vw_active_customers';

-- Renamed-column impact.
SELECT
    view_name,
    consumer_name,
    'completed_order_amount' AS required_column,
    'RENAME_COLUMN' AS change_type,
    'HIGH_REVIEW' AS impact_level,
    'Consumer requires the current column name.' AS review_action
FROM view_consumers
WHERE required_columns LIKE '%completed_order_amount%';

-- Removed-column impact.
SELECT
    view_name,
    consumer_name,
    'email_address' AS required_column,
    'REMOVE_COLUMN' AS change_type,
    CASE
        WHEN required_columns LIKE '%email%' THEN 'HIGH_REVIEW'
        ELSE 'LOW_REVIEW'
    END AS impact_level,
    'Check whether the consumer expects the removed column.' AS review_action
FROM view_consumers;

-- Data-type change concept.
SELECT
    'vw_valid_orders' AS view_name,
    'order_amount' AS column_name,
    'numeric' AS current_expected_type,
    'text' AS proposed_type,
    'HIGH_REVIEW' AS impact_level,
    'Amount calculations may fail if a numeric field becomes text.' AS review_action;

-- Null-behaviour change.
SELECT
    'vw_active_customers' AS view_name,
    'country' AS required_column,
    'NULL_HANDLING_CHANGE' AS change_type,
    'MEDIUM_REVIEW' AS impact_level,
    'Compare null counts and country distribution before changing null handling.' AS review_action;

-- Derived-column meaning change.
SELECT
    'vw_order_reporting' AS view_name,
    'reporting_order_status' AS required_column,
    'MEANING_CHANGE' AS change_type,
    'HIGH_REVIEW' AS impact_level,
    'Changing status rules while keeping the same alias can mislead consumers.' AS review_action;

-- Consumer-impact summary.
SELECT
    view_name,
    consumer_name,
    required_columns AS required_column,
    'CONTRACT_REVIEW' AS change_type,
    CASE
        WHEN change_sensitivity = 'HIGH' THEN 'HIGH_REVIEW'
        WHEN change_sensitivity = 'MEDIUM' THEN 'MEDIUM_REVIEW'
        ELSE 'LOW_REVIEW'
    END AS impact_level,
    'Review required columns, grain, and critical metrics.' AS review_action
FROM view_consumers
ORDER BY impact_level, view_name;
