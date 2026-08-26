-- Day 042: Projection Practice
-- Purpose: Practise choosing only the columns a query needs.
-- Safety: All executable SQL is read-only.
-- Business goal: reduce unnecessary columns while preserving the intended result.

-- Section 1: SELECT * example for quick exploration.
-- Acceptable briefly during exploration, but avoid using it as a stable pipeline contract.
SELECT *
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Section 2: explicit projection for the same lookup.
SELECT
    order_id,
    customer_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Section 3: required columns only for a monthly report.
SELECT
    order_id,
    order_date,
    country_group,
    order_amount
FROM orders_performance_sample
WHERE order_date >= '2026-08-01'
  AND order_date < '2026-09-01'
  AND order_status = 'COMPLETED';

-- Section 4: join projection with only useful customer columns.
SELECT
    o.order_id,
    o.order_date,
    o.order_amount,
    c.customer_segment
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Section 5: aggregation projection.
SELECT
    country_group,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
GROUP BY country_group
ORDER BY country_group;

-- Section 6: wide versus narrow output comparison using metadata.
SELECT
    query_id,
    query_name,
    required_columns,
    known_risk
FROM query_pattern_catalog
WHERE known_risk LIKE '%SELECT star%'
   OR known_risk LIKE '%unused columns%'
   OR query_name = 'select_star_extract';

-- Section 7: unused-column review.
SELECT
    case_id,
    business_question,
    main_unnecessary_work,
    safer_habit,
    recommended_validation
FROM performance_casebook
WHERE main_unnecessary_work LIKE '%projection%'
   OR main_unnecessary_work LIKE '%columns%';

-- Section 8: projection summary.
SELECT
    'PROJECTION' AS habit_category,
    COUNT(*) AS relevant_pattern_count
FROM query_pattern_catalog
WHERE required_columns IS NOT NULL;

