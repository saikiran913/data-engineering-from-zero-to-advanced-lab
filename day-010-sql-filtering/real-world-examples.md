# Day 010 Real-World SQL Filtering Examples

## Example 1: Find Active Customers in a Specific Country

Business situation: a team wants active UK customers.

Table used: `customers`

Columns needed: `customer_id`, `customer_name`, `country`, `customer_status`

SQL filtering concept used: `AND`

```sql
SELECT customer_id, customer_name, country, customer_status
FROM customers
WHERE country = 'UK'
AND customer_status = 'Active';
```

Expected result: active customers from the UK.

Why a data engineer may use it: to prepare customer data for a regional report.

Possible next step: later lessons may summarize customers by country.

## Example 2: Find Customers with Missing Email

```sql
SELECT customer_id, customer_name, email
FROM customers
WHERE email IS NULL;
```

Expected result: customers whose email is missing. This supports data quality review.

## Example 3: Find Failed Payments

```sql
SELECT order_id, customer_id, order_amount, payment_status
FROM orders
WHERE payment_status = 'Failed';
```

Expected result: orders with failed payment status.

## Example 4: Find Refunded or Failed Orders

```sql
SELECT order_id, payment_status, order_amount
FROM orders
WHERE payment_status IN ('Failed', 'Refunded');
```

Expected result: orders that need payment review.

## Example 5: Find High-Value Paid Orders

```sql
SELECT order_id, customer_id, order_amount
FROM orders
WHERE payment_status = 'Paid'
AND order_amount > 500
ORDER BY order_amount DESC;
```

Expected result: paid orders above 500, largest first.

## Example 6: Find Orders in a Date Range

```sql
SELECT order_id, order_date, order_amount
FROM orders
WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
```

Expected result: June orders.

## Example 7: Find Products Containing Book

```sql
SELECT product_id, product_name, category
FROM products
WHERE product_name LIKE '%Book%';
```

Expected result: products with Book in the name.

## Example 8: Find Inactive or Discontinued Products

```sql
SELECT product_id, product_name, is_active, stock_status
FROM products
WHERE is_active = false
OR stock_status = 'Discontinued';
```

Expected result: products that may need catalog review.

## Example 9: Find Active Campaigns in Selected Channels

```sql
SELECT campaign_id, campaign_name, channel, campaign_status
FROM campaigns
WHERE campaign_status = 'Active'
AND channel IN ('Search', 'Social', 'Email');
```

Expected result: active campaigns in selected channels.

## Example 10: Find Campaigns with Budget in a Specific Range

```sql
SELECT campaign_id, campaign_name, budget
FROM campaigns
WHERE budget BETWEEN 1000 AND 5000
ORDER BY budget DESC;
```

Expected result: campaigns with budget between 1000 and 5000.

