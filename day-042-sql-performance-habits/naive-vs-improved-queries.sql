-- Day 042: Naive vs Improved Queries
-- Purpose: Compare query shapes while preserving business meaning.
-- Safety: All executable SQL is read-only.
-- Warning: Some examples are cautionary and are not equivalent rewrites.

-- Pair 1 naive: SELECT * for one order.
SELECT *
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Pair 1 improved: explicit columns only.
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Pair 1 validation: same business key.
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS distinct_order_count
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Pair 2 naive: broad CTE then filter.
WITH all_orders AS (
    SELECT
        order_id,
        order_date,
        order_status,
        order_amount
    FROM orders_performance_sample
)
SELECT
    order_id,
    order_date,
    order_amount
FROM all_orders
WHERE order_date >= '2026-08-01'
  AND order_date < '2026-09-01'
  AND order_status = 'COMPLETED';

-- Pair 2 improved: relevant date and status filter inside the first step.
WITH completed_august_orders AS (
    SELECT
        order_id,
        order_date,
        order_amount
    FROM orders_performance_sample
    WHERE order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
      AND order_status = 'COMPLETED'
)
SELECT
    order_id,
    order_date,
    order_amount
FROM completed_august_orders;

-- Pair 3 naive: unnecessary customer join.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Pair 3 improved: orders-only query, equivalent only if no customer rule is needed.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Pair 4 improved: safely filtered join input.
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

-- Pair 5 improved: pre-aggregated item totals at order grain.
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

-- Pair 6 caution: DISTINCT after raw item join hides row multiplication.
SELECT DISTINCT
    o.order_id,
    o.order_amount
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Pair 6 safer: correct the grain instead of hiding duplicates.
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

-- Pair 7 naive: unnecessary final sort.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_amount DESC;

-- Pair 7 improved: remove ORDER BY only if output order is not required.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Pair 8 improved: repeated aggregation gathered once.
WITH completed_summary AS (
    SELECT
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_amount,
        AVG(order_amount) AS average_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    order_count,
    total_amount,
    average_amount
FROM completed_summary;

-- Pair 9 improved: repeated CASE expression becomes a derived column.
WITH labelled_orders AS (
    SELECT
        order_id,
        order_amount,
        CASE
            WHEN order_amount >= 500 THEN 'HIGH'
            WHEN order_amount >= 200 THEN 'MEDIUM'
            ELSE 'LOW'
        END AS amount_band
    FROM orders_performance_sample
)
SELECT
    amount_band,
    COUNT(*) AS order_count
FROM labelled_orders
GROUP BY amount_band
ORDER BY amount_band;

-- Pair 10 improved: narrower multi-CTE flow.
WITH completed_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
),
customer_segments AS (
    SELECT
        customer_id,
        customer_segment
    FROM customers_performance_sample
)
SELECT
    o.order_id,
    o.order_amount,
    c.customer_segment
FROM completed_orders AS o
INNER JOIN customer_segments AS c
    ON o.customer_id = c.customer_id;

-- Pair 11 caution: outer join filter can change meaning.
SELECT
    o.order_id,
    c.customer_status
FROM orders_performance_sample AS o
LEFT JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE c.customer_status = 'ACTIVE';

-- Pair 12 caution: invalid pre-aggregation when order detail is still required.
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS customer_total_amount
    FROM orders_performance_sample
    GROUP BY customer_id
)
SELECT
    customer_id,
    customer_total_amount
FROM customer_totals;

-- Comparison catalog review for all pairs.
SELECT
    comparison_id,
    query_goal,
    expected_result_relationship,
    review_note
FROM query_comparison_catalog
ORDER BY comparison_id;

