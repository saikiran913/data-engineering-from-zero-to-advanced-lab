-- Day 012: SQL GROUP BY, HAVING, and Data Quality Summary Checks
-- Topic: filtering grouped results after aggregation

-- 1. Countries above 5 orders.
SELECT country, COUNT(*) AS total_orders FROM orders GROUP BY country HAVING COUNT(*) > 5;

-- 2. Customer statuses above 3 customers.
SELECT customer_status, COUNT(*) AS total_customers FROM customers GROUP BY customer_status HAVING COUNT(*) > 3;

-- 3. Product categories above 2 products.
SELECT category, COUNT(*) AS total_products FROM products GROUP BY category HAVING COUNT(*) > 2;

-- 4. Campaign channels above 2 campaigns.
SELECT channel, COUNT(*) AS total_campaigns FROM campaigns GROUP BY channel HAVING COUNT(*) > 2;

-- 5. Payment statuses above 5 orders.
SELECT payment_status, COUNT(*) AS total_orders FROM orders GROUP BY payment_status HAVING COUNT(*) > 5;

-- 6. Countries where order total is above 1000.
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country HAVING SUM(order_amount) > 1000;

-- 7. Channels where revenue is above 5000.
SELECT channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY channel HAVING SUM(revenue) > 5000;

-- 8. Countries where campaign cost is above 1000.
SELECT country, SUM(cost) AS total_cost FROM campaign_performance GROUP BY country HAVING SUM(cost) > 1000;

-- 9. Dates where order summary sales are below 100.
SELECT summary_date, SUM(total_sales) AS daily_sales FROM daily_order_summary GROUP BY summary_date HAVING SUM(total_sales) < 100;

-- 10. Channels where campaign budget is above 3000.
SELECT channel, SUM(budget) AS total_budget FROM campaigns GROUP BY channel HAVING SUM(budget) > 3000;

-- 11. Countries where average order amount is above 250.
SELECT country, AVG(order_amount) AS average_order_amount FROM orders GROUP BY country HAVING AVG(order_amount) > 250;

-- 12. Product categories where average price is above 50.
SELECT category, AVG(price) AS average_price FROM products GROUP BY category HAVING AVG(price) > 50;

-- 13. Channels where average revenue is above 1200.
SELECT channel, AVG(revenue) AS average_revenue FROM campaign_performance GROUP BY channel HAVING AVG(revenue) > 1200;

-- 14. Countries where average daily summary sales are below 500.
SELECT country, AVG(total_sales) AS average_summary_sales FROM daily_order_summary GROUP BY country HAVING AVG(total_sales) < 500;

-- 15. Countries where highest order is above 700.
SELECT country, MAX(order_amount) AS highest_order FROM orders GROUP BY country HAVING MAX(order_amount) > 700;

-- 16. Countries where lowest order is below 20.
SELECT country, MIN(order_amount) AS lowest_order FROM orders GROUP BY country HAVING MIN(order_amount) < 20;

-- 17. Categories where highest product price is above 100.
SELECT category, MAX(price) AS highest_price FROM products GROUP BY category HAVING MAX(price) > 100;

-- 18. Categories where lowest product price is below 20.
SELECT category, MIN(price) AS lowest_price FROM products GROUP BY category HAVING MIN(price) < 20;

-- 19. Channels where highest cost is above 350.
SELECT channel, MAX(cost) AS highest_cost FROM campaign_performance GROUP BY channel HAVING MAX(cost) > 350;

-- 20. Channels where lowest revenue is below 600.
SELECT channel, MIN(revenue) AS lowest_revenue FROM campaign_performance GROUP BY channel HAVING MIN(revenue) < 600;

-- 21. Dates where highest revenue is above 1000.
SELECT performance_date, MAX(revenue) AS highest_revenue FROM campaign_performance GROUP BY performance_date HAVING MAX(revenue) > 1000;

-- 22. Dates where summary sales are below 100.
SELECT summary_date, MIN(total_sales) AS lowest_total_sales FROM daily_order_summary GROUP BY summary_date HAVING MIN(total_sales) < 100;

-- 23. Paid sales by country above 1000.
SELECT country, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY country HAVING SUM(order_amount) > 1000;

-- 24. Delivered orders by country above 3.
SELECT country, COUNT(*) AS delivered_orders FROM orders WHERE order_status = 'Delivered' GROUP BY country HAVING COUNT(*) > 3;

-- 25. Active customers by country above 2.
SELECT country, COUNT(*) AS active_customers FROM customers WHERE customer_status = 'Active' GROUP BY country HAVING COUNT(*) > 2;

-- 26. Active products by category above 1.
SELECT category, COUNT(*) AS active_products FROM products WHERE is_active = 'true' GROUP BY category HAVING COUNT(*) > 1;

-- 27. Active campaign budget by channel above 1000.
SELECT channel, SUM(budget) AS active_budget FROM campaigns WHERE campaign_status = 'Active' GROUP BY channel HAVING SUM(budget) > 1000;

-- 28. Search revenue by country above 1000.
SELECT country, SUM(revenue) AS search_revenue FROM campaign_performance WHERE channel = 'Search' GROUP BY country HAVING SUM(revenue) > 1000;

-- 29. Order IDs appearing more than once.
SELECT order_id, COUNT(*) AS record_count FROM orders GROUP BY order_id HAVING COUNT(*) > 1;

-- 30. Customer emails appearing more than once, excluding missing email values.
SELECT email, COUNT(*) AS email_count FROM customers WHERE email IS NOT NULL GROUP BY email HAVING COUNT(*) > 1;

-- 31. Summary date and country combinations appearing more than once.
SELECT summary_date, country, COUNT(*) AS record_count FROM daily_order_summary GROUP BY summary_date, country HAVING COUNT(*) > 1;

-- 32. Campaign IDs where performance rows are above 3.
SELECT campaign_id, COUNT(*) AS performance_rows FROM campaign_performance GROUP BY campaign_id HAVING COUNT(*) > 3;

-- 33. Payment statuses where count is above 5.
SELECT payment_status, COUNT(*) AS total_orders FROM orders GROUP BY payment_status HAVING COUNT(*) > 5;

-- 34. Order statuses where count is above 5.
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status HAVING COUNT(*) > 5;

-- 35. Customer statuses where count is above 3.
SELECT customer_status, COUNT(*) AS total_customers FROM customers GROUP BY customer_status HAVING COUNT(*) > 3;

-- 36. Campaign statuses where count is above 3.
SELECT campaign_status, COUNT(*) AS total_campaigns FROM campaigns GROUP BY campaign_status HAVING COUNT(*) > 3;

-- 37. Date and country groups where zero orders are reported.
SELECT summary_date, country, SUM(total_orders) AS orders_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(total_orders) = 0;

-- 38. Date and country groups where failed payments are above 5.
SELECT summary_date, country, SUM(failed_payments) AS failed_payment_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(failed_payments) > 5;

-- 39. Date and country groups where cancelled orders are above 3.
SELECT summary_date, country, SUM(cancelled_orders) AS cancelled_order_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(cancelled_orders) > 3;

-- 40. Date and country groups where sales are below 100.
SELECT summary_date, country, SUM(total_sales) AS summary_sales FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(total_sales) < 100;

-- 41. Dates where summary sales are above 1000.
SELECT summary_date, SUM(total_sales) AS daily_sales FROM daily_order_summary GROUP BY summary_date HAVING SUM(total_sales) > 1000;

-- 42. Countries where summary sales are above 2000.
SELECT country, SUM(total_sales) AS country_sales FROM daily_order_summary GROUP BY country HAVING SUM(total_sales) > 2000;

-- 43. Countries above 500 sales, sorted highest first.
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country HAVING SUM(order_amount) > 500 ORDER BY total_sales DESC;

-- 44. Channels above 1000 revenue, sorted highest first.
SELECT channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY channel HAVING SUM(revenue) > 1000 ORDER BY total_revenue DESC;

-- 45. Product categories above 50 average price, sorted highest first.
SELECT category, AVG(price) AS average_price FROM products GROUP BY category HAVING AVG(price) > 50 ORDER BY average_price DESC;

-- 46. Order date and country groups above 2 orders.
SELECT order_date, country, COUNT(*) AS total_orders FROM orders GROUP BY order_date, country HAVING COUNT(*) > 2;

-- 47. Performance date and channel groups above 1000 revenue.
SELECT performance_date, channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date, channel HAVING SUM(revenue) > 1000;

-- 48. Campaign status and channel groups above 1 campaign.
SELECT campaign_status, channel, COUNT(*) AS total_campaigns FROM campaigns GROUP BY campaign_status, channel HAVING COUNT(*) > 1;

-- 49. Summary date and country groups above 2 failed payments.
SELECT summary_date, country, SUM(failed_payments) AS failed_payment_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(failed_payments) > 2;

-- 50. Top five countries above 500 sales.
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country HAVING SUM(order_amount) > 500 ORDER BY total_sales DESC LIMIT 5;

-- 51. Top five channels above 1000 revenue.
SELECT channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY channel HAVING SUM(revenue) > 1000 ORDER BY total_revenue DESC LIMIT 5;
