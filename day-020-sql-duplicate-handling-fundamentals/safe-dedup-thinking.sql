-- Day 020: Safe Deduplication Thinking
-- Topic: Investigation queries only. Do not delete raw data blindly.

-- 1. Count all raw order rows before deciding anything.
SELECT COUNT(*) AS total_order_rows FROM raw_orders_with_duplicates;

-- 2. Count distinct order IDs for comparison with total rows.
SELECT COUNT(DISTINCT order_id) AS distinct_order_ids FROM raw_orders_with_duplicates;

-- 3. Find order IDs needing review.
SELECT order_id, COUNT(*) AS row_count FROM raw_orders_with_duplicates GROUP BY order_id HAVING COUNT(*) > 1;

-- 4. Inspect retry-source order records.
SELECT order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file FROM raw_orders_with_duplicates WHERE source_file = 'orders_retry.csv' ORDER BY order_id;

-- 5. Inspect records from late correction source.
SELECT order_id, customer_id, order_date, order_amount, order_status, payment_status, country, source_file FROM raw_orders_with_duplicates WHERE source_file = 'orders_feb.csv' ORDER BY order_id;

-- 6. Count contacts before email review.
SELECT COUNT(*) AS total_contact_rows FROM customer_contacts;

-- 7. Count distinct cleaned emails.
SELECT COUNT(DISTINCT LOWER(TRIM(email))) AS distinct_clean_emails FROM customer_contacts WHERE email IS NOT NULL;

-- 8. Find emails needing review.
SELECT LOWER(TRIM(email)) AS clean_email, COUNT(*) AS row_count FROM customer_contacts WHERE email IS NOT NULL GROUP BY LOWER(TRIM(email)) HAVING COUNT(*) > 1;

-- 9. Find blank emails for separate quality review.
SELECT contact_id, customer_id, email, phone, country, contact_status, updated_date FROM customer_contacts WHERE email IS NULL OR TRIM(email) = '';

-- 10. Count website event rows.
SELECT COUNT(*) AS total_event_rows FROM website_events_with_duplicates;

-- 11. Count distinct event IDs.
SELECT COUNT(DISTINCT event_id) AS distinct_event_ids FROM website_events_with_duplicates;

-- 12. Find event IDs needing review.
SELECT event_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY event_id HAVING COUNT(*) > 1;

-- 13. Show repeated users, which may be normal.
SELECT user_id, COUNT(*) AS row_count FROM website_events_with_duplicates GROUP BY user_id HAVING COUNT(*) > 1;

-- 14. Count payment rows.
SELECT COUNT(*) AS total_payment_rows FROM payment_transactions;

-- 15. Count distinct transaction IDs.
SELECT COUNT(DISTINCT transaction_id) AS distinct_transaction_ids FROM payment_transactions;

-- 16. Find transaction IDs needing review.
SELECT transaction_id, COUNT(*) AS row_count FROM payment_transactions GROUP BY transaction_id HAVING COUNT(*) > 1;

-- 17. Show order IDs with multiple payment attempts, which may be valid.
SELECT order_id, COUNT(*) AS payment_attempts FROM payment_transactions GROUP BY order_id HAVING COUNT(*) > 1;

-- 18. Count campaign performance rows.
SELECT COUNT(*) AS total_campaign_rows FROM campaign_performance_duplicates;

-- 19. Find campaign composite keys needing review.
SELECT performance_date, campaign_id, channel, country, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY performance_date, campaign_id, channel, country HAVING COUNT(*) > 1;

-- 20. Find exact duplicate-looking campaign rows.
SELECT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file, COUNT(*) AS row_count FROM campaign_performance_duplicates GROUP BY performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue, source_file HAVING COUNT(*) > 1;

-- 21. List records that may need business review.
SELECT order_id, order_status, payment_status, source_file FROM raw_orders_with_duplicates WHERE order_id IN ('ORD1005', 'ORD1006', 'ORD1010') ORDER BY order_id, source_file;

-- 22. List repeated payment records for manual review.
SELECT transaction_id, order_id, payment_status, payment_method, source_file FROM payment_transactions WHERE transaction_id IN ('TXN5005', 'TXN5006') ORDER BY transaction_id, source_file;

-- 23. List repeated event records for manual review.
SELECT event_id, user_id, event_timestamp, event_type, source_file FROM website_events_with_duplicates WHERE event_id IN ('EVT1010', 'EVT1011') ORDER BY event_id, source_file;

-- 24. List unique source files involved in order duplicate checks.
SELECT DISTINCT source_file FROM raw_orders_with_duplicates ORDER BY source_file;

-- 25. List unique source files involved in event duplicate checks.
SELECT DISTINCT source_file FROM website_events_with_duplicates ORDER BY source_file;

-- 26. List unique safe action examples.
SELECT DISTINCT safe_action FROM duplicate_output_examples;
