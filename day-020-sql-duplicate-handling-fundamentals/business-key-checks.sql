-- Day 020: Business Key Checks
-- Topic: Checking expected identifiers and table grain

-- 1. Check order_id as possible business key.
SELECT order_id, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY order_id HAVING COUNT(*) > 1;

-- 2. Check transaction_id as possible business key.
SELECT transaction_id, COUNT(*) AS row_count FROM payment_transactions GROUP BY transaction_id HAVING COUNT(*) > 1;

-- 3. Check event_id as possible business key.
SELECT event_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY event_id HAVING COUNT(*) > 1;

-- 4. Check campaign composite business key.
SELECT performance_date, campaign_id, channel, country, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY performance_date, campaign_id, channel, country HAVING COUNT(*) > 1;

-- 5. Check contact_id as technical key.
SELECT contact_id, COUNT(*) AS row_count FROM customer_contacts GROUP BY contact_id HAVING COUNT(*) > 1;

-- 6. Check cleaned email repetition.
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS row_count FROM customer_contacts WHERE email IS NOT NULL GROUP BY LOWER(TRIM(email)) HAVING COUNT(*) > 1;

-- 7. Check customer_id repetition in orders. This may be normal.
SELECT customer_id, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY customer_id HAVING COUNT(*) > 1;

-- 8. Check user_id repetition in events. This may be normal.
SELECT user_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY user_id HAVING COUNT(*) > 1;

-- 9. Check order_id repetition in payments. Multiple attempts may be normal.
SELECT order_id, COUNT(*) AS row_count FROM payment_transactions GROUP BY order_id HAVING COUNT(*) > 1;

-- 10. Check campaign_id repetition across dates. This is normally expected.
SELECT campaign_id, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY campaign_id HAVING COUNT(*) > 1;

-- 11. Inspect repeated order key with changed values.
SELECT order_id, order_status, payment_status, source_file FROM raw_orders_with_duplicates WHERE order_id = 'ORD1006' ORDER BY source_file;

-- 12. Inspect repeated transaction key with changed status.
SELECT transaction_id, payment_status, source_file FROM payment_transactions WHERE transaction_id = 'TXN5006' ORDER BY source_file;

-- 13. Inspect repeated event key with changed timestamp.
SELECT event_id, event_timestamp, event_type, source_file FROM website_events_with_duplicates WHERE event_id = 'EVT1011' ORDER BY event_timestamp;

-- 14. Inspect campaign key with changed metrics.
SELECT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file FROM campaign_performance_duplicates WHERE performance_date = '2026-06-08' AND campaign_id = 'CMP3002' ORDER BY source_file;

-- 15. Count rows by order source file.
SELECT source_file, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY source_file ORDER BY source_file;

-- 16. Count rows by payment source file.
SELECT source_file, COUNT(*) AS row_count FROM payment_transactions GROUP BY source_file ORDER BY source_file;

-- 17. Count rows by event source file.
SELECT source_file, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY source_file ORDER BY source_file;

-- 18. Count rows by campaign source file.
SELECT source_file, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY source_file ORDER BY source_file;

-- 19. List possible order grain fields.
SELECT DISTINCT order_id, customer_id, order_date, source_file FROM raw_orders_with_duplicates ORDER BY order_id;

-- 20. List possible payment grain fields.
SELECT DISTINCT transaction_id, order_id, payment_date, source_file FROM payment_transactions ORDER BY transaction_id;
