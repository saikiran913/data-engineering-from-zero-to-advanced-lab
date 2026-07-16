# Practice Questions

## Section 1: Simple Questions

1. What is monthly reporting?
2. How is daily reporting different from monthly reporting?
3. Why should year and month be grouped together?
4. What does a one-month date filter do?
5. What does start-inclusive and end-exclusive mean?
6. What is a period comparison?
7. Which function can find the latest date?
8. What is a zero-activity check?
9. Why can duplicate summary rows be a problem?
10. Why should monthly pipeline freshness be checked?
11. Why can comparing a complete month with an incomplete month be misleading?
12. Why do thresholds need business context?

## Section 2: Identify the Reporting Grain

Choose daily, monthly, country-month, channel-month, or date-country.

1. Sales by `order_date`
2. Sales by order year and month
3. Campaign revenue by month and channel
4. Daily sales summary by date and country
5. Monthly sales summary by year, month, and country
6. Website events by `event_date`
7. Monthly events by `event_type`
8. Failed payments by `summary_date` and country
9. Campaign cost by month and country
10. Pipeline runs by `run_date`
11. Monthly campaign summary by channel and country
12. Orders by `order_date` and country

## Section 3: Choose the Correct Query

1. Monthly sales by year and month:
   - A: `SELECT EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), SUM(order_amount) FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);`
   - B: `SELECT order_date, order_amount FROM orders;`

2. Monthly paid sales by country:
   - A: `SELECT EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country, SUM(order_amount) FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country;`
   - B: `SELECT country FROM orders;`

3. One fixed month filter:
   - A: `WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01'`
   - B: `WHERE order_date = '2026-06-01'`

4. June sales query:
   - A: `SELECT SUM(order_amount) FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';`
   - B: `SELECT SUM(order_amount) FROM orders WHERE order_date >= '2026-07-01';`

5. July sales query:
   - A: `SELECT SUM(order_amount) FROM orders WHERE order_date >= '2026-07-01' AND order_date < '2026-08-01';`
   - B: `SELECT SUM(order_amount) FROM orders WHERE order_date < '2026-07-01';`

6. Monthly campaign revenue by channel:
   - A: `SELECT EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel, SUM(revenue) FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel;`
   - B: `SELECT channel, revenue FROM campaign_performance;`

7. Latest daily summary date:
   - A: `SELECT MAX(summary_date) FROM daily_sales_summary;`
   - B: `SELECT MIN(summary_date) FROM daily_sales_summary;`

8. Failed monthly pipeline runs:
   - A: `SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND status = 'Failed';`
   - B: `SELECT * FROM pipeline_runs WHERE status = 'Success';`

9. Zero-order monthly summary rows:
   - A: `SELECT * FROM monthly_sales_summary WHERE total_orders = 0;`
   - B: `SELECT * FROM monthly_sales_summary WHERE total_orders > 0;`

10. Duplicate monthly sales summary rows:
    - A: `SELECT summary_year, summary_month, country, COUNT(*) FROM monthly_sales_summary GROUP BY summary_year, summary_month, country HAVING COUNT(*) > 1;`
    - B: `SELECT * FROM monthly_sales_summary;`

11. Low monthly sales rows:
    - A: `SELECT * FROM monthly_sales_summary WHERE total_sales < 100;`
    - B: `SELECT * FROM monthly_sales_summary WHERE total_sales > 100;`

12. Monthly website purchase count:
    - A: `SELECT EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date), COUNT(*) FROM website_events WHERE event_type = 'purchase' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date);`
    - B: `SELECT event_timestamp FROM website_events;`

## Section 4: Write Monthly Reporting Queries

Write SQL to:

1. Create monthly order count.
2. Create monthly paid sales.
3. Create monthly sales by country.
4. Create monthly failed payments.
5. Create monthly campaign cost.
6. Create monthly campaign revenue.
7. Create monthly campaign revenue by channel.
8. Create monthly website events.
9. Create monthly website purchases.
10. Filter orders for one fixed month.
11. Filter campaigns for one fixed month.
12. Find latest order date.
13. Find latest monthly sales summary period.
14. Find failed monthly pipeline runs.
15. Find zero-order monthly summary rows.

## Section 5: Spot the Mistake

1. Grouping by month but not year.
2. Using `event_date` for monthly order sales.
3. Comparing incomplete July with complete June without saying July is incomplete.
4. Using `BETWEEN` carelessly for timestamp-style data.
5. Ignoring a failed monthly summary pipeline.
6. Not checking the latest summary date.
7. Treating zero orders as always wrong.
8. Not checking duplicate summary rows.
9. Using a low-sales threshold without business context.
10. Assuming every SQL platform supports the same date functions.
11. Mixing daily rows with monthly rows in one total without understanding grain.
12. Comparing raw data with a summary table without matching definitions.

## Section 6: Date-Based Quality Investigation

Choose the check you would use:

1. Monthly dashboard is stale.
2. Latest monthly summary is missing.
3. Monthly pipeline failed.
4. One country has zero orders.
5. Monthly failed payments are high.
6. Campaign cost is high and revenue is low.
7. Monthly campaign summary has duplicate rows.
8. July sales look lower but July is incomplete.
9. Website purchases dropped.
10. One date is missing from daily summary.

## Section 7: Think Like a Data Engineer

1. Which reporting period is needed?
2. Which date column should be used?
3. Which columns define the reporting grain?
4. Which quality checks should run before sharing the report?
5. Which freshness checks prove the report is current?
6. Is the period complete enough to compare?
7. What threshold needs business agreement?
8. Which dashboard would be affected if the monthly summary is stale?

## Section 8: Mini Assignment

Imagine you are validating a monthly business dashboard. Write or describe checks to:

1. create monthly paid sales
2. create monthly sales by country
3. create monthly campaign revenue by channel
4. create monthly website purchases
5. compare two fixed months manually
6. check latest daily summary date
7. check latest monthly summary period
8. find failed monthly pipeline runs
9. find zero-order monthly summary rows
10. find duplicate monthly sales summary rows
11. find duplicate monthly campaign summary rows
12. explain why incomplete period comparison can mislead

## Answer Key

### Section 1

1. Monthly reporting summarises activity by month.
2. Daily reporting is per day; monthly reporting is per month.
3. Month alone can mix different years.
4. It returns rows for one month.
5. Include the start date and exclude the next period start.
6. Comparing one time period with another.
7. `MAX`.
8. A check for rows with zero activity.
9. They can inflate totals.
10. Failed or old monthly pipelines can make dashboards stale.
11. The incomplete month has fewer days of data.
12. Numbers need business meaning before they are judged.

### Section 2

1. Daily
2. Monthly
3. Channel-month
4. Date-country
5. Country-month
6. Daily
7. Monthly
8. Date-country
9. Country-month
10. Daily
11. Channel-month
12. Date-country

### Section 3

1. A
2. A
3. A
4. A
5. A
6. A
7. A
8. A
9. A
10. A
11. A
12. A

### Section 4 Sample Answers

```sql
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS total_orders FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, country, SUM(order_amount) AS total_sales FROM orders GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), country;
SELECT EXTRACT(YEAR FROM order_date) AS order_year, EXTRACT(MONTH FROM order_date) AS order_month, COUNT(*) AS failed_payments FROM orders WHERE payment_status = 'Failed' GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date);
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(cost) AS total_cost FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date);
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date);
SELECT EXTRACT(YEAR FROM performance_date) AS performance_year, EXTRACT(MONTH FROM performance_date) AS performance_month, channel, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY EXTRACT(YEAR FROM performance_date), EXTRACT(MONTH FROM performance_date), channel;
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS total_events FROM website_events GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date);
SELECT EXTRACT(YEAR FROM event_date) AS event_year, EXTRACT(MONTH FROM event_date) AS event_month, COUNT(*) AS purchases FROM website_events WHERE event_type = 'purchase' GROUP BY EXTRACT(YEAR FROM event_date), EXTRACT(MONTH FROM event_date);
SELECT * FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';
SELECT * FROM campaign_performance WHERE performance_date >= '2026-06-01' AND performance_date < '2026-07-01';
SELECT MAX(order_date) AS latest_order_date FROM orders;
SELECT MAX(summary_year) AS latest_summary_year, MAX(summary_month) AS latest_summary_month FROM monthly_sales_summary;
SELECT * FROM pipeline_runs WHERE pipeline_name IN ('monthly_sales_summary_build', 'monthly_campaign_summary_build') AND status = 'Failed';
SELECT * FROM monthly_sales_summary WHERE total_orders = 0;
```

### Section 5

1. Month alone can mix years.
2. Use `order_date` for order sales.
3. Incomplete periods can mislead.
4. Timestamp-style filtering needs care.
5. Failed pipelines can explain stale reports.
6. Latest date checks are needed for freshness.
7. Zero can be normal or suspicious.
8. Duplicate summary rows can inflate totals.
9. Thresholds need business context.
10. Date syntax varies by platform.
11. Grain must be understood.
12. Definitions must match before comparing.
