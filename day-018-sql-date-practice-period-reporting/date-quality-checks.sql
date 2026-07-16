-- Day 018: Date Quality Checks
-- Topic: Freshness, missing dates, future dates, summary quality, and duplicate-looking rows

-- 1. Latest order date.
SELECT MAX(order_date) AS latest_order_date FROM orders;

-- 2. Latest campaign performance date.
SELECT MAX(performance_date) AS latest_performance_date FROM campaign_performance;

-- 3. Latest website event date.
SELECT MAX(event_date) AS latest_event_date FROM website_events;

-- 4. Latest daily sales summary date.
SELECT MAX(summary_date) AS latest_summary_date FROM daily_sales_summary;

-- 5. Latest monthly sales summary year and month.
SELECT MAX(summary_year) AS latest_summary_year, MAX(summary_month) AS latest_summary_month FROM monthly_sales_summary;

-- 6. Latest monthly campaign summary year and month.
SELECT MAX(summary_year) AS latest_summary_year, MAX(summary_month) AS latest_summary_month FROM monthly_campaign_summary;

-- 7. Missing order dates.
SELECT * FROM orders WHERE order_date IS NULL;

-- 8. Future-looking order dates.
SELECT * FROM orders WHERE order_date > '2026-12-31';

-- 9. Future-looking website event dates.
SELECT * FROM website_events WHERE event_date > '2026-12-31';

-- 10. Zero-order daily summary rows.
SELECT * FROM daily_sales_summary WHERE total_orders = 0 ORDER BY summary_date;

-- 11. Low-sales daily summary rows.
SELECT * FROM daily_sales_summary WHERE total_sales < 100 ORDER BY summary_date;

-- 12. High failed-payment daily summary rows.
SELECT * FROM daily_sales_summary WHERE failed_payments > 5 ORDER BY summary_date;

-- 13. Zero-order monthly summary rows.
SELECT * FROM monthly_sales_summary WHERE total_orders = 0 ORDER BY summary_year, summary_month, country;

-- 14. Low-sales monthly summary rows.
SELECT * FROM monthly_sales_summary WHERE total_sales < 100 ORDER BY summary_year, summary_month, country;

-- 15. High failed-payment monthly summary rows.
SELECT * FROM monthly_sales_summary WHERE failed_payments > 10 ORDER BY summary_year, summary_month, country;

-- 16. Monthly campaign rows with zero conversions.
SELECT * FROM monthly_campaign_summary WHERE total_conversions = 0 ORDER BY summary_year, summary_month, channel, country;

-- 17. Monthly campaign rows with high cost.
SELECT * FROM monthly_campaign_summary WHERE total_cost > 5000 ORDER BY summary_year, summary_month, channel, country;

-- 18. Monthly campaign rows with low revenue.
SELECT * FROM monthly_campaign_summary WHERE total_revenue < 100 ORDER BY summary_year, summary_month, channel, country;

-- 19. Monthly pipeline latest run dates.
SELECT pipeline_name, MAX(run_date) AS latest_run_date FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') GROUP BY pipeline_name ORDER BY pipeline_name;

-- 20. Failed monthly pipeline runs.
SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND status = 'Failed' ORDER BY run_date;

-- 21. Running monthly pipeline runs.
SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND status = 'Running' ORDER BY run_date;

-- 22. Skipped monthly pipeline runs.
SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND status = 'Skipped' ORDER BY run_date;

-- 23. Zero-record pipeline runs.
SELECT * FROM pipeline_runs WHERE records_processed = 0 ORDER BY run_date;

-- 24. Pipeline runs with missing completion time.
SELECT * FROM pipeline_runs WHERE completed_at IS NULL ORDER BY run_date;

-- 25. Pipeline runs with missing source file date.
SELECT * FROM pipeline_runs WHERE source_file_date IS NULL ORDER BY run_date;

-- 26. Daily summary rows by date.
SELECT summary_date, COUNT(*) AS row_count FROM daily_sales_summary GROUP BY summary_date ORDER BY summary_date;

-- 27. Monthly sales summary rows by period.
SELECT summary_year, summary_month, COUNT(*) AS row_count FROM monthly_sales_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 28. Monthly campaign summary rows by period.
SELECT summary_year, summary_month, COUNT(*) AS row_count FROM monthly_campaign_summary GROUP BY summary_year, summary_month ORDER BY summary_year, summary_month;

-- 29. Duplicate-looking monthly sales summary rows.
SELECT summary_year, summary_month, country, COUNT(*) AS row_count FROM monthly_sales_summary GROUP BY summary_year, summary_month, country HAVING COUNT(*) > 1;

-- 30. Duplicate-looking monthly campaign summary rows.
SELECT summary_year, summary_month, channel, country, COUNT(*) AS row_count FROM monthly_campaign_summary GROUP BY summary_year, summary_month, channel, country HAVING COUNT(*) > 1;

-- 31. Latest order date by country.
SELECT country, MAX(order_date) AS latest_order_date FROM orders GROUP BY country ORDER BY country;

-- 32. Latest campaign date by country.
SELECT country, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY country ORDER BY country;

-- 33. Latest campaign date by channel.
SELECT channel, MAX(performance_date) AS latest_performance_date FROM campaign_performance GROUP BY channel ORDER BY channel;

-- 34. Latest website event date by country.
SELECT country, MAX(event_date) AS latest_event_date FROM website_events GROUP BY country ORDER BY country;

-- 35. Latest pipeline source file date by pipeline.
SELECT pipeline_name, MAX(source_file_date) AS latest_source_file_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;

-- 36. Monthly sales summary high cancellations.
SELECT * FROM monthly_sales_summary WHERE cancelled_orders > 8 ORDER BY summary_year, summary_month, country;

-- 37. Campaign summary high cost and low revenue review.
SELECT * FROM monthly_campaign_summary WHERE total_cost > 5000 AND total_revenue < 1000 ORDER BY summary_year, summary_month, channel, country;

-- 38. Daily summary rows with high cancelled orders.
SELECT * FROM daily_sales_summary WHERE cancelled_orders > 4 ORDER BY summary_date, country;

-- 39. Old-looking monthly summary pipeline runs.
SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND run_date < '2026-07-01' ORDER BY run_date;

-- 40. Latest completed time by monthly pipeline.
SELECT pipeline_name, MAX(completed_at) AS latest_completed_at FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') GROUP BY pipeline_name ORDER BY pipeline_name;
