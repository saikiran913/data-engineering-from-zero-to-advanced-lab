-- Day 014: SQL JOIN Practice
-- Topic: INNER JOIN, LEFT JOIN, Join Debugging, Data Quality Checks

-- 1. Customers and matching orders.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 2. Orders and customer names.
SELECT o.order_id, o.order_amount, c.customer_name FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id;

-- 3. Orders and customer country.
SELECT o.order_id, o.country AS order_country, c.country AS customer_country FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id;

-- 4. Order items and product names.
SELECT oi.order_item_id, oi.order_id, p.product_name FROM order_items AS oi INNER JOIN products AS p ON oi.product_id = p.product_id;

-- 5. Order items and product category.
SELECT oi.order_item_id, oi.quantity, p.category FROM order_items AS oi INNER JOIN products AS p ON oi.product_id = p.product_id;

-- 6. Payments and order details.
SELECT pay.payment_id, pay.payment_amount, o.order_id, o.order_amount FROM payments AS pay INNER JOIN orders AS o ON pay.order_id = o.order_id;

-- 7. Support tickets and customer names.
SELECT st.ticket_id, st.issue_type, c.customer_name FROM support_tickets AS st INNER JOIN customers AS c ON st.customer_id = c.customer_id;

-- 8. Campaigns and performance rows.
SELECT ca.campaign_name, cp.performance_date, cp.revenue FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id;

-- 9. All customers and possible orders.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- 10. All orders and possible customer details.
SELECT o.order_id, o.customer_id, c.customer_name FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id;

-- 11. All products and possible order items.
SELECT p.product_id, p.product_name, oi.order_item_id FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id;

-- 12. All order items and possible product details.
SELECT oi.order_item_id, oi.product_id, p.product_name FROM order_items AS oi LEFT JOIN products AS p ON oi.product_id = p.product_id;

-- 13. All orders and possible payments.
SELECT o.order_id, o.order_amount, pay.payment_id, pay.payment_status FROM orders AS o LEFT JOIN payments AS pay ON o.order_id = pay.order_id;

-- 14. All customers and possible support tickets.
SELECT c.customer_id, c.customer_name, st.ticket_id FROM customers AS c LEFT JOIN support_tickets AS st ON c.customer_id = st.customer_id;

-- 15. All campaigns and possible performance rows.
SELECT ca.campaign_id, ca.campaign_name, cp.performance_date FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id;

-- 16. Customers that have no orders.
SELECT c.customer_id, c.customer_name FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

-- 17. Orders that have missing customers.
SELECT o.order_id, o.customer_id FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;

-- 18. Products never ordered.
SELECT p.product_id, p.product_name FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id WHERE oi.order_item_id IS NULL;

-- 19. Order items that have missing products.
SELECT oi.order_item_id, oi.product_id FROM order_items AS oi LEFT JOIN products AS p ON oi.product_id = p.product_id WHERE p.product_id IS NULL;

-- 20. Order items that have missing orders.
SELECT oi.order_item_id, oi.order_id FROM order_items AS oi LEFT JOIN orders AS o ON oi.order_id = o.order_id WHERE o.order_id IS NULL;

-- 21. Payments that have missing orders.
SELECT pay.payment_id, pay.order_id FROM payments AS pay LEFT JOIN orders AS o ON pay.order_id = o.order_id WHERE o.order_id IS NULL;

-- 22. Orders that have no payments.
SELECT o.order_id, o.order_amount FROM orders AS o LEFT JOIN payments AS pay ON o.order_id = pay.order_id WHERE pay.payment_id IS NULL;

-- 23. Support tickets that have missing customers.
SELECT st.ticket_id, st.customer_id FROM support_tickets AS st LEFT JOIN customers AS c ON st.customer_id = c.customer_id WHERE c.customer_id IS NULL;

-- 24. Campaigns that have no performance rows.
SELECT ca.campaign_id, ca.campaign_name FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id WHERE cp.campaign_id IS NULL;

-- 25. Campaign performance that has missing campaign records.
SELECT cp.performance_date, cp.campaign_id FROM campaign_performance AS cp LEFT JOIN campaigns AS ca ON cp.campaign_id = ca.campaign_id WHERE ca.campaign_id IS NULL;

-- 26. Paid orders and customer names.
SELECT o.order_id, c.customer_name, o.order_amount FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id WHERE o.payment_status = 'Paid';

-- 27. Failed payments and order details.
SELECT pay.payment_id, pay.payment_status, o.order_id FROM payments AS pay INNER JOIN orders AS o ON pay.order_id = o.order_id WHERE pay.payment_status = 'Failed';

-- 28. Active customers and orders.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id WHERE c.customer_status = 'Active';

-- 29. Inactive customers and orders.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id WHERE c.customer_status = 'Inactive';

-- 30. Delivered orders and payment details.
SELECT o.order_id, o.order_status, pay.payment_id, pay.payment_amount FROM orders AS o INNER JOIN payments AS pay ON o.order_id = pay.order_id WHERE o.order_status = 'Delivered';

-- 31. Refunded payments and order details.
SELECT pay.payment_id, pay.payment_status, o.order_id, o.order_amount FROM payments AS pay INNER JOIN orders AS o ON pay.order_id = o.order_id WHERE pay.payment_status = 'Refunded';

-- 32. Open support tickets and customer details.
SELECT st.ticket_id, st.ticket_status, c.customer_name FROM support_tickets AS st INNER JOIN customers AS c ON st.customer_id = c.customer_id WHERE st.ticket_status = 'Open';

-- 33. Active campaigns and performance data.
SELECT ca.campaign_name, cp.performance_date, cp.revenue FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id WHERE ca.campaign_status = 'Active';

-- 34. Search campaigns and performance data.
SELECT ca.campaign_name, cp.performance_date, cp.revenue FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id WHERE ca.channel = 'Search';

-- 35. Count orders by customer.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id GROUP BY c.customer_name;

-- 36. Total order amount by customer.
SELECT c.customer_name, SUM(o.order_amount) AS total_order_amount FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id GROUP BY c.customer_name;

-- 37. Count support tickets by customer.
SELECT c.customer_name, COUNT(st.ticket_id) AS total_tickets FROM customers AS c LEFT JOIN support_tickets AS st ON c.customer_id = st.customer_id GROUP BY c.customer_name;

-- 38. Total payment amount by payment method.
SELECT pay.payment_method, SUM(pay.payment_amount) AS total_payment_amount FROM payments AS pay GROUP BY pay.payment_method;

-- 39. Count order items by product.
SELECT p.product_name, COUNT(oi.order_item_id) AS total_order_items FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id GROUP BY p.product_name;

-- 40. Total quantity sold by product.
SELECT p.product_name, SUM(oi.quantity) AS total_quantity FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id GROUP BY p.product_name;

-- 41. Total quantity sold by product category.
SELECT p.category, SUM(oi.quantity) AS total_quantity FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id GROUP BY p.category;

-- 42. Campaign revenue by campaign name.
SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id GROUP BY ca.campaign_name;

-- 43. Campaign cost by campaign status.
SELECT ca.campaign_status, SUM(cp.cost) AS total_cost FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id GROUP BY ca.campaign_status;

-- 44. Count performance rows by campaign.
SELECT ca.campaign_name, COUNT(cp.campaign_id) AS performance_rows FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id GROUP BY ca.campaign_name;

-- 45. Count customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- 46. Count customers joined to orders using INNER JOIN.
SELECT COUNT(*) AS customer_order_rows FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;

-- 47. Count customers left joined to orders.
SELECT COUNT(*) AS customer_left_join_rows FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- 48. Count orders.
SELECT COUNT(*) AS total_orders FROM orders;

-- 49. Count orders joined to customers using INNER JOIN.
SELECT COUNT(*) AS matched_order_customer_rows FROM orders AS o INNER JOIN customers AS c ON o.customer_id = c.customer_id;

-- 50. Count orders left joined to customers.
SELECT COUNT(*) AS order_left_join_rows FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id;

-- 51. Customers, orders, and payments.
SELECT c.customer_name, o.order_id, pay.payment_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id LEFT JOIN payments AS pay ON o.order_id = pay.order_id;

-- 52. Orders, order items, and products.
SELECT o.order_id, oi.order_item_id, p.product_name FROM orders AS o INNER JOIN order_items AS oi ON o.order_id = oi.order_id LEFT JOIN products AS p ON oi.product_id = p.product_id;

-- 53. Customers, orders, order items, and products.
SELECT c.customer_name, o.order_id, oi.quantity, p.product_name FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id INNER JOIN order_items AS oi ON o.order_id = oi.order_id LEFT JOIN products AS p ON oi.product_id = p.product_id;

-- 54. Customers, support tickets, and orders using selected columns.
SELECT c.customer_name, st.ticket_id, o.order_id FROM customers AS c LEFT JOIN support_tickets AS st ON c.customer_id = st.customer_id LEFT JOIN orders AS o ON c.customer_id = o.customer_id;

-- 55. Campaigns and performance summary.
SELECT ca.campaign_name, COUNT(cp.campaign_id) AS performance_rows, SUM(cp.revenue) AS total_revenue FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id GROUP BY ca.campaign_name;
