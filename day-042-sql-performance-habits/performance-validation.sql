-- Day 042: Performance Validation
-- Purpose: Validate that performance rewrites preserve business output.
-- Safety: All executable SQL is read-only.
-- Recommended review statuses: MATCH, EXPECTED_DIFFERENCE, REVIEW.

-- Check 1: row count validation for equivalent completed-order versions.
WITH version_a AS (
    SELECT
        order_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
),
version_b AS (
    SELECT
        order_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    'completed_order_row_count' AS check_name,
    COUNT(*) AS version_a_value,
    COUNT(*) AS version_b_value,
    0 AS difference,
    'MATCH' AS status,
    'Both versions use the same status filter.' AS review_message
FROM version_a;

-- Check 2: distinct business-key count after item join.
SELECT
    'item_join_key_count' AS check_name,
    COUNT(DISTINCT o.order_id) AS version_a_value,
    COUNT(*) AS version_b_value,
    COUNT(*) - COUNT(DISTINCT o.order_id) AS difference,
    'EXPECTED_DIFFERENCE' AS status,
    'Raw item join has more rows than distinct orders because item grain is lower.' AS review_message
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Check 3: control total from orders.
SELECT
    'completed_order_amount_total' AS check_name,
    SUM(order_amount) AS version_a_value,
    SUM(order_amount) AS version_b_value,
    0 AS difference,
    'MATCH' AS status,
    'Control totals match because the same source and filter are used.' AS review_message
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Check 4: grouped totals by country.
SELECT
    country_group AS check_name,
    COUNT(*) AS version_a_value,
    SUM(order_amount) AS version_b_value,
    0 AS difference,
    'REVIEW' AS status,
    'Review grouped counts and totals together; they answer different measures.' AS review_message
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
GROUP BY country_group
ORDER BY country_group;

-- Check 5: min and max business dates.
SELECT
    'completed_order_date_range' AS check_name,
    MIN(order_date) AS version_a_value,
    MAX(order_date) AS version_b_value,
    0 AS difference,
    'REVIEW' AS status,
    'Date range should match the intended business period.' AS review_message
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Check 6: missing customer keys before a join.
SELECT
    o.customer_id,
    COUNT(*) AS order_count
FROM orders_performance_sample AS o
LEFT JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
GROUP BY o.customer_id
ORDER BY o.customer_id;

-- Check 7: extra item keys without matching orders.
SELECT
    i.order_id,
    COUNT(*) AS item_line_count
FROM order_items_performance_sample AS i
LEFT JOIN orders_performance_sample AS o
    ON i.order_id = o.order_id
WHERE o.order_id IS NULL
GROUP BY i.order_id
ORDER BY i.order_id;

-- Check 8: metric comparison between order amount and item amount.
WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS item_total_amount
    FROM order_items_performance_sample
    GROUP BY order_id
)
SELECT
    o.order_id AS check_name,
    o.order_amount AS version_a_value,
    i.item_total_amount AS version_b_value,
    o.order_amount - i.item_total_amount AS difference,
    CASE
        WHEN o.order_amount = i.item_total_amount THEN 'MATCH'
        ELSE 'REVIEW'
    END AS status,
    'Compare order header amount with summed item lines.' AS review_message
FROM orders_performance_sample AS o
LEFT JOIN item_totals AS i
    ON o.order_id = i.order_id
ORDER BY o.order_id;

-- Check 9: grain comparison.
SELECT
    'orders_vs_items' AS check_name,
    COUNT(DISTINCT order_id) AS version_a_value,
    COUNT(*) AS version_b_value,
    COUNT(*) - COUNT(DISTINCT order_id) AS difference,
    'EXPECTED_DIFFERENCE' AS status,
    'Item table has multiple rows per order.' AS review_message
FROM order_items_performance_sample;

-- Check 10: column contract comparison conceptually from comparison catalog.
SELECT
    comparison_id AS check_name,
    column_difference AS version_a_value,
    expected_result_relationship AS version_b_value,
    0 AS difference,
    'REVIEW' AS status,
    review_note AS review_message
FROM query_comparison_catalog
ORDER BY comparison_id;

