# Day 009 Real-World SQL Examples

## Example 1: E-commerce Customer Lookup

| Topic | Details |
| --- | --- |
| Business situation | Check customers from the UK. |
| Table used | `customers` |
| Columns needed | `customer_id`, `customer_name`, `country` |
| SQL concept used | `SELECT`, `FROM`, `WHERE` |

```sql
SELECT customer_id, customer_name, country
FROM customers
WHERE country = 'UK';
```

Expected result: customers whose country is UK. A data engineer may use it to inspect country data.

## Example 2: E-commerce Failed Payment Investigation

```sql
SELECT order_id, customer_id, order_amount, payment_status
FROM orders
WHERE payment_status = 'Failed';
```

This reads failed payment orders. Future lessons may add deeper checks.

## Example 3: Marketing Active Customer List

```sql
SELECT customer_id, customer_name, email
FROM customers
WHERE customer_status = 'Active';
```

This finds active customers for a simple review.

## Example 4: Product Category Review

```sql
SELECT product_id, product_name, category, price
FROM products
WHERE category = 'Electronics';
```

This reviews products in one category.

## Example 5: High-Value Order Review

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE order_amount > 500
ORDER BY order_amount DESC;
```

This shows large orders first.

## Example 6: Cancelled Order Review

```sql
SELECT order_id, customer_id, order_status
FROM orders
WHERE order_status = 'Cancelled';
```

This helps review cancelled orders.

## Example 7: New Customer Signup Review

```sql
SELECT customer_id, customer_name, signup_date
FROM customers
ORDER BY signup_date DESC
LIMIT 5;
```

This previews the newest customer signups.

## Example 8: Dashboard Preview Query

```sql
SELECT order_id, order_date, order_amount, country
FROM orders
LIMIT 10;
```

This previews columns that might feed a simple dashboard. A future next step could include filtering by dates or combining tables.

