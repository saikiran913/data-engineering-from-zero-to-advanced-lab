# Practice Questions

## Section A: Concept Checks

1. What is a subquery?
2. What is an inner query?
3. What is an outer query?
4. What should a scalar subquery return?
5. What does `IN` check?
6. Why can `NOT IN` be risky with `NULL`?
7. What does `EXISTS` check?
8. What does `NOT EXISTS` check?
9. What is a correlation condition?
10. Why should a `FROM` subquery have an alias?
11. Why should the inner query be run first?
12. When might a join be clearer than a subquery?
13. When might a CTE be clearer than a subquery?
14. What is reconciliation?
15. Why are validation results review inputs?

## Section B: Predict the Result

1. What does this inner query return?

```sql
SELECT AVG(order_amount)
FROM orders;
```

2. What does the outer query return?

```sql
SELECT order_id
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);
```

3. Does this expect one value or many values?

```sql
SELECT MAX(unit_price)
FROM products;
```

4. What does `IN` compare?

```sql
SELECT customer_id
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
```

5. Why is this risky?

```sql
SELECT customer_id
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);
```

6. What does `EXISTS` check in a customer-order query?
7. What does `NOT EXISTS` return for products and sales?
8. What shape does a `FROM`-clause subquery return?

## Section C: Complete the SQL

1. Orders above average order amount.
2. Customers with orders using `IN`.
3. Customers without orders using `NOT EXISTS`.
4. Orders with successful payments using `EXISTS`.
5. Products never sold using `NOT EXISTS`.
6. Safe `NOT IN` for customers without orders.
7. Products above average unit price.
8. Daily totals using a `FROM`-clause subquery.
9. Source records missing from target.
10. Target records missing from source.

## Section D: Fix the Mistake

1. Scalar subquery returns many rows.
2. `IN` subquery returns two columns.
3. `NOT IN` inner query does not filter `NULL`.
4. `EXISTS` has no correlation condition.
5. Query compares `order_id` with `customer_id`.
6. Query compares `unit_price` with `product_name`.
7. `FROM` subquery has no alias.
8. Query uses three nested levels for a simple filter.

## Section E: Data Engineering Scenarios

Choose a pattern and explain briefly:

1. Find customers with at least one order.
2. Find customers with no order.
3. Find orders above the average amount.
4. Find orders without successful payment.
5. Find products that were never sold.
6. Find source IDs missing from target.
7. Find target IDs missing from source.
8. Build daily sales totals and filter high days.

## Answer Key

### Section A

1. A query inside another query.
2. The query placed inside the larger query.
3. The query that uses the inner result.
4. One row and one column.
5. Whether a value appears in a returned list.
6. `NULL` can make the result unexpected.
7. Whether at least one matching row exists.
8. Whether no matching row exists.
9. The condition connecting inner and outer rows.
10. Many platforms require it, and it improves readability.
11. To confirm row count, column count, keys, and `NULL` values.
12. When final output needs columns from both tables.
13. When named steps would make a larger query clearer.
14. Comparing source and target data.
15. They need investigation before action.

### Section B

1. One average order amount.
2. Orders whose amount is greater than the average.
3. One value.
4. Customer IDs from the outer table against customer IDs returned by orders.
5. `orders.customer_id` contains a `NULL`.
6. Whether a matching order exists for each customer.
7. Products with no matching sales row.
8. A table-like result with rows and columns.

### Section C: Sample Answers

```sql
-- 1. Orders above average.
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
);

-- 2. Customers with orders.
SELECT customer_id, customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);

-- 3. Customers without orders.
SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- 4. Orders with successful payments.
SELECT o.order_id, o.customer_id
FROM orders AS o
WHERE EXISTS (
    SELECT 1
    FROM payments AS p
    WHERE p.order_id = o.order_id
      AND p.payment_status = 'SUCCESS'
);

-- 5. Products never sold.
SELECT p.product_id, p.product_name
FROM products AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM daily_sales AS s
    WHERE s.product_id = p.product_id
);
```

### Section D

1. Use an aggregate such as `AVG`, or use `IN` if many rows are expected.
2. Return one comparable column.
3. Add `WHERE customer_id IS NOT NULL` inside the subquery.
4. Add a condition such as `o.customer_id = c.customer_id`.
5. Compare matching keys.
6. Compare compatible values.
7. Add an alias after the closing parenthesis.
8. Use a simple `WHERE` filter or a clearer CTE preview.

### Section E

1. `EXISTS` or `IN`.
2. `NOT EXISTS`.
3. Scalar subquery.
4. `NOT EXISTS` with a payment status filter.
5. `NOT EXISTS`.
6. `NOT EXISTS`.
7. Reverse `NOT EXISTS`.
8. `FROM`-clause subquery.
