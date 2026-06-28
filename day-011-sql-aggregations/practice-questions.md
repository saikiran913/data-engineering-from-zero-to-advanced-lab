# Day 011 Practice Questions

## Section 1: Simple Questions

1. What does aggregation mean in SQL?
2. Why do data engineers use aggregation?
3. What does `COUNT(*)` count?
4. What does `COUNT(column_name)` count?
5. What does `SUM` do?
6. What does `AVG` do?
7. What does `MIN` do?
8. What does `MAX` do?
9. What does `GROUP BY` do?
10. Does `WHERE` filter rows before or after `GROUP BY`?
11. Why might you use `ORDER BY` with aggregated results?
12. Give one data quality check that uses aggregation.

## Section 2: Identify the Aggregation Function

Choose `COUNT`, `SUM`, `AVG`, `MIN`, or `MAX`.

1. Total number of orders
2. Total sales amount
3. Average order value
4. Highest order amount
5. Lowest product price
6. Latest order date
7. Earliest campaign date
8. Total campaign cost
9. Total clicks
10. Average product price
11. Number of active customers
12. Total conversions
13. Highest campaign revenue
14. Lowest campaign cost
15. Latest performance date

## Section 3: Choose the Correct Query

1. Count all orders.

   A.
   ```sql
   SELECT COUNT(*) AS total_orders
   FROM orders;
   ```

   B.
   ```sql
   SELECT SUM(order_id) AS total_orders
   FROM orders;
   ```

2. Calculate total sales.

   A.
   ```sql
   SELECT SUM(order_amount) AS total_sales
   FROM orders;
   ```

   B.
   ```sql
   SELECT COUNT(order_amount) AS total_sales
   FROM orders;
   ```

3. Calculate average order amount.

   A.
   ```sql
   SELECT AVG(order_amount) AS average_order_amount
   FROM orders;
   ```

   B.
   ```sql
   SELECT MAX(order_amount) AS average_order_amount
   FROM orders;
   ```

4. Find highest order amount.

   A.
   ```sql
   SELECT MIN(order_amount) AS highest_order_amount
   FROM orders;
   ```

   B.
   ```sql
   SELECT MAX(order_amount) AS highest_order_amount
   FROM orders;
   ```

5. Count orders by country.

   A.
   ```sql
   SELECT country, COUNT(*) AS total_orders
   FROM orders
   GROUP BY country;
   ```

   B.
   ```sql
   SELECT country, COUNT(*) AS total_orders
   FROM orders;
   ```

6. Count orders by status.

   A.
   ```sql
   SELECT order_status, COUNT(*) AS total_orders
   FROM orders
   GROUP BY order_status;
   ```

   B.
   ```sql
   SELECT order_status, SUM(order_status) AS total_orders
   FROM orders
   GROUP BY order_status;
   ```

7. Calculate sales by country.

   A.
   ```sql
   SELECT country, SUM(order_amount) AS total_sales
   FROM orders
   GROUP BY country;
   ```

   B.
   ```sql
   SELECT country, AVG(order_status) AS total_sales
   FROM orders
   GROUP BY country;
   ```

8. Count products by category.

   A.
   ```sql
   SELECT category, COUNT(*) AS total_products
   FROM products
   GROUP BY category;
   ```

   B.
   ```sql
   SELECT category, COUNT(*) AS total_products
   FROM products;
   ```

9. Calculate revenue by channel.

   A.
   ```sql
   SELECT channel, SUM(revenue) AS total_revenue
   FROM campaign_performance
   GROUP BY channel;
   ```

   B.
   ```sql
   SELECT channel, COUNT(revenue) AS total_revenue
   FROM campaign_performance;
   ```

10. Find latest order date.

    A.
    ```sql
    SELECT MAX(order_date) AS latest_order_date
    FROM orders;
    ```

    B.
    ```sql
    SELECT SUM(order_date) AS latest_order_date
    FROM orders;
    ```

11. Calculate paid sales by country.

    A.
    ```sql
    SELECT country, SUM(order_amount) AS paid_sales
    FROM orders
    WHERE payment_status = 'Paid'
    GROUP BY country;
    ```

    B.
    ```sql
    SELECT country, SUM(order_amount) AS paid_sales
    FROM orders
    GROUP BY country
    WHERE payment_status = 'Paid';
    ```

12. Sort countries by highest sales.

    A.
    ```sql
    SELECT country, SUM(order_amount) AS total_sales
    FROM orders
    GROUP BY country
    ORDER BY total_sales DESC;
    ```

    B.
    ```sql
    SELECT country, SUM(order_amount) AS total_sales
    FROM orders
    ORDER BY total_sales DESC;
    ```

## Section 4: Write Aggregation Queries

Write SQL queries for these tasks:

1. Count all customers.
2. Count all orders.
3. Count customers with email.
4. Calculate total order amount.
5. Calculate average order amount.
6. Find lowest product price.
7. Find highest product price.
8. Count orders by `payment_status`.
9. Count orders by `order_status`.
10. Calculate total sales by country.
11. Calculate average order amount by country.
12. Count products by category.
13. Sum campaign budget by channel.
14. Sum campaign revenue by country.
15. Find latest campaign performance date.

## Section 5: Spot the Mistake

1.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders;
```

2.
```sql
SELECT SUM(customer_name) AS total_names
FROM customers;
```

3.
```sql
SELECT *
FROM orders
GROUP BY country;
```

4.
```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
WHERE payment_status = 'Paid';
```

5.
```sql
SELECT COUT(*) AS total_orders
FROM orders;
```

6.
```sql
SELECT COUNT(*)
FROM customers;
```

7.
```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
GROUP BY country
ORDER BY order_amount DESC;
```

8.
```sql
SELECT country, SUM(order_amount) AS total_sales
FROM orders
WHERE total_sales > 500
GROUP BY country;
```

9.
```sql
SELECT COUNT(*) AS total_orders;
```

10.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_status;
```

11.
```sql
SELECT AVG(order_status) AS average_status
FROM orders;
```

12. A learner says `COUNT(email)` counts rows where email is null. Is that correct?

## Section 6: Data Quality Investigation

Which aggregation would you use?

1. Check if a file loaded any rows.
2. Check the latest order date.
3. Check total revenue.
4. Check number of failed payments.
5. Check count by country.
6. Check minimum and maximum order amount.
7. Check customers with email.
8. Check campaign performance row counts.

## Section 7: Think Like a Data Engineer

1. Which table would you summarise to calculate total sales?
2. Which metric would you calculate to show average order value?
3. Do you need grouping to count orders by status?
4. Do you need filtering before calculating paid sales?
5. How can sales by country help a dashboard?
6. What business question does revenue by channel answer?

## Section 8: Mini Assignment

Imagine you are preparing simple dashboard metrics for an e-commerce and marketing dataset. Write queries to:

1. Count total customers.
2. Count total orders.
3. Calculate total sales.
4. Calculate average order value.
5. Find highest order amount.
6. Find lowest order amount.
7. Show orders by status.
8. Show paid sales by country.
9. Show products by category.
10. Show campaign revenue by channel.
11. Show latest order date.
12. Show campaign cost by country.

## Answer Key

### Section 1

1. Aggregation summarises many rows into useful numbers.
2. To create metrics, dashboards, reports, checks, and summaries.
3. All rows returned by the query.
4. Non-null values in that column.
5. Adds numeric values.
6. Calculates an average.
7. Finds the smallest value.
8. Finds the largest value.
9. Creates one summary per unique group value.
10. Before `GROUP BY`.
11. To sort summary results.
12. Row count, latest date, total amount, status count, or min/max range check.

### Section 2

1. `COUNT`
2. `SUM`
3. `AVG`
4. `MAX`
5. `MIN`
6. `MAX`
7. `MIN`
8. `SUM`
9. `SUM`
10. `AVG`
11. `COUNT`
12. `SUM`
13. `MAX`
14. `MIN`
15. `MAX`

### Section 3

1. A
2. A
3. A
4. B
5. A
6. A
7. A
8. A
9. A
10. A
11. A
12. A

### Section 4

```sql
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(email) AS customers_with_email FROM customers;
SELECT SUM(order_amount) AS total_order_amount FROM orders;
SELECT AVG(order_amount) AS average_order_amount FROM orders;
SELECT MIN(price) AS lowest_product_price FROM products;
SELECT MAX(price) AS highest_product_price FROM products;
SELECT payment_status, COUNT(*) AS total_orders FROM orders GROUP BY payment_status;
SELECT order_status, COUNT(*) AS total_orders FROM orders GROUP BY order_status;
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country;
SELECT country, AVG(order_amount) AS average_order_amount FROM orders GROUP BY country;
SELECT category, COUNT(*) AS total_products FROM products GROUP BY category;
SELECT channel, SUM(budget) AS total_budget FROM campaigns GROUP BY channel;
SELECT country, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY country;
SELECT MAX(performance_date) AS latest_performance_date FROM campaign_performance;
```

### Section 5

1. Missing `GROUP BY country`.
2. `SUM` should be used on numeric values, not customer names.
3. Avoid `SELECT *` with `GROUP BY`.
4. `WHERE` must come before `GROUP BY`.
5. `COUNT` is misspelled.
6. The query works, but a clear alias would be better.
7. In this beginner context, sort by the aggregated alias `total_sales`.
8. `WHERE` filters source rows, not aggregated results. This will be covered later.
9. Missing `FROM orders`.
10. The selected grouping column and `GROUP BY` column do not match.
11. `AVG` should not be used on status text.
12. No. `COUNT(email)` counts non-null email values.
