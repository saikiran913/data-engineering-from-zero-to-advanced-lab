# Real-World Examples

Each example uses beginner SQL date practice patterns.

## 1. Monthly Paid Sales Report

Business situation: finance wants monthly paid sales.

Table used: `orders`

Date or period column used: `order_date`

SQL date concept used: monthly grouping

```sql
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS paid_sales
FROM orders
WHERE payment_status = 'Paid'
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY order_year, order_month;
```

Expected result: paid sales per month.

Why a data engineer may use it: monthly sales dashboards need this metric.

Common mistake to avoid: grouping by month without year.

## 2. Monthly Orders by Country

Business situation: leaders want order counts by country and month.

Table used: `orders`

Date or period column used: `order_date`

SQL date concept used: country-month grain

```sql
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, COUNT(*) AS total_orders
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country
ORDER BY order_year, order_month, country;
```

Expected result: one row per year, month, and country.

Why a data engineer may use it: country-month reporting supports regional reviews.

Common mistake to avoid: mixing daily and monthly grain.

## 3. Monthly Campaign Revenue by Channel

Business situation: marketing wants revenue by channel.

Table used: `campaign_performance`

Date or period column used: `performance_date`

SQL date concept used: channel-month reporting

```sql
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(revenue) AS total_revenue
FROM campaign_performance
GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel
ORDER BY performance_year, performance_month, channel;
```

Expected result: monthly revenue by channel.

Why a data engineer may use it: channel dashboards need consistent period logic.

Common mistake to avoid: using the wrong date column.

## 4. Monthly Campaign Cost by Country

Business situation: marketing spend needs country-level review.

Table used: `campaign_performance`

Date or period column used: `performance_date`

SQL date concept used: monthly cost summary

```sql
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, country, SUM(cost) AS total_cost
FROM campaign_performance
GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), country
ORDER BY performance_year, performance_month, country;
```

Expected result: monthly cost by country.

Why a data engineer may use it: it helps spot unusual spend.

Common mistake to avoid: treating high cost as wrong without context.

## 5. Monthly Website Purchases

Business situation: product teams want monthly purchase activity.

Table used: `website_events`

Date or period column used: `event_date`

SQL date concept used: monthly event filter

```sql
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS purchases
FROM website_events
WHERE event_type = 'purchase'
GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date)
ORDER BY event_year, event_month;
```

Expected result: monthly purchase counts.

Why a data engineer may use it: product activity reports often track purchases.

Common mistake to avoid: grouping by timestamp instead of event date.

## 6. June vs July Sales Comparison

Business situation: finance wants to compare two months.

Table used: `orders`

Date or period column used: `order_date`

SQL date concept used: fixed period comparison

```sql
SELECT SUM(order_amount) AS june_paid_sales
FROM orders
WHERE payment_status = 'Paid'
AND order_date >= '2026-06-01'
AND order_date < '2026-07-01';
```

Expected result: June paid sales. Run a similar July query and compare manually.

Why a data engineer may use it: manual comparison is a safe beginner step.

Common mistake to avoid: comparing incomplete July with complete June without context.

## 7. June vs July Campaign Cost Comparison

Business situation: marketing wants to compare cost across months.

Table used: `campaign_performance`

Date or period column used: `performance_date`

SQL date concept used: one-month filters

```sql
SELECT SUM(cost) AS june_campaign_cost
FROM campaign_performance
WHERE performance_date >= '2026-06-01'
AND performance_date < '2026-07-01';
```

Expected result: June campaign cost.

Why a data engineer may use it: campaign cost changes need review.

Common mistake to avoid: using different period definitions for each query.

## 8. Latest Daily Sales Summary Freshness Check

Business situation: a dashboard may be stale.

Table used: `daily_sales_summary`

Date or period column used: `summary_date`

SQL date concept used: latest date check

```sql
SELECT MAX(summary_date) AS latest_summary_date
FROM daily_sales_summary;
```

Expected result: latest daily summary date.

Why a data engineer may use it: freshness checks protect dashboard trust.

Common mistake to avoid: assuming the dashboard is fresh because it opens.

## 9. Monthly Sales Summary Duplicate Check

Business situation: one country-month should have one row.

Table used: `monthly_sales_summary`

Date or period column used: `summary_year`, `summary_month`

SQL date concept used: duplicate summary check

```sql
SELECT summary_year, summary_month, country, COUNT(*) AS row_count
FROM monthly_sales_summary
GROUP BY summary_year, summary_month, country
HAVING COUNT(*) > 1;
```

Expected result: duplicate-looking country-month rows.

Why a data engineer may use it: duplicates can inflate totals.

Common mistake to avoid: not checking summary grain.

## 10. Monthly Campaign Summary Duplicate Check

Business situation: one channel-country-month should have one row.

Table used: `monthly_campaign_summary`

Date or period column used: `summary_year`, `summary_month`

SQL date concept used: duplicate campaign summary check

```sql
SELECT summary_year, summary_month, channel, country, COUNT(*) AS row_count
FROM monthly_campaign_summary
GROUP BY summary_year, summary_month, channel, country
HAVING COUNT(*) > 1;
```

Expected result: duplicate-looking campaign summary rows.

Why a data engineer may use it: duplicates can mislead marketing dashboards.

Common mistake to avoid: checking only year and month without channel and country.

## 11. Failed Monthly Pipeline Run Investigation

Business situation: the monthly dashboard did not refresh.

Table used: `pipeline_runs`

Date or period column used: `run_date`

SQL date concept used: pipeline status check

```sql
SELECT *
FROM pipeline_runs
WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build')
AND status = 'Failed';
```

Expected result: failed monthly pipeline runs.

Why a data engineer may use it: failed runs often explain stale summaries.

Common mistake to avoid: checking summary tables but ignoring pipeline status.

## 12. Zero-Order Monthly Summary Investigation

Business situation: one country-month shows zero orders.

Table used: `monthly_sales_summary`

Date or period column used: `summary_year`, `summary_month`

SQL date concept used: zero-activity check

```sql
SELECT *
FROM monthly_sales_summary
WHERE total_orders = 0;
```

Expected result: rows with zero monthly orders.

Why a data engineer may use it: zero activity can be normal or suspicious.

Common mistake to avoid: deciding without business context.

## 13. Low Monthly Sales Investigation

Business situation: a dashboard shows unusually low sales.

Table used: `monthly_sales_summary`

Date or period column used: `summary_year`, `summary_month`

SQL date concept used: low-total check

```sql
SELECT *
FROM monthly_sales_summary
WHERE total_sales < 100;
```

Expected result: low monthly sales rows.

Why a data engineer may use it: low totals may signal missing data.

Common mistake to avoid: using a threshold without context.

## 14. Incomplete Month Comparison Warning

Business situation: July looks lower than June, but July is still in progress.

Table used: any monthly reporting table.

Date or period column used: report period columns.

SQL date concept used: period completeness check

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

Expected result: latest date available for the current period.

Why a data engineer may use it: incomplete months should not be compared blindly with complete months.

Common mistake to avoid: treating incomplete-period performance as final.
