# Beginner Summary

Day 012 builds directly on Day 011. In Day 011, you learned that `GROUP BY` creates summaries from many rows. For example, you can group orders by country and count how many orders each country has. You can also group campaign performance by channel and calculate total revenue for each channel. `GROUP BY` is useful because data engineers often need summaries instead of individual rows.

Day 012 adds a new SQL clause: `HAVING`. `HAVING` filters grouped results after aggregation. This is different from `WHERE`. `WHERE` filters individual rows before grouping happens. `HAVING` filters summary rows after groups and aggregate values have been created. This difference is one of the most important beginner SQL ideas.

For example, if you want to calculate paid sales by country, you can use `WHERE payment_status = 'Paid'` to keep only paid order rows before grouping. Then you can group by country and use `SUM(order_amount)`. If you only want to show countries where paid sales are above 1000, you use `HAVING SUM(order_amount) > 1000`. The `WHERE` clause controls which rows go into the calculation. The `HAVING` clause controls which summary groups appear after the calculation.

`HAVING` works with the same aggregation functions you learned in Day 011. With `COUNT`, it can find groups with high or low row counts. For example, `HAVING COUNT(*) > 5` can show countries with more than five orders or statuses with more than five records. With `SUM`, it can find groups where totals are high or low, such as countries with total sales above 1000 or dates with total sales below 100. With `AVG`, it can show groups where the average value crosses a threshold, such as countries with average order amount above 250. With `MIN` and `MAX`, it can help find unusual ranges, such as countries where the highest order amount is above 700 or the lowest order amount is below 20.

One very practical use of `GROUP BY` and `HAVING` is duplicate-style checking. If you group by `order_id` and use `HAVING COUNT(*) > 1`, SQL shows order IDs that appear more than once. This can help find duplicate-looking records. You can do something similar for emails by grouping customers by email and keeping only email values that appear more than once. However, repeated values are not always wrong. A repeated email might be allowed in some systems, so business context matters.

`HAVING` is also useful for status distribution checks. A data engineer can group orders by `payment_status` or `order_status` and keep statuses above a threshold. High failed payment counts, cancelled order counts, returned order counts, or blocked customer counts may indicate a real business issue, a source system issue, or a pipeline issue.

Daily summary checks are another common use. A table such as `daily_order_summary` can be grouped by date and country. `HAVING` can find date and country groups where total orders are zero, failed payments are unusually high, cancelled orders are high, or sales are unusually low. These checks help validate batch outputs and dashboard-ready summary tables.

There are two broad types of summary checks. Technical summary checks ask whether data arrived and loaded correctly. Examples include row counts, duplicate IDs, repeated keys, and latest date checks. Business summary checks ask whether business numbers look reasonable. Examples include sales by country, revenue by channel, failed payments, and cancelled orders.

Before Day 013, remember this simple rule: use `WHERE` for row-level filtering before aggregation, and use `HAVING` for group-level filtering after aggregation. Also remember that thresholds need business context. A number like `> 5` or `< 100` is only an example until a business rule explains why it matters.
