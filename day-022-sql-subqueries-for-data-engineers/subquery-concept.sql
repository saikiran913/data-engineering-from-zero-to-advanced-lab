-- Day 022: SQL Subquery Concept
-- Topic: Learning how one SELECT query can be used inside another SELECT query.
-- Safety note: every query in this file is read-only.

-- Section 1: Preview source tables.
-- Run these first so you know what data the subqueries will use.
SELECT customer_id, customer_name, country, customer_status
FROM customers
ORDER BY customer_id;

SELECT order_id, customer_id, order_date, order_status, order_amount
FROM orders
ORDER BY order_id;

-- Section 2: First scalar subquery.
-- Inner query shape: one row and one column.
-- It returns the average order amount.
SELECT AVG(order_amount) AS average_order_amount
FROM orders;

-- Outer query compares each order with that one returned value.
SELECT
    order_id,
    customer_id,
    order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
)
ORDER BY order_amount DESC;

-- Section 3: First IN subquery.
-- Inner query shape: many rows and one column.
-- It returns customer IDs that appear in orders.
SELECT customer_id
FROM orders
WHERE customer_id IS NOT NULL;

SELECT
    customer_id,
    customer_name,
    country
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
)
ORDER BY customer_id;

-- Section 4: First EXISTS subquery.
-- EXISTS checks whether at least one matching row exists.
-- The correlation condition connects each customer to their orders.
SELECT
    c.customer_id,
    c.customer_name,
    c.country
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- Section 5: First FROM-clause subquery.
-- The inner query creates a temporary table-like result.
-- Many SQL platforms require an alias after the closing parenthesis.
SELECT
    customer_id,
    order_count,
    total_order_value
FROM (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(order_amount) AS total_order_value
    FROM orders
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
) AS customer_order_summary
WHERE total_order_value > 500
ORDER BY total_order_value DESC;

-- Section 6: Run-the-inner-query-first workflow.
-- Step 1: run only the inner query.
SELECT product_id
FROM daily_sales
WHERE product_id IS NOT NULL;

-- Step 2: place it inside the outer query after checking the result.
SELECT
    product_id,
    product_name,
    category
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM daily_sales
    WHERE product_id IS NOT NULL
)
ORDER BY product_id;

-- Practice tasks:
-- 1. Change the average-order query to find orders below average.
-- 2. Change the customer query to show only active customers with orders.
-- 3. Run the inner query of every example by itself before running the full query.
