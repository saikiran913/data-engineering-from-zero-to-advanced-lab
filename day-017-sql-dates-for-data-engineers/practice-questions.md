# Practice Questions

## Section 1: Simple Questions

1. What is a date?
2. What is a datetime?
3. What is a timestamp?
4. What does a date filter do?
5. What is a date range?
6. Does `BETWEEN` usually include boundary dates?
7. What does the `>=` and `<` pattern mean in date filtering?
8. Which `ORDER BY` direction shows newest dates first?
9. Which aggregate function finds the latest date?
10. What does data freshness mean?
11. What is daily reporting?
12. What is the difference between event date and load date?

## Section 2: Identify the Date Column

Choose the best date column.

1. Daily order sales
2. Customer signup trend
3. Campaign daily reporting
4. Website event activity
5. Pipeline monitoring
6. Source file freshness
7. Dashboard summary date
8. Order exact timestamp investigation
9. Pipeline completion time
10. Latest website event check
11. Monthly campaign reporting
12. Failed pipeline run analysis
13. Customer acquisition month
14. Paid sales by order date
15. Event activity by timestamp

## Section 3: Choose the Correct Query

1. Orders on one date:
   - A: `SELECT * FROM orders WHERE order_date = '2026-06-15';`
   - B: `SELECT * FROM orders ORDER BY order_date;`

2. Orders between two dates:
   - A: `SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';`
   - B: `SELECT * FROM orders WHERE country = 'UK';`

3. June orders using `>=` and `<`:
   - A: `SELECT * FROM orders WHERE order_date >= '2026-06-01' AND order_date < '2026-07-01';`
   - B: `SELECT * FROM orders WHERE order_date > '2026-07-01';`

4. Newest orders first:
   - A: `SELECT * FROM orders ORDER BY order_date DESC;`
   - B: `SELECT * FROM orders ORDER BY order_date ASC;`

5. Latest order date:
   - A: `SELECT MAX(order_date) AS latest_order_date FROM orders;`
   - B: `SELECT MIN(order_date) AS latest_order_date FROM orders;`

6. Earliest campaign performance date:
   - A: `SELECT MIN(performance_date) AS earliest_performance_date FROM campaign_performance;`
   - B: `SELECT MAX(performance_date) AS earliest_performance_date FROM campaign_performance;`

7. Daily sales summary:
   - A: `SELECT order_date, SUM(order_amount) AS total_sales FROM orders GROUP BY order_date ORDER BY order_date;`
   - B: `SELECT order_amount FROM orders;`

8. Daily campaign revenue:
   - A: `SELECT performance_date, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;`
   - B: `SELECT revenue FROM campaign_performance;`

9. Website events by event type and date:
   - A: `SELECT event_date, event_type, COUNT(*) AS total_events FROM website_events GROUP BY event_date, event_type ORDER BY event_date, event_type;`
   - B: `SELECT event_timestamp FROM website_events;`

10. Failed pipeline runs:
    - A: `SELECT * FROM pipeline_runs WHERE status = 'Failed';`
    - B: `SELECT * FROM pipeline_runs WHERE status = 'Success';`

11. Latest run date by pipeline:
    - A: `SELECT pipeline_name, MAX(run_date) AS latest_run_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;`
    - B: `SELECT MAX(run_date) AS latest_run_date FROM pipeline_runs;`

12. Zero-order daily summary rows:
    - A: `SELECT * FROM daily_sales_summary WHERE total_orders = 0;`
    - B: `SELECT * FROM daily_sales_summary WHERE total_orders > 0;`

## Section 4: Write Date Queries

Write SQL to:

1. Find orders on a specific date.
2. Find orders in a date range.
3. Find paid orders in a date range.
4. Sort orders newest first.
5. Find latest order date.
6. Find earliest order date.
7. Count orders by `order_date`.
8. Calculate sales by `order_date`.
9. Calculate campaign revenue by `performance_date`.
10. Count website events by `event_date`.
11. Count website events by `event_date` and `event_type`.
12. Find latest `run_date` by `pipeline_name`.
13. Find failed pipeline runs.
14. Find daily summaries with zero orders.
15. Find rows with missing `order_date`.

## Section 5: Spot the Mistake

1. `SELECT * FROM orders WHERE order_date = 2026-06-15;`
2. `SELECT event_timestamp, COUNT(*) FROM website_events GROUP BY event_timestamp;`
3. `SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';` but the learner thinks June 30 is excluded.
4. `SELECT * FROM website_events WHERE event_timestamp = '2026-06-15';`
5. `SELECT * FROM orders ORDER BY order_date ASC;` when newest orders are needed.
6. `SELECT MAX(order_date) FROM orders;` when checking pipeline run freshness.
7. `SELECT * FROM pipeline_runs WHERE status = 'Success';` when failed runs need review.
8. Opening a dashboard and assuming the data is fresh without checking `MAX(summary_date)`.
9. Treating zero records processed as always fine.
10. Writing `EXTRACT(MONTH FROM order_date)` without checking whether the SQL platform supports it.
11. Comparing a text date without understanding how the source stores dates.
12. Using `signup_date` for daily order sales.

## Section 6: Freshness Investigation

Which check would you use?

1. A dashboard shows old data.
2. A pipeline failed yesterday.
3. Latest campaign date is last week.
4. Orders table has future dates.
5. Source file date is missing.
6. Records processed is zero.
7. Website events stopped arriving.
8. Daily summary has a missing-looking date.
9. One country has an older latest date than others.
10. `completed_at` is blank.

## Section 7: Think Like a Data Engineer

1. Which date column should be used for daily order sales?
2. Is filtering or grouping needed for a daily sales report?
3. When should a freshness check be used?
4. When should latest date be checked by group?
5. Is zero records processed always a failure?
6. What business report is affected if `daily_sales_summary` is stale?

## Section 8: Mini Assignment

Imagine you are validating a daily data refresh. Write or describe checks to:

1. find latest order date
2. find latest campaign performance date
3. find latest website event date
4. find latest pipeline run date by pipeline
5. find failed pipeline runs
6. find zero-record pipeline runs
7. create daily sales summary
8. create daily campaign performance summary
9. create daily website event summary
10. find daily sales summary rows with zero orders
11. find future-looking order dates
12. explain event date vs load/run date

## Answer Key

### Section 1

1. A calendar day.
2. A date and time together.
3. A precise point in time.
4. It keeps rows matching a date condition.
5. A start and end period.
6. Yes, usually.
7. Include the start date and stop before the end date.
8. `DESC`.
9. `MAX`.
10. How up-to-date data is.
11. Summarising activity for each day.
12. Event date is when activity happened; load date is when data was processed.

### Section 2

1. `order_date`
2. `signup_date`
3. `performance_date`
4. `event_date`
5. `run_date` or `run_timestamp`
6. `source_file_date`
7. `summary_date`
8. `order_datetime`
9. `completed_at`
10. `event_date`
11. `performance_date`
12. `run_date`
13. `signup_date`
14. `order_date`
15. `event_timestamp`

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
SELECT * FROM orders WHERE order_date = '2026-06-15';
SELECT * FROM orders WHERE order_date BETWEEN '2026-06-01' AND '2026-06-30';
SELECT * FROM orders WHERE payment_status = 'Paid' AND order_date BETWEEN '2026-06-01' AND '2026-06-30';
SELECT * FROM orders ORDER BY order_date DESC;
SELECT MAX(order_date) AS latest_order_date FROM orders;
SELECT MIN(order_date) AS earliest_order_date FROM orders;
SELECT order_date, COUNT(*) AS total_orders FROM orders GROUP BY order_date ORDER BY order_date;
SELECT order_date, SUM(order_amount) AS total_sales FROM orders GROUP BY order_date ORDER BY order_date;
SELECT performance_date, SUM(revenue) AS total_revenue FROM campaign_performance GROUP BY performance_date ORDER BY performance_date;
SELECT event_date, COUNT(*) AS total_events FROM website_events GROUP BY event_date ORDER BY event_date;
SELECT event_date, event_type, COUNT(*) AS total_events FROM website_events GROUP BY event_date, event_type ORDER BY event_date, event_type;
SELECT pipeline_name, MAX(run_date) AS latest_run_date FROM pipeline_runs GROUP BY pipeline_name ORDER BY pipeline_name;
SELECT * FROM pipeline_runs WHERE status = 'Failed';
SELECT * FROM daily_sales_summary WHERE total_orders = 0;
SELECT * FROM orders WHERE order_date IS NULL;
```

### Section 5

1. Date value should be quoted or written in the correct date literal format for the platform.
2. Daily reports should usually group by `event_date`, not exact timestamp.
3. `BETWEEN` usually includes the end date.
4. Timestamp filtering needs care; an exact date may not match timestamp values.
5. `ASC` shows oldest first.
6. Pipeline freshness should use pipeline run dates.
7. Failed runs need `status = 'Failed'`.
8. A dashboard can open while showing stale data.
9. Zero records may be normal or a warning depending on context.
10. Date function syntax varies by platform.
11. Text dates can behave unexpectedly.
12. Daily order sales should use `order_date`.
