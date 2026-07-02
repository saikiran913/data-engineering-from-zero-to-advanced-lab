-- Day 014: Common SQL JOIN Mistakes
-- These examples are for learning and debugging.
-- Some queries are intentionally incorrect or risky.
-- Do not copy incorrect examples into production work.

-- 1. Incorrect example: missing ON condition.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o;
-- Corrected example: include the join key.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 2. Incorrect example: customer-order join uses country.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.country = o.country;
-- Corrected example: use customer_id.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 3. Incorrect example: INNER JOIN cannot find customers that have no orders.
SELECT c.customer_id, c.customer_name FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;
-- Corrected example: use LEFT JOIN.
SELECT c.customer_id, c.customer_name FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

-- 4. Incorrect example: wrong left table for customers that have no orders.
SELECT o.order_id, c.customer_name FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;
-- Corrected example: start from customers.
SELECT c.customer_id, c.customer_name FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

-- 5. Incorrect example: IS NULL after INNER JOIN cannot find missing customers.
SELECT o.order_id FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;
-- Corrected example: use LEFT JOIN from orders.
SELECT o.order_id FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;

-- 6. Incorrect example: ambiguous customer_id.
SELECT customer_id, order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
-- Corrected example: prefix columns.
SELECT c.customer_id, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 7. Incorrect example: SELECT star makes joined output hard to inspect.
SELECT * FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
-- Corrected example: select needed columns.
SELECT c.customer_name, o.order_id, o.order_amount FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 8. Incorrect example: no aliases makes query harder to read.
SELECT customers.customer_name, orders.order_id FROM customers INNER JOIN orders ON customers.customer_id = orders.customer_id;
-- Corrected example: use aliases.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 9. Incorrect example: product name is not the product key.
SELECT oi.order_item_id, p.product_name FROM order_items AS oi INNER JOIN products AS p ON oi.product_id = p.product_name;
-- Corrected example: use product_id.
SELECT oi.order_item_id, p.product_name FROM order_items AS oi INNER JOIN products AS p ON oi.product_id = p.product_id;

-- 10. Incorrect example: campaign channel alone is not the campaign key.
SELECT ca.campaign_name, cp.revenue FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.channel = cp.channel;
-- Corrected example: use campaign_id.
SELECT ca.campaign_name, cp.revenue FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id;

-- 11. Incorrect example: expecting one customer row after joining many orders.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
-- Corrected example: count orders when one row per customer is needed.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id GROUP BY c.customer_name;

-- 12. Incorrect example: filtering right table removes unmatched customer rows.
SELECT c.customer_name, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.payment_status = 'Paid';
-- Corrected example: state the matched paid-order question clearly.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.payment_status = 'Paid';

-- 13. Incorrect example: payments do not directly connect to customers in this sample.
SELECT pay.payment_id, c.customer_name FROM payments AS pay INNER JOIN customers AS c ON pay.order_id = c.customer_id;
-- Corrected example: connect payments to orders first.
SELECT pay.payment_id, o.order_id FROM payments AS pay INNER JOIN orders AS o ON pay.order_id = o.order_id;

-- 14. Incorrect example: forgetting order_items can multiply orders.
SELECT o.order_id, oi.order_item_id FROM orders AS o INNER JOIN order_items AS oi ON o.order_id = oi.order_id;
-- Corrected example: count items if one row per order is needed.
SELECT o.order_id, COUNT(oi.order_item_id) AS total_items FROM orders AS o LEFT JOIN order_items AS oi ON o.order_id = oi.order_id GROUP BY o.order_id;

-- 15. Incorrect example: row count after one-to-many join is treated as order count.
SELECT COUNT(*) AS order_count FROM orders AS o INNER JOIN order_items AS oi ON o.order_id = oi.order_id;
-- Corrected example: count rows from orders for order count.
SELECT COUNT(*) AS order_count FROM orders;

-- 16. Incorrect example: same column name does not prove same meaning.
SELECT c.customer_name, ca.campaign_name FROM customers AS c INNER JOIN campaigns AS ca ON c.country = ca.country;
-- Corrected example: document this as country-level comparison, not customer-campaign relationship.
SELECT c.country, ca.campaign_name FROM customers AS c INNER JOIN campaigns AS ca ON c.country = ca.country;

-- 17. Incorrect example: NULL check uses equals sign.
SELECT c.customer_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id = NULL;
-- Corrected example: use IS NULL.
SELECT c.customer_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

-- 18. Incorrect example: left join but only right-side columns are selected.
SELECT o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;
-- Corrected example: include left-side context.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- 19. Incorrect example: product references are not checked.
SELECT oi.order_item_id, oi.product_id FROM order_items AS oi;
-- Corrected example: validate products using LEFT JOIN.
SELECT oi.order_item_id, oi.product_id FROM order_items AS oi LEFT JOIN products AS p ON oi.product_id = p.product_id WHERE p.product_id IS NULL;

-- 20. Incorrect example: join logic is not documented.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
-- Corrected example: add a comment explaining the business relationship.
-- This joins each order to the customer record using customer_id.
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
