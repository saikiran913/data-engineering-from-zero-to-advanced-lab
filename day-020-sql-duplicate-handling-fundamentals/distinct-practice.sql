-- Day 020: DISTINCT Practice
-- Topic: Unique output values and unique output combinations

-- 1. List unique order countries.
SELECT DISTINCT country FROM raw_orders_with_duplicates;

-- 2. List unique order statuses.
SELECT DISTINCT order_status FROM raw_orders_with_duplicates;

-- 3. List unique payment statuses.
SELECT DISTINCT payment_status FROM raw_orders_with_duplicates;

-- 4. List unique order source files.
SELECT DISTINCT source_file FROM raw_orders_with_duplicates;

-- 5. List unique country and payment status combinations.
SELECT DISTINCT country, payment_status FROM raw_orders_with_duplicates;

-- 6. List unique order status and payment status combinations.
SELECT DISTINCT order_status, payment_status FROM raw_orders_with_duplicates;

-- 7. List unique contact countries.
SELECT DISTINCT country FROM customer_contacts;

-- 8. List unique contact statuses.
SELECT DISTINCT contact_status FROM customer_contacts;

-- 9. List unique raw email values.
SELECT DISTINCT email FROM customer_contacts;

-- 10. List unique cleaned email values.
SELECT DISTINCT LOWER(TRIM(email)) AS clean_email FROM customer_contacts WHERE email IS NOT NULL;

-- 11. List unique website event types.
SELECT DISTINCT event_type FROM website_events_with_duplicates;

-- 12. List unique event source files.
SELECT DISTINCT source_file FROM website_events_with_duplicates;

-- 13. List unique event pages.
SELECT DISTINCT page_name FROM website_events_with_duplicates;

-- 14. List unique event type and page combinations.
SELECT DISTINCT event_type, page_name FROM website_events_with_duplicates;

-- 15. List unique campaign channels.
SELECT DISTINCT channel FROM campaign_performance_duplicates;

-- 16. List unique campaign source files.
SELECT DISTINCT source_file FROM campaign_performance_duplicates;

-- 17. List unique campaign date and channel combinations.
SELECT DISTINCT performance_date, channel FROM campaign_performance_duplicates;

-- 18. List unique payment methods.
SELECT DISTINCT payment_method FROM payment_transactions;

-- 19. List unique payment statuses.
SELECT DISTINCT payment_status FROM payment_transactions;

-- 20. List unique transaction source files.
SELECT DISTINCT source_file FROM payment_transactions;

-- 21. Show distinct order IDs and amounts. This does not deduplicate by order_id.
SELECT DISTINCT order_id, order_amount FROM raw_orders_with_duplicates;

-- 22. Show distinct transaction IDs and statuses. Changed statuses remain separate output rows.
SELECT DISTINCT transaction_id, payment_status FROM payment_transactions;

-- 23. Show distinct event IDs and timestamps. Changed timestamps remain separate output rows.
SELECT DISTINCT event_id, event_timestamp FROM website_events_with_duplicates;

-- 24. Show distinct campaign keys and metric values.
SELECT DISTINCT performance_date, campaign_id, channel, country, impressions, clicks, cost, conversions, revenue FROM campaign_performance_duplicates;

-- 25. Count all order rows.
SELECT COUNT(*) AS total_order_rows FROM raw_orders_with_duplicates;

-- 26. Count distinct order IDs.
SELECT COUNT(DISTINCT order_id) AS distinct_order_ids FROM raw_orders_with_duplicates;

-- 27. Count all contact rows.
SELECT COUNT(*) AS total_contact_rows FROM customer_contacts;

-- 28. Count distinct cleaned emails.
SELECT COUNT(DISTINCT LOWER(TRIM(email))) AS distinct_clean_emails FROM customer_contacts WHERE email IS NOT NULL;

-- 29. Count all event rows.
SELECT COUNT(*) AS total_event_rows FROM website_events_with_duplicates;

-- 30. Count distinct event IDs.
SELECT COUNT(DISTINCT event_id) AS distinct_event_ids FROM website_events_with_duplicates;
