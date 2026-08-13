-- Day 035: Date Coverage Checks
-- Purpose: Validate expected dates and date boundaries.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: source date boundaries.
SELECT
    MIN(order_date) AS earliest_source_order_date,
    MAX(order_date) AS latest_source_order_date,
    COUNT(DISTINCT order_date) AS distinct_source_dates
FROM source_customer_orders;

-- Query 2: reporting date boundaries.
SELECT
    MIN(report_date) AS earliest_report_date,
    MAX(report_date) AS latest_report_date,
    COUNT(DISTINCT report_date) AS distinct_report_dates
FROM reporting_customer_orders;

-- Query 3: missing expected report dates from explicit expectation list.
SELECT
    e.expected_date
FROM expected_records_catalog AS e
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
WHERE e.expectation_type = 'REPORT_DATE'
  AND r.report_date IS NULL
ORDER BY
    e.expected_date;

-- Query 4: unexpected reporting dates not in expectation list.
SELECT
    r.report_date,
    COUNT(*) AS report_row_count
FROM reporting_customer_orders AS r
LEFT JOIN expected_records_catalog AS e
    ON r.report_date = e.expected_date
   AND e.expectation_type = 'REPORT_DATE'
WHERE e.expected_date IS NULL
GROUP BY
    r.report_date
ORDER BY
    r.report_date;

-- Query 5: missing expected date-country group combinations.
SELECT
    e.expected_date,
    e.country_group
FROM expected_records_catalog AS e
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
   AND e.country_group = r.country_group
WHERE e.expectation_type = 'DATE_COUNTRY_GROUP'
  AND r.report_date IS NULL
ORDER BY
    e.expected_date,
    e.country_group;
