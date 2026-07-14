-- Day 015: Dirty vs Clean SQL Examples
-- These queries show raw values and cleaned output values side by side.
-- The source data is not modified.

-- 1. Raw customer_name compared with trimmed customer_name.
SELECT customer_name AS raw_customer_name, TRIM(customer_name) AS clean_customer_name FROM dirty_customers;

-- 2. Raw email compared with lowercased and trimmed email.
SELECT email AS raw_email, LOWER(TRIM(email)) AS clean_email FROM dirty_customers;

-- 3. Raw country compared with clean country.
SELECT country AS raw_country, CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM dirty_customers;

-- 4. Raw customer_status compared with clean customer_status.
SELECT customer_status AS raw_customer_status, CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END AS clean_customer_status FROM dirty_customers;

-- 5. Raw city compared with clean city fallback.
SELECT city AS raw_city, COALESCE(TRIM(city), 'Unknown') AS clean_city FROM dirty_customers;

-- 6. Raw order_status compared with clean order_status.
SELECT order_status AS raw_order_status, CASE WHEN LOWER(TRIM(order_status)) = 'created' THEN 'Created' WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped' WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered' WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled' WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned' ELSE 'Unknown' END AS clean_order_status FROM dirty_orders;

-- 7. Raw payment_status compared with clean payment_status.
SELECT payment_status AS raw_payment_status, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status FROM dirty_orders;

-- 8. Raw order country compared with clean country.
SELECT country AS raw_country, CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM dirty_orders;

-- 9. Raw product_name compared with clean product_name.
SELECT product_name AS raw_product_name, TRIM(product_name) AS clean_product_name FROM dirty_products;

-- 10. Raw category compared with clean category.
SELECT category AS raw_category, CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' ELSE COALESCE(TRIM(category), 'Unknown') END AS clean_category FROM dirty_products;

-- 11. Raw is_active compared with clean is_active.
SELECT is_active AS raw_is_active, CASE WHEN LOWER(TRIM(is_active)) IN ('true', 'yes', 'y') THEN 'true' WHEN LOWER(TRIM(is_active)) IN ('false', 'no', 'n') THEN 'false' ELSE 'unknown' END AS clean_is_active FROM dirty_products;

-- 12. Raw campaign_name compared with clean campaign_name.
SELECT campaign_name AS raw_campaign_name, TRIM(campaign_name) AS clean_campaign_name FROM dirty_campaigns;

-- 13. Raw channel compared with clean channel.
SELECT channel AS raw_channel, CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' ELSE 'Unknown' END AS clean_channel FROM dirty_campaigns;

-- 14. Raw campaign_status compared with clean campaign_status.
SELECT campaign_status AS raw_campaign_status, CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END AS clean_campaign_status FROM dirty_campaigns;

-- 15. Raw campaign country compared with clean country.
SELECT country AS raw_country, CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM dirty_campaigns;

-- 16. Dirty GROUP BY country before cleaning.
SELECT country, COUNT(*) AS total_rows FROM dirty_customers GROUP BY country;

-- 17. Clean GROUP BY country after cleaning.
SELECT CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country, COUNT(*) AS total_rows FROM dirty_customers GROUP BY CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END;

-- 18. Dirty GROUP BY payment_status before cleaning.
SELECT payment_status, COUNT(*) AS total_rows FROM dirty_orders GROUP BY payment_status;

-- 19. Clean GROUP BY payment_status after cleaning.
SELECT CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status, COUNT(*) AS total_rows FROM dirty_orders GROUP BY CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END;

-- 20. Dirty GROUP BY category before cleaning.
SELECT category, COUNT(*) AS total_rows FROM dirty_products GROUP BY category;

-- 21. Clean GROUP BY category after cleaning.
SELECT CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' ELSE COALESCE(TRIM(category), 'Unknown') END AS clean_category, COUNT(*) AS total_rows FROM dirty_products GROUP BY CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' ELSE COALESCE(TRIM(category), 'Unknown') END;

-- 22. Blank email detection.
SELECT customer_id, email FROM dirty_customers WHERE email IS NULL OR TRIM(email) = '';

-- 23. Blank city detection.
SELECT customer_id, city FROM dirty_customers WHERE city IS NULL OR TRIM(city) = '';

-- 24. Unknown status detection.
SELECT customer_id, customer_status FROM dirty_customers WHERE customer_status IS NULL OR TRIM(customer_status) = '';

-- 25. Clean output selected columns for dashboard readiness.
SELECT customer_id, TRIM(customer_name) AS clean_customer_name, LOWER(TRIM(email)) AS clean_email, CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM dirty_customers;
