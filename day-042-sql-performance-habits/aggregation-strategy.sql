-- Day 042: Aggregation Strategy
-- Purpose: Decide when aggregation should happen before or after joins.
-- Safety: All executable SQL is read-only.
-- Business goal: preserve the required output grain.

-- Section 1: raw-detail aggregation from order items.
SELECT
    order_id,
    SUM(line_amount) AS item_total_amount
FROM order_items_performance_sample
GROUP BY order_id
ORDER BY order_id;

-- Section 2: aggregate after joining raw item lines.
SELECT
    o.country_group,
    SUM(i.line_amount) AS item_revenue
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
WHERE o.order_status = 'COMPLETED'
GROUP BY o.country_group
ORDER BY o.country_group;

-- Section 3: valid pre-aggregation to order grain before joining to orders.
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
    ON o.order_id = i.order_id
ORDER BY o.order_id;

-- Section 4: invalid pre-aggregation example for order detail.
-- This is not equivalent if the final output still needs one row per order.
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
FROM customer_totals
ORDER BY customer_id;

-- Section 5: grain documentation from metadata.
SELECT
    query_id,
    query_name,
    aggregation_grain,
    known_risk
FROM query_pattern_catalog
WHERE aggregation_grain IS NOT NULL
ORDER BY query_id;

-- Section 6: aggregate input-row comparison.
SELECT
    'raw_item_rows' AS check_name,
    COUNT(*) AS row_count
FROM order_items_performance_sample
UNION ALL
SELECT
    'order_level_item_totals' AS check_name,
    COUNT(*) AS row_count
FROM (
    SELECT
        order_id
    FROM order_items_performance_sample
    GROUP BY order_id
) AS item_orders;

-- Section 7: aggregation strategy summary.
SELECT
    case_id,
    business_question,
    safer_habit,
    correctness_risk,
    recommended_validation
FROM performance_casebook
WHERE safer_habit LIKE '%Aggregate%'
   OR safer_habit LIKE '%grain%';

