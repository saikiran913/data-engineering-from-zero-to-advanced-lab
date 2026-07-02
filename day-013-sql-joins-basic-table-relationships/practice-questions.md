# Day 013 Practice Questions

## Section 1: Simple Questions

1. Why do companies store data in multiple related tables?
2. What is a primary key?
3. What is a foreign key?
4. What is a parent table?
5. What is a child table?
6. What does one-to-many relationship mean?
7. What does a SQL `JOIN` do?
8. What does `INNER JOIN` return?
9. What does `LEFT JOIN` return?
10. What does the `ON` condition do?
11. Why are table aliases useful?
12. How can joins help find missing relationships?

## Section 2: Identify the Relationship

Identify the likely relationship.

1. Customer to orders
2. Order to order items
3. Product to order items
4. Campaign to campaign performance
5. Student to exam results
6. Department to employees
7. Country to cities
8. Order to payment
9. Product category to products
10. User to login events
11. Driver to delivery events
12. Store to sales

## Section 3: INNER JOIN or LEFT JOIN?

Choose `INNER JOIN` or `LEFT JOIN`.

1. Show only customers who placed orders.
2. Show all customers even if they have no orders.
3. Find orders with missing customers.
4. Show order items with product names when product exists.
5. Find products never ordered.
6. Show all campaigns even if they have no performance rows.
7. Show only campaigns with performance rows.
8. Find campaign performance with unknown campaign IDs.
9. Enrich paid orders with customer details.
10. Validate order items against products.
11. Build a matched customer-order dataset.
12. Investigate missing reference data.
13. Find customers without orders.
14. Show products with order item quantities if any.
15. Show campaign revenue with campaign names.

## Section 4: Choose the Correct Query

1. Customers with orders.

   A.
   ```sql
   SELECT c.customer_name, o.order_id
   FROM customers AS c
   INNER JOIN orders AS o
   ON c.customer_id = o.customer_id;
   ```

   B.
   ```sql
   SELECT c.customer_name, o.order_id
   FROM customers AS c
   INNER JOIN orders AS o;
   ```

2. All customers with possible orders.

   A.
   ```sql
   SELECT c.customer_name, o.order_id
   FROM customers AS c
   LEFT JOIN orders AS o
   ON c.customer_id = o.customer_id;
   ```

   B.
   ```sql
   SELECT c.customer_name, o.order_id
   FROM customers AS c
   INNER JOIN orders AS o
   ON c.customer_name = o.order_id;
   ```

3. Orders with missing customers.

   A.
   ```sql
   SELECT o.order_id, o.customer_id
   FROM orders AS o
   LEFT JOIN customers AS c
   ON o.customer_id = c.customer_id
   WHERE c.customer_id IS NULL;
   ```

   B.
   ```sql
   SELECT o.order_id, o.customer_id
   FROM orders AS o
   INNER JOIN customers AS c
   ON o.customer_id = c.customer_id
   WHERE c.customer_id IS NULL;
   ```

4. Order items with product names.

   A.
   ```sql
   SELECT oi.order_item_id, p.product_name
   FROM order_items AS oi
   INNER JOIN products AS p
   ON oi.product_id = p.product_id;
   ```

   B.
   ```sql
   SELECT oi.order_item_id, p.product_name
   FROM order_items AS oi
   INNER JOIN products AS p
   ON oi.order_id = p.product_id;
   ```

5. Order items with missing products.

   A.
   ```sql
   SELECT oi.order_item_id, oi.product_id
   FROM order_items AS oi
   LEFT JOIN products AS p
   ON oi.product_id = p.product_id
   WHERE p.product_id IS NULL;
   ```

   B.
   ```sql
   SELECT oi.order_item_id, oi.product_id
   FROM order_items AS oi
   INNER JOIN products AS p
   ON oi.product_id = p.product_id;
   ```

6. Products without order items.

   A.
   ```sql
   SELECT p.product_id, p.product_name
   FROM products AS p
   LEFT JOIN order_items AS oi
   ON p.product_id = oi.product_id
   WHERE oi.product_id IS NULL;
   ```

   B.
   ```sql
   SELECT p.product_id, p.product_name
   FROM products AS p
   INNER JOIN order_items AS oi
   ON p.product_id = oi.product_id;
   ```

7. Campaigns with performance rows.

   A.
   ```sql
   SELECT ca.campaign_name, cp.performance_date
   FROM campaigns AS ca
   INNER JOIN campaign_performance AS cp
   ON ca.campaign_id = cp.campaign_id;
   ```

   B.
   ```sql
   SELECT ca.campaign_name, cp.performance_date
   FROM campaigns AS ca
   INNER JOIN campaign_performance AS cp
   ON ca.campaign_name = cp.campaign_id;
   ```

8. Campaigns without performance rows.

   A.
   ```sql
   SELECT ca.campaign_id, ca.campaign_name
   FROM campaigns AS ca
   LEFT JOIN campaign_performance AS cp
   ON ca.campaign_id = cp.campaign_id
   WHERE cp.campaign_id IS NULL;
   ```

   B.
   ```sql
   SELECT ca.campaign_id, ca.campaign_name
   FROM campaigns AS ca
   INNER JOIN campaign_performance AS cp
   ON ca.campaign_id = cp.campaign_id
   WHERE cp.campaign_id IS NULL;
   ```

9. Campaign performance with missing campaign.

   A.
   ```sql
   SELECT cp.performance_date, cp.campaign_id
   FROM campaign_performance AS cp
   LEFT JOIN campaigns AS ca
   ON cp.campaign_id = ca.campaign_id
   WHERE ca.campaign_id IS NULL;
   ```

   B.
   ```sql
   SELECT cp.performance_date, cp.campaign_id
   FROM campaign_performance AS cp
   INNER JOIN campaigns AS ca
   ON cp.campaign_id = ca.campaign_id;
   ```

10. Count orders by customer.

    A.
    ```sql
    SELECT c.customer_name, COUNT(o.order_id) AS total_orders
    FROM customers AS c
    LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_name;
    ```

    B.
    ```sql
    SELECT c.customer_name, COUNT(o.order_id) AS total_orders
    FROM customers AS c
    LEFT JOIN orders AS o
    GROUP BY c.customer_name;
    ```

11. Quantity sold by product.

    A.
    ```sql
    SELECT p.product_name, SUM(oi.quantity) AS total_quantity
    FROM products AS p
    LEFT JOIN order_items AS oi
    ON p.product_id = oi.product_id
    GROUP BY p.product_name;
    ```

    B.
    ```sql
    SELECT p.product_name, SUM(oi.quantity) AS total_quantity
    FROM products AS p
    LEFT JOIN order_items AS oi
    ON p.product_name = oi.order_id
    GROUP BY p.product_name;
    ```

12. Campaign revenue by campaign name.

    A.
    ```sql
    SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue
    FROM campaigns AS ca
    LEFT JOIN campaign_performance AS cp
    ON ca.campaign_id = cp.campaign_id
    GROUP BY ca.campaign_name;
    ```

    B.
    ```sql
    SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue
    FROM campaigns AS ca
    LEFT JOIN campaign_performance AS cp
    GROUP BY ca.campaign_name;
    ```

## Section 5: Write JOIN Queries

Write SQL for these tasks:

1. Join customers and orders using `INNER JOIN`.
2. Join customers and orders using `LEFT JOIN`.
3. Find customers with no orders.
4. Find orders with missing customer records.
5. Join `order_items` with `products`.
6. Find `order_items` with missing products.
7. Find products never ordered.
8. Join orders with order items.
9. Join campaigns with campaign performance.
10. Find campaigns with no performance rows.
11. Find campaign performance rows with missing campaign records.
12. Count orders by customer.
13. Sum order amount by customer.
14. Count order items by product.
15. Sum campaign revenue by campaign name.

## Section 6: Spot the Mistake

1.
```sql
SELECT c.customer_name, o.order_id
FROM customers AS c
INNER JOIN orders AS o;
```

2.
```sql
SELECT c.customer_name, o.order_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_name = o.customer_id;
```

3. A learner uses `INNER JOIN` to find customers with no orders.

4.
```sql
SELECT c.customer_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered';
```

5.
```sql
SELECT customer_name, order_id
FROM customers
INNER JOIN orders
ON customer_id = customer_id;
```

6.
```sql
SELECT customer_id
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

7. A learner expects one customer row after joining customers to many orders.

8.
```sql
SELECT ca.campaign_name, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_name = cp.campaign_id;
```

9.
```sql
SELECT o.order_id
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

10. A learner says unmatched right-table columns are filled with text values after a `LEFT JOIN`.

11.
```sql
SELECT *
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

12. A learner joins tables only because both tables have a column named `country`.

## Section 7: Data Quality Investigation

Choose the join check:

1. Orders reference unknown customers.
2. Order items reference unknown products.
3. Campaigns have no performance data.
4. Campaign performance references unknown campaign IDs.
5. Products are never ordered.
6. Customers have no orders.
7. Row count drops after `INNER JOIN`.
8. Dashboard missing product names.
9. Campaign report has unknown campaign rows.
10. Order item table has orphan order IDs.

## Section 8: Think Like a Data Engineer

1. Which tables are involved?
2. Which keys connect them?
3. Which table should be the left table?
4. Is `INNER JOIN` or `LEFT JOIN` appropriate?
5. What do missing values after a `LEFT JOIN` mean?
6. How does the join support reporting or validation?

## Section 9: Mini Assignment

Imagine you are validating an e-commerce and marketing dataset. Write or describe checks to:

1. Find customers with no orders.
2. Find orders with missing customer records.
3. Find order items with missing orders.
4. Find order items with missing products.
5. Find products never ordered.
6. Enrich orders with customer names.
7. Enrich order items with product categories.
8. Find campaigns with no performance rows.
9. Find campaign performance with missing campaign records.
10. Create a simple campaign revenue by campaign name summary.

## Answer Key

### Section 1

1. To organize data, avoid repetition, and represent different entities.
2. A column that uniquely identifies a row.
3. A column pointing to a primary key in another table.
4. The main entity table.
5. A related detail table.
6. One row connects to many related rows.
7. It combines related tables.
8. Only matching rows from both tables.
9. All left table rows plus matching right table rows.
10. It tells SQL how tables connect.
11. They make queries shorter and clearer.
12. `LEFT JOIN` plus `IS NULL` can reveal missing matches.

### Section 2

1. One-to-many
2. One-to-many
3. One-to-many through order items
4. One-to-many
5. One-to-many
6. One-to-many
7. One-to-many
8. Often one-to-one or one-to-many
9. One-to-many
10. One-to-many
11. One-to-many
12. One-to-many

### Section 3

1. `INNER JOIN`
2. `LEFT JOIN`
3. `LEFT JOIN`
4. `INNER JOIN`
5. `LEFT JOIN`
6. `LEFT JOIN`
7. `INNER JOIN`
8. `LEFT JOIN`
9. `INNER JOIN`
10. `LEFT JOIN`
11. `INNER JOIN`
12. `LEFT JOIN`
13. `LEFT JOIN`
14. `LEFT JOIN`
15. `LEFT JOIN`

### Section 4

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

### Section 5

```sql
SELECT c.customer_name, o.order_id FROM customers AS c INNER JOIN orders AS o ON c.customer_id = o.customer_id;
SELECT c.customer_name, o.order_id FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id;
SELECT c.customer_id, c.customer_name FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;
SELECT o.order_id, o.customer_id FROM orders AS o LEFT JOIN customers AS c ON o.customer_id = c.customer_id WHERE c.customer_id IS NULL;
SELECT oi.order_item_id, p.product_name FROM order_items AS oi INNER JOIN products AS p ON oi.product_id = p.product_id;
SELECT oi.order_item_id, oi.product_id FROM order_items AS oi LEFT JOIN products AS p ON oi.product_id = p.product_id WHERE p.product_id IS NULL;
SELECT p.product_id, p.product_name FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id WHERE oi.product_id IS NULL;
SELECT o.order_id, oi.order_item_id FROM orders AS o INNER JOIN order_items AS oi ON o.order_id = oi.order_id;
SELECT ca.campaign_name, cp.performance_date FROM campaigns AS ca INNER JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id;
SELECT ca.campaign_id, ca.campaign_name FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id WHERE cp.campaign_id IS NULL;
SELECT cp.performance_date, cp.campaign_id FROM campaign_performance AS cp LEFT JOIN campaigns AS ca ON cp.campaign_id = ca.campaign_id WHERE ca.campaign_id IS NULL;
SELECT c.customer_name, COUNT(o.order_id) AS total_orders FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id GROUP BY c.customer_name;
SELECT c.customer_name, SUM(o.order_amount) AS total_order_amount FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id GROUP BY c.customer_name;
SELECT p.product_name, COUNT(oi.order_item_id) AS total_order_items FROM products AS p LEFT JOIN order_items AS oi ON p.product_id = oi.product_id GROUP BY p.product_name;
SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue FROM campaigns AS ca LEFT JOIN campaign_performance AS cp ON ca.campaign_id = cp.campaign_id GROUP BY ca.campaign_name;
```

### Section 6

1. Missing `ON` condition.
2. Wrong join columns.
3. Use `LEFT JOIN` to find non-matches.
4. Filtering the right table in `WHERE` changes the result pattern.
5. No aliases and unclear column references.
6. `customer_id` is ambiguous because both tables have it.
7. One-to-many joins can return multiple rows per customer.
8. Campaign name is being joined to campaign ID.
9. `INNER JOIN` will not return missing customer rows.
10. Missing right-side values become `NULL`.
11. `SELECT *` can be confusing in joins.
12. Same column names do not automatically mean a valid relationship.
