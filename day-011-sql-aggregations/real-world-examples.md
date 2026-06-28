# Real-World Beginner Aggregation Examples

## 1. Count total customers

Business situation: A team wants to know how many customer records exist.

- Table used: `customers`
- Columns needed: all rows
- SQL aggregation concept used: `COUNT(*)`

```sql
SELECT COUNT(*) AS total_customers
FROM customers;
```

Expected result: One number showing total customers.

Why a data engineer may use it: To confirm that customer data loaded.

Possible next step in future lessons: Compare customer counts between source and target systems.

## 2. Count orders by status

Business situation: Operations wants to know how many orders are delivered, cancelled, returned, or still open.

- Table used: `orders`
- Columns needed: `order_status`
- SQL aggregation concept used: `COUNT(*)`, `GROUP BY`

```sql
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
```

Expected result: One row per order status.

Why a data engineer may use it: To monitor order pipeline health.

Possible next step in future lessons: Filter grouped results after aggregation.

## 3. Calculate total sales

Business situation: A reporting team needs total order value.

- Table used: `orders`
- Columns needed: `order_amount`
- SQL aggregation concept used: `SUM`

```sql
SELECT SUM(order_amount) AS total_sales
FROM orders;
```

Expected result: One total sales value.

Why a data engineer may use it: To prepare revenue metrics.

Possible next step in future lessons: Build a daily sales summary table.

## 4. Calculate paid sales by country

Business situation: Finance wants sales totals for paid orders only.

- Table used: `orders`
- Columns needed: `country`, `order_amount`, `payment_status`
- SQL aggregation concept used: `WHERE`, `SUM`, `GROUP BY`

```sql
SELECT country, SUM(order_amount) AS paid_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY country
ORDER BY paid_sales DESC;
```

Expected result: One paid sales total per country.

Why a data engineer may use it: To apply a simple business rule before reporting.

Possible next step in future lessons: Add checks for refunded orders.

## 5. Find average order value

Business situation: A dashboard needs average order value.

- Table used: `orders`
- Columns needed: `order_amount`
- SQL aggregation concept used: `AVG`

```sql
SELECT AVG(order_amount) AS average_order_value
FROM orders;
```

Expected result: One average amount.

Why a data engineer may use it: To support KPI reporting.

Possible next step in future lessons: Calculate average order value by customer segment.

## 6. Find highest and lowest order amount

Business situation: A team wants to understand the order amount range.

- Table used: `orders`
- Columns needed: `order_amount`
- SQL aggregation concept used: `MIN`, `MAX`

```sql
SELECT
  MIN(order_amount) AS lowest_order_amount,
  MAX(order_amount) AS highest_order_amount
FROM orders;
```

Expected result: One row with the lowest and highest order amounts.

Why a data engineer may use it: To detect unusual ranges.

Possible next step in future lessons: Investigate outlier records.

## 7. Count products by category

Business situation: A catalog team wants to know how many products exist in each category.

- Table used: `products`
- Columns needed: `category`
- SQL aggregation concept used: `COUNT(*)`, `GROUP BY`

```sql
SELECT category, COUNT(*) AS total_products
FROM products
GROUP BY category;
```

Expected result: One product count per category.

Why a data engineer may use it: To prepare catalog summary data.

Possible next step in future lessons: Compare active and inactive products.

## 8. Summarise campaign cost by channel

Business situation: Marketing wants to know spend by channel.

- Table used: `campaign_performance`
- Columns needed: `channel`, `cost`
- SQL aggregation concept used: `SUM`, `GROUP BY`

```sql
SELECT channel, SUM(cost) AS total_cost
FROM campaign_performance
GROUP BY channel
ORDER BY total_cost DESC;
```

Expected result: One cost total per channel.

Why a data engineer may use it: To support marketing cost reporting.

Possible next step in future lessons: Compare spend with conversions.

## 9. Summarise campaign revenue by country

Business situation: Marketing needs revenue by country.

- Table used: `campaign_performance`
- Columns needed: `country`, `revenue`
- SQL aggregation concept used: `SUM`, `GROUP BY`

```sql
SELECT country, SUM(revenue) AS total_revenue
FROM campaign_performance
GROUP BY country
ORDER BY total_revenue DESC;
```

Expected result: One revenue total per country.

Why a data engineer may use it: To create country-level marketing metrics.

Possible next step in future lessons: Filter countries above a target revenue.

## 10. Check latest data date using MAX date

Business situation: A data engineer wants to know whether fresh order data arrived.

- Table used: `orders`
- Columns needed: `order_date`
- SQL aggregation concept used: `MAX`

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

Expected result: The latest order date in the table.

Why a data engineer may use it: To check data freshness.

Possible next step in future lessons: Automate freshness checks.

## 11. Compare daily order totals

Business situation: A team wants daily sales totals.

- Table used: `orders`
- Columns needed: `order_date`, `order_amount`
- SQL aggregation concept used: `SUM`, `GROUP BY`, `ORDER BY`

```sql
SELECT order_date, SUM(order_amount) AS daily_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

Expected result: One sales total per order date.

Why a data engineer may use it: To prepare batch reporting outputs.

Possible next step in future lessons: Filter days with unusual totals.

## 12. Create simple dashboard metrics

Business situation: A dashboard needs a small order summary.

- Table used: `orders`
- Columns needed: `order_amount`
- SQL aggregation concept used: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`

```sql
SELECT
  COUNT(*) AS total_orders,
  SUM(order_amount) AS total_sales,
  AVG(order_amount) AS average_order_amount,
  MIN(order_amount) AS lowest_order_amount,
  MAX(order_amount) AS highest_order_amount
FROM orders;
```

Expected result: One row with several dashboard metrics.

Why a data engineer may use it: To create a simple reporting summary.

Possible next step in future lessons: Store summary results in a reporting table.
