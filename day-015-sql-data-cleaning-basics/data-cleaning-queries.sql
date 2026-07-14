-- Day 015: SQL Data Cleaning Basics
-- Topic: NULLs, TRIM, LOWER, UPPER, COALESCE, Clean Columns
-- These SELECT queries create cleaned output results and do not change source data.

-- 1. Find customers where email is NULL.
SELECT customer_id, email FROM dirty_customers WHERE email IS NULL;

-- 2. Find customers where email is blank after trimming spaces.
SELECT customer_id, email FROM dirty_customers WHERE TRIM(email) = '';

-- 3. Find customers where city is blank after trimming spaces.
SELECT customer_id, city FROM dirty_customers WHERE TRIM(city) = '';

-- 4. Find orders where payment_status is blank after trimming spaces.
SELECT order_id, payment_status FROM dirty_orders WHERE TRIM(payment_status) = '';

-- 5. Find products where category is blank after trimming spaces.
SELECT product_id, category FROM dirty_products WHERE TRIM(category) = '';

-- 6. Find campaigns where channel is blank after trimming spaces.
SELECT campaign_id, channel FROM dirty_campaigns WHERE TRIM(channel) = '';

-- 7. Trim customer names.
SELECT customer_id, customer_name, TRIM(customer_name) AS clean_customer_name FROM dirty_customers;

-- 8. Trim emails.
SELECT customer_id, email, TRIM(email) AS trimmed_email FROM dirty_customers;

-- 9. Trim country values.
SELECT customer_id, country, TRIM(country) AS trimmed_country FROM dirty_customers;

-- 10. Trim product names.
SELECT product_id, product_name, TRIM(product_name) AS clean_product_name FROM dirty_products;

-- 11. Trim campaign names.
SELECT campaign_id, campaign_name, TRIM(campaign_name) AS clean_campaign_name FROM dirty_campaigns;

-- 12. Lowercase emails after trimming.
SELECT customer_id, email, LOWER(TRIM(email)) AS clean_email FROM dirty_customers;

-- 13. Lowercase customer_status for inspection.
SELECT customer_id, customer_status, LOWER(TRIM(customer_status)) AS lower_customer_status FROM dirty_customers;

-- 14. Lowercase campaign channel for inspection.
SELECT campaign_id, channel, LOWER(TRIM(channel)) AS lower_channel FROM dirty_campaigns;

-- 15. Uppercase country values.
SELECT customer_id, country, UPPER(TRIM(country)) AS upper_country FROM dirty_customers;

-- 16. Uppercase product category for inspection.
SELECT product_id, category, UPPER(TRIM(category)) AS upper_category FROM dirty_products;

-- 17. Uppercase campaign status for inspection.
SELECT campaign_id, campaign_status, UPPER(TRIM(campaign_status)) AS upper_campaign_status FROM dirty_campaigns;

-- 18. Replace NULL email with unknown.
SELECT customer_id, COALESCE(email, 'unknown') AS email_or_unknown FROM dirty_customers;

-- 19. Replace NULL city with Unknown.
SELECT customer_id, COALESCE(city, 'Unknown') AS city_or_unknown FROM dirty_customers;

-- 20. Replace NULL customer_status with Unknown.
SELECT customer_id, COALESCE(customer_status, 'Unknown') AS status_or_unknown FROM dirty_customers;

-- 21. Replace NULL payment_status with Unknown.
SELECT order_id, COALESCE(payment_status, 'Unknown') AS payment_status_or_unknown FROM dirty_orders;

-- 22. Replace NULL product category with Unknown.
SELECT product_id, COALESCE(category, 'Unknown') AS category_or_unknown FROM dirty_products;

-- 23. Replace NULL campaign channel with Unknown.
SELECT campaign_id, COALESCE(channel, 'Unknown') AS channel_or_unknown FROM dirty_campaigns;

-- 24. Create clean_customer_name using TRIM.
SELECT customer_id, TRIM(customer_name) AS clean_customer_name FROM dirty_customers;

-- 25. Create clean_email using LOWER and TRIM.
SELECT customer_id, LOWER(TRIM(email)) AS clean_email FROM dirty_customers;

-- 26. Create clean_country using CASE.
SELECT customer_id, country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    WHEN UPPER(TRIM(country)) = 'CANADA' THEN 'Canada'
    WHEN UPPER(TRIM(country)) = 'GERMANY' THEN 'Germany'
    WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Australia'
    ELSE 'Unknown'
  END AS clean_country
FROM dirty_customers;

-- 27. Create clean_customer_status using CASE.
SELECT customer_id, customer_status,
  CASE
    WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive'
    WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending'
    WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked'
    ELSE 'Unknown'
  END AS clean_customer_status
FROM dirty_customers;

-- 28. Create full clean customer output with raw and clean columns.
SELECT customer_id, customer_name AS raw_customer_name, TRIM(customer_name) AS clean_customer_name, email AS raw_email, LOWER(TRIM(email)) AS clean_email, country AS raw_country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    ELSE COALESCE(TRIM(country), 'Unknown')
  END AS clean_country
FROM dirty_customers;

-- 29. Clean order_status.
SELECT order_id, order_status,
  CASE
    WHEN LOWER(TRIM(order_status)) = 'created' THEN 'Created'
    WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped'
    WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered'
    WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled'
    WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned'
    ELSE 'Unknown'
  END AS clean_order_status
FROM dirty_orders;

-- 30. Clean payment_status.
SELECT order_id, payment_status,
  CASE
    WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid'
    WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending'
    WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed'
    WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded'
    ELSE 'Unknown'
  END AS clean_payment_status
FROM dirty_orders;

-- 31. Clean order country.
SELECT order_id, country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    ELSE COALESCE(TRIM(country), 'Unknown')
  END AS clean_country
FROM dirty_orders;

-- 32. Clean order output with raw and clean status columns.
SELECT order_id, order_status AS raw_order_status, payment_status AS raw_payment_status,
  CASE WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered' WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled' ELSE COALESCE(TRIM(order_status), 'Unknown') END AS clean_order_status,
  CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' ELSE COALESCE(TRIM(payment_status), 'Unknown') END AS clean_payment_status
FROM dirty_orders;

-- 33. Clean product_name.
SELECT product_id, product_name, TRIM(product_name) AS clean_product_name FROM dirty_products;

-- 34. Clean category.
SELECT product_id, category,
  CASE
    WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics'
    WHEN LOWER(TRIM(category)) = 'books' THEN 'Books'
    WHEN LOWER(TRIM(category)) = 'home' THEN 'Home'
    WHEN LOWER(TRIM(category)) = 'clothing' THEN 'Clothing'
    WHEN LOWER(TRIM(category)) = 'sports' THEN 'Sports'
    WHEN LOWER(TRIM(category)) = 'beauty' THEN 'Beauty'
    ELSE 'Unknown'
  END AS clean_category
FROM dirty_products;

-- 35. Clean is_active values into true, false, or unknown.
SELECT product_id, is_active,
  CASE
    WHEN LOWER(TRIM(is_active)) IN ('true', 'yes', 'y') THEN 'true'
    WHEN LOWER(TRIM(is_active)) IN ('false', 'no', 'n') THEN 'false'
    ELSE 'unknown'
  END AS clean_is_active
FROM dirty_products;

-- 36. Clean product output with raw and clean columns.
SELECT product_id, product_name AS raw_product_name, TRIM(product_name) AS clean_product_name, category AS raw_category,
  CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' ELSE 'Unknown' END AS clean_category,
  is_active AS raw_is_active,
  CASE WHEN LOWER(TRIM(is_active)) IN ('true', 'yes', 'y') THEN 'true' WHEN LOWER(TRIM(is_active)) IN ('false', 'no', 'n') THEN 'false' ELSE 'unknown' END AS clean_is_active
FROM dirty_products;

-- 37. Clean campaign_name.
SELECT campaign_id, campaign_name, TRIM(campaign_name) AS clean_campaign_name FROM dirty_campaigns;

-- 38. Clean channel.
SELECT campaign_id, channel,
  CASE
    WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search'
    WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social'
    WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email'
    WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display'
    WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate'
    ELSE 'Unknown'
  END AS clean_channel
FROM dirty_campaigns;

-- 39. Clean campaign country.
SELECT campaign_id, country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India'
    ELSE COALESCE(TRIM(country), 'Unknown')
  END AS clean_country
FROM dirty_campaigns;

-- 40. Clean campaign_status.
SELECT campaign_id, campaign_status,
  CASE
    WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused'
    WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed'
    WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled'
    ELSE 'Unknown'
  END AS clean_campaign_status
FROM dirty_campaigns;

-- 41. Clean campaign output with raw and clean columns.
SELECT campaign_id, campaign_name AS raw_campaign_name, TRIM(campaign_name) AS clean_campaign_name, channel AS raw_channel,
  CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' ELSE 'Unknown' END AS clean_channel
FROM dirty_campaigns;

-- 42. Group dirty customer country values before cleaning.
SELECT country, COUNT(*) AS total_customers FROM dirty_customers GROUP BY country ORDER BY country;

-- 43. Group cleaned customer country values after cleaning.
SELECT CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country, COUNT(*) AS total_customers FROM dirty_customers GROUP BY CASE WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END ORDER BY clean_country;

-- 44. Group dirty payment_status values before cleaning.
SELECT payment_status, COUNT(*) AS total_orders FROM dirty_orders GROUP BY payment_status ORDER BY payment_status;

-- 45. Group cleaned payment_status values after cleaning.
SELECT CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status, COUNT(*) AS total_orders FROM dirty_orders GROUP BY CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END ORDER BY clean_payment_status;

-- 46. Group dirty product category values before cleaning.
SELECT category, COUNT(*) AS total_products FROM dirty_products GROUP BY category ORDER BY category;

-- 47. Group cleaned product category values after cleaning.
SELECT CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' WHEN LOWER(TRIM(category)) = 'clothing' THEN 'Clothing' WHEN LOWER(TRIM(category)) = 'sports' THEN 'Sports' WHEN LOWER(TRIM(category)) = 'beauty' THEN 'Beauty' ELSE 'Unknown' END AS clean_category, COUNT(*) AS total_products FROM dirty_products GROUP BY CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' WHEN LOWER(TRIM(category)) = 'clothing' THEN 'Clothing' WHEN LOWER(TRIM(category)) = 'sports' THEN 'Sports' WHEN LOWER(TRIM(category)) = 'beauty' THEN 'Beauty' ELSE 'Unknown' END ORDER BY clean_category;

-- 48. Count blank or NULL customer emails.
SELECT COUNT(*) AS blank_or_null_customer_emails FROM dirty_customers WHERE email IS NULL OR TRIM(email) = '';

-- 49. Count blank or NULL product categories.
SELECT COUNT(*) AS blank_or_null_product_categories FROM dirty_products WHERE category IS NULL OR TRIM(category) = '';

-- 50. Count blank or NULL campaign channels.
SELECT COUNT(*) AS blank_or_null_campaign_channels FROM dirty_campaigns WHERE channel IS NULL OR TRIM(channel) = '';

-- 51. Show records where clean country is Unknown.
SELECT customer_id, country FROM dirty_customers WHERE country IS NULL OR TRIM(country) = '';

-- 52. Show records where clean status is Unknown.
SELECT customer_id, customer_status FROM dirty_customers WHERE customer_status IS NULL OR TRIM(customer_status) = '';
