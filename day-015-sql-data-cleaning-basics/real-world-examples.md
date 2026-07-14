# Real-World Beginner SQL Cleaning Examples

## 1. Clean customer names

Business situation: Customer names contain extra spaces.

- Dirty data problem: Leading or trailing spaces
- Table used: `dirty_customers`
- SQL cleaning concept used: `TRIM`

```sql
SELECT customer_name, TRIM(customer_name) AS clean_customer_name
FROM dirty_customers;
```

Expected result: Names without outer spaces.

Why use it: Cleaner dashboard labels.

Common mistake: Forgetting to keep the raw value while testing.

## 2. Standardise email addresses

```sql
SELECT email, LOWER(TRIM(email)) AS clean_email
FROM dirty_customers;
```

Expected result: Trimmed lowercase emails.

## 3. Standardise country names

```sql
SELECT country,
  CASE
    WHEN UPPER(TRIM(country)) IN ('UK', 'U.K.', 'UNITED KINGDOM') THEN 'UK'
    WHEN UPPER(TRIM(country)) IN ('USA', 'U.S.A', 'UNITED STATES') THEN 'USA'
    ELSE COALESCE(TRIM(country), 'Unknown')
  END AS clean_country
FROM dirty_customers;
```

Expected result: Consistent country labels.

## 4. Replace missing city with Unknown

```sql
SELECT city, COALESCE(TRIM(city), 'Unknown') AS clean_city
FROM dirty_customers;
```

Expected result: A readable fallback for missing city values.

## 5. Standardise customer status

```sql
SELECT customer_status,
  CASE
    WHEN LOWER(TRIM(customer_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(customer_status)) = 'inactive' THEN 'Inactive'
    ELSE 'Unknown'
  END AS clean_customer_status
FROM dirty_customers;
```

## 6. Standardise order status

```sql
SELECT order_status,
  CASE
    WHEN LOWER(TRIM(order_status)) = 'delivered' THEN 'Delivered'
    WHEN LOWER(TRIM(order_status)) = 'cancelled' THEN 'Cancelled'
    ELSE COALESCE(TRIM(order_status), 'Unknown')
  END AS clean_order_status
FROM dirty_orders;
```

## 7. Standardise payment status

```sql
SELECT payment_status,
  CASE
    WHEN LOWER(TRIM(payment_status)) = 'paid' THEN 'Paid'
    WHEN LOWER(TRIM(payment_status)) = 'failed' THEN 'Failed'
    ELSE 'Unknown'
  END AS clean_payment_status
FROM dirty_orders;
```

## 8. Standardise product category

```sql
SELECT category,
  CASE
    WHEN LOWER(TRIM(category)) = 'electronics' THEN 'Electronics'
    WHEN LOWER(TRIM(category)) = 'books' THEN 'Books'
    ELSE 'Unknown'
  END AS clean_category
FROM dirty_products;
```

## 9. Convert product active flag

```sql
SELECT is_active,
  CASE
    WHEN LOWER(TRIM(is_active)) IN ('true', 'yes', 'y') THEN 'true'
    WHEN LOWER(TRIM(is_active)) IN ('false', 'no', 'n') THEN 'false'
    ELSE 'unknown'
  END AS clean_is_active
FROM dirty_products;
```

## 10. Standardise campaign channel

```sql
SELECT channel,
  CASE
    WHEN LOWER(TRIM(channel)) = 'search' THEN 'Search'
    WHEN LOWER(TRIM(channel)) = 'social' THEN 'Social'
    ELSE 'Unknown'
  END AS clean_channel
FROM dirty_campaigns;
```

## 11. Standardise campaign status

```sql
SELECT campaign_status,
  CASE
    WHEN LOWER(TRIM(campaign_status)) = 'active' THEN 'Active'
    WHEN LOWER(TRIM(campaign_status)) = 'paused' THEN 'Paused'
    ELSE 'Unknown'
  END AS clean_campaign_status
FROM dirty_campaigns;
```

## 12. Compare dirty vs clean country grouping

```sql
SELECT country, COUNT(*) AS total_rows
FROM dirty_customers
GROUP BY country;
```

Compare this with a grouped clean country query to see fewer, clearer groups.

## 13. Compare dirty vs clean payment status grouping

```sql
SELECT payment_status, COUNT(*) AS total_rows
FROM dirty_orders
GROUP BY payment_status;
```

Dirty statuses split metrics. Clean statuses make reporting clearer.

## 14. Build clean customer output for dashboard use

```sql
SELECT
  customer_id,
  TRIM(customer_name) AS clean_customer_name,
  LOWER(TRIM(email)) AS clean_email
FROM dirty_customers;
```

Expected result: Dashboard-friendly customer columns.
