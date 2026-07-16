-- Day 020: Duplicate Investigation Queries
-- Topic: Finding repeated values using GROUP BY and HAVING

-- 1. Find repeated order IDs.
SELECT order_id, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY order_id HAVING COUNT(*) > 1;

-- 2. Inspect one repeated order ID.
SELECT order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file FROM raw_orders_with_duplicates WHERE order_id = 'ORD1005' ORDER BY source_file;

-- 3. Find repeated order IDs and source files.
SELECT order_id, source_file, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY order_id, source_file HAVING COUNT(*) > 1;

-- 4. Find exact duplicate-looking order rows.
SELECT order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file HAVING COUNT(*) > 1;

-- 5. Count orders by source file.
SELECT source_file, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY source_file ORDER BY source_file;

-- 6. Find repeated cleaned emails.
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS row_count FROM customer_contacts WHERE email IS NOT NULL GROUP BY LOWER(TRIM(email)) HAVING COUNT(*) > 1;

-- 7. Inspect one repeated cleaned email.
SELECT contact_id, customer_id, email, phone, country, contact_status, updated_date FROM customer_contacts WHERE LOWER(TRIM(email)) = 'shared@example.com' ORDER BY updated_date;

-- 8. Find repeated customer IDs in contacts.
SELECT customer_id, COUNT(*) AS row_count FROM customer_contacts GROUP BY customer_id HAVING COUNT(*) > 1;

-- 9. Find blank email rows.
SELECT contact_id, customer_id, email, phone, country, contact_status, updated_date FROM customer_contacts WHERE email IS NULL OR TRIM(email) = '';

-- 10. Find repeated event IDs.
SELECT event_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY event_id HAVING COUNT(*) > 1;

-- 11. Inspect one repeated event ID.
SELECT event_id, user_id, event_date, event_timestamp, event_type, page_name, country, source_file FROM website_events_with_duplicates WHERE event_id = 'EVT1010' ORDER BY source_file, event_timestamp;

-- 12. Find exact duplicate-looking event rows.
SELECT event_id, user_id, event_date, event_timestamp, event_type, page_name, country, source_file, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY event_id, user_id, event_date, event_timestamp, event_type, page_name, country, source_file HAVING COUNT(*) > 1;

-- 13. Show repeated user IDs. This may be normal.
SELECT user_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY user_id HAVING COUNT(*) > 1;

-- 14. Find repeated transaction IDs.
SELECT transaction_id, COUNT(*) AS row_count FROM payment_transactions GROUP BY transaction_id HAVING COUNT(*) > 1;

-- 15. Inspect one repeated transaction ID.
SELECT transaction_id, order_id, payment_date, payment_amount, payment_status, payment_method, source_file FROM payment_transactions WHERE transaction_id = 'TXN5005' ORDER BY source_file;

-- 16. Find exact duplicate-looking transaction rows.
SELECT transaction_id, order_id, payment_date, payment_amount, payment_status, payment_method, source_file, COUNT(*) AS row_count FROM payment_transactions GROUP BY transaction_id, order_id, payment_date, payment_amount, payment_status, payment_method, source_file HAVING COUNT(*) > 1;

-- 17. Find repeated order IDs in payments. Multiple attempts may be normal.
SELECT order_id, COUNT(*) AS row_count FROM payment_transactions GROUP BY order_id HAVING COUNT(*) > 1;

-- 18. Find repeated campaign daily keys.
SELECT performance_date, campaign_id, channel, country, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY performance_date, campaign_id, channel, country HAVING COUNT(*) > 1;

-- 19. Inspect one repeated campaign key.
SELECT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file FROM campaign_performance_duplicates WHERE performance_date = '2026-06-05' AND campaign_id = 'CMP3001' ORDER BY source_file;

-- 20. Find exact duplicate-looking campaign rows.
SELECT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file HAVING COUNT(*) > 1;

-- 21. Count campaign rows by source file.
SELECT source_file, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY source_file ORDER BY source_file;

-- 22. Count payment rows by source file.
SELECT source_file, COUNT(*) AS row_count FROM payment_transactions GROUP BY source_file ORDER BY source_file;

-- 23. Count event rows by source file.
SELECT source_file, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY source_file ORDER BY source_file;

-- 24. Find rows from retry files in orders.
SELECT order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file FROM raw_orders_with_duplicates WHERE source_file = 'orders_retry.csv';

-- 25. Find rows from retry files in campaigns.
SELECT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file FROM campaign_performance_duplicates WHERE source_file = 'retry_load.csv';
