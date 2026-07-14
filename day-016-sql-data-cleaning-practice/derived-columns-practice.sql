-- Day 016: Derived Columns Practice
-- Topic: Creating useful business columns from raw values
-- These SELECT queries create derived outputs and do not modify source data.

-- 1. clean_customer_name.
SELECT customer_id, TRIM(customer_name) AS clean_customer_name FROM raw_customers;

-- 2. clean_email.
SELECT customer_id, LOWER(TRIM(email)) AS clean_email FROM raw_customers;

-- 3. clean_country.
SELECT customer_id, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' WHEN UPPER(TRIM(country)) = 'CANADA' THEN 'Canada' WHEN UPPER(TRIM(country)) = 'GERMANY' THEN 'Germany' WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Australia' ELSE 'Unknown' END AS clean_country FROM raw_customers;

-- 4. clean_customer_status.
SELECT customer_id, CASE WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive' WHEN LOWER(TRIM(customer_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(customer_status)) = 'blocked' THEN 'Blocked' ELSE 'Unknown' END AS clean_customer_status FROM raw_customers;

-- 5. clean_marketing_opt_in.
SELECT customer_id, CASE WHEN LOWER(TRIM(marketing_opt_in)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(marketing_opt_in)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_marketing_opt_in FROM raw_customers;

-- 6. customer_region_simple.
SELECT customer_id, country, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM','GERMANY') THEN 'Europe' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'Asia' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES','CANADA') THEN 'North America' WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Oceania' ELSE 'Unknown' END AS customer_region_simple FROM raw_customers;

-- 7. clean_order_status.
SELECT order_id, CASE WHEN LOWER(TRIM(order_status)) = 'created' THEN 'Created' WHEN LOWER(TRIM(order_status)) = 'shipped' THEN 'Shipped' WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered' WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled' WHEN LOWER(TRIM(order_status)) = 'returned' THEN 'Returned' ELSE 'Unknown' END AS clean_order_status FROM raw_orders;

-- 8. clean_payment_status.
SELECT order_id, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid' WHEN LOWER(TRIM(payment_status)) = 'pending' THEN 'Pending' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed' WHEN LOWER(TRIM(payment_status)) = 'refunded' THEN 'Refunded' ELSE 'Unknown' END AS clean_payment_status FROM raw_orders;

-- 9. clean_country for orders.
SELECT order_id, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM raw_orders;

-- 10. order_value_band.
SELECT order_id, CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END AS order_value_band FROM raw_orders;

-- 11. is_high_value_order.
SELECT order_id, CASE WHEN order_amount >= 500 THEN 'true' WHEN order_amount IS NULL THEN 'unknown' ELSE 'false' END AS is_high_value_order FROM raw_orders;

-- 12. order_health_label.
SELECT order_id, CASE WHEN LOWER(TRIM(payment_status)) = 'paid' AND LOWER(TRIM(order_status)) IN ('delivered','shipped') THEN 'Healthy' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Payment Issue' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Needs Review' ELSE 'Unknown' END AS order_health_label FROM raw_orders;

-- 13. reporting_order_status.
SELECT order_id, CASE WHEN LOWER(TRIM(order_status)) IN ('delivered','shipped') THEN 'Completed Flow' WHEN LOWER(TRIM(order_status)) = 'created' THEN 'Open' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Exception' ELSE 'Unknown' END AS reporting_order_status FROM raw_orders;

-- 14. clean_product_name.
SELECT product_id, TRIM(product_name) AS clean_product_name FROM raw_products;

-- 15. clean_category.
SELECT product_id, CASE WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics' WHEN LOWER(TRIM(category)) = 'books' THEN 'Books' WHEN LOWER(TRIM(category)) = 'home' THEN 'Home' WHEN LOWER(TRIM(category)) = 'clothing' THEN 'Clothing' WHEN LOWER(TRIM(category)) = 'sports' THEN 'Sports' WHEN LOWER(TRIM(category)) = 'beauty' THEN 'Beauty' ELSE 'Unknown' END AS clean_category FROM raw_products;

-- 16. clean_is_active.
SELECT product_id, CASE WHEN LOWER(TRIM(is_active)) IN ('true','yes','y') THEN 'true' WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'false' ELSE 'unknown' END AS clean_is_active FROM raw_products;

-- 17. clean_stock_status.
SELECT product_id, CASE WHEN LOWER(TRIM(stock_status)) = 'in stock' THEN 'In Stock' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'low stock' THEN 'Low Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Unknown' END AS clean_stock_status FROM raw_products;

-- 18. product_price_band.
SELECT product_id, CASE WHEN price IS NULL THEN 'Unknown' WHEN price < 20 THEN 'Low' WHEN price >= 20 AND price < 100 THEN 'Medium' WHEN price >= 100 AND price < 300 THEN 'High' ELSE 'Premium' END AS product_price_band FROM raw_products;

-- 19. product_reporting_status.
SELECT product_id, CASE WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'Inactive Product' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Available for Review' END AS product_reporting_status FROM raw_products;

-- 20. clean_campaign_name.
SELECT campaign_id, TRIM(campaign_name) AS clean_campaign_name FROM raw_campaigns;

-- 21. clean_channel.
SELECT campaign_id, CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END AS clean_channel FROM raw_campaigns;

-- 22. clean campaign country.
SELECT campaign_id, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM raw_campaigns;

-- 23. clean_campaign_status.
SELECT campaign_id, CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Completed' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Cancelled' ELSE 'Unknown' END AS clean_campaign_status FROM raw_campaigns;

-- 24. campaign_budget_band.
SELECT campaign_id, CASE WHEN budget IS NULL THEN 'Unknown' WHEN budget < 1000 THEN 'Small' WHEN budget >= 1000 AND budget < 5000 THEN 'Medium' ELSE 'Large' END AS campaign_budget_band FROM raw_campaigns;

-- 25. campaign_reporting_status.
SELECT campaign_id, CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Running' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Finished' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Stopped' ELSE 'Unknown' END AS campaign_reporting_status FROM raw_campaigns;

-- 26. performance clean_channel.
SELECT campaign_id, CASE WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search' WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social' WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email' WHEN LOWER(TRIM(channel)) = 'display' THEN 'Display' WHEN LOWER(TRIM(channel)) = 'affiliate' THEN 'Affiliate' ELSE 'Unknown' END AS clean_channel FROM raw_campaign_performance;

-- 27. performance clean_country.
SELECT campaign_id, CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM') THEN 'UK' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES') THEN 'USA' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'India' ELSE COALESCE(TRIM(country), 'Unknown') END AS clean_country FROM raw_campaign_performance;

-- 28. cost_band.
SELECT campaign_id, CASE WHEN cost IS NULL THEN 'Unknown' WHEN cost < 100 THEN 'Low Cost' WHEN cost >= 100 AND cost < 300 THEN 'Medium Cost' ELSE 'High Cost' END AS cost_band FROM raw_campaign_performance;

-- 29. revenue_band.
SELECT campaign_id, CASE WHEN revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN revenue < 1000 THEN 'Low Revenue' WHEN revenue >= 1000 AND revenue < 2000 THEN 'Medium Revenue' ELSE 'High Revenue' END AS revenue_band FROM raw_campaign_performance;

-- 30. conversion_label.
SELECT campaign_id, CASE WHEN conversions = 0 THEN 'No Conversions' WHEN conversions >= 1 AND conversions <= 5 THEN 'Low Conversions' WHEN conversions >= 6 AND conversions <= 20 THEN 'Medium Conversions' ELSE 'High Conversions' END AS conversion_label FROM raw_campaign_performance;

-- 31. performance_label.
SELECT campaign_id, CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END AS performance_label FROM raw_campaign_performance;

-- 32. simple_roi_label.
SELECT campaign_id, CASE WHEN revenue > cost THEN 'Revenue Above Cost' WHEN revenue = cost THEN 'Revenue Equals Cost' WHEN revenue < cost THEN 'Revenue Below Cost' ELSE 'Unknown' END AS simple_roi_label FROM raw_campaign_performance;

-- 33. Count orders by order_value_band.
SELECT CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END AS order_value_band, COUNT(*) AS total_orders FROM raw_orders GROUP BY CASE WHEN order_amount IS NULL THEN 'Unknown' WHEN order_amount < 50 THEN 'Low' WHEN order_amount >= 50 AND order_amount < 200 THEN 'Medium' WHEN order_amount >= 200 AND order_amount < 500 THEN 'High' ELSE 'Premium' END;

-- 34. Count products by product_price_band.
SELECT CASE WHEN price IS NULL THEN 'Unknown' WHEN price < 20 THEN 'Low' WHEN price >= 20 AND price < 100 THEN 'Medium' WHEN price >= 100 AND price < 300 THEN 'High' ELSE 'Premium' END AS product_price_band, COUNT(*) AS total_products FROM raw_products GROUP BY CASE WHEN price IS NULL THEN 'Unknown' WHEN price < 20 THEN 'Low' WHEN price >= 20 AND price < 100 THEN 'Medium' WHEN price >= 100 AND price < 300 THEN 'High' ELSE 'Premium' END;

-- 35. Count campaigns by campaign_budget_band.
SELECT CASE WHEN budget IS NULL THEN 'Unknown' WHEN budget < 1000 THEN 'Small' WHEN budget >= 1000 AND budget < 5000 THEN 'Medium' ELSE 'Large' END AS campaign_budget_band, COUNT(*) AS total_campaigns FROM raw_campaigns GROUP BY CASE WHEN budget IS NULL THEN 'Unknown' WHEN budget < 1000 THEN 'Small' WHEN budget >= 1000 AND budget < 5000 THEN 'Medium' ELSE 'Large' END;

-- 36. Count performance rows by performance_label.
SELECT CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END AS performance_label, COUNT(*) AS total_rows FROM raw_campaign_performance GROUP BY CASE WHEN cost IS NULL OR revenue IS NULL THEN 'Unknown' WHEN revenue = 0 THEN 'No Revenue' WHEN cost = 0 AND revenue > 0 THEN 'Check Cost Data' WHEN revenue > cost THEN 'Profitable' WHEN revenue = cost THEN 'Break Even' ELSE 'Needs Review' END;

-- 37. Count customers by customer_region_simple.
SELECT CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM','GERMANY') THEN 'Europe' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'Asia' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES','CANADA') THEN 'North America' WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Oceania' ELSE 'Unknown' END AS customer_region_simple, COUNT(*) AS total_customers FROM raw_customers GROUP BY CASE WHEN UPPER(TRIM(country)) IN ('UK','U.K.','UNITED KINGDOM','GERMANY') THEN 'Europe' WHEN UPPER(TRIM(country)) = 'INDIA' THEN 'Asia' WHEN UPPER(TRIM(country)) IN ('USA','U.S.A','UNITED STATES','CANADA') THEN 'North America' WHEN UPPER(TRIM(country)) = 'AUSTRALIA' THEN 'Oceania' ELSE 'Unknown' END;

-- 38. Count orders by order_health_label.
SELECT CASE WHEN LOWER(TRIM(payment_status)) = 'paid' AND LOWER(TRIM(order_status)) IN ('delivered','shipped') THEN 'Healthy' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Payment Issue' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Needs Review' ELSE 'Unknown' END AS order_health_label, COUNT(*) AS total_orders FROM raw_orders GROUP BY CASE WHEN LOWER(TRIM(payment_status)) = 'paid' AND LOWER(TRIM(order_status)) IN ('delivered','shipped') THEN 'Healthy' WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Payment Issue' WHEN LOWER(TRIM(order_status)) IN ('cancelled','returned') THEN 'Needs Review' ELSE 'Unknown' END;

-- 39. Count products by product_reporting_status.
SELECT CASE WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'Inactive Product' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Available for Review' END AS product_reporting_status, COUNT(*) AS total_products FROM raw_products GROUP BY CASE WHEN LOWER(TRIM(is_active)) IN ('false','no','n') THEN 'Inactive Product' WHEN LOWER(TRIM(stock_status)) = 'out of stock' THEN 'Out of Stock' WHEN LOWER(TRIM(stock_status)) = 'discontinued' THEN 'Discontinued' ELSE 'Available for Review' END;

-- 40. Count campaigns by campaign_reporting_status.
SELECT CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Running' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Finished' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Stopped' ELSE 'Unknown' END AS campaign_reporting_status, COUNT(*) AS total_campaigns FROM raw_campaigns GROUP BY CASE WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Running' WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused' WHEN LOWER(TRIM(campaign_status)) = 'completed' THEN 'Finished' WHEN LOWER(TRIM(campaign_status)) = 'cancelled' THEN 'Stopped' ELSE 'Unknown' END;
