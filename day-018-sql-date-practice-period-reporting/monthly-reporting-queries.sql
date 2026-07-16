-- Day 018: Monthly Reporting Queries
-- Topic: Grouping data by year and month
-- Date functions may differ by SQL platform.

-- 1. Monthly order count.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 2. Monthly total sales.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS total_sales FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 3. Monthly paid sales.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 4. Monthly failed payments.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 5. Monthly cancelled orders.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS cancelled_orders FROM orders WHERE order_status = 'Cancelled' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 6. Monthly returned orders.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS returned_orders FROM orders WHERE order_status = 'Returned' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 7. Monthly order count by country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 8. Monthly paid sales by country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 9. Monthly failed payments by country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 10. Monthly campaign impressions.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(impressions) AS total_impressions FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 11. Monthly campaign clicks.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(clicks) AS total_clicks FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 12. Monthly campaign cost.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 13. Monthly campaign conversions.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 14. Monthly campaign revenue.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 15. Monthly campaign revenue by channel.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel ORDER BY performance_year, performance_month, channel;

-- 16. Monthly campaign cost by channel.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel ORDER BY performance_year, performance_month, channel;

-- 17. Monthly campaign conversions by channel.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel ORDER BY performance_year, performance_month, channel;

-- 18. Monthly campaign revenue by country.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), country ORDER BY performance_year, performance_month, country;

-- 19. Monthly campaign cost by country.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, country, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), country ORDER BY performance_year, performance_month, country;

-- 20. Monthly website event count.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 21. Monthly website events by type.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, event_type, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date), event_type ORDER BY event_year, event_month, event_type;

-- 22. Monthly purchases.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS purchases FROM website_events WHERE event_type = 'purchase' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 23. Monthly signups.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS signups FROM website_events WHERE event_type = 'signup' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 24. Monthly events by country.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, country, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date), country ORDER BY event_year, event_month, country;

-- 25. Monthly sales summary rows by period.
SELECT summary_year, summary_month, COUNT(*) AS total_rows FROM monthly_sales_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 26. Monthly sales summary total sales.
SELECT summary_year, summary_month, SUM(total_sales) AS total_sales FROM monthly_sales_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 27. Monthly sales summary total orders.
SELECT summary_year, summary_month, SUM(total_orders) AS total_orders FROM monthly_sales_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 28. Monthly campaign summary revenue.
SELECT summary_year, summary_month, SUM(total_revenue) AS total_revenue FROM monthly_campaign_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 29. Monthly campaign summary cost.
SELECT summary_year, summary_month, SUM(total_cost) AS total_cost FROM monthly_campaign_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 30. Monthly campaign summary conversions.
SELECT summary_year, summary_month, SUM(total_conversions) AS total_conversions FROM monthly_campaign_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 31. June orders using one-month filter.
SELECT * FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';

-- 32. July orders using one-month filter.
SELECT * FROM orders WHERE order_date >= '2026-07-01' AND order_date < '2026-08-01';

-- 33. June campaign performance using one-month filter.
SELECT * FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';

-- 34. July website events using one-month filter.
SELECT * FROM website_events WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- 35. Latest order date by country.
SELECT country, MAX(order_date) AS latest_order_date FROM orders GROUP BY country ORDER BY country;

-- 36. Latest campaign performance date by channel.
SELECT channel, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY channel ORDER BY channel;

-- 37. Latest event date by event type.
SELECT event_type, MAX(event_date) AS latest_event_date FROM website_events GROUP BY event_type ORDER BY event_type;

-- 38. Monthly cancelled orders by country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, COUNT(*) AS cancelled_orders FROM orders WHERE order_status = 'Cancelled' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 39. Monthly refunded orders.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS refunded_orders FROM orders WHERE payment_status = 'Refunded' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 40. Monthly page views.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS page_views FROM website_events WHERE event_type = 'page_view' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;
