-- Day 035: Missing-Key Checks
-- Purpose: Compare expected and actual business-key populations.
-- Safety: All executable SQL is read-only and SELECT-based.
-- Completeness queries do not modify or fabricate data.

-- Query 1: source-only keys compared with stage.
-- Expected population: source order IDs.
-- Actual population: staged order IDs.
-- Grain: one order key.
-- Expected exclusions: deduplication and review rules must be considered.
SELECT
    s.order_id,
    s.customer_id,
    s.order_status,
    s.source_file
FROM source_customer_orders AS s
LEFT JOIN staged_customer_orders AS t
    ON s.order_id = t.order_id
WHERE t.order_id IS NULL
ORDER BY
    s.order_id;

-- Query 2: accepted staged orders missing from clean.
SELECT
    s.order_id,
    s.customer_id,
    s.standard_status,
    s.validation_status,
    s.source_file
FROM staged_customer_orders AS s
LEFT JOIN clean_customer_orders AS c
    ON s.order_id = c.order_id
WHERE s.validation_status = 'ACCEPTED'
  AND c.order_id IS NULL
ORDER BY
    s.order_id;

-- Query 3: unexpected clean-only orders.
SELECT
    c.order_id,
    c.customer_id,
    c.order_status,
    c.source_file
FROM clean_customer_orders AS c
LEFT JOIN staged_customer_orders AS s
    ON c.order_id = s.order_id
WHERE s.order_id IS NULL
ORDER BY
    c.order_id;

-- Query 4: expected clean order IDs missing from clean.
SELECT
    e.expected_value AS expected_order_id,
    e.review_note
FROM expected_records_catalog AS e
LEFT JOIN clean_customer_orders AS c
    ON e.expected_value = c.order_id
WHERE e.expectation_type = 'ORDER_ID'
  AND e.stage_name = 'CLEAN'
  AND c.order_id IS NULL
ORDER BY
    e.expected_value;
