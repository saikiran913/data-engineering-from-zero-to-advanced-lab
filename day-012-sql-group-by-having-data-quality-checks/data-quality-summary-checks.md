# Data Quality Summary Checks with GROUP BY and HAVING

## What is a Summary Check?

A summary check uses grouped counts, totals, averages, minimums, or maximums to understand whether data looks correct. Instead of checking every row manually, a data engineer checks summary patterns.

## Why Summary Checks Matter

Full row-by-row checks are useful, but they are not always enough. Summaries help quickly detect unusual patterns. Dashboards depend on correct summaries, and business users often notice issues at summary level first.

## Row Count by Date

Checking record counts by date helps confirm that daily data arrived.

```sql
SELECT order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;
```

## Finding Dates with Low or Zero Activity

`HAVING` can find groups where activity is unusually low.

```sql
SELECT summary_date, country, SUM(total_orders) AS orders_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(total_orders) = 0;
```

## Duplicate Key Checks

```sql
SELECT order_id, COUNT(*) AS record_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

This can reveal duplicate-looking order IDs. Duplicates should be reviewed with business context.

## Repeated Attribute Checks

```sql
SELECT email, COUNT(*) AS email_count
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

Repeated important values can be useful to investigate, especially when the business expects uniqueness.

## Status Count Checks

Checking `order_status` and `payment_status` counts helps identify unusual status patterns. Sudden high failed, refunded, cancelled, or returned counts may indicate source or business issues.

## Revenue and Sales Summary Checks

Data engineers often check totals by date, country, or channel:

- Country-level total sales.
- Channel-level revenue.
- Date-level sales.

## Failed Payment Checks

```sql
SELECT summary_date, country, SUM(failed_payments) AS failed_payment_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(failed_payments) > 5;
```

This flags groups where failed payments are above an example threshold.

## Cancelled Order Checks

```sql
SELECT summary_date, country, SUM(cancelled_orders) AS cancelled_order_count
FROM daily_order_summary
GROUP BY summary_date, country
HAVING SUM(cancelled_orders) > 3;
```

This helps identify high cancellation patterns.

## Freshness-Style Summary Checks

Day 011 introduced `MAX`. A basic freshness check can use the latest date in a table.

```sql
SELECT MAX(order_date) AS latest_order_date
FROM orders;
```

Future lessons will expand freshness checks.

## Thresholds Need Business Context

Thresholds such as `> 5` or `< 100` are examples only. In real work, thresholds should be defined using business understanding, expected volumes, seasonality, and pipeline rules.

## Warning vs Failure

| Check | Warning Example | Failure Example |
| --- | --- | --- |
| Row count | Lower than usual | Zero rows when data is required |
| Failed payments | Slightly high | Much higher than allowed |
| Duplicate ID | One repeated ID | Many repeated required-unique IDs |
| Latest date | One day late | Several days late |
| Sales total | Lower than usual | Missing or near zero unexpectedly |

## Summary Check Documentation

Data engineers should document:

- Check name.
- Table checked.
- Columns checked.
- Aggregation used.
- Threshold.
- Expected behaviour.
- Action if failed.
- Owner or team to contact.

## Beginner Summary Check Checklist

- Count records by date.
- Count records by status.
- Check duplicate IDs.
- Check repeated important values.
- Sum important amounts.
- Compare totals with expectations.
- Check min and max values.
- Check latest date.
- Check zero-activity groups.
- Check unusually high or low groups.
- Document checks and thresholds.
