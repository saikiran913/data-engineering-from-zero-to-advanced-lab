-- Day 042: Repeated Work Review
-- Purpose: Identify repeated logic and replace it with clearer reusable query steps.
-- Safety: All executable SQL is read-only.
-- Important: A CTE can improve readability, but whether it reduces physical work depends on the SQL platform and optimizer.

-- Section 1: repeated aggregate concept from catalog.
SELECT
    query_id,
    query_name,
    query_goal,
    known_risk
FROM query_pattern_catalog
WHERE known_risk LIKE '%Repeated%';

-- Section 2: repeated aggregation written separately.
SELECT
    'completed_total' AS metric_name,
    SUM(order_amount) AS metric_value
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
UNION ALL
SELECT
    'completed_average' AS metric_name,
    AVG(order_amount) AS metric_value
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Section 3: reusable CTE for clarity.
WITH completed_orders AS (
    SELECT
        order_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    COUNT(*) AS completed_order_count,
    SUM(order_amount) AS completed_total_amount,
    AVG(order_amount) AS completed_average_amount
FROM completed_orders;

-- Section 4: repeated CASE expression in one query.
SELECT
    order_id,
    CASE
        WHEN order_amount >= 500 THEN 'HIGH'
        WHEN order_amount >= 200 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS amount_band,
    order_amount
FROM orders_performance_sample
ORDER BY
    CASE
        WHEN order_amount >= 500 THEN 'HIGH'
        WHEN order_amount >= 200 THEN 'MEDIUM'
        ELSE 'LOW'
    END,
    order_id;

-- Section 5: shared derived column using a CTE.
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
    order_id,
    amount_band,
    order_amount
FROM labelled_orders
ORDER BY amount_band, order_id;

-- Section 6: repeated scan concept from casebook.
SELECT
    case_id,
    business_question,
    current_pattern,
    main_unnecessary_work,
    safer_habit,
    correctness_risk
FROM performance_casebook
WHERE main_unnecessary_work LIKE '%Repeated%'
   OR safer_habit LIKE '%CTE%';

-- Section 7: summary by safer habit.
SELECT
    safer_habit,
    COUNT(*) AS case_count
FROM performance_casebook
GROUP BY safer_habit
ORDER BY case_count DESC, safer_habit;

