# Real-World Beginner JOIN Examples

## 1. Enrich orders with customer names

Business situation: A report needs customer names beside orders.

- Tables used: `orders`, `customers`
- Relationship used: `customer_id`
- SQL join type used: `INNER JOIN`

```sql
SELECT o.order_id, c.customer_name, o.order_amount
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id;
```

Expected result: Orders that have matching customer records.

Why use it: To prepare readable order reports.

Common mistake to avoid: Joining by country instead of customer ID.

## 2. Find customers with no orders

```sql
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

Expected result: Customers without matching orders.

Why use it: To investigate customer activity.

Common mistake: Using `INNER JOIN`.

## 3. Find orders with unknown customers

```sql
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

Expected result: Orders pointing to missing customers.

Why use it: To find broken relationships.

Common mistake: Starting from customers instead of orders.

## 4. Enrich order items with product categories

```sql
SELECT oi.order_item_id, p.category, oi.quantity
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;
```

Expected result: Matched order items and product categories.

Why use it: To support category reporting.

Common mistake: Joining product name to product ID.

## 5. Find order items with unknown products

```sql
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
```

Expected result: Order items missing product details.

## 6. Find products never ordered

```sql
SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;
```

Expected result: Products without order item rows.

## 7. Match payments to orders

```sql
SELECT pay.payment_id, o.order_id, pay.payment_amount
FROM payments AS pay
INNER JOIN orders AS o
ON pay.order_id = o.order_id;
```

Expected result: Payments that match orders.

## 8. Find payments without orders

```sql
SELECT pay.payment_id, pay.order_id
FROM payments AS pay
LEFT JOIN orders AS o
ON pay.order_id = o.order_id
WHERE o.order_id IS NULL;
```

Expected result: Payment rows with unknown orders.

## 9. Find orders without payments

```sql
SELECT o.order_id, o.payment_status
FROM orders AS o
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
WHERE pay.payment_id IS NULL;
```

Expected result: Orders without payment rows.

## 10. Match support tickets to customers

```sql
SELECT st.ticket_id, st.issue_type, c.customer_name
FROM support_tickets AS st
INNER JOIN customers AS c
ON st.customer_id = c.customer_id;
```

Expected result: Tickets with matching customer records.

## 11. Match campaign performance to campaign names

```sql
SELECT ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id;
```

Expected result: Performance rows with campaign names.

## 12. Find campaigns without performance data

```sql
SELECT ca.campaign_id, ca.campaign_name
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;
```

Expected result: Campaigns without performance rows.

## 13. Product quantity sold by category

```sql
SELECT p.category, SUM(oi.quantity) AS total_quantity
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.category;
```

Expected result: Quantity summary by category.

## 14. Campaign revenue by campaign name

```sql
SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
GROUP BY ca.campaign_name;
```

Expected result: Revenue summary by campaign.
