-- Day 011: SQL Aggregations for Data Engineers
-- Topic: COUNT, SUM, AVG, MIN, MAX, GROUP BY
-- Syntax may vary slightly across SQL tools.

-- 1. Count all customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- 2. Count all orders.
SELECT COUNT(*) AS total_orders FROM orders;

-- 3. Count all products.
SELECT COUNT(*) AS total_products FROM products;

-- 4. Count all campaigns.
SELECT COUNT(*) AS total_campaigns FROM campaigns;

-- 5. Count all campaign performance rows.
SELECT COUNT(*) AS total_performance_rows FROM campaign_performance;

-- 6. Count customers that have an email value.
SELECT COUNT(email) AS customers_with_email FROM customers;

-- 7. Count orders that have a delivery date.
SELECT COUNT(delivery_date) AS orders_with_delivery_date FROM orders;

-- 8. Count campaigns that have an end date.
SELECT COUNT(end_date) AS campaigns_with_end_date FROM campaigns;

-- 9. Calculate total order amount.
SELECT SUM(order_amount) AS total_order_amount FROM orders;

-- 10. Calculate total campaign cost.
SELECT SUM(cost) AS total_campaign_cost FROM campaign_performance;

-- 11. Calculate total campaign revenue.
SELECT SUM(revenue) AS total_campaign_revenue FROM campaign_performance;

-- 12. Calculate total impressions.
SELECT SUM(impressions) AS total_impressions FROM campaign_performance;

-- 13. Calculate total clicks.
SELECT SUM(clicks) AS total_clicks FROM campaign_performance;

-- 14. Calculate total conversions.
SELECT SUM(conversions) AS total_conversions FROM campaign_performance;

-- 15. Calculate average order amount.
SELECT AVG(order_amount) AS average_order_amount FROM orders;

-- 16. Calculate average product price.
SELECT AVG(price) AS average_product_price FROM products;

-- 17. Calculate average campaign cost.
SELECT AVG(cost) AS average_campaign_cost FROM campaign_performance;

-- 18. Calculate average revenue.
SELECT AVG(revenue) AS average_revenue FROM campaign_performance;

-- 19. Find the lowest order amount.
SELECT MIN(order_amount) AS lowest_order_amount FROM orders;

-- 20. Find the lowest product price.
SELECT MIN(price) AS lowest_product_price FROM products;

-- 21. Find the earliest order date.
SELECT MIN(order_date) AS earliest_order_date FROM orders;

-- 22. Find the earliest campaign performance date.
SELECT MIN(performance_date) AS earliest_performance_date FROM campaign_performance;

-- 23. Find the highest order amount.
SELECT MAX(order_amount) AS highest_order_amount FROM orders;

-- 24. Find the highest product price.
SELECT MAX(price) AS highest_product_price FROM products;

-- 25. Find the latest order date.
SELECT MAX(order_date) AS latest_order_date FROM orders;

-- 26. Find the latest campaign performance date.
SELECT MAX(performance_date) AS latest_performance_date FROM campaign_performance;

-- 27. Create an order summary using several metrics.
SELECT COUNT(*) AS total_orders, SUM(order_amount) AS total_sales, AVG(order_amount) AS average_order_amount, MIN(order_amount) AS lowest_order_amount, MAX(order_amount) AS highest_order_amount FROM orders;

-- 28. Create a campaign performance summary.
SELECT SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks, SUM(cost) AS total_cost, SUM(revenue) AS total_revenue FROM campaign_performance;

-- 29. Count orders by country.
SELECT country, COUNT(*) AS total_orders FROM orders GROUP BY country;

-- 30. Count orders by order status.
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status;

-- 31. Count orders by payment status.
SELECT payment_status, COUNT(*) AS total_orders FROM orders GROUP BY payment_status;

-- 32. Calculate total sales by country.
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country;

-- 33. Calculate average order amount by country.
SELECT country, AVG(order_amount) AS average_order_amount FROM orders GROUP BY country;

-- 34. Count products by category.
SELECT category, COUNT(*) AS total_products FROM products GROUP BY category;

-- 35. Count products by stock status.
SELECT stock_status, COUNT(*) AS total_products FROM products GROUP BY stock_status;

-- 36. Count customers by country.
SELECT country, COUNT(*) AS total_customers FROM customers GROUP BY country;

-- 37. Count customers by customer status.
SELECT customer_status, COUNT(*) AS total_customers FROM customers GROUP BY customer_status;

-- 38. Count campaigns by channel.
SELECT channel, COUNT(*) AS total_campaigns FROM campaigns GROUP BY channel;

-- 39. Calculate campaign budget by channel.
SELECT channel, SUM(budget) AS total_budget FROM campaigns GROUP BY channel;

-- 40. Calculate campaign performance cost by channel.
SELECT channel, SUM(cost) AS total_cost FROM campaign_performance GROUP BY channel;

-- 41. Calculate campaign revenue by country.
SELECT country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY country;

-- 42. Calculate impressions and clicks by channel.
SELECT channel, SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks FROM campaign_performance GROUP BY channel;

-- 43. Calculate conversions by country.
SELECT country, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY country;

-- 44. Calculate daily order sales by order date.
SELECT order_date, SUM(order_amount) AS daily_sales FROM orders GROUP BY order_date;

-- 45. Calculate daily campaign revenue by performance date.
SELECT performance_date, SUM(revenue) AS daily_revenue FROM campaign_performance GROUP BY performance_date;

-- 46. Calculate paid order sales by country.
SELECT country, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY country;

-- 47. Count delivered orders by country.
SELECT country, COUNT(*) AS delivered_orders FROM orders WHERE order_status = 'Delivered' GROUP BY country;

-- 48. Count active customers by country.
SELECT country, COUNT(*) AS active_customers FROM customers WHERE customer_status = 'Active' GROUP BY country;

-- 49. Count active products by category.
SELECT category, COUNT(*) AS active_products FROM products WHERE is_active = 'true' GROUP BY category;

-- 50. Calculate active campaign budget by channel.
SELECT channel, SUM(budget) AS active_campaign_budget FROM campaigns WHERE campaign_status = 'Active' GROUP BY channel;

-- 51. Summarise Search campaign performance by country.
SELECT country, SUM(cost) AS search_cost, SUM(revenue) AS search_revenue FROM campaign_performance WHERE channel = 'Search' GROUP BY country;

-- 52. Sort countries by highest sales.
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country ORDER BY total_sales DESC;

-- 53. Sort channels by highest revenue.
SELECT channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY channel ORDER BY total_revenue DESC;

-- 54. Sort categories by average product price.
SELECT category, AVG(price) AS average_product_price FROM products GROUP BY category ORDER BY average_product_price DESC;

-- 55. Sort order statuses by count descending.
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status ORDER BY total_orders DESC;
