-- Day 042: Sort Reduction Practice
-- Purpose: Use ORDER BY only when ordering is required.
-- Safety: All executable SQL is read-only.
-- Business goal: avoid unnecessary sorting while preserving required output order.

-- Section 1: final output sort for a human-readable report.
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_date, order_id;

-- Section 2: no sort when downstream does not require order.
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Section 3: sort for top-N requirement.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_amount DESC
LIMIT 10;

-- Section 4: sort required by window function logic.
SELECT
    order_id,
    customer_id,
    order_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY order_date DESC
    ) AS recent_order_rank
FROM orders_performance_sample;

-- Section 5: sort not required for aggregation output unless consumer needs it.
SELECT
    country_group,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_amount
FROM orders_performance_sample
GROUP BY country_group;

-- Section 6: sort-column reduction.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_amount DESC;

-- Section 7: sort after filtering.
WITH completed_orders AS (
    SELECT
        order_id,
        order_date,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
)
SELECT
    order_id,
    order_date,
    order_amount
FROM completed_orders
ORDER BY order_date;

-- Section 8: sort summary cases.
SELECT
    case_id,
    business_question,
    current_pattern,
    main_unnecessary_work,
    safer_habit,
    recommended_validation
FROM performance_casebook
WHERE main_unnecessary_work LIKE '%sort%'
   OR current_pattern LIKE '%ORDER BY%';

