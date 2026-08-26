-- Day 042: Performance Debugging Lab
-- Purpose: Review weak query habits and safer rewrites.
-- Safety: All executable SQL is read-only.
-- Business goal: reduce unnecessary work only when correctness is preserved.

-- Issue 1: SELECT *.
SELECT *
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Safer rewrite: explicit columns.
SELECT
    order_id,
    customer_id,
    order_amount
FROM orders_performance_sample
WHERE order_id = 'PO1001';

-- Issue 2: unnecessary columns through CTEs.
WITH wide_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_status,
        country_group,
        order_amount,
        channel,
        source_file,
        loaded_at
    FROM orders_performance_sample
)
SELECT
    order_id,
    order_amount
FROM wide_orders
WHERE order_status = 'COMPLETED';

-- Safer rewrite: narrow the CTE contract.
WITH narrow_orders AS (
    SELECT
        order_id,
        order_status,
        order_amount
    FROM orders_performance_sample
)
SELECT
    order_id,
    order_amount
FROM narrow_orders
WHERE order_status = 'COMPLETED';

-- Issue 3: date filter too late.
WITH all_orders AS (
    SELECT
        order_id,
        order_date,
        order_amount
    FROM orders_performance_sample
)
SELECT
    order_id,
    order_date,
    order_amount
FROM all_orders
WHERE order_date >= '2026-08-10';

-- Safer rewrite: filter in the first logical step.
WITH recent_orders AS (
    SELECT
        order_id,
        order_date,
        order_amount
    FROM orders_performance_sample
    WHERE order_date >= '2026-08-10'
)
SELECT
    order_id,
    order_date,
    order_amount
FROM recent_orders;

-- Issue 4: unnecessary join.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Safer rewrite if no customer rule is required.
SELECT
    COUNT(*) AS completed_order_count
FROM orders_performance_sample
WHERE order_status = 'COMPLETED';

-- Issue 5: join used for hidden business rule.
SELECT
    COUNT(*) AS active_customer_completed_orders
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED'
  AND c.customer_status = 'ACTIVE';

-- Validation: removing this join would change the business rule.
SELECT
    c.customer_status,
    COUNT(*) AS order_count
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED'
GROUP BY c.customer_status
ORDER BY c.customer_status;

-- Issue 6: accidental row multiplication.
SELECT
    o.order_id,
    o.order_amount,
    i.product_code
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Validation: count rows per order after the join.
SELECT
    o.order_id,
    COUNT(*) AS joined_rows
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
GROUP BY o.order_id
HAVING COUNT(*) > 1
ORDER BY o.order_id;

-- Issue 7: DISTINCT hides row multiplication.
SELECT DISTINCT
    o.order_id
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Safer rewrite: pre-aggregate when order grain is required.
WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS item_total_amount
    FROM order_items_performance_sample
    GROUP BY order_id
)
SELECT
    o.order_id,
    i.item_total_amount
FROM orders_performance_sample AS o
LEFT JOIN item_totals AS i
    ON o.order_id = i.order_id;

-- Issue 8: wrong pre-aggregation grain.
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

-- Validation: order-level detail count is different from customer-level output.
SELECT
    'orders' AS check_name,
    COUNT(*) AS row_count
FROM orders_performance_sample
UNION ALL
SELECT
    'customer_totals' AS check_name,
    COUNT(*) AS row_count
FROM (
    SELECT customer_id
    FROM orders_performance_sample
    GROUP BY customer_id
) AS customer_totals;

-- Issue 9: unnecessary ORDER BY for a machine-consumed extract.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
ORDER BY order_amount DESC;

-- Safer rewrite if order is not required.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample;

-- Issue 10: sorting before filtering through a wide step.
WITH sorted_orders AS (
    SELECT
        order_id,
        order_status,
        order_amount
    FROM orders_performance_sample
    ORDER BY order_amount DESC
)
SELECT
    order_id,
    order_amount
FROM sorted_orders
WHERE order_status = 'COMPLETED';

-- Safer rewrite: filter first and only sort final output if needed.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
ORDER BY order_amount DESC;

-- Issue 11: repeated CASE.
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
GROUP BY amount_band;

-- Issue 12: row count matches but total differs.
SELECT
    country_group,
    COUNT(*) AS row_count,
    SUM(order_amount) AS total_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
GROUP BY country_group
ORDER BY country_group;

-- Issue 13: total matches but keys differ.
SELECT
    order_id,
    order_amount
FROM orders_performance_sample
WHERE order_amount >= 500
ORDER BY order_id;

-- Issue 14: query rewritten without validation.
SELECT
    comparison_id,
    query_goal,
    expected_result_relationship,
    review_note
FROM query_comparison_catalog
ORDER BY comparison_id;

-- Issue 15: filter date range accidentally changed.
SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    COUNT(*) AS row_count
FROM orders_performance_sample
WHERE order_date >= '2026-08-01'
  AND order_date < '2026-09-01';

-- Issue 16: output columns changed unexpectedly.
SELECT
    query_id,
    query_name,
    required_columns,
    known_risk
FROM query_pattern_catalog
ORDER BY query_id;

-- Issue 17: CTE assumed faster.
SELECT
    case_id,
    business_question,
    correctness_risk,
    recommended_validation
FROM performance_casebook
WHERE current_pattern LIKE '%CTE%'
   OR safer_habit LIKE '%CTE%';

-- Issue 18: shorter SQL assumed faster.
SELECT
    comparison_id,
    version_a_pattern,
    version_b_pattern,
    review_note
FROM query_comparison_catalog
WHERE review_note LIKE '%not equivalent%'
   OR expected_result_relationship LIKE '%Not equivalent%';

-- Issue 19: no pre-aggregation where clearly safe.
SELECT
    order_id,
    SUM(line_amount) AS item_total_amount
FROM order_items_performance_sample
GROUP BY order_id
ORDER BY order_id;

-- Issue 20: final validation checklist from casebook.
SELECT
    case_id,
    business_question,
    recommended_validation
FROM performance_casebook
ORDER BY case_id;

