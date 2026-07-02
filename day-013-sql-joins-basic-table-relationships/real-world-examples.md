# Real-World Beginner JOIN Examples

## 1. Customers with orders

Business situation: A team wants customers who placed orders.

- Tables used: `customers`, `orders`
- Relationship used: `customer_id`
- SQL join type used: `INNER JOIN`

```sql
SELECT c.customer_name, o.order_id, o.order_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;
```

Expected result: Only customers with matching orders.

Why use it: To build matched customer-order reporting data.

Possible next step: Add filters for paid or delivered orders.

## 2. Customers without orders

Business situation: A team wants registered customers who have not bought anything.

```sql
SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

Expected result: Customers with no matching order rows.

Why use it: To support customer activation analysis.

Possible next step: Review customer signup dates.

## 3. Orders with missing customers

Business situation: Some orders may reference unknown customers.

```sql
SELECT o.order_id, o.customer_id
FROM orders AS o
LEFT JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

Expected result: Orders whose customer IDs do not match `customers`.

Why use it: To find broken relationships.

Possible next step: Check source system customer loads.

## 4. Order items with product names

Business situation: Analysts need product names on order item rows.

```sql
SELECT oi.order_item_id, p.product_name, oi.quantity
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;
```

Expected result: Order items with matching product names.

Why use it: To enrich transaction details.

Possible next step: Add product categories.

## 5. Products never ordered

Business situation: A catalog team wants products with no order activity.

```sql
SELECT p.product_id, p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;
```

Expected result: Products with no matching order item rows.

Why use it: To review inactive or unused products.

Possible next step: Compare with product status.

## 6. Order items with missing products

Business situation: An order item references a product ID that is not in the product table.

```sql
SELECT oi.order_item_id, oi.product_id
FROM order_items AS oi
LEFT JOIN products AS p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
```

Expected result: Order items with unknown product IDs.

Why use it: To find missing product reference data.

Possible next step: Fix product loads or mapping.

## 7. Campaign performance with campaign names

Business situation: Marketing performance rows need campaign names.

```sql
SELECT ca.campaign_name, cp.performance_date, cp.revenue
FROM campaigns AS ca
INNER JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id;
```

Expected result: Matching campaign performance rows with names.

Why use it: To prepare marketing reports.

Possible next step: Summarise revenue by campaign.

## 8. Campaigns without performance data

Business situation: Some campaigns may have no performance rows.

```sql
SELECT ca.campaign_id, ca.campaign_name
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
WHERE cp.campaign_id IS NULL;
```

Expected result: Campaigns with no matching performance records.

Why use it: To find missing or inactive campaign data.

Possible next step: Check campaign status.

## 9. Customer order summary

Business situation: A dashboard needs order counts by customer.

```sql
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
```

Expected result: One row per customer with an order count.

Why use it: To combine joins and beginner aggregation.

Possible next step: Add total order amount.

## 10. Product quantity sold summary

Business situation: A team wants quantity sold by product.

```sql
SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_name;
```

Expected result: Product-level quantity summary.

Why use it: To support product reporting.

Possible next step: Add category-level summaries.

## 11. Campaign revenue by campaign name

Business situation: Marketing wants revenue by campaign name.

```sql
SELECT ca.campaign_name, SUM(cp.revenue) AS total_revenue
FROM campaigns AS ca
LEFT JOIN campaign_performance AS cp
ON ca.campaign_id = cp.campaign_id
GROUP BY ca.campaign_name;
```

Expected result: Campaign-level revenue summary.

Why use it: To build business-friendly campaign reporting.

Possible next step: Add campaign cost summaries.

## 12. Data quality validation using LEFT JOIN

Business situation: A data engineer wants to validate campaign references.

```sql
SELECT cp.performance_date, cp.campaign_id
FROM campaign_performance AS cp
LEFT JOIN campaigns AS ca
ON cp.campaign_id = ca.campaign_id
WHERE ca.campaign_id IS NULL;
```

Expected result: Performance rows with missing campaign records.

Why use it: To catch unknown campaign IDs before reporting.

Possible next step: Investigate source campaign mapping.
