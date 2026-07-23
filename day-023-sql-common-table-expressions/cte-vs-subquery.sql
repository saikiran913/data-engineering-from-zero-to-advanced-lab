-- Day 023: CTE vs Subquery
-- Topic: Compare valid ways to organise the same logic.
-- Safety note: every query in this file is read-only.

-- Example 1A: Orders above average using a scalar subquery.
SELECT order_id, customer_id, order_amount
FROM raw_orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM raw_orders
    WHERE order_amount > 0
)
ORDER BY order_amount DESC;

-- Example 1B: Orders above average using CTEs.
WITH average_order_amount AS (
    SELECT AVG(order_amount) AS average_amount
    FROM raw_orders
    WHERE order_amount > 0
),
positive_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE order_amount > 0
)
SELECT p.order_id, p.customer_id, p.order_amount
FROM positive_orders AS p
JOIN average_order_amount AS a
    ON 1 = 1
WHERE p.order_amount > a.average_amount
ORDER BY p.order_amount DESC;

-- Example 2A: Customer totals using a FROM-clause subquery.
SELECT customer_id, total_order_value
FROM (
    SELECT customer_id, SUM(order_amount) AS total_order_value
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
    GROUP BY customer_id
) AS customer_totals
WHERE total_order_value > 500;

-- Example 2B: Customer totals using a CTE.
WITH customer_totals AS (
    SELECT customer_id, SUM(order_amount) AS total_order_value
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT customer_id, total_order_value
FROM customer_totals
WHERE total_order_value > 500;

-- Example 3A: Customers without orders using NOT EXISTS.
SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM raw_orders AS o
    WHERE o.customer_id = c.customer_id
);

-- Example 3B: Customers without orders using CTEs and LEFT JOIN.
WITH order_customer_ids AS (
    SELECT DISTINCT customer_id
    FROM raw_orders
    WHERE customer_id IS NOT NULL
),
customers_without_orders AS (
    SELECT c.customer_id, c.customer_name
    FROM customers AS c
    LEFT JOIN order_customer_ids AS o
        ON c.customer_id = o.customer_id
    WHERE o.customer_id IS NULL
)
SELECT *
FROM customers_without_orders
ORDER BY customer_id;

-- Example 4: Latest record selection using a CTE.
WITH ranked_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        updated_at,
        source_file,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY updated_at DESC, source_file DESC
        ) AS row_num
    FROM raw_orders
)
SELECT order_id, customer_id, order_amount, updated_at, source_file
FROM ranked_orders
WHERE row_num = 1
ORDER BY order_id;

-- Both subqueries and CTEs can be valid.
-- CTEs are often easier to extend and debug when the logic has several steps.
