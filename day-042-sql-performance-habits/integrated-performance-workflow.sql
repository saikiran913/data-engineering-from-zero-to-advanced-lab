-- Day 042: Integrated Performance Workflow
-- Workflow: Reduce Unnecessary Work While Preserving the Business Result
-- Safety: All executable SQL is read-only.

-- Part 1: Define business question.
SELECT
    'Completed August order revenue by customer segment' AS business_question;

-- Part 2: Define output grain.
SELECT
    'customer_segment' AS output_grain,
    'One row per customer segment' AS grain_description;

-- Part 3: Identify required columns.
SELECT
    'orders' AS source_table,
    'order_id, customer_id, order_date, order_status, order_amount' AS required_columns
UNION ALL
SELECT
    'customers' AS source_table,
    'customer_id, customer_segment' AS required_columns;

-- Part 4: Identify required rows.
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders_performance_sample
GROUP BY order_status
ORDER BY order_status;

-- Part 5: Review filters.
WITH completed_august_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
      AND order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
)
SELECT
    COUNT(*) AS filtered_order_count,
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date
FROM completed_august_orders;

-- Part 6: Review joins.
WITH completed_august_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
      AND order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
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
FROM completed_august_orders AS o
INNER JOIN customer_segments AS c
    ON o.customer_id = c.customer_id;

-- Part 7: Check join-key uniqueness.
SELECT
    customer_id,
    COUNT(*) AS customer_rows
FROM customers_performance_sample
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Part 8: Review aggregation stage.
WITH completed_august_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
      AND order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
),
segment_orders AS (
    SELECT
        o.order_id,
        o.order_amount,
        c.customer_segment
    FROM completed_august_orders AS o
    INNER JOIN customers_performance_sample AS c
        ON o.customer_id = c.customer_id
)
SELECT
    customer_segment,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_order_amount
FROM segment_orders
GROUP BY customer_segment
ORDER BY customer_segment;

-- Part 9: Review DISTINCT.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT o.order_id) AS distinct_order_count
FROM orders_performance_sample AS o
INNER JOIN customers_performance_sample AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'COMPLETED';

-- Part 10: Review ORDER BY.
SELECT
    'ORDER BY customer_segment is included because this is a readable report output.' AS sort_reason;

-- Part 11: Review repeated work.
SELECT
    case_id,
    business_question,
    main_unnecessary_work,
    safer_habit
FROM performance_casebook
WHERE main_unnecessary_work LIKE '%Repeated%';

-- Part 12: Build simplified query.
WITH completed_august_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
      AND order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
),
customer_segments AS (
    SELECT
        customer_id,
        customer_segment
    FROM customers_performance_sample
)
SELECT
    c.customer_segment,
    COUNT(*) AS order_count,
    SUM(o.order_amount) AS total_order_amount
FROM completed_august_orders AS o
INNER JOIN customer_segments AS c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY c.customer_segment;

-- Part 13: Validate old versus new output.
WITH version_a AS (
    SELECT
        c.customer_segment,
        COUNT(*) AS order_count,
        SUM(o.order_amount) AS total_order_amount
    FROM orders_performance_sample AS o
    INNER JOIN customers_performance_sample AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'COMPLETED'
      AND o.order_date >= '2026-08-01'
      AND o.order_date < '2026-09-01'
    GROUP BY c.customer_segment
),
completed_august_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM orders_performance_sample
    WHERE order_status = 'COMPLETED'
      AND order_date >= '2026-08-01'
      AND order_date < '2026-09-01'
),
version_b AS (
    SELECT
        c.customer_segment,
        COUNT(*) AS order_count,
        SUM(o.order_amount) AS total_order_amount
    FROM completed_august_orders AS o
    INNER JOIN customers_performance_sample AS c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_segment
)
SELECT
    a.customer_segment,
    a.order_count AS version_a_count,
    b.order_count AS version_b_count,
    a.total_order_amount AS version_a_total,
    b.total_order_amount AS version_b_total
FROM version_a AS a
INNER JOIN version_b AS b
    ON a.customer_segment = b.customer_segment
ORDER BY a.customer_segment;

-- Part 14: Connect changes to plan concepts.
SELECT
    comparison_id,
    query_goal,
    column_difference,
    row_difference,
    join_difference,
    sort_difference,
    review_note
FROM query_comparison_catalog
ORDER BY comparison_id;

-- Part 15: Document limitations.
SELECT
    'This workflow is conceptual. Actual performance depends on the SQL platform, optimizer, data volume, statistics, storage design, and workload.' AS limitation_note;
