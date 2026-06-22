-- Day 009: Basic SQL for Data Engineers
-- Topic: SELECT, FROM, WHERE, ORDER BY, LIMIT

-- 1. Select all columns from customers.
SELECT *
FROM customers;

-- 2. Select specific customer columns.
SELECT customer_id, customer_name, country
FROM customers;

-- 3. Select all orders.
SELECT *
FROM orders;

-- 4. Preview first 10 orders.
SELECT *
FROM orders
LIMIT 10;

-- 5. Select specific order columns.
SELECT order_id, customer_id, order_amount, payment_status
FROM orders;

-- 6. Filter customers from UK.
SELECT *
FROM customers
WHERE country = 'UK';

-- 7. Filter customers from India.
SELECT *
FROM customers
WHERE country = 'India';

-- 8. Filter active customers.
SELECT *
FROM customers
WHERE customer_status = 'Active';

-- 9. Filter inactive customers.
SELECT *
FROM customers
WHERE customer_status = 'Inactive';

-- 10. Filter orders with Paid payment_status.
SELECT *
FROM orders
WHERE payment_status = 'Paid';

-- 11. Filter orders with Failed payment_status.
SELECT *
FROM orders
WHERE payment_status = 'Failed';

-- 12. Filter cancelled orders.
SELECT *
FROM orders
WHERE order_status = 'Cancelled';

-- 13. Filter delivered orders.
SELECT *
FROM orders
WHERE order_status = 'Delivered';

-- 14. Filter orders above 100.
SELECT *
FROM orders
WHERE order_amount > 100;

-- 15. Filter orders above 500.
SELECT *
FROM orders
WHERE order_amount > 500;

-- 16. Filter products from Electronics category.
SELECT *
FROM products
WHERE category = 'Electronics';

-- 17. Filter active products.
SELECT *
FROM products
WHERE is_active = true;

-- 18. Sort orders by amount highest to lowest.
SELECT *
FROM orders
ORDER BY order_amount DESC;

-- 19. Sort orders by amount lowest to highest.
SELECT *
FROM orders
ORDER BY order_amount ASC;

-- 20. Sort customers by signup_date newest first.
SELECT *
FROM customers
ORDER BY signup_date DESC;

-- 21. Sort customers by signup_date oldest first.
SELECT *
FROM customers
ORDER BY signup_date ASC;

-- 22. Combine WHERE and ORDER BY.
SELECT order_id, customer_id, order_amount, payment_status
FROM orders
WHERE payment_status = 'Paid'
ORDER BY order_amount DESC;

-- 23. Combine WHERE, ORDER BY, and LIMIT.
SELECT order_id, customer_id, order_amount, order_status
FROM orders
WHERE payment_status = 'Paid'
ORDER BY order_amount DESC
LIMIT 5;

-- 24. Select only a few columns for reporting.
SELECT order_id, order_date, order_amount, country
FROM orders;

-- 25. Preview products table.
SELECT *
FROM products
LIMIT 10;

