-- Day 035: Completeness Debugging Lab
-- Purpose: Show misleading completeness checks and safer follow-ups.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Debug 1: min and max dates do not prove middle-date coverage.
SELECT
    MIN(report_date) AS earliest_report_date,
    MAX(report_date) AS latest_report_date,
    COUNT(DISTINCT report_date) AS distinct_report_dates
FROM reporting_customer_orders;

-- Debug 2: explicitly check expected middle dates.
SELECT
    e.expected_date
FROM expected_records_catalog AS e
LEFT JOIN reporting_customer_orders AS r
    ON e.expected_date = r.report_date
WHERE e.expectation_type = 'REPORT_DATE'
  AND r.report_date IS NULL
ORDER BY
    e.expected_date;

-- Debug 3: field completeness does not prove record completeness.
SELECT
    COUNT(*) AS clean_rows,
    SUM(CASE WHEN order_id IS NOT NULL THEN 1 ELSE 0 END) AS rows_with_order_id
FROM clean_customer_orders;

-- Debug 4: target-only records are completeness issues too.
SELECT
    c.order_id,
    c.customer_id,
    c.source_file
FROM clean_customer_orders AS c
LEFT JOIN staged_customer_orders AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    c.order_id;

-- Debug 5: duplicate reporting grain can distort coverage.
SELECT
    report_date,
    country_group,
    COUNT(*) AS row_count
FROM reporting_customer_orders
GROUP BY
    report_date,
    country_group
HAVING COUNT(*) > 1
ORDER BY
    report_date,
    country_group;
