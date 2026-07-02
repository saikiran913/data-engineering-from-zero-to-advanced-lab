# Real-World Beginner Examples

## 1. Find duplicate order IDs

Business situation: A data engineer suspects repeated order records.

- Table used: `orders`
- Columns needed: `order_id`
- SQL concept used: `GROUP BY`, `HAVING`, `COUNT`

```sql
SELECT order_id, COUNT(*) AS record_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Expected result: Order IDs appearing more than once.

Why use it: To investigate duplicate-looking keys.

Possible next step: Review source system rules.

## 2. Find repeated customer emails

Business situation: Customer email duplication is suspected.

- Table used: `customers`
- Columns needed: `email`
- SQL concept used: `WHERE`, `GROUP BY`, `HAVING`

```sql
SELECT email, COUNT(*) AS email_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

Expected result: Non-null emails appearing more than once.

Why use it: To review important repeated values.

Possible next step: Confirm whether shared emails are allowed.

## 3. Find countries with high failed payments

Business situation: Payment issues may be affecting some countries.

```sql
SELECT country, COUNT(*) AS failed_orders
FROM orders
WHERE payment_status = 'Failed'
GROUP BY country
HAVING COUNT(*) > 1;
```

Expected result: Countries above the failed-payment threshold.

Why use it: To investigate payment patterns.

Possible next step: Compare against normal daily volume.

## 4. Find dates with zero orders

Business situation: A daily summary may have missing activity.

```sql
SELECT summary_date, country, SUM(total_orders) AS orders_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(total_orders) = 0;
```

Expected result: Date and country groups reporting zero orders.

Why use it: To validate batch summary output.

Possible next step: Check source file arrival.

## 5. Find countries with low sales

Business situation: A dashboard shows sales dropping.

```sql
SELECT summary_date, country, SUM(total_sales) AS summary_sales
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(total_sales) < 100;
```

Expected result: Low-sales date and country groups.

Why use it: To investigate possible missing or low activity.

Possible next step: Compare against previous days.

## 6. Find channels with high campaign cost

Business situation: Marketing spend looks high.

```sql
SELECT channel, SUM(cost) AS total_cost
FROM campaign_performance
GROUP BY channel
HAVING SUM(cost) > 1000
ORDER BY total_cost DESC;
```

Expected result: High-cost channels.

Why use it: To focus investigation on expensive channels.

Possible next step: Compare cost and revenue.

## 7. Find product categories with many inactive products

Business situation: A catalog team wants inactive product counts.

```sql
SELECT category, COUNT(*) AS inactive_products
FROM products
WHERE is_active = 'false'
GROUP BY category
HAVING COUNT(*) > 1;
```

Expected result: Categories above the inactive-product threshold.

Why use it: To review catalog health.

Possible next step: Confirm discontinued products.

## 8. Find order statuses with unusual counts

Business situation: Operations wants high-volume statuses.

```sql
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
HAVING COUNT(*) > 5
ORDER BY total_orders DESC;
```

Expected result: Statuses above the count threshold.

Why use it: To monitor operational states.

Possible next step: Investigate cancelled or returned orders.

## 9. Find campaign channels with high revenue

Business situation: Marketing wants top-performing channels.

```sql
SELECT channel, SUM(revenue) AS total_revenue
FROM campaign_performance
GROUP BY channel
HAVING SUM(revenue) > 5000
ORDER BY total_revenue DESC;
```

Expected result: Channels above the revenue threshold.

Why use it: To support campaign reporting.

Possible next step: Compare revenue against cost.

## 10. Validate daily order summary output

Business situation: A nightly batch created daily summaries.

```sql
SELECT summary_date, country, COUNT(*) AS record_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING COUNT(*) > 1;
```

Expected result: Duplicate-looking date and country summary rows.

Why use it: To find repeated summary groups.

Possible next step: Review batch logic.

## 11. Investigate dashboard sales drop

Business situation: A dashboard total is lower than expected.

```sql
SELECT country, SUM(total_sales) AS country_sales
FROM daily_order_summary
GROUP BY country
HAVING SUM(total_sales) < 1000
ORDER BY country_sales;
```

Expected result: Countries below the example sales threshold.

Why use it: To identify where the drop may be happening.

Possible next step: Review daily records for those countries.

## 12. Check latest available data

Business situation: A data engineer wants to confirm data freshness.

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

Expected result: The latest order date.

Why use it: To see whether recent data exists.

Possible next step: Compare latest date with expected refresh date.
