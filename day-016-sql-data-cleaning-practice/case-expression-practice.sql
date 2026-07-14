-- Day 016: CASE Expression Practice
-- Topic: Cleaning and standardising values with CASE
-- These SELECT queries create cleaned result sets and do not modify raw source data.

-- 1. Clean customer status values.
SELECT customer_id, customer_status, CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END AS clean_customer_status FROM raw_customers;

-- 2. Clean customer country values.
SELECT customer_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' WHEN UPPER(TRIM(country)) = 'CANADA' THEN 'Canada' WHEN UPPER(TRIM(country)) = 'GERMANY' THEN 'Germany' WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Australia' ELSE 'Unknown' END AS clean_country FROM raw_customers;

-- 3. Clean marketing opt-in values.
SELECT customer_id, marketing_opt_in, CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(marketing_opt_in)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_marketing_opt_in FROM raw_customers;

-- 4. Clean customer email.
SELECT customer_id, email, LOWER(TRIM(email)) AS clean_email FROM raw_customers;

-- 5. Clean customer name.
SELECT customer_id, customer_name, TRIM(customer_name) AS clean_customer_name FROM raw_customers;

-- 6. Clean customer city.
SELECT customer_id, city, COALESCE(TRIM(city), 'Unknown') AS clean_city FROM raw_customers;

-- 7. Clean order status values.
SELECT order_id, order_status, CASE WHEN LOWER(TRIM(order_status)) = 'created' THEN 'Created' WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped' WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered' WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled' WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned' ELSE 'Unknown' END AS clean_order_status FROM raw_orders;

-- 8. Clean payment status values.
SELECT order_id, payment_status, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status FROM raw_orders;

-- 9. Clean order country values.
SELECT order_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM raw_orders;

-- 10. Create order value band.
SELECT order_id, order_amount, CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END AS order_value_band FROM raw_orders;

-- 11. Create high value order flag.
SELECT order_id, order_amount, CASE WHEN order_amount >= 500 THEN 'true' WHEN order_amount IS NULL THEN 'unknown' ELSE 'false' END AS is_high_value_order FROM raw_orders;

-- 12. Create order health label.
SELECT order_id, order_status, payment_status, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' AND LOWER(TRIM(order_status)) IN ('delivered','shipped') THEN 'Healthy' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Payment Issue' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Needs Review' ELSE 'Unknown' END AS order_health_label FROM raw_orders;

-- 13. Clean product category.
SELECT product_id, category, CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' WHEN LOWER(TRIM(category)) = 'clothing' THEN 'Clothing' WHEN LOWER(TRIM(category)) = 'sports' THEN 'Sports' WHEN LOWER(TRIM(category)) = 'beauty' THEN 'Beauty' ELSE 'Unknown' END AS clean_category FROM raw_products;

-- 14. Clean product is_active.
SELECT product_id, is_active, CASE WHEN LOWER(TRIM(is_active)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_is_active FROM raw_products;

-- 15. Clean stock status.
SELECT product_id, stock_status, CASE WHEN LOWER(TRIM(stock_status)) = 'in stock' THEN 'In Stock' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'low stock' THEN 'Low Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Unknown' END AS clean_stock_status FROM raw_products;

-- 16. Create product price band.
SELECT product_id, price, CASE WHEN price IS NULL THEN 'Unknown' WHEN price < 20 THEN 'Low' WHEN price >= 20 AND price < 100 THEN 'Medium' WHEN price >= 100 AND price < 300 THEN 'High' ELSE 'Premium' END AS product_price_band FROM raw_products;

-- 17. Clean campaign channel.
SELECT campaign_id, channel, CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END AS clean_channel FROM raw_campaigns;

-- 18. Clean campaign status.
SELECT campaign_id, campaign_status, CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END AS clean_campaign_status FROM raw_campaigns;

-- 19. Create campaign budget band.
SELECT campaign_id, budget, CASE WHEN budget IS NULL THEN 'Unknown' WHEN budget < 1000 THEN 'Small' WHEN budget >= 1000 AND budget < 5000 THEN 'Medium' ELSE 'Large' END AS campaign_budget_band FROM raw_campaigns;

-- 20. Clean performance channel.
SELECT campaign_id, channel, CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END AS clean_channel FROM raw_campaign_performance;

-- 21. Clean performance country.
SELECT campaign_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM raw_campaign_performance;

-- 22. Create performance label.
SELECT campaign_id, cost, revenue, CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END AS performance_label FROM raw_campaign_performance;

-- 23. Create conversion label.
SELECT campaign_id, conversions, CASE WHEN conversions = 0 THEN 'No Conversions' WHEN conversions >= 1 AND conversions <= 5 THEN 'Low Conversions' WHEN conversions >= 6 AND conversions <= 20 THEN 'Medium Conversions' ELSE 'High Conversions' END AS conversion_label FROM raw_campaign_performance;

-- 24. Group clean customer status.
SELECT CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END AS clean_customer_status, COUNT(*) AS total_customers FROM raw_customers GROUP BY CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END;

-- 25. Group clean country.
SELECT CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country, COUNT(*) AS total_rows FROM raw_customers GROUP BY CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END;

-- 26. Clean campaign country values.
SELECT campaign_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' WHEN UPPER(TRIM(country)) = 'CANADA' THEN 'Canada' ELSE 'Unknown' END AS clean_country FROM raw_campaigns;

-- 27. Clean campaign names.
SELECT campaign_id, campaign_name, CASE WHEN campaign_name IS NULL THEN 'Unknown Campaign' WHEN TRIM(campaign_name) = '' THEN 'Unknown Campaign' ELSE TRIM(campaign_name) END AS clean_campaign_name FROM raw_campaigns;

-- 28. Clean product names.
SELECT product_id, product_name, CASE WHEN product_name IS NULL THEN 'Unknown Product' WHEN TRIM(product_name) = '' THEN 'Unknown Product' ELSE TRIM(product_name) END AS clean_product_name FROM raw_products;

-- 29. Clean performance country values.
SELECT performance_date, campaign_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' WHEN UPPER(TRIM(country)) = 'GERMANY' THEN 'Germany' ELSE 'Unknown' END AS clean_country FROM raw_campaign_performance;

-- 30. Flag orders with unknown payment status.
SELECT order_id, payment_status, CASE WHEN payment_status IS NULL THEN 'Needs Review' WHEN TRIM(payment_status) = '' THEN 'Needs Review' WHEN LOWER(TRIM(payment_status)) NOT IN ('paid','pending','failed','refunded') THEN 'Needs Review' ELSE 'Known Payment Status' END AS payment_status_quality FROM raw_orders;

-- 31. Group clean payment status values.
SELECT CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status, COUNT(*) AS total_orders FROM raw_orders GROUP BY CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END;

-- 32. Group clean campaign channels.
SELECT CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END AS clean_channel, COUNT(*) AS total_campaigns FROM raw_campaigns GROUP BY CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END;

-- 33. Group order value bands.
SELECT CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END AS order_value_band, COUNT(*) AS total_orders FROM raw_orders GROUP BY CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END;

-- 34. Group campaign performance labels.
SELECT CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END AS performance_label, COUNT(*) AS total_rows FROM raw_campaign_performance GROUP BY CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END;

-- 35. Show customer status values that become Unknown.
SELECT customer_id, customer_status, CASE WHEN LOWER(TRIM(customer_status)) IN ('active','inactive','pending','blocked') THEN 'Known' ELSE 'Unknown' END AS customer_status_quality FROM raw_customers;

-- 36. Show country values that become Unknown.
SELECT customer_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM','USA','U.S.A','UNITED STATES','INDIA','CANADA','GERMANY','AUSTRALIA') THEN 'Known' ELSE 'Unknown' END AS country_quality FROM raw_customers;

-- 37. Create a small clean customer output.
SELECT customer_id, TRIM(customer_name) AS clean_customer_name, CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END AS clean_customer_status FROM raw_customers;

-- 38. Create a small clean order output.
SELECT order_id, order_amount, CASE WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered' WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped' WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled' WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned' ELSE 'Other' END AS clean_order_status FROM raw_orders;

-- 39. Create a small clean product output.
SELECT product_id, TRIM(product_name) AS clean_product_name, CASE WHEN price < 20 THEN 'Low' WHEN price >= 20 AND price < 100 THEN 'Medium' WHEN price >= 100 AND price < 300 THEN 'High' WHEN price >= 300 THEN 'Premium' ELSE 'Unknown' END AS product_price_band FROM raw_products;

-- 40. Create a small clean campaign output.
SELECT campaign_id, TRIM(campaign_name) AS clean_campaign_name, CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END AS clean_campaign_status FROM raw_campaigns;

-- 41. Create a small clean performance output.
SELECT performance_date, campaign_id, CASE WHEN clicks = 0 THEN 'No Clicks' WHEN clicks >= 1 AND clicks <= 100 THEN 'Low Clicks' WHEN clicks > 100 AND clicks <= 500 THEN 'Medium Clicks' ELSE 'High Clicks' END AS click_volume_label FROM raw_campaign_performance;

-- 42. Group clean stock status values.
SELECT CASE WHEN LOWER(TRIM(stock_status)) = 'in stock' THEN 'In Stock' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'low stock' THEN 'Low Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Unknown' END AS clean_stock_status, COUNT(*) AS total_products FROM raw_products GROUP BY CASE WHEN LOWER(TRIM(stock_status)) = 'in stock' THEN 'In Stock' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'low stock' THEN 'Low Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Unknown' END;

-- 43. Group clean marketing opt-in values.
SELECT CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(marketing_opt_in)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_marketing_opt_in, COUNT(*) AS total_customers FROM raw_customers GROUP BY CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(marketing_opt_in)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END;

-- 44. Group clean campaign status values.
SELECT CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END AS clean_campaign_status, COUNT(*) AS total_campaigns FROM raw_campaigns GROUP BY CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END;

-- 45. Group conversion labels.
SELECT CASE WHEN conversions = 0 THEN 'No Conversions' WHEN conversions >= 1 AND conversions <= 5 THEN 'Low Conversions' WHEN conversions >= 6 AND conversions <= 20 THEN 'Medium Conversions' ELSE 'High Conversions' END AS conversion_label, COUNT(*) AS total_rows FROM raw_campaign_performance GROUP BY CASE WHEN conversions = 0 THEN 'No Conversions' WHEN conversions >= 1 AND conversions <= 5 THEN 'Low Conversions' WHEN conversions >= 6 AND conversions <= 20 THEN 'Medium Conversions' ELSE 'High Conversions' END;
