-- Day 018: Period Comparison Queries
-- Topic: Comparing two fixed periods manually
-- Run period A and period B queries separately, then compare the outputs.

-- 1. June paid sales.
SELECT SUM(order_amount) AS june_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-06-01' AND order_date < '2026-07-01';

-- 2. July paid sales.
SELECT SUM(order_amount) AS july_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-07-01' AND order_date < '2026-08-01';

-- 3. June total orders.
SELECT COUNT(*) AS june_total_orders FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';

-- 4. July total orders.
SELECT COUNT(*) AS july_total_orders FROM orders WHERE order_date >= '2026-07-01' AND order_date < '2026-08-01';

-- 5. June failed payments.
SELECT COUNT(*) AS june_failed_payments FROM orders WHERE payment_status = 'Failed' AND order_date >= '2026-06-01' AND order_date < '2026-07-01';

-- 6. July failed payments.
SELECT COUNT(*) AS july_failed_payments FROM orders WHERE payment_status = 'Failed' AND order_date >= '2026-07-01' AND order_date < '2026-08-01';

-- 7. June campaign cost.
SELECT SUM(cost) AS june_campaign_cost FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';

-- 8. July campaign cost.
SELECT SUM(cost) AS july_campaign_cost FROM campaign_performance WHERE performance_date >= '2026-07-01' AND performance_date < '2026-08-01';

-- 9. June campaign revenue.
SELECT SUM(revenue) AS june_campaign_revenue FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';

-- 10. July campaign revenue.
SELECT SUM(revenue) AS july_campaign_revenue FROM campaign_performance WHERE performance_date >= '2026-07-01' AND performance_date < '2026-08-01';

-- 11. June campaign conversions.
SELECT SUM(conversions) AS june_campaign_conversions FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';

-- 12. July campaign conversions.
SELECT SUM(conversions) AS july_campaign_conversions FROM campaign_performance WHERE performance_date >= '2026-07-01' AND performance_date < '2026-08-01';

-- 13. June website events.
SELECT COUNT(*) AS june_events FROM website_events WHERE event_date >= '2026-06-01' AND event_date < '2026-07-01';

-- 14. July website events.
SELECT COUNT(*) AS july_events FROM website_events WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- 15. June purchases.
SELECT COUNT(*) AS june_purchases FROM website_events WHERE event_type = 'purchase' AND event_date >= '2026-06-01' AND event_date < '2026-07-01';

-- 16. July purchases.
SELECT COUNT(*) AS july_purchases FROM website_events WHERE event_type = 'purchase' AND event_date >= '2026-07-01' AND event_date < '2026-08-01';

-- 17. May paid sales.
SELECT SUM(order_amount) AS may_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-05-01' AND order_date < '2026-06-01';

-- 18. August paid sales.
SELECT SUM(order_amount) AS august_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-08-01' AND order_date < '2026-09-01';

-- 19. May campaign revenue.
SELECT SUM(revenue) AS may_campaign_revenue FROM campaign_performance WHERE performance_date >= '2026-05-01' AND performance_date < '2026-06-01';

-- 20. August campaign revenue.
SELECT SUM(revenue) AS august_campaign_revenue FROM campaign_performance WHERE performance_date >= '2026-08-01' AND performance_date < '2026-09-01';

-- 21. June paid sales by country.
SELECT country, SUM(order_amount) AS june_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-06-01' AND order_date < '2026-07-01' GROUP BY country ORDER BY country;

-- 22. July paid sales by country.
SELECT country, SUM(order_amount) AS july_paid_sales FROM orders WHERE payment_status = 'Paid' AND order_date >= '2026-07-01' AND order_date < '2026-08-01' GROUP BY country ORDER BY country;

-- 23. June campaign revenue by channel.
SELECT channel, SUM(revenue) AS june_revenue FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01' GROUP BY channel ORDER BY channel;

-- 24. July campaign revenue by channel.
SELECT channel, SUM(revenue) AS july_revenue FROM campaign_performance WHERE performance_date >= '2026-07-01' AND performance_date < '2026-08-01' GROUP BY channel ORDER BY channel;

-- 25. June campaign cost by country.
SELECT country, SUM(cost) AS june_cost FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01' GROUP BY country ORDER BY country;

-- 26. July campaign cost by country.
SELECT country, SUM(cost) AS july_cost FROM campaign_performance WHERE performance_date >= '2026-07-01' AND performance_date < '2026-08-01' GROUP BY country ORDER BY country;

-- 27. June website events by type.
SELECT event_type, COUNT(*) AS june_events FROM website_events WHERE event_date >= '2026-06-01' AND event_date < '2026-07-01' GROUP BY event_type ORDER BY event_type;

-- 28. July website events by type.
SELECT event_type, COUNT(*) AS july_events FROM website_events WHERE event_date >= '2026-07-01' AND event_date < '2026-08-01' GROUP BY event_type ORDER BY event_type;

-- 29. June daily summary total sales.
SELECT SUM(total_sales) AS june_summary_sales FROM daily_sales_summary WHERE summary_date >= '2026-06-01' AND summary_date < '2026-07-01';

-- 30. July daily summary total sales.
SELECT SUM(total_sales) AS july_summary_sales FROM daily_sales_summary WHERE summary_date >= '2026-07-01' AND summary_date < '2026-08-01';

-- 31. June monthly sales summary.
SELECT country, SUM(total_sales) AS june_monthly_sales FROM monthly_sales_summary WHERE summary_year = 2026 AND summary_month = 6 GROUP BY country ORDER BY country;

-- 32. July monthly sales summary.
SELECT country, SUM(total_sales) AS july_monthly_sales FROM monthly_sales_summary WHERE summary_year = 2026 AND summary_month = 7 GROUP BY country ORDER BY country;
