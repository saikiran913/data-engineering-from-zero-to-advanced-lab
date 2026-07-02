# Data Quality Checks Using SQL JOINs

## Why Joins Help Data Quality

Joins can reveal broken relationships and missing reference data. They help data engineers check whether child records have matching parent records and whether important lookup data exists.

## Check 1: Orders with Missing Customers

```sql
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

This matters because orders usually need valid customer records for reporting.

## Check 2: Customers with No Orders

```sql
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

This may be normal, but it is useful for business analysis and customer activation checks.

## Check 3: Order Items with Missing Orders

```sql
SELECT oi.order_item_id, oi.order_id
FROM order_items AS oi
LEFT JOIN orders AS o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
```

This is more serious because an order item usually should belong to an order.

## Check 4: Order Items with Missing Products

```sql
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
```

Product reference data matters because reports often need product names and categories.

## Check 5: Products Never Ordered

```sql
SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

This may be normal, but it can support catalog and inventory analysis.

## Check 6: Campaign Performance with Missing Campaign

```sql
SELECT cp.performance_date, cp.campaign_id
FROM campaign_performance AS cp
LEFT JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id
WHERE ca.campaign_id IS NULL;
```

Unknown campaign IDs are a data quality issue because campaign names and budgets cannot be attached.

## Check 7: Campaigns with No Performance Data

```sql
SELECT ca.campaign_id, ca.campaign_name
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;
```

This may indicate no activity, paused campaigns, or missing performance data.

## INNER JOIN Can Hide Problems

`INNER JOIN` only keeps matching records. If relationships are broken, unmatched rows may disappear from the result. Data engineers often use `LEFT JOIN` for validation because it keeps rows that need review.

## Beginner Join Quality Checklist

- Check child records have matching parent records.
- Check parent records without child records when relevant.
- Compare row counts before and after joins.
- Review `NULL` values after `LEFT JOIN`.
- Confirm join keys are correct.
- Confirm join relationship is expected.
- Document acceptable unmatched records.
- Investigate unexpected unmatched records.
