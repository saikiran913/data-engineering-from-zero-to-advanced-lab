-- Day 017: Date Filtering Queries
-- Topic: Filtering, sorting, and checking date ranges
-- Exact date syntax may vary across SQL platforms.

-- 1. Orders from one specific date.
SELECT * FROM orders WHERE order_date = '2026-06-15';

-- 2. Orders from another specific date.
SELECT * FROM orders WHERE order_date = '2026-07-01';

-- 3. Customers who signed up on one date.
SELECT * FROM customers WHERE signup_date = '2026-06-10';

-- 4. Campaign performance for one date.
SELECT * FROM campaign_performance WHERE performance_date = '2026-06-15';

-- 5. Website events for one date.
SELECT * FROM website_events WHERE event_date = '2026-06-15';

-- 6. Pipeline runs for one date.
SELECT * FROM pipeline_runs WHERE run_date = '2026-07-01';

-- 7. Daily summary rows for one date.
SELECT * FROM daily_sales_summary WHERE summary_date = '2026-06-15';

-- 8. June orders using BETWEEN.
SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 9. July orders using BETWEEN.
SELECT * FROM orders WHERE order_date BETWEEN '2026-07-01' AND '2026-07-31';

-- 10. June customers using BETWEEN.
SELECT * FROM customers WHERE signup_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 11. June campaign performance using BETWEEN.
SELECT * FROM campaign_performance WHERE performance_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 12. June website events using BETWEEN.
SELECT * FROM website_events WHERE event_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 13. Pipeline runs in a date range.
SELECT * FROM pipeline_runs WHERE run_date BETWEEN '2026-06-25' AND '2026-07-05';

-- 14. Daily summaries in a date range.
SELECT * FROM daily_sales_summary WHERE summary_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 15. June orders using start-inclusive and end-exclusive range.
SELECT * FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';

-- 16. July orders using start-inclusive and end-exclusive range.
SELECT * FROM orders WHERE order_date >= '2026-07-01' AND order_date < '2026-08-01';

-- 17. Campaign performance using start-inclusive and end-exclusive range.
SELECT * FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';

-- 18. Website events using start-inclusive and end-exclusive range.
SELECT * FROM website_events WHERE event_date >= '2026-06-01' AND event_date < '2026-07-01';

-- 19. Pipeline runs using start-inclusive and end-exclusive range.
SELECT * FROM pipeline_runs WHERE run_date >= '2026-07-01' AND run_date < '2026-07-08';

-- 20. Daily summary rows using start-inclusive and end-exclusive range.
SELECT * FROM daily_sales_summary WHERE summary_date >= '2026-06-01' AND summary_date < '2026-07-01';

-- 21. Orders before a date.
SELECT * FROM orders WHERE order_date < '2026-06-15';

-- 22. Orders on or after a date.
SELECT * FROM orders WHERE order_date >= '2026-07-01';

-- 23. Campaign performance after a date.
SELECT * FROM campaign_performance WHERE performance_date > '2026-06-20';

-- 24. Website events before a date.
SELECT * FROM website_events WHERE event_date < '2026-06-20';

-- 25. Pipeline runs on or after a date.
SELECT * FROM pipeline_runs WHERE run_date >= '2026-07-01';

-- 26. Orders sorted oldest first.
SELECT * FROM orders ORDER BY order_date ASC;

-- 27. Orders sorted newest first.
SELECT * FROM orders ORDER BY order_date DESC;

-- 28. Campaign performance sorted by newest date.
SELECT * FROM campaign_performance ORDER BY performance_date DESC;

-- 29. Website events sorted by date and timestamp.
SELECT * FROM website_events ORDER BY event_date, event_timestamp;

-- 30. Pipeline runs sorted by newest run date.
SELECT * FROM pipeline_runs ORDER BY run_date DESC;

-- 31. Latest order date.
SELECT MAX(order_date) AS latest_order_date FROM orders;

-- 32. Earliest order date.
SELECT MIN(order_date) AS earliest_order_date FROM orders;

-- 33. Latest customer signup date.
SELECT MAX(signup_date) AS latest_signup_date FROM customers;

-- 34. Earliest customer signup date.
SELECT MIN(signup_date) AS earliest_signup_date FROM customers;

-- 35. Latest campaign performance date.
SELECT MAX(performance_date) AS latest_performance_date FROM campaign_performance;

-- 36. Earliest campaign performance date.
SELECT MIN(performance_date) AS earliest_performance_date FROM campaign_performance;

-- 37. Latest website event date.
SELECT MAX(event_date) AS latest_event_date FROM website_events;

-- 38. Latest pipeline run date.
SELECT MAX(run_date) AS latest_run_date FROM pipeline_runs;

-- 39. Latest daily sales summary date.
SELECT MAX(summary_date) AS latest_summary_date FROM daily_sales_summary;

-- 40. Orders with missing order date.
SELECT * FROM orders WHERE order_date IS NULL;

-- 41. Customers with missing signup date.
SELECT * FROM customers WHERE signup_date IS NULL;

-- 42. Orders with future-looking dates for investigation.
SELECT * FROM orders WHERE order_date > '2026-12-31';

-- 43. Pipeline runs with missing completed time.
SELECT * FROM pipeline_runs WHERE completed_at IS NULL;

-- 44. Pipeline runs with missing source file date.
SELECT * FROM pipeline_runs WHERE source_file_date IS NULL;

-- 45. Website events on a date sorted by exact timestamp.
SELECT * FROM website_events WHERE event_date = '2026-06-15' ORDER BY event_timestamp;
