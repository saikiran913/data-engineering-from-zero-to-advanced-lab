# Day 009 Practice Questions

## Section 1: Simple Questions

1. What does SQL stand for?
2. What is a table?
3. What is a row?
4. What is a column?
5. What does `SELECT` do?
6. What does `FROM` do?
7. What does `WHERE` do?
8. What does `ORDER BY` do?
9. What does `LIMIT` do?
10. What does `ASC` mean?
11. What does `DESC` mean?
12. What is a result set?

## Section 2: Identify the SQL Clause

Identify whether each clause is `SELECT`, `FROM`, `WHERE`, `ORDER BY`, or `LIMIT`.

1. `SELECT customer_id, customer_name`
2. `FROM customers`
3. `WHERE country = 'UK'`
4. `ORDER BY order_amount DESC`
5. `LIMIT 10`
6. `WHERE payment_status = 'Failed'`
7. `SELECT *`
8. `FROM orders`
9. `ORDER BY signup_date ASC`
10. `LIMIT 5`

## Section 3: Choose the Correct Query

1. Show all customers.
   - A: `SELECT * FROM customers;`
   - B: `FROM customers SELECT *;`

2. Show only customer names and countries.
   - A: `SELECT customer_name, country FROM customers;`
   - B: `SELECT customers FROM customer_name, country;`

3. Find customers from UK.
   - A: `SELECT * FROM customers WHERE country = 'UK';`
   - B: `SELECT * FROM customers WHERE country = UK;`

4. Find failed payments.
   - A: `SELECT * FROM orders WHERE payment_status = 'Failed';`
   - B: `SELECT * FROM orders WHERE payment_status Failed;`

5. Find orders above 500.
   - A: `SELECT * FROM orders WHERE order_amount > 500;`
   - B: `SELECT * FROM orders WHERE order_amount = > 500;`

6. Sort orders highest to lowest.
   - A: `SELECT * FROM orders ORDER BY order_amount DESC;`
   - B: `SELECT * FROM orders ORDER BY order_amount ASC;`

7. Preview first 10 products.
   - A: `SELECT * FROM products LIMIT 10;`
   - B: `SELECT * LIMIT 10 FROM products;`

8. Find active customers.
   - A: `SELECT * FROM customers WHERE customer_status = 'Active';`
   - B: `SELECT * FROM customers WHERE customer_status = Active;`

9. Find cancelled orders.
   - A: `SELECT * FROM orders WHERE order_status = 'Cancelled';`
   - B: `SELECT * FROM orders ORDER BY order_status = 'Cancelled';`

10. Show newest signups first.
   - A: `SELECT * FROM customers ORDER BY signup_date DESC;`
   - B: `SELECT * FROM customers ORDER BY signup_date ASC;`

## Section 4: Write Simple Queries

Write SQL for:

1. Select all customers.
2. Select `customer_id` and `customer_name`.
3. Find customers from India.
4. Find active customers.
5. Find orders where `payment_status` is Failed.
6. Find orders above 100.
7. Sort orders by `order_amount` descending.
8. Show first 5 products.
9. Find products in Electronics category.
10. Find products where `is_active` is true.
11. Sort customers by `signup_date`.
12. Combine `WHERE`, `ORDER BY`, and `LIMIT` to find top 5 paid orders by amount.

## Section 5: Spot the Mistake

1. `SELEC * FROM customers;`
2. `SELECT * customers;`
3. `SELECT * FROM customers WHERE country = UK;`
4. `SELECT * FROM customer;`
5. `SELECT cust_name FROM customers;`
6. `SELECT * FROM orders ORDER BY order_amount DESC WHERE payment_status = 'Paid';`
7. `SELECT customer_id customer_name FROM customers;`
8. `SELECT * FROM orders LIMIT 5 ORDER BY order_amount DESC;`
9. `SELECT * FROM orders WHERE;`
10. `SELECT * FROM orders ORDER BY order_amount ASC;` when the task asks highest first.

## Section 6: Think Like a Data Engineer

1. Which table would you check to investigate failed payments?
2. Which columns would you select to review high-value orders?
3. Which filter would find active customers?
4. Would you sort high-value orders? Why?
5. Why should you use `LIMIT` when previewing a new table?
6. How does a simple query help investigate data?

## Section 7: Mini Assignment

Imagine you are checking an e-commerce dataset. Write queries to:

1. Preview customers.
2. Preview orders.
3. Preview products.
4. Find active customers.
5. Find failed payments.
6. Find cancelled orders.
7. Find high-value orders.
8. Sort newest customers.
9. Sort most expensive products.
10. Limit results to 5 rows.

## Answer Key

### Section 1

1. Structured Query Language.
2. Data arranged in rows and columns.
3. One complete record.
4. One field or attribute.
5. Chooses columns.
6. Chooses the table.
7. Filters rows.
8. Sorts results.
9. Limits rows returned.
10. Ascending.
11. Descending.
12. The output returned by a query.

### Section 2

1. SELECT
2. FROM
3. WHERE
4. ORDER BY
5. LIMIT
6. WHERE
7. SELECT
8. FROM
9. ORDER BY
10. LIMIT

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

### Section 4

1. `SELECT * FROM customers;`
2. `SELECT customer_id, customer_name FROM customers;`
3. `SELECT * FROM customers WHERE country = 'India';`
4. `SELECT * FROM customers WHERE customer_status = 'Active';`
5. `SELECT * FROM orders WHERE payment_status = 'Failed';`
6. `SELECT * FROM orders WHERE order_amount > 100;`
7. `SELECT * FROM orders ORDER BY order_amount DESC;`
8. `SELECT * FROM products LIMIT 5;`
9. `SELECT * FROM products WHERE category = 'Electronics';`
10. `SELECT * FROM products WHERE is_active = true;`
11. `SELECT * FROM customers ORDER BY signup_date ASC;`
12. `SELECT * FROM orders WHERE payment_status = 'Paid' ORDER BY order_amount DESC LIMIT 5;`

### Section 5

1. `SELECT` is misspelled.
2. Missing `FROM`.
3. Text value needs quotes.
4. Table name should be checked.
5. Column name should be checked.
6. `WHERE` should come before `ORDER BY`.
7. Missing comma between columns.
8. `ORDER BY` should come before `LIMIT`.
9. Missing condition after `WHERE`.
10. Use `DESC` for highest first.

