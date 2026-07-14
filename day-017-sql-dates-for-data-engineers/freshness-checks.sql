-- Day 017: Freshness Checks
-- Topic: Latest dates, pipeline status, and simple date quality checks

-- 1. Latest order date shows whether new orders arrived.
SELECT MAX(order_date) AS latest_order_date FROM orders;

-- 2. Latest customer signup date shows newest customer data.
SELECT MAX(signup_date) AS latest_signup_date FROM customers;

-- 3. Latest campaign performance date checks marketing data freshness.
SELECT MAX(performance_date) AS latest_performance_date FROM campaign_performance;

-- 4. Latest website event date checks event data freshness.
SELECT MAX(event_date) AS latest_event_date FROM website_events;

-- 5. Latest pipeline run date checks pipeline activity.
SELECT MAX(run_date) AS latest_run_date FROM pipeline_runs;

-- 6. Latest sales summary date checks dashboard-ready data freshness.
SELECT MAX(summary_date) AS latest_summary_date FROM daily_sales_summary;

-- 7. Earliest order date shows available order history.
SELECT MIN(order_date) AS earliest_order_date FROM orders;

-- 8. Earliest campaign performance date shows available campaign history.
SELECT MIN(performance_date) AS earliest_performance_date FROM campaign_performance;

-- 9. Orders with missing dates cannot be grouped into daily reports correctly.
SELECT * FROM orders WHERE order_date IS NULL;

-- 10. Customers with missing signup dates affect signup trend reports.
SELECT * FROM customers WHERE signup_date IS NULL;

-- 11. Latest campaign performance date by channel shows if one channel is stale.
SELECT channel, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY channel ORDER BY channel;

-- 12. Latest website event date by event type shows if one event stream is stale.
SELECT event_type, MAX(event_date) AS latest_event_date FROM website_events GROUP BY event_type ORDER BY event_type;

-- 13. Latest run date by pipeline name shows freshness per pipeline.
SELECT pipeline_name, MAX(run_date) AS latest_run_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;

-- 14. Latest summary date by country shows if one country is behind.
SELECT country, MAX(summary_date) AS latest_summary_date FROM daily_sales_summary GROUP BY country ORDER BY country;

-- 15. Pipeline runs by status help monitor overall run health.
SELECT status, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY status ORDER BY status;

-- 16. Pipeline runs by date and status show daily pipeline health.
SELECT run_date, status, COUNT(*) AS total_runs FROM pipeline_runs GROUP BY run_date, status ORDER BY run_date, status;

-- 17. Failed pipeline runs need investigation.
SELECT * FROM pipeline_runs WHERE status = 'Failed' ORDER BY run_date;

-- 18. Skipped pipeline runs may explain missing data.
SELECT * FROM pipeline_runs WHERE status = 'Skipped' ORDER BY run_date;

-- 19. Running pipeline runs may indicate incomplete data.
SELECT * FROM pipeline_runs WHERE status = 'Running' ORDER BY run_date;

-- 20. Zero records processed can be normal or a warning.
SELECT * FROM pipeline_runs WHERE records_processed = 0 ORDER BY run_date;

-- 21. Latest source file date by pipeline checks source freshness.
SELECT pipeline_name, MAX(source_file_date) AS latest_source_file_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;

-- 22. Missing source file dates make source freshness unclear.
SELECT * FROM pipeline_runs WHERE source_file_date IS NULL ORDER BY run_date;

-- 23. Missing completed_at values may indicate incomplete runs.
SELECT * FROM pipeline_runs WHERE completed_at IS NULL ORDER BY run_date;

-- 24. Latest run date by pipeline supports freshness investigation.
SELECT pipeline_name, MAX(run_date) AS latest_run_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;

-- 25. Latest completed_at by pipeline shows recent completion time.
SELECT pipeline_name, MAX(completed_at) AS latest_completed_at FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;

-- 26. Records processed by run date shows daily processing volume.
SELECT run_date, SUM(records_processed) AS total_records_processed FROM pipeline_runs GROUP BY run_date ORDER BY run_date;

-- 27. Records processed by pipeline and run date shows per-pipeline volume.
SELECT pipeline_name, run_date, SUM(records_processed) AS total_records_processed FROM pipeline_runs GROUP BY pipeline_name, run_date ORDER BY pipeline_name, run_date;

-- 28. Daily summary latest date by country checks dashboard freshness per country.
SELECT country, MAX(summary_date) AS latest_summary_date FROM daily_sales_summary GROUP BY country ORDER BY country;

-- 29. Daily sales summary rows with zero orders need review.
SELECT * FROM daily_sales_summary WHERE total_orders = 0 ORDER BY summary_date;

-- 30. Failed payments above an example threshold need review.
SELECT * FROM daily_sales_summary WHERE failed_payments > 5 ORDER BY summary_date;

-- 31. Cancelled orders above an example threshold need review.
SELECT * FROM daily_sales_summary WHERE cancelled_orders > 4 ORDER BY summary_date;

-- 32. Very low sales may indicate missing data or a quiet day.
SELECT * FROM daily_sales_summary WHERE total_sales < 100 ORDER BY summary_date;

-- 33. Daily summary rows grouped by summary date.
SELECT summary_date, COUNT(*) AS total_rows FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 34. Latest order date by payment status checks freshness across payment groups.
SELECT payment_status, MAX(order_date) AS latest_order_date FROM orders GROUP BY payment_status ORDER BY payment_status;

-- 35. Latest campaign performance date by country checks country-level freshness.
SELECT country, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY country ORDER BY country;
