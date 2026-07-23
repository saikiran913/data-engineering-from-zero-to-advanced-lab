-- Day 023: CTE Concept
-- Topic: Common Table Expressions as named query steps.
-- Safety note: every query in this file is read-only.

-- Section 1: Preview source tables.
SELECT customer_id, customer_name, country, customer_status
FROM customers
ORDER BY customer_id;

SELECT order_id, customer_id, order_status, order_amount, updated_at, source_file
FROM raw_orders
ORDER BY order_id, updated_at;

-- Section 2: First CTE.
-- WITH starts the CTE section.
-- active_customers is the CTE name.
-- The final query reads from the named result.
WITH active_customers AS (
    SELECT
        customer_id,
        customer_name,
        country
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
SELECT *
FROM active_customers
ORDER BY customer_id;

-- Section 3: Completed orders.
-- Input: raw_orders.
-- Output: completed orders with useful audit columns.
WITH completed_orders AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        order_amount,
        updated_at,
        source_file
    FROM raw_orders
    WHERE order_status = 'COMPLETED'
      AND customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT *
FROM completed_orders
ORDER BY order_date, order_id;

-- Section 4: Orders above a threshold.
WITH positive_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount,
        source_file
    FROM raw_orders
    WHERE order_amount > 0
)
SELECT *
FROM positive_orders
WHERE order_amount > 500
ORDER BY order_amount DESC;

-- Section 5: Aggregate inside a CTE.
WITH customer_order_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_status = 'COMPLETED'
      AND order_amount > 0
    GROUP BY customer_id
)
SELECT *
FROM customer_order_totals
ORDER BY total_order_value DESC;

-- Section 6: Validate the CTE inner SELECT separately first.
SELECT
    customer_id,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_order_value
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_status = 'COMPLETED'
  AND order_amount > 0
GROUP BY customer_id
ORDER BY total_order_value DESC;

-- Practice tasks:
-- 1. Change active_customers to show inactive customers.
-- 2. Change positive_orders to find orders above 300.
-- 3. Run each CTE body as a standalone query before running the full statement.
