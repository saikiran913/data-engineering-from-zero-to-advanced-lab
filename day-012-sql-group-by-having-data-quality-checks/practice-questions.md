# Day 012 Practice Questions

## Section 1: Simple Questions

1. What does `GROUP BY` do?
2. What does `HAVING` do?
3. What is the main difference between `WHERE` and `HAVING`?
4. Why is `HAVING COUNT(*) > 5` useful?
5. How can `HAVING SUM(order_amount) > 1000` help?
6. What does `HAVING AVG(order_amount) > 250` show?
7. How can `GROUP BY order_id HAVING COUNT(*) > 1` help?
8. Why should repeated email values be reviewed carefully?
9. How can grouped status counts support data quality?
10. What is a daily summary check?
11. Why do thresholds need business context?
12. Give one example of a data quality summary check.

## Section 2: WHERE or HAVING?

Choose whether `WHERE` or `HAVING` is more appropriate.

1. Keep only `Paid` rows before calculating sales.
2. Show countries with total sales above 1000.
3. Keep only `Active` customers before grouping.
4. Show statuses with more than 5 orders.
5. Filter orders from UK before grouping.
6. Show dates with zero orders.
7. Keep only `Search` channel rows.
8. Show channels with total revenue above 5000.
9. Filter non-null emails before checking repeated emails.
10. Show emails that appear more than once.
11. Filter orders after a date.
12. Show countries with average order amount above 300.
13. Keep only `Delivered` orders.
14. Show product categories with more than 2 products.
15. Show campaign statuses with more than 3 campaigns.

## Section 3: Choose the Correct Query

1. Countries with more than 5 orders.

   A.
   ```sql
   SELECT country, COUNT(*) AS total_orders
   FROM orders
   GROUP BY country
   HAVING COUNT(*) > 5;
   ```

   B.
   ```sql
   SELECT country, COUNT(*) AS total_orders
   FROM orders
   WHERE COUNT(*) > 5
   GROUP BY country;
   ```

2. Duplicate order IDs.

   A.
   ```sql
   SELECT order_id, COUNT(*) AS record_count
   FROM orders
   GROUP BY order_id
   HAVING COUNT(*) > 1;
   ```

   B.
   ```sql
   SELECT order_id, COUNT(*) AS record_count
   FROM orders
   HAVING COUNT(*) > 1;
   ```

3. Repeated emails.

   A.
   ```sql
   SELECT email, COUNT(*) AS email_count
   FROM customers
   WHERE email IS NOT NULL
   GROUP BY email
   HAVING COUNT(*) > 1;
   ```

   B.
   ```sql
   SELECT email, COUNT(*) AS email_count
   FROM customers
   WHERE COUNT(*) > 1
   GROUP BY email;
   ```

4. Countries with total sales above 1000.

   A.
   ```sql
   SELECT country, SUM(order_amount) AS total_sales
   FROM orders
   GROUP BY country
   HAVING SUM(order_amount) > 1000;
   ```

   B.
   ```sql
   SELECT country, SUM(order_amount) AS total_sales
   FROM orders
   WHERE SUM(order_amount) > 1000
   GROUP BY country;
   ```

5. Channels with revenue above 5000.

   A.
   ```sql
   SELECT channel, SUM(revenue) AS total_revenue
   FROM campaign_performance
   GROUP BY channel
   HAVING SUM(revenue) > 5000;
   ```

   B.
   ```sql
   SELECT channel, revenue
   FROM campaign_performance
   HAVING revenue > 5000;
   ```

6. Categories with average product price above 100.

   A.
   ```sql
   SELECT category, AVG(price) AS average_price
   FROM products
   GROUP BY category
   HAVING AVG(price) > 100;
   ```

   B.
   ```sql
   SELECT category, AVG(price) AS average_price
   FROM products
   WHERE AVG(price) > 100
   GROUP BY category;
   ```

7. Dates with zero orders.

   A.
   ```sql
   SELECT summary_date, country, SUM(total_orders) AS orders_count
   FROM daily_order_summary
   GROUP BY summary_date, country
   HAVING SUM(total_orders) = 0;
   ```

   B.
   ```sql
   SELECT summary_date, country, total_orders
   FROM daily_order_summary
   HAVING total_orders = 0;
   ```

8. Payment statuses with high counts.

   A.
   ```sql
   SELECT payment_status, COUNT(*) AS total_orders
   FROM orders
   GROUP BY payment_status
   HAVING COUNT(*) > 5;
   ```

   B.
   ```sql
   SELECT payment_status, COUNT(*) AS total_orders
   FROM orders
   WHERE COUNT(*) > 5;
   ```

9. Paid sales by country above 1000.

   A.
   ```sql
   SELECT country, SUM(order_amount) AS paid_sales
   FROM orders
   WHERE payment_status = 'Paid'
   GROUP BY country
   HAVING SUM(order_amount) > 1000;
   ```

   B.
   ```sql
   SELECT country, SUM(order_amount) AS paid_sales
   FROM orders
   GROUP BY country
   WHERE payment_status = 'Paid';
   ```

10. Active customers by country above 2.

    A.
    ```sql
    SELECT country, COUNT(*) AS active_customers
    FROM customers
    WHERE customer_status = 'Active'
    GROUP BY country
    HAVING COUNT(*) > 2;
    ```

    B.
    ```sql
    SELECT country, COUNT(*) AS active_customers
    FROM customers
    HAVING customer_status = 'Active';
    ```

11. Summary date and country combinations appearing more than once.

    A.
    ```sql
    SELECT summary_date, country, COUNT(*) AS record_count
    FROM daily_order_summary
    GROUP BY summary_date, country
    HAVING COUNT(*) > 1;
    ```

    B.
    ```sql
    SELECT summary_date, country, COUNT(*) AS record_count
    FROM daily_order_summary
    WHERE COUNT(*) > 1;
    ```

12. Countries sorted by highest sales after `HAVING`.

    A.
    ```sql
    SELECT country, SUM(order_amount) AS total_sales
    FROM orders
    GROUP BY country
    HAVING SUM(order_amount) > 500
    ORDER BY total_sales DESC;
    ```

    B.
    ```sql
    SELECT country, SUM(order_amount) AS total_sales
    FROM orders
    ORDER BY total_sales DESC
    HAVING SUM(order_amount) > 500;
    ```

## Section 4: Write HAVING Queries

Write SQL queries for these tasks:

1. Find countries with more than 5 orders.
2. Find payment statuses with more than 5 orders.
3. Find categories with more than 2 products.
4. Find countries with total sales above 1000.
5. Find countries with average order amount above 250.
6. Find countries where highest order amount is above 700.
7. Find countries where lowest order amount is below 20.
8. Find duplicate order IDs.
9. Find repeated customer emails excluding null emails.
10. Find daily summary rows with zero total orders.
11. Find date and country groups with failed payments above 5.
12. Find channels with total revenue above 5000.
13. Find channels with total cost above 1000.
14. Find order date and country groups with more than 2 orders.
15. Find active campaigns budget by channel above 1000.

## Section 5: Spot the Mistake

1.
```sql
SELECT order_id, COUNT(*) AS record_count
FROM orders
GROUP BY order_id
WHERE COUNT(*) > 1;
```

2.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
HAVING COUNT(*) > 5;
```

3.
```sql
SELECT country, payment_status, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_status
HAVING COUNT(*) > 5;
```

4.
```sql
SELECT *
FROM orders
GROUP BY country
HAVING COUNT(*) > 5;
```

5.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY country
HAVING country = 'UK';
```

6.
```sql
SELECT country, COUNT(*)
FROM orders
GROUP BY country
HAVING COUNT(*) > 5;
```

7.
```sql
SELECT country, SUM(order_status) AS total_status
FROM orders
GROUP BY country;
```

8.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_status
HAVING COUNT(*) > 5;
```

9.
```sql
SELECT email, COUNT(*) AS email_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;
```

10. A query uses `HAVING COUNT(*) > 5` but nobody explains why 5 matters.

11.
```sql
SELECT country, COUNT(*) AS total_orders
FROM orders
HAVING COUNT(*) > 5
GROUP BY country;
```

12. A learner uses `WHERE` for row filters and `HAVING` for row filters too. What is confused?

## Section 6: Data Quality Investigation

Choose a summary check:

1. Dashboard sales dropped suddenly.
2. Duplicate order IDs are suspected.
3. Failed payments are unusually high.
4. Daily summary has zero orders.
5. Campaign cost looks too high.
6. Customer email duplication is suspected.
7. One country is missing from a report.
8. Latest order date seems old.
9. Cancelled order count increased.
10. Source and warehouse totals may not match.

## Section 7: Think Like a Data Engineer

1. Which table should be summarised?
2. Which columns should be grouped?
3. Which aggregation should be used?
4. Is `WHERE` needed before grouping?
5. Is `HAVING` needed after grouping?
6. What threshold makes sense, and is the result a warning or failure?

## Section 8: Mini Assignment

Imagine you are validating a daily e-commerce and marketing data refresh. Write or describe checks to:

1. Find duplicate order IDs.
2. Find repeated emails.
3. Find countries with low order counts.
4. Find countries with high failed payments.
5. Find date and country groups with zero orders.
6. Find channels with high campaign cost.
7. Find channels with high campaign revenue.
8. Find order statuses with unusual counts.
9. Find latest available order date.
10. Find daily summaries that look suspicious.

## Answer Key

### Section 1

1. It creates grouped summaries.
2. It filters grouped results after aggregation.
3. `WHERE` filters rows before grouping; `HAVING` filters groups after aggregation.
4. It finds groups above a count threshold.
5. It finds groups above a total sales threshold.
6. It shows groups above an average value threshold.
7. It finds duplicate-looking order IDs.
8. Repeated values are not always errors; business context matters.
9. They show unusual high or low status patterns.
10. A grouped check on daily output.
11. A threshold needs a business reason.
12. Duplicate ID check, zero-order check, high failed payment check, or latest date check.

### Section 2

1. `WHERE`
2. `HAVING`
3. `WHERE`
4. `HAVING`
5. `WHERE`
6. `HAVING`
7. `WHERE`
8. `HAVING`
9. `WHERE`
10. `HAVING`
11. `WHERE`
12. `HAVING`
13. `WHERE`
14. `HAVING`
15. `HAVING`

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

```sql
SELECT country, COUNT(*) AS total_orders FROM orders GROUP BY country HAVING COUNT(*) > 5;
SELECT payment_status, COUNT(*) AS total_orders FROM orders GROUP BY payment_status HAVING COUNT(*) > 5;
SELECT category, COUNT(*) AS total_products FROM products GROUP BY category HAVING COUNT(*) > 2;
SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country HAVING SUM(order_amount) > 1000;
SELECT country, AVG(order_amount) AS average_order_amount FROM orders GROUP BY country HAVING AVG(order_amount) > 250;
SELECT country, MAX(order_amount) AS highest_order FROM orders GROUP BY country HAVING MAX(order_amount) > 700;
SELECT country, MIN(order_amount) AS lowest_order FROM orders GROUP BY country HAVING MIN(order_amount) < 20;
SELECT order_id, COUNT(*) AS record_count FROM orders GROUP BY order_id HAVING COUNT(*) > 1;
SELECT email, COUNT(*) AS email_count FROM customers WHERE email IS NOT NULL GROUP BY email HAVING COUNT(*) > 1;
SELECT summary_date, country, SUM(total_orders) AS orders_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(total_orders) = 0;
SELECT summary_date, country, SUM(failed_payments) AS failed_payment_count FROM daily_order_summary GROUP BY summary_date, country HAVING SUM(failed_payments) > 5;
SELECT channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY channel HAVING SUM(revenue) > 5000;
SELECT channel, SUM(cost) AS total_cost FROM campaign_performance GROUP BY channel HAVING SUM(cost) > 1000;
SELECT order_date, country, COUNT(*) AS total_orders FROM orders GROUP BY order_date, country HAVING COUNT(*) > 2;
SELECT channel, SUM(budget) AS active_budget FROM campaigns WHERE campaign_status = 'Active' GROUP BY channel HAVING SUM(budget) > 1000;
```

### Section 5

1. Use `HAVING`, not `WHERE`, for `COUNT(*) > 1`.
2. Missing `GROUP BY country`.
3. `country` is selected but not grouped.
4. Avoid `SELECT *` in grouped queries.
5. A row-level country filter is simpler as `WHERE country = 'UK'`.
6. The query works, but a clear alias is better.
7. `SUM` should use numeric columns.
8. Selected group column and `GROUP BY` column do not match.
9. It should exclude missing emails before repeated email review.
10. Threshold lacks business context.
11. `HAVING` must come after `GROUP BY`.
12. Row-level and group-level filters are confused.
