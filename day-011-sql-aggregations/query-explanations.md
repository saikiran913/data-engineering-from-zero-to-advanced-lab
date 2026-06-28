# Query Explanations for Day 011

## Counting Rows

`COUNT(*)` counts all rows returned by a query. In `SELECT COUNT(*) AS total_orders FROM orders;`, the purpose is to find how many order rows exist. The table used is `orders`, the aggregation used is `COUNT(*)`, and there is no grouping. The expected result is one number. Data engineers use this to check whether data loaded and whether row counts look reasonable.

## Counting Non-Null Values

`COUNT(column_name)` counts rows where the selected column has a value. In `SELECT COUNT(email) AS customers_with_email FROM customers;`, the purpose is to count customer rows that have an email. The table used is `customers`, the aggregation used is `COUNT(email)`, and there is no grouping. The expected result is one number showing available email values. This matters for data quality because important missing values can affect business processes.

## Adding Values with SUM

`SUM` adds numeric values. In `SELECT SUM(order_amount) AS total_order_amount FROM orders;`, the table used is `orders`, the aggregation is `SUM`, and the expected result is one total sales amount. Data engineers use totals for reporting, finance checks, and source-to-target comparisons.

## Calculating Averages with AVG

`AVG` calculates an average numeric value. In `SELECT AVG(order_amount) AS average_order_amount FROM orders;`, the table used is `orders`, the aggregation is `AVG`, and the expected result is one average order amount. A dashboard may show this as average order value. Use averages only when the value is meaningful to average.

## Finding Lowest and Highest Values with MIN and MAX

`MIN` finds the smallest value. `MAX` finds the largest value. In `orders`, `MIN(order_amount)` finds the lowest order amount and `MAX(order_amount)` finds the highest order amount. With dates, `MIN(order_date)` can show the earliest date and `MAX(order_date)` can show the latest date. Data engineers use this to check ranges and freshness.

## Multiple Aggregations in One Query

A summary query can return several metrics at once. The order summary query uses `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX` on the `orders` table. The expected result is one row with multiple summary columns. This matters because dashboards and validation reports often need several numbers from the same table.

## GROUP BY Basics

`GROUP BY` creates one summary per unique value in a grouping column. In `SELECT country, COUNT(*) AS total_orders FROM orders GROUP BY country;`, the table used is `orders`, the aggregation is `COUNT(*)`, and the grouping is `country`. The expected result is one row per country.

## GROUP BY with One Column

Day 011 uses one grouping column at a time. Examples include orders by `country`, orders by `order_status`, products by `category`, campaigns by `channel`, and daily summaries by date. Each query answers a clear business question, such as "How many orders are delivered?" or "Which channel has the most revenue?"

## WHERE Before GROUP BY

`WHERE` filters rows before aggregation. In `SELECT country, SUM(order_amount) AS paid_sales FROM orders WHERE payment_status = 'Paid' GROUP BY country;`, SQL first keeps only paid order rows. Then it groups those rows by country and sums the order amount. This matters because business rules decide which rows belong in a metric.

## ORDER BY Aggregated Results

`ORDER BY` sorts final summary results. In `SELECT country, SUM(order_amount) AS total_sales FROM orders GROUP BY country ORDER BY total_sales DESC;`, countries with higher sales appear first. Sorting helps analysts and dashboard users read the most important summaries quickly.

## Aggregations for Dashboards

Dashboard-ready summaries include total customers, orders by status, sales by country, campaign revenue by channel, and latest data date. The query purpose is usually to provide a metric, the table used depends on the business question, and the aggregation may be `COUNT`, `SUM`, `AVG`, `MIN`, or `MAX`.

## Aggregations for Data Quality

Aggregation supports row count checks, non-null checks, total amount checks, min/max range checks, latest date checks, and status distribution checks. For example, `MAX(order_date)` shows the latest order date, while `COUNT(*)` shows whether expected rows arrived. These checks help data engineers monitor pipelines and investigate unusual data changes.
