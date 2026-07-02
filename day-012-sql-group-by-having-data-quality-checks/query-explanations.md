# Query Explanations for Day 012

## GROUP BY Review

`GROUP BY` creates grouped summaries. The query purpose is to summarise data by a column such as `country`, `status`, `category`, `channel`, or date. The aggregation is usually `COUNT`, `SUM`, `AVG`, `MIN`, or `MAX`. The expected result is one row per group.

## What HAVING Does

`HAVING` filters grouped results. For example, a query can group orders by country, count orders in each country, and then keep only countries where `COUNT(*) > 5`. This matters because data engineers often need to focus only on groups that cross a threshold.

## HAVING with COUNT

`HAVING COUNT(*) > number` filters groups based on row counts. The table might be `orders`, `customers`, `products`, or `campaigns`. The expected result is only the groups where the count is high enough. This is useful for duplicate-style checks, status distribution checks, and high-volume group checks.

## HAVING with SUM

`HAVING SUM(numeric_column) > number` filters groups based on totals. In `orders`, this can find countries where total sales are above 1000. In `campaign_performance`, this can find channels where total revenue is high. This helps data engineers investigate high or low business metrics.

## HAVING with AVG

`HAVING AVG(numeric_column) > number` filters groups based on averages. This can find countries where average order amount is above 250 or categories where average product price is above 50. The expected result is only groups whose average crosses the threshold.

## HAVING with MIN and MAX

`HAVING MIN(column_name)` and `HAVING MAX(column_name)` filter groups by smallest or largest values. These are useful for range checks, unusual values, and freshness-style thinking. For example, a country where `MAX(order_amount) > 700` may have a high-value order that needs review.

## WHERE + GROUP BY + HAVING

`WHERE` filters source rows before grouping. `GROUP BY` creates summaries. `HAVING` filters those summaries. For paid sales by country above 1000, the query first keeps only paid orders, groups them by country, sums `order_amount`, and then keeps only country groups above 1000.

## Duplicate-Style Checks

Duplicate-style checks group by a key or important value and keep groups where `COUNT(*) > 1`. Example: group by `order_id` to find repeated order IDs. These results should be reviewed with business context because repeated-looking values are not always errors.

## Status Distribution Checks

Status distribution checks group by status columns such as `payment_status`, `order_status`, `customer_status`, or `campaign_status`. The aggregation is `COUNT(*)`. The `HAVING` condition can keep statuses above a threshold. This helps identify high failed, cancelled, blocked, or returned counts.

## Daily Summary Checks

The `daily_order_summary` table supports beginner data quality checks. Queries can find date and country groups where total orders are zero, failed payments are high, cancelled orders are high, or total sales are low. These checks help validate batch summary output.

## Multiple Grouping Columns

Multiple grouping columns create summaries for combinations. For example, grouping by `order_date` and `country` creates one result per date and country combination. This matters when one country may look normal overall but unusual on a specific date.

## ORDER BY with HAVING

After `HAVING` filters grouped results, `ORDER BY` can sort the remaining groups. Sorting by `total_sales DESC` or `total_revenue DESC` makes the largest remaining groups easiest to inspect.

## How Data Engineers Use These Queries

Data engineers use these queries for duplicate investigation, pipeline validation, summary checks, dashboard issue investigation, data freshness checks, high or low metric checks, and source-to-target investigation concepts. Each query has a purpose, table, aggregation, `HAVING` condition, expected result, and reason to matter in data engineering.
