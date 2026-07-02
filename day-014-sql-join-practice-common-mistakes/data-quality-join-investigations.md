# Data Quality Join Investigations

## Why Data Engineers Investigate Relationships

Many reporting issues come from broken table relationships. Joins help find records that point to missing customers, products, orders, campaigns, payments, or support entities.

## Investigation 1: Orders with Unknown Customers

```sql
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

This finds orders that do not match a known customer.

## Investigation 2: Customers Without Orders

```sql
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

This may be normal, but it helps customer activity analysis.

## Investigation 3: Order Items with Unknown Orders

```sql
SELECT oi.order_item_id, oi.order_id
FROM order_items AS oi
LEFT JOIN orders AS o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
```

This is usually serious because order items should belong to valid orders.

## Investigation 4: Order Items with Unknown Products

```sql
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
```

This finds missing product reference data.

## Investigation 5: Products Never Ordered

```sql
SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;
```

This may be normal for new or inactive products.

## Investigation 6: Payments with Unknown Orders

```sql
SELECT pay.payment_id, pay.order_id
FROM payments AS pay
LEFT JOIN orders AS o
ON pay.order_id = o.order_id
WHERE o.order_id IS NULL;
```

Payment rows should usually connect to valid orders.

## Investigation 7: Orders Without Payments

```sql
SELECT o.order_id, o.payment_status
FROM orders AS o
LEFT JOIN payments AS pay
ON o.order_id = pay.order_id
WHERE pay.payment_id IS NULL;
```

This may be normal for created, failed, or cancelled orders.

## Investigation 8: Support Tickets with Unknown Customers

```sql
SELECT st.ticket_id, st.customer_id
FROM support_tickets AS st
LEFT JOIN customers AS c
ON st.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

Support tickets usually need valid customer references.

## Investigation 9: Campaigns Without Performance Data

```sql
SELECT ca.campaign_id, ca.campaign_name
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;
```

This may indicate no activity, missing data, or a tracking issue.

## Investigation 10: Campaign Performance with Unknown Campaign IDs

```sql
SELECT cp.performance_date, cp.campaign_id
FROM campaign_performance AS cp
LEFT JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id
WHERE ca.campaign_id IS NULL;
```

Unknown campaign IDs can break reporting.

## What Counts as a Problem?

Likely serious: order item with unknown order, payment with unknown order, campaign performance with unknown campaign, and order with unknown customer.

May be normal: customer with no orders, product never ordered, campaign with no performance yet, and order without payment depending on status.

## Investigation Summary Table

| Investigation | Join Pattern | Likely Severity | Why It Matters |
| --- | --- | --- | --- |
| Unknown customers | orders to customers | High | Orders need customer context |
| Unknown products | order_items to products | High | Product reporting breaks |
| Products never ordered | products to order_items | Low | May be normal |
| Payments without orders | payments to orders | High | Payment should match order |
| Campaigns without performance | campaigns to performance | Medium | Could be no activity |

## Actions After Finding Issues

Check the source system, ingestion logic, transformation logic, and reference data. Quarantine invalid records if needed, alert the data owner, document known exceptions, rerun pipelines after correction, and update validation checks.
