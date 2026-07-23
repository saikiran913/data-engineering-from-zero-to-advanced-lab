-- Day 022: Scalar Subqueries
-- Topic: Using an inner query that returns exactly one row and one column.
-- Safety note: every query in this file is read-only.

-- 1. Orders above average order amount.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
)
ORDER BY order_amount DESC;

-- 2. Products above average unit price.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
)
ORDER BY unit_price DESC;

-- 3. Sales on the latest sale date.
SELECT sale_date, product_id, customer_id, sales_amount
FROM daily_sales
WHERE sale_date = (
    SELECT MAX(sale_date)
    FROM daily_sales
)
ORDER BY product_id;

-- 4. Orders matching the maximum order amount.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount = (
    SELECT MAX(order_amount)
    FROM orders
);

-- 5. Orders above the total successful payment average.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(payment_amount)
    FROM payments
    WHERE payment_status = 'SUCCESS'
)
ORDER BY order_amount DESC;

-- 6. Scalar subquery in the SELECT list.
-- The same average value appears on each output row.
SELECT
    order_id,
    order_amount,
    (
        SELECT AVG(order_amount)
        FROM orders
    ) AS overall_average_order_amount
FROM orders
ORDER BY order_id;

-- 7. Difference from the overall average order amount.
SELECT
    order_id,
    order_amount,
    order_amount - (
        SELECT AVG(order_amount)
        FROM orders
    ) AS difference_from_average
FROM orders
ORDER BY order_amount DESC;

-- Error-risk note:
-- SELECT customer_id FROM orders may return many rows.
-- Do not use it with = as if it returned one scalar value.
