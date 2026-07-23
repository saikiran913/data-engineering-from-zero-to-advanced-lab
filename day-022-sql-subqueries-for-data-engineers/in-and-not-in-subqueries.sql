-- Day 022: IN and NOT IN Subqueries
-- Topic: Comparing a value with a one-column list returned by an inner query.
-- Safety note: every query in this file is read-only.

-- IN basics: customers who placed orders.
SELECT customer_id, customer_name, country
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
)
ORDER BY customer_id;

-- IN basics: orders that have payment records.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM payments
)
ORDER BY order_id;

-- IN basics: products that appear in daily sales.
SELECT product_id, product_name, category
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM daily_sales
)
ORDER BY product_id;

-- IN basics: countries with active customers.
SELECT customer_id, customer_name, country
FROM customers
WHERE country IN (
    SELECT country
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
ORDER BY country, customer_id;

-- NOT IN basics: customers who did not place orders.
-- Safe version filters NULL from the inner query.
SELECT customer_id, customer_name, country
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
)
ORDER BY customer_id;

-- NOT IN basics: orders without payment records.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_id NOT IN (
    SELECT order_id
    FROM payments
    WHERE order_id IS NOT NULL
)
ORDER BY order_id;

-- NOT IN basics: products not present in daily sales.
SELECT product_id, product_name, category
FROM products
WHERE product_id NOT IN (
    SELECT product_id
    FROM daily_sales
    WHERE product_id IS NOT NULL
)
ORDER BY product_id;

-- NULL warning: this query is intentionally risky.
-- orders.customer_id contains a NULL value.
-- Some platforms return no rows because NOT IN with NULL can become unknown.
-- SELECT *
-- FROM customers
-- WHERE customer_id NOT IN (
--     SELECT customer_id
--     FROM orders
-- );

-- Safer NOT IN pattern: remove NULL values inside the subquery.
SELECT customer_id, customer_name, country
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
)
ORDER BY customer_id;

-- Compare with NOT EXISTS.
-- NOT EXISTS checks matching rows and is often safer for missing-record checks.
SELECT c.customer_id, c.customer_name, c.country
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
)
ORDER BY c.customer_id;

-- Beginner warning:
-- Use one comparable column inside IN and NOT IN.
-- Do not return customer_id and order_id together in the same IN subquery.
