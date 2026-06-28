-- Day 010: SQL Filtering for Data Engineers
-- Topic: WHERE, AND, OR, IN, BETWEEN, LIKE, IS NULL

-- 1. Customers from UK.
SELECT * FROM customers
WHERE country = 'UK';

-- 2. Customers with Active status.
SELECT * FROM customers
WHERE customer_status = 'Active';

-- 3. Orders with Failed payment_status.
SELECT * FROM orders
WHERE payment_status = 'Failed';

-- 4. Products in Electronics category.
SELECT * FROM products
WHERE category = 'Electronics';

-- 5. Campaigns with Active status.
SELECT * FROM campaigns
WHERE campaign_status = 'Active';

-- 6. Active customers from UK.
SELECT * FROM customers
WHERE country = 'UK'
AND customer_status = 'Active';

-- 7. Paid orders above 500.
SELECT * FROM orders
WHERE payment_status = 'Paid'
AND order_amount > 500;

-- 8. Active products in Electronics.
SELECT * FROM products
WHERE category = 'Electronics'
AND is_active = true;

-- 9. Active campaigns in India.
SELECT * FROM campaigns
WHERE country = 'India'
AND campaign_status = 'Active';

-- 10. Delivered orders from USA.
SELECT * FROM orders
WHERE country = 'USA'
AND order_status = 'Delivered';

-- 11. Customers from UK or India.
SELECT * FROM customers
WHERE country = 'UK'
OR country = 'India';

-- 12. Orders Cancelled or Returned.
SELECT * FROM orders
WHERE order_status = 'Cancelled'
OR order_status = 'Returned';

-- 13. Products Out of Stock or Low Stock.
SELECT * FROM products
WHERE stock_status = 'Out of Stock'
OR stock_status = 'Low Stock';

-- 14. Campaigns Paused or Cancelled.
SELECT * FROM campaigns
WHERE campaign_status = 'Paused'
OR campaign_status = 'Cancelled';

-- 15. Payment status Failed or Refunded.
SELECT * FROM orders
WHERE payment_status = 'Failed'
OR payment_status = 'Refunded';

-- 16. Customers from UK, India, USA.
SELECT * FROM customers
WHERE country IN ('UK', 'India', 'USA');

-- 17. Orders with selected statuses.
SELECT * FROM orders
WHERE order_status IN ('Cancelled', 'Returned', 'Created');

-- 18. Products in selected categories.
SELECT * FROM products
WHERE category IN ('Electronics', 'Books', 'Sports');

-- 19. Campaigns in selected channels.
SELECT * FROM campaigns
WHERE channel IN ('Search', 'Social', 'Email');

-- 20. Records from selected countries.
SELECT * FROM customers
WHERE country IN ('UK', 'Canada', 'Germany');

-- 21. Orders between 100 and 500.
SELECT * FROM orders
WHERE order_amount BETWEEN 100 AND 500;

-- 22. Products priced between 20 and 100.
SELECT * FROM products
WHERE price BETWEEN 20 AND 100;

-- 23. Customers signed up between two dates.
SELECT * FROM customers
WHERE signup_date BETWEEN '2026-01-01' AND '2026-03-31';

-- 24. Campaigns with budget between 1000 and 5000.
SELECT * FROM campaigns
WHERE budget BETWEEN 1000 AND 5000;

-- 25. Orders in a date range.
SELECT * FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';

-- 26. Products containing Book.
SELECT * FROM products
WHERE product_name LIKE '%Book%';

-- 27. Products starting with Wireless.
SELECT * FROM products
WHERE product_name LIKE 'Wireless%';

-- 28. Campaign names containing Sale.
SELECT * FROM campaigns
WHERE campaign_name LIKE '%Sale%';

-- 29. Campaign names containing Promo.
SELECT * FROM campaigns
WHERE campaign_name LIKE '%Promo%';

-- 30. Emails ending with gmail.com.
SELECT * FROM customers
WHERE email LIKE '%gmail.com';

-- 31. Customers with missing email.
SELECT * FROM customers
WHERE email IS NULL;

-- 32. Customers with missing city.
SELECT * FROM customers
WHERE city IS NULL;

-- 33. Orders with missing delivery_date.
SELECT * FROM orders
WHERE delivery_date IS NULL;

-- 34. Campaigns with missing end_date.
SELECT * FROM campaigns
WHERE end_date IS NULL;

-- 35. Customers with available email.
SELECT * FROM customers
WHERE email IS NOT NULL;

-- 36. Orders with delivery_date available.
SELECT * FROM orders
WHERE delivery_date IS NOT NULL;

-- 37. Customers with city available.
SELECT * FROM customers
WHERE city IS NOT NULL;

-- 38. Active UK customers with email available.
SELECT customer_id, customer_name, country, email
FROM customers
WHERE country = 'UK'
AND customer_status = 'Active'
AND email IS NOT NULL;

-- 39. Paid high-value orders from selected countries.
SELECT order_id, customer_id, country, order_amount
FROM orders
WHERE country IN ('UK', 'India', 'USA')
AND payment_status = 'Paid'
AND order_amount > 500
ORDER BY order_amount DESC;

-- 40. Active campaigns in selected channels.
SELECT campaign_id, campaign_name, channel, country
FROM campaigns
WHERE campaign_status = 'Active'
AND channel IN ('Search', 'Social', 'Email');

-- 41. Products containing Book and currently active.
SELECT product_id, product_name, category, price
FROM products
WHERE product_name LIKE '%Book%'
AND is_active = true;

-- 42. Orders in June with payment_status Paid.
SELECT order_id, order_date, order_amount, payment_status
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30'
AND payment_status = 'Paid';

-- 43. Customers from selected countries with marketing_opt_in true.
SELECT customer_id, customer_name, country, marketing_opt_in
FROM customers
WHERE country IN ('UK', 'India', 'USA')
AND marketing_opt_in = true;

-- 44. Cancelled or returned orders with missing delivery_date.
SELECT order_id, order_status, delivery_date
FROM orders
WHERE order_status IN ('Cancelled', 'Returned')
AND delivery_date IS NULL;

-- 45. Products in selected categories with price between 20 and 200.
SELECT product_id, product_name, category, price
FROM products
WHERE category IN ('Electronics', 'Books', 'Sports')
AND price BETWEEN 20 AND 200;

