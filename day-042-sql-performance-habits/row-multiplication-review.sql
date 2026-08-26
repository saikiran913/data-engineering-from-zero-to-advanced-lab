-- Day 042: Row Multiplication Review
-- Purpose: Understand when joins increase row counts.
-- Safety: All executable SQL is read-only.
-- Warning: More rows after a join are not automatically wrong. The expected output grain determines whether row growth is valid.

-- Section 1: customer keys are unique in the customer sample.
SELECT
    customer_id,
    COUNT(*) AS customer_row_count
FROM customers_performance_sample
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Section 2: one-to-many order-to-items row expansion.
SELECT
    o.order_id,
    COUNT(*) AS joined_item_rows
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
GROUP BY o.order_id
ORDER BY o.order_id;

-- Section 3: expected row multiplication by order item lines.
SELECT
    COUNT(*) AS raw_item_join_rows
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Section 4: distinct order count after item join.
SELECT
    COUNT(DISTINCT o.order_id) AS distinct_orders_after_join
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

-- Section 5: pre-join duplicate check for item grain.
SELECT
    order_id,
    COUNT(*) AS item_line_count
FROM order_items_performance_sample
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY order_id;

-- Section 6: post-join row count by customer.
SELECT
    o.customer_id,
    COUNT(*) AS joined_item_rows
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id
GROUP BY o.customer_id
ORDER BY joined_item_rows DESC;

-- Section 7: many-to-many risk review from casebook.
SELECT
    case_id,
    business_question,
    current_pattern,
    main_unnecessary_work,
    correctness_risk,
    recommended_validation
FROM performance_casebook
WHERE main_unnecessary_work LIKE '%multiplication%'
   OR current_pattern LIKE '%join%';

-- Section 8: row multiplication summary.
SELECT
    'orders' AS grain_name,
    COUNT(*) AS row_count
FROM orders_performance_sample
UNION ALL
SELECT
    'order_items' AS grain_name,
    COUNT(*) AS row_count
FROM order_items_performance_sample
UNION ALL
SELECT
    'order_item_join' AS grain_name,
    COUNT(*) AS row_count
FROM orders_performance_sample AS o
INNER JOIN order_items_performance_sample AS i
    ON o.order_id = i.order_id;

