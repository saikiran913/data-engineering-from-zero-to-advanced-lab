-- Day 042: Join Reduction Practice
-- Purpose: Review whether each join is needed and whether join inputs can be reduced safely.
-- Safety: All executable SQL is read-only.
-- Warning: Never remove a join until its business role is known.

-- Section 1: required join for customer segment.
SELECT
    o.order_id,
    o.order_amount,
    c.customer_segment
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Section 2: unnecessary join when counting completed orders only.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Section 3: reduced version without customer join.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Section 4: join used only for a customer filter.
SELECT
    o.order_id,
    o.order_amount,
    c.customer_status
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_status = 'ACTIVE';

-- Section 5: join used only for selected attribute.
SELECT
    o.order_id,
    o.order_amount,
    c.preferred_channel
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id;

-- Section 6: reduced join columns.
WITH customer_segments AS (
    SELECT
        customer_id,
        customer_segment
    FROM customers_performance_sample
)
SELECT
    o.order_id,
    o.order_amount,
    c.customer_segment
FROM orders_performance_sample AS o
INNER JOIN customer_segments AS c
    ON o.customer_id = c.customer_id;

-- Section 7: filtered join input.
WITH completed_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    o.order_id,
    o.order_amount,
    c.customer_segment
FROM completed_orders AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id;

-- Section 8: pre-aggregated join input at order grain.
WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS item_total_amount
    FROM order_items_performance_sample
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.order_amount,
    i.item_total_amount
FROM orders_performance_sample AS o
LEFT JOIN item_totals AS i
    ON o.order_id = i.order_id;

-- Section 9: join removal validation.
SELECT
    'joined_count' AS check_name,
    COUNT(*) AS check_value
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED'
UNION ALL
SELECT
    'orders_only_count' AS check_name,
    COUNT(*) AS check_value
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Section 10: join-count summary.
SELECT
    query_id,
    query_name,
    join_columns,
    known_risk
FROM query_pattern_catalog
WHERE join_columns IS NOT NULL
ORDER BY query_id;

