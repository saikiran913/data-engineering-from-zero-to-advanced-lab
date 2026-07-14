-- Day 017: Date Parts Practice
-- Topic: Year, month, day, and week-style reporting
-- Main examples use EXTRACT. Some SQL platforms require different date functions.

-- 1. Show order year.
SELECT order_id, order_date, EXTRACT(YEAR FROM order_date) AS order_year FROM orders;

-- 2. Show order month.
SELECT order_id, order_date, EXTRACT(MONTH FROM order_date) AS order_month FROM orders;

-- 3. Show order day.
SELECT order_id, order_date, EXTRACT(DAY FROM order_date) AS order_day FROM orders;

-- 4. Show customer signup year.
SELECT customer_id, signup_date, EXTRACT(YEAR FROM signup_date) AS signup_year FROM customers;

-- 5. Show customer signup month.
SELECT customer_id, signup_date, EXTRACT(MONTH FROM signup_date) AS signup_month FROM customers;

-- 6. Show campaign performance year.
SELECT performance_date, campaign_id, EXTRACT(YEAR FROM performance_date) AS performance_year FROM campaign_performance;

-- 7. Show campaign performance month.
SELECT performance_date, campaign_id, EXTRACT(MONTH FROM performance_date) AS performance_month FROM campaign_performance;

-- 8. Show website event month.
SELECT event_id, event_date, EXTRACT(MONTH FROM event_date) AS event_month FROM website_events;

-- 9. Show pipeline run month.
SELECT pipeline_name, run_date, EXTRACT(MONTH FROM run_date) AS run_month FROM pipeline_runs;

-- 10. Show daily summary month.
SELECT summary_date, country, EXTRACT(MONTH FROM summary_date) AS summary_month FROM daily_sales_summary;

-- 11. Monthly order counts.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 12. Monthly order sales.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS total_sales FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 13. Monthly paid order counts.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS paid_orders FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;

-- 14. Monthly customer signup counts.
SELECT EXTRACT(YEAR FROM signup_date) AS signup_year, EXTRACT(MONTH FROM signup_date) AS signup_month, COUNT(*) AS total_signups FROM customers GROUP BY EXTRACT(YEAR FROM signup_date), EXTRACT(MONTH FROM signup_date) ORDER BY signup_year, signup_month;

-- 15. Monthly campaign impressions.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(impressions) AS total_impressions FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 16. Monthly campaign revenue.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date) ORDER BY performance_year, performance_month;

-- 17. Monthly website event counts.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date) ORDER BY event_year, event_month;

-- 18. Monthly pipeline run counts.
SELECT EXTRACT(YEAR FROM run_date) AS run_year, EXTRACT(MONTH FROM run_date) AS run_month, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY EXTRACT(YEAR FROM run_date), EXTRACT(MONTH FROM run_date) ORDER BY run_year, run_month;

-- 19. Monthly daily summary sales.
SELECT EXTRACT(YEAR FROM summary_date) AS summary_year, EXTRACT(MONTH FROM summary_date) AS summary_month, SUM(total_sales) AS total_sales FROM daily_sales_summary GROUP BY EXTRACT(YEAR FROM summary_date), EXTRACT(MONTH FROM summary_date) ORDER BY summary_year, summary_month;

-- 20. Order counts by month and country.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country ORDER BY order_year, order_month, country;

-- 21. Campaign revenue by month and channel.
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel ORDER BY performance_year, performance_month, channel;

-- 22. Website events by month and event type.
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, event_type, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date), event_type ORDER BY event_year, event_month, event_type;

-- 23. Pipeline runs by month and status.
SELECT EXTRACT(YEAR FROM run_date) AS run_year, EXTRACT(MONTH FROM run_date) AS run_month, status, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY EXTRACT(YEAR FROM run_date), EXTRACT(MONTH FROM run_date), status ORDER BY run_year, run_month, status;

-- 24. Daily summary sales by month and country.
SELECT EXTRACT(YEAR FROM summary_date) AS summary_year, EXTRACT(MONTH FROM summary_date) AS summary_month, country, SUM(total_sales) AS total_sales FROM daily_sales_summary GROUP BY EXTRACT(YEAR FROM summary_date), EXTRACT(MONTH FROM summary_date), country ORDER BY summary_year, summary_month, country;

-- 25. Orders grouped by day of month.
SELECT EXTRACT(DAY FROM order_date) AS order_day, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(DAY FROM order_date) ORDER BY order_day;

-- 26. Campaign performance grouped by day of month.
SELECT EXTRACT(DAY FROM performance_date) AS performance_day, SUM(clicks) AS total_clicks FROM campaign_performance GROUP BY EXTRACT(DAY FROM performance_date) ORDER BY performance_day;

-- 27. Website events grouped by day of month.
SELECT EXTRACT(DAY FROM event_date) AS event_day, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(DAY FROM event_date) ORDER BY event_day;

-- 28. Pipeline runs grouped by day of month.
SELECT EXTRACT(DAY FROM run_date) AS run_day, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY EXTRACT(DAY FROM run_date) ORDER BY run_day;

-- 29. Summary rows grouped by day of month.
SELECT EXTRACT(DAY FROM summary_date) AS summary_day, SUM(total_orders) AS total_orders FROM daily_sales_summary GROUP BY EXTRACT(DAY FROM summary_date) ORDER BY summary_day;

-- 30. Latest order date by order month.
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, MAX(order_date) AS latest_order_date FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date) ORDER BY order_year, order_month;
