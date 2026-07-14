-- Day 017: Daily Reporting Queries
-- Topic: Daily summaries for orders, campaigns, website events, and pipeline runs

-- 1. Total orders by order date.
SELECT order_date, COUNT(*) AS total_orders FROM orders GROUP BY order_date ORDER BY order_date;

-- 2. Total sales by order date.
SELECT order_date, SUM(order_amount) AS total_sales FROM orders GROUP BY order_date ORDER BY order_date;

-- 3. Paid orders by order date.
SELECT order_date, COUNT(*) AS paid_orders FROM orders WHERE payment_status = 'Paid' GROUP BY order_date ORDER BY order_date;

-- 4. Failed payments by order date.
SELECT order_date, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY order_date ORDER BY order_date;

-- 5. Cancelled orders by order date.
SELECT order_date, COUNT(*) AS cancelled_orders FROM orders WHERE order_status = 'Cancelled' GROUP BY order_date ORDER BY order_date;

-- 6. Orders by order date and country.
SELECT order_date, country, COUNT(*) AS total_orders FROM orders GROUP BY order_date, country ORDER BY order_date, country;

-- 7. Paid sales by order date and country.
SELECT order_date, country, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY order_date, country ORDER BY order_date, country;

-- 8. Latest order date per country.
SELECT country, MAX(order_date) AS latest_order_date FROM orders GROUP BY country ORDER BY country;

-- 9. Impressions by performance date.
SELECT performance_date, SUM(impressions) AS total_impressions FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 10. Clicks by performance date.
SELECT performance_date, SUM(clicks) AS total_clicks FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 11. Cost by performance date.
SELECT performance_date, SUM(cost) AS total_cost FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 12. Conversions by performance date.
SELECT performance_date, SUM(conversions) AS total_conversions FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 13. Revenue by performance date.
SELECT performance_date, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;

-- 14. Campaign performance by date and channel.
SELECT performance_date, channel, SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date, channel ORDER BY performance_date, channel;

-- 15. Campaign revenue by date and country.
SELECT performance_date, country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date, country ORDER BY performance_date, country;

-- 16. Latest performance date per channel.
SELECT channel, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY channel ORDER BY channel;

-- 17. Total events by event date.
SELECT event_date, COUNT(*) AS total_events FROM website_events GROUP BY event_date ORDER BY event_date;

-- 18. Events by event date and event type.
SELECT event_date, event_type, COUNT(*) AS total_events FROM website_events GROUP BY event_date, event_type ORDER BY event_date, event_type;

-- 19. Page views by event date.
SELECT event_date, COUNT(*) AS page_views FROM website_events WHERE event_type = 'page_view' GROUP BY event_date ORDER BY event_date;

-- 20. Purchases by event date.
SELECT event_date, COUNT(*) AS purchases FROM website_events WHERE event_type = 'purchase' GROUP BY event_date ORDER BY event_date;

-- 21. Signups by event date.
SELECT event_date, COUNT(*) AS signups FROM website_events WHERE event_type = 'signup' GROUP BY event_date ORDER BY event_date;

-- 22. Events by event date and country.
SELECT event_date, country, COUNT(*) AS total_events FROM website_events GROUP BY event_date, country ORDER BY event_date, country;

-- 23. Latest event date by event type.
SELECT event_type, MAX(event_date) AS latest_event_date FROM website_events GROUP BY event_type ORDER BY event_type;

-- 24. Pipeline runs by run date.
SELECT run_date, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY run_date ORDER BY run_date;

-- 25. Pipeline runs by run date and status.
SELECT run_date, status, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY run_date, status ORDER BY run_date, status;

-- 26. Records processed by run date.
SELECT run_date, SUM(records_processed) AS total_records_processed FROM pipeline_runs GROUP BY run_date ORDER BY run_date;

-- 27. Records processed by run date and pipeline name.
SELECT run_date, pipeline_name, SUM(records_processed) AS total_records_processed FROM pipeline_runs GROUP BY run_date, pipeline_name ORDER BY run_date, pipeline_name;

-- 28. Failed pipeline runs by run date.
SELECT run_date, COUNT(*) AS failed_runs FROM pipeline_runs WHERE status = 'Failed' GROUP BY run_date ORDER BY run_date;

-- 29. Daily summary total sales by summary date.
SELECT summary_date, SUM(total_sales) AS total_sales FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 30. Daily summary total orders by summary date.
SELECT summary_date, SUM(total_orders) AS total_orders FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 31. Daily summary failed payments by summary date.
SELECT summary_date, SUM(failed_payments) AS failed_payments FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 32. Daily summary cancelled orders by summary date.
SELECT summary_date, SUM(cancelled_orders) AS cancelled_orders FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 33. Daily summary by summary date and country.
SELECT summary_date, country, SUM(total_orders) AS total_orders, SUM(total_sales) AS total_sales FROM daily_sales_summary GROUP BY summary_date, country ORDER BY summary_date, country;

-- 34. Zero-order summary rows.
SELECT * FROM daily_sales_summary WHERE total_orders = 0 ORDER BY summary_date;

-- 35. Low-sales summary rows using an example threshold.
SELECT * FROM daily_sales_summary WHERE total_sales < 100 ORDER BY summary_date;
