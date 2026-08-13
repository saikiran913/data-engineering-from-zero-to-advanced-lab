-- Day 035: Expected-Record Checks
-- Purpose: Compare expected catalogue records with actual datasets.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: expected clean orders and whether they exist.
WITH expected_orders AS (
    SELECT
        expected_value AS order_id,
        review_note
    FROM expected_records_catalog
    WHERE expectation_type = 'ORDER_ID'
      AND stage_name = 'CLEAN'
)
SELECT
    e.order_id AS expected_order_id,
    CASE WHEN c.order_id IS NULL THEN 'MISSING' ELSE 'PRESENT' END AS completeness_status,
    e.review_note
FROM expected_orders AS e
LEFT JOIN clean_customer_orders AS c
    ON e.order_id = c.order_id
ORDER BY
    e.order_id;

-- Query 2: unexpected clean records not listed as expected.
SELECT
    c.order_id,
    c.customer_id,
    c.order_status,
    c.source_file
FROM clean_customer_orders AS c
LEFT JOIN expected_records_catalog AS e
    ON c.order_id = e.expected_value
   AND e.expectation_type = 'ORDER_ID'
   AND e.stage_name = 'CLEAN'
WHERE e.expected_value IS NULL
ORDER BY
    c.order_id;

-- Query 3: duplicate expected order IDs in the expectation catalogue.
SELECT
    expected_value AS expected_order_id,
    COUNT(*) AS expectation_count
FROM expected_records_catalog
WHERE expectation_type = 'ORDER_ID'
GROUP BY
    expected_value
HAVING COUNT(*) > 1
ORDER BY
    expected_value;

-- Query 4: expected required-field definitions.
SELECT
    expectation_id,
    expected_value AS required_field,
    stage_name,
    required_flag,
    review_note
FROM expected_records_catalog
WHERE expectation_type = 'REQUIRED_FIELD'
ORDER BY
    expectation_id;
