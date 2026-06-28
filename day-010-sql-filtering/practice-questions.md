# Day 010 Practice Questions

## Section 1: Simple Questions

1. What does `WHERE` do?
2. What does `AND` mean?
3. What does `OR` mean?
4. Why are parentheses useful with `AND` and `OR`?
5. What does `IN` do?
6. What does `BETWEEN` do?
7. What does `LIKE` do?
8. What does `%` mean in a `LIKE` pattern?
9. How should you check for missing values?
10. What does `IS NOT NULL` do?
11. Why should date filters be used carefully?
12. How can filtering help data quality checks?

## Section 2: Identify the Filter Type

Identify whether the filter uses exact match, `AND`, `OR`, `IN`, `BETWEEN`, `LIKE`, `IS NULL`, or `IS NOT NULL`.

1. `country = 'UK'`
2. `country = 'UK' AND customer_status = 'Active'`
3. `payment_status = 'Failed' OR payment_status = 'Refunded'`
4. `country IN ('UK', 'India', 'USA')`
5. `order_amount BETWEEN 100 AND 500`
6. `product_name LIKE '%Book%'`
7. `email IS NULL`
8. `email IS NOT NULL`
9. `category = 'Electronics' AND is_active = true`
10. `channel IN ('Search', 'Social')`
11. `campaign_name LIKE 'Summer%'`
12. `delivery_date IS NULL`
13. `price BETWEEN 20 AND 100`
14. `stock_status = 'Out of Stock' OR stock_status = 'Low Stock'`
15. `campaign_status = 'Active'`

## Section 3: Choose the Correct Query

1. Active customers from UK.
   - A: `SELECT * FROM customers WHERE country = 'UK' AND customer_status = 'Active';`
   - B: `SELECT * FROM customers WHERE country = 'UK' OR customer_status = 'Active';`

2. Failed payments.
   - A: `SELECT * FROM orders WHERE payment_status = 'Failed';`
   - B: `SELECT * FROM orders WHERE payment_status Failed;`

3. Orders above 500.
   - A: `SELECT * FROM orders WHERE order_amount > 500;`
   - B: `SELECT * FROM orders WHERE order_amount > 'Paid';`

4. Orders between 100 and 500.
   - A: `SELECT * FROM orders WHERE order_amount BETWEEN 100 AND 500;`
   - B: `SELECT * FROM orders WHERE order_amount BETWEEN 100;`

5. Customers from UK, India, or USA.
   - A: `SELECT * FROM customers WHERE country IN ('UK', 'India', 'USA');`
   - B: `SELECT * FROM customers WHERE country = ('UK', 'India', 'USA');`

6. Products containing Book.
   - A: `SELECT * FROM products WHERE product_name LIKE '%Book%';`
   - B: `SELECT * FROM products WHERE product_name = '%Book%';`

7. Missing customer email.
   - A: `SELECT * FROM customers WHERE email IS NULL;`
   - B: `SELECT * FROM customers WHERE email = NULL;`

8. Customers with available email.
   - A: `SELECT * FROM customers WHERE email IS NOT NULL;`
   - B: `SELECT * FROM customers WHERE email NOT NULL;`

9. Campaigns in Search or Social.
   - A: `SELECT * FROM campaigns WHERE channel IN ('Search', 'Social');`
   - B: `SELECT * FROM campaigns WHERE channel BETWEEN 'Search' AND 'Social';`

10. Products in Electronics and active.
   - A: `SELECT * FROM products WHERE category = 'Electronics' AND is_active = true;`
   - B: `SELECT * FROM products WHERE category = 'Electronics' OR is_active = true;`

11. Orders in a date range.
   - A: `SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';`
   - B: `SELECT * FROM orders WHERE order_date IN '2026-06-01';`

12. Cancelled or returned orders.
   - A: `SELECT * FROM orders WHERE order_status IN ('Cancelled', 'Returned');`
   - B: `SELECT * FROM orders WHERE order_status = 'Cancelled' AND order_status = 'Returned';`

## Section 4: Write Filtering Queries

Write SQL using the sample tables.

1. Find customers from India.
2. Find active customers from UK.
3. Find customers from UK, India, and USA.
4. Find customers with missing email.
5. Find customers with available city.
6. Find orders with Failed `payment_status`.
7. Find orders with Cancelled or Returned status.
8. Find paid orders above 500.
9. Find orders between 100 and 500.
10. Find orders in a date range.
11. Find products in Electronics or Books.
12. Find products containing Book.
13. Find products priced between 20 and 100.
14. Find active campaigns in Search and Social channels.
15. Find campaigns with budget between 1000 and 5000.

## Section 5: Spot the Mistake

1. `SELECT * FROM customers WHERE email = NULL;`
2. `SELECT * FROM customers WHERE country = UK;`
3. `SELECT * FROM orders WHERE country = 'UK' AND payment_status = 'Failed' OR payment_status = 'Refunded';`
4. `SELECT * FROM customers WHERE country IN 'UK', 'India';`
5. `SELECT * FROM orders WHERE order_amount BETWEEN 100;`
6. `SELECT * FROM products WHERE product_name LIKE %Book%;`
7. `SELECT * FROM orders ORDER BY order_amount DESC WHERE payment_status = 'Paid';`
8. `SELECT * FROM customers WHERE custmer_status = 'Active';`
9. `SELECT * FROM campaign WHERE channel = 'Search';`
10. `SELECT * FROM orders WHERE payment_status = 'Paid', order_amount > 500;`
11. `SELECT * FROM products WHERE product_name LIKE 'Book';`
12. `SELECT * FROM products WHERE category = 'Electronics' OR is_active = true;` when the task asks for Electronics products that are active.

## Section 6: Data Quality Investigation

Choose a useful filter.

1. Missing emails
2. Missing delivery dates
3. Failed payments
4. Cancelled orders
5. Unexpected country
6. Inactive products
7. Campaigns with missing end date
8. Orders in suspicious amount range

## Section 7: Think Like a Data Engineer

1. Which table would you check for failed payments?
2. Which columns would you select to review missing emails?
3. Which filter would find active UK customers?
4. When would you use `IN` instead of many `OR` conditions?
5. When would you use `BETWEEN`?
6. Why might you sort and limit investigation results?

## Section 8: Mini Assignment

Imagine you are checking an e-commerce and marketing dataset. Write queries to:

1. Find active customers from selected countries.
2. Find customers with missing emails.
3. Find paid high-value orders.
4. Find cancelled or returned orders.
5. Find orders within a date range.
6. Find products containing `Book`.
7. Find active products in selected categories.
8. Find campaigns in Search, Social, or Email channels.
9. Find campaigns with budget between two values.
10. Find campaigns with names containing `Sale`.

## Answer Key

### Section 1

1. Filters rows.
2. All conditions must be true.
3. At least one condition must be true.
4. They make mixed logic clear and safer.
5. Checks whether a value is in a list.
6. Checks whether a value is in a range.
7. Searches for text patterns.
8. Any number of characters.
9. Use `IS NULL`.
10. Finds rows where the value is available.
11. Database date behavior can vary, especially with timestamps.
12. It helps find missing, failed, unexpected, or suspicious records.

### Section 2

1. Exact match
2. AND
3. OR
4. IN
5. BETWEEN
6. LIKE
7. IS NULL
8. IS NOT NULL
9. AND
10. IN
11. LIKE
12. IS NULL
13. BETWEEN
14. OR
15. Exact match

### Section 3

1. A
2. A
3. A
4. A
5. A
6. A
7. A
8. A
9. A
10. A
11. A
12. A

### Section 4

1. `SELECT * FROM customers WHERE country = 'India';`
2. `SELECT * FROM customers WHERE country = 'UK' AND customer_status = 'Active';`
3. `SELECT * FROM customers WHERE country IN ('UK', 'India', 'USA');`
4. `SELECT * FROM customers WHERE email IS NULL;`
5. `SELECT * FROM customers WHERE city IS NOT NULL;`
6. `SELECT * FROM orders WHERE payment_status = 'Failed';`
7. `SELECT * FROM orders WHERE order_status IN ('Cancelled', 'Returned');`
8. `SELECT * FROM orders WHERE payment_status = 'Paid' AND order_amount > 500;`
9. `SELECT * FROM orders WHERE order_amount BETWEEN 100 AND 500;`
10. `SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';`
11. `SELECT * FROM products WHERE category IN ('Electronics', 'Books');`
12. `SELECT * FROM products WHERE product_name LIKE '%Book%';`
13. `SELECT * FROM products WHERE price BETWEEN 20 AND 100;`
14. `SELECT * FROM campaigns WHERE campaign_status = 'Active' AND channel IN ('Search', 'Social');`
15. `SELECT * FROM campaigns WHERE budget BETWEEN 1000 AND 5000;`

### Section 5

1. Use `IS NULL`.
2. Text value needs quotes.
3. Add parentheses around the `OR` conditions if that is the intended logic.
4. `IN` needs parentheses.
5. `BETWEEN` needs lower and upper values.
6. Pattern needs quotes.
7. `WHERE` comes before `ORDER BY`.
8. Column name is misspelled.
9. Table name should be `campaigns`.
10. Use `AND`, not comma.
11. Missing wildcards if the goal is contains Book.
12. Use `AND` when both conditions must be true.

