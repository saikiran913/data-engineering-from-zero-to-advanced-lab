-- Day 022: WHERE Subqueries Practice
-- Topic: Using subqueries inside WHERE filters.
-- Safety note: every query in this file is read-only.

-- 1. Orders above the overall average order amount.
-- Inner query returns one value.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
)
ORDER BY order_amount DESC;

-- 2. Orders below the maximum order amount.
-- Inner query returns one maximum value.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount < (
    SELECT MAX(order_amount)
    FROM orders
)
ORDER BY order_amount DESC;

-- 3. Orders after the earliest order date.
SELECT order_id, customer_id, order_date
FROM orders
WHERE order_date > (
    SELECT MIN(order_date)
    FROM orders
)
ORDER BY order_date;

-- 4. Customers from countries that have at least one active customer.
-- Inner query returns a list of country values.
SELECT customer_id, customer_name, country, customer_status
FROM customers
WHERE country IN (
    SELECT country
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
ORDER BY country, customer_id;

-- 5. Products priced above the average product price.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > (
    SELECT AVG(unit_price)
    FROM products
)
ORDER BY unit_price DESC;

-- 6. Sales greater than the average sale amount.
SELECT sale_date, product_id, customer_id, sales_amount
FROM daily_sales
WHERE sales_amount > (
    SELECT AVG(sales_amount)
    FROM daily_sales
)
ORDER BY sales_amount DESC;

-- 7. Paid-like orders above the global average order amount.
-- This is a global comparison, not an average per customer.
SELECT order_id, customer_id, order_status, order_amount
FROM orders
WHERE order_status IN ('PAID', 'SHIPPED')
  AND order_amount > (
      SELECT AVG(order_amount)
      FROM orders
  )
ORDER BY order_amount DESC;

-- 8. Reconciliation records with source values above the average source value.
SELECT record_type, record_id, source_value, target_value
FROM source_target_reconciliation
WHERE record_type = 'SOURCE'
  AND source_value > (
      SELECT AVG(source_value)
      FROM source_target_reconciliation
      WHERE record_type = 'SOURCE'
  )
ORDER BY source_value DESC;
