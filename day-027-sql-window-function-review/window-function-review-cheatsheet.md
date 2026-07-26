# Day 027 Window Function Review Cheatsheet

## Choose by Business Question

| Need | Use |
|---|---|
| Exactly one row per group | `ROW_NUMBER` |
| All tied rows with rank gaps | `RANK` |
| All tied rows without rank gaps | `DENSE_RANK` |
| Previous row value | `LAG` |
| Next row value | `LEAD` |
| Total so far | `SUM OVER` with cumulative frame |
| Count so far | `COUNT OVER` with cumulative frame |
| Recent-row average | `AVG OVER` with moving frame |

## Ranking Pattern

```sql
WITH ranked_rows AS (
    SELECT
        country,
        customer_id,
        total_spend,
        ROW_NUMBER() OVER (
            PARTITION BY country
            ORDER BY total_spend DESC, customer_id
        ) AS country_row_number
    FROM customer_activity_metrics
)
SELECT
    country,
    customer_id,
    total_spend,
    country_row_number
FROM ranked_rows
WHERE country_row_number = 1;
```

## Previous-Row Pattern

```sql
SELECT
    campaign_id,
    metric_date,
    conversions,
    LAG(conversions) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date
    ) AS previous_conversions
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;
```

## Running-Total Pattern

```sql
SELECT
    region,
    sale_date,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY region
        ORDER BY sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_sales
FROM regional_sales_history
ORDER BY region, sale_date;
```

## Moving-Average Pattern

```sql
SELECT
    campaign_id,
    metric_date,
    spend,
    AVG(spend) OVER (
        PARTITION BY campaign_id
        ORDER BY metric_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_row_moving_spend_avg
FROM campaign_metrics_history
ORDER BY campaign_id, metric_date;
```

## Review Checklist

- Define source grain.
- Define output grain.
- Choose the partition.
- Choose the ordering.
- Decide how ties should behave.
- Decide how first or last rows should behave.
- Use explicit `ROWS` frames for cumulative and moving metrics.
- Filter window aliases in a later CTE step.
- Validate source counts, nulls, duplicate ordering values, boundary rows, and final cumulative totals.

## Key Reminder

The correct window function depends on the business question, data grain, partition, ordering, tie policy, and frame. Syntax alone is not enough.
