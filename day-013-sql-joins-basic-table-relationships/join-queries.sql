-- Day 013: SQL JOINs for Data Engineers
-- Topic: INNER JOIN, LEFT JOIN, Basic Table Relationships

-- 1. Customers and matching orders.
SELECT c.customer_id, c.customer_name, o.order_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 2. Selected customer and order columns.
SELECT c.customer_name, c.country, o.order_id, o.order_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 3. Orders and customer names.
SELECT o.order_id, o.order_date, c.customer_name
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;

-- 4. Orders and customer country.
SELECT o.order_id, o.order_amount, c.country
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;

-- 5. Campaigns and matching performance rows.
SELECT ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id;

-- 6. All customers and their orders.
SELECT c.customer_id, c.customer_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 7. All customers and order amounts.
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 8. All products and matching order items.
SELECT p.product_id, p.product_name, oi.order_item_id
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id;

-- 9. All campaigns and performance rows.
SELECT ca.campaign_id, ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id;

-- 10. All orders and customer details.
SELECT o.order_id, o.customer_id, c.customer_name, c.country
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id;

-- 11. Paid orders and customer names.
SELECT o.order_id, c.customer_name, o.order_amount
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE o.payment_status = 'Paid';

-- 12. Failed payments and customer names.
SELECT o.order_id, c.customer_name, o.payment_status
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE o.payment_status = 'Failed';

-- 13. Delivered orders and customer names.
SELECT o.order_id, c.customer_name, o.order_status
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered';

-- 14. UK customers and orders.
SELECT c.customer_name, c.country, o.order_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE c.country = 'UK';

-- 15. Active campaigns and performance data.
SELECT ca.campaign_name, ca.campaign_status, cp.performance_date, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE ca.campaign_status = 'Active';

-- 16. Customers that have no orders.
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 17. Orders that have missing customer records.
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 18. Products that have no order items.
SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

-- 19. Order items that have missing product records.
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 20. Campaigns that have no performance rows.
SELECT ca.campaign_id, ca.campaign_name
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;

-- 21. Campaign performance rows that have missing campaign records.
SELECT cp.performance_date, cp.campaign_id, cp.revenue
FROM campaign_performance AS cp
LEFT JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id
WHERE ca.campaign_id IS NULL;

-- 22. Order items and product names.
SELECT oi.order_item_id, oi.order_id, p.product_name
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;

-- 23. Order items and product categories.
SELECT oi.order_item_id, oi.quantity, p.category
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;

-- 24. Active products used in order items.
SELECT oi.order_item_id, p.product_name, p.is_active
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.is_active = 'true';

-- 25. Order items for Books category.
SELECT oi.order_item_id, oi.quantity, p.product_name, p.category
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.category = 'Books';

-- 26. Orders and order item details.
SELECT o.order_id, o.order_date, oi.order_item_id, oi.product_id
FROM orders AS o
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id;

-- 27. Paid orders and order item details.
SELECT o.order_id, o.payment_status, oi.order_item_id, oi.quantity
FROM orders AS o
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
WHERE o.payment_status = 'Paid';

-- 28. Delivered orders and order item quantities.
SELECT o.order_id, o.order_status, oi.quantity
FROM orders AS o
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'Delivered';

-- 29. Campaign performance and campaign names.
SELECT cp.performance_date, ca.campaign_name, cp.revenue
FROM campaign_performance AS cp
INNER JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id;

-- 30. Campaign performance and campaign status.
SELECT cp.performance_date, ca.campaign_status, cp.cost, cp.revenue
FROM campaign_performance AS cp
INNER JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id;

-- 31. Search campaign performance and campaign names.
SELECT cp.performance_date, ca.campaign_name, cp.channel, cp.revenue
FROM campaign_performance AS cp
INNER JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id
WHERE cp.channel = 'Search';

-- 32. Active campaign performance rows.
SELECT ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE ca.campaign_status = 'Active';

-- 33. Customers, orders, and order items.
SELECT c.customer_name, o.order_id, oi.order_item_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id;

-- 34. Orders, order items, and products.
SELECT o.order_id, oi.order_item_id, p.product_name
FROM orders AS o
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
INNER JOIN products AS p
ON oi.product_id = p.product_id;

-- 35. Customers, orders, order items, and products using selected columns.
SELECT c.customer_name, o.order_id, oi.quantity, p.product_name
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
INNER JOIN products AS p
ON oi.product_id = p.product_id;

-- 36. Count orders by customer.
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 37. Total order amount by customer.
SELECT c.customer_name, SUM(o.order_amount) AS total_order_amount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 38. Count order items by product.
SELECT p.product_name, COUNT(oi.order_item_id) AS total_order_items
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 39. Quantity sold by product.
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 40. Campaign revenue by campaign name.
SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
GROUP BY ca.campaign_name;

-- 41. Count orders that have missing customers.
SELECT COUNT(o.order_id) AS orders_with_missing_customers
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 42. Count order items that have missing products.
SELECT COUNT(oi.order_item_id) AS order_items_with_missing_products
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- 43. Count campaigns that have no performance rows.
SELECT COUNT(ca.campaign_id) AS campaigns_with_no_performance
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;

-- 44. Count customers that have no orders.
SELECT COUNT(c.customer_id) AS customers_with_no_orders
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 45. Count products that have no order items.
SELECT COUNT(p.product_id) AS products_with_no_order_items
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;
