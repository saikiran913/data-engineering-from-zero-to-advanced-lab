-- Day 035: Category and Status Coverage
-- Purpose: Validate expected statuses and category values.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: source status coverage.
SELECT
    order_status,
    COUNT(*) AS source_row_count
FROM source_customer_orders
GROUP BY
    order_status
ORDER BY
    order_status;

-- Query 2: missing expected source statuses.
SELECT
    e.status_category AS expected_status
FROM expected_records_catalog AS e
LEFT JOIN source_customer_orders AS s
    ON e.status_category = s.order_status
WHERE e.expectation_type = 'STATUS_CATEGORY'
  AND e.stage_name = 'SOURCE'
  AND s.order_status IS NULL
ORDER BY
    e.status_category;

-- Query 3: unexpected source statuses.
SELECT
    s.order_status,
    COUNT(*) AS source_row_count
FROM source_customer_orders AS s
LEFT JOIN expected_records_catalog AS e
    ON s.order_status = e.status_category
   AND e.expectation_type = 'STATUS_CATEGORY'
   AND e.stage_name = 'SOURCE'
WHERE e.status_category IS NULL
GROUP BY
    s.order_status
ORDER BY
    s.order_status;

-- Query 4: reporting country group coverage.
SELECT
    report_date,
    country_group,
    COUNT(*) AS reporting_row_count
FROM reporting_customer_orders
GROUP BY
    report_date,
    country_group
ORDER BY
    report_date,
    country_group;

-- Query 5: blank or null category values.
SELECT
    order_id,
    country_group,
    source_file
FROM clean_customer_orders
WHERE country_group IS NULL
   OR country_group = ''
ORDER BY
    order_id;
