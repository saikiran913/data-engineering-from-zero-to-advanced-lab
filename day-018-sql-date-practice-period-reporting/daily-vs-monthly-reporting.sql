-- Day 018: Daily vs Monthly Reporting
-- Topic: Understanding daily summaries and monthly rollups

-- 1. Daily order count.
SELECT order_date, COUNT(*) AS total_orders FROM orders GROUP BY order_date ORDER BY order_date;

-- 2. Daily paid sales.
SELECT order_date, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY order_date ORDER BY order_date;

-- 3. Daily failed payments.
SELECT order_date, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY order_date ORDER BY order_date;

-- 4. Daily cancelled orders.
SELECT order_date, COUNT(*) AS cancelled_orders FROM orders WHERE order_status = 'Cancelled' GROUP BY order_date ORDER BY order_date;

-- 5. Daily sales by country.
SELECT order_date, country, SUM(order_amount) AS total_sales FROM orders GROUP BY order_date, country ORDER BY order_date, country;

-- 6. Monthly order count.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 7. Monthly paid sales.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 8. Monthly failed payments.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 9. Monthly cancelled orders.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS cancelled_orders FROM orders WHERE order_status = 'Cancelled' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 10. Monthly sales by country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, SUM(order_amount) AS total_sales FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 11. Daily campaign cost.
SELECT performance_date, SUM(cost) AS total_cost FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 12. Daily campaign revenue.
SELECT performance_date, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 13. Daily conversions.
SELECT performance_date, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 14. Daily campaign cost by channel.
SELECT performance_date, channel, SUM(cost) AS total_cost FROM campaign_performance GROUP BY performance_date, channel ORDER BY performance_date, channel;

-- 15. Daily campaign revenue by country.
SELECT performance_date, country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date, country ORDER BY performance_date, country;

-- 16. Monthly campaign cost.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 17. Monthly campaign revenue.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 18. Monthly conversions.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 19. Monthly campaign cost by channel.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel ORDER BY performance_year, performance_month, channel;

-- 20. Monthly campaign revenue by country.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), country ORDER BY performance_year, performance_month, country;

-- 21. Daily event count.
SELECT event_date, COUNT(*) AS total_events FROM website_events GROUP BY event_date ORDER BY event_date;

-- 22. Daily event count by event type.
SELECT event_date, event_type, COUNT(*) AS total_events FROM website_events GROUP BY event_date, event_type ORDER BY event_date, event_type;

-- 23. Daily purchases.
SELECT event_date, COUNT(*) AS purchases FROM website_events WHERE event_type = 'purchase' GROUP BY event_date ORDER BY event_date;

-- 24. Daily signups.
SELECT event_date, COUNT(*) AS signups FROM website_events WHERE event_type = 'signup' GROUP BY event_date ORDER BY event_date;

-- 25. Monthly event count.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 26. Monthly event count by event type.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, event_type, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date), event_type ORDER BY event_year, event_month, event_type;

-- 27. Monthly purchases.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS purchases FROM website_events WHERE event_type = 'purchase' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 28. Monthly signups.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS signups FROM website_events WHERE event_type = 'signup' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 29. Daily sales summary by summary date.
SELECT summary_date, SUM(total_sales) AS total_sales FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 30. Monthly sales summary by year and month.
SELECT summary_year, summary_month, SUM(total_sales) AS total_sales FROM monthly_sales_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 31. Monthly campaign summary by year and month.
SELECT summary_year, summary_month, SUM(total_revenue) AS total_revenue FROM monthly_campaign_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 32. Daily summary low sales rows.
SELECT * FROM daily_sales_summary WHERE total_sales < 100 ORDER BY summary_date;

-- 33. Monthly summary low sales rows.
SELECT * FROM monthly_sales_summary WHERE total_sales < 100 ORDER BY summary_year, summary_month;

-- 34. Daily summary high failed payment rows.
SELECT * FROM daily_sales_summary WHERE failed_payments > 5 ORDER BY summary_date;

-- 35. Monthly summary high failed payment rows.
SELECT * FROM monthly_sales_summary WHERE failed_payments > 10 ORDER BY summary_year, summary_month;
