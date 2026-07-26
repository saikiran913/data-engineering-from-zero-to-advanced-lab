# Query Explanations

## LAG

Business question: what was the previous value in this sequence? `LAG` looks backward inside the partition and returns `NULL` for the first row unless a default value is supplied.

## LEAD

Business question: what is the next value in this sequence? `LEAD` looks forward and returns `NULL` for the last row unless a default value is supplied.

## Partitioned Comparisons

Partition keys such as `region`, `product_id`, or `transaction_id` create independent sequences. Without the right partition, unrelated rows may be compared.

## Current Versus Previous Values

Use `current_value - previous_value` for simple differences. Null previous values produce null differences.

## Percentage Change

Use `CASE` to avoid division by zero and null previous values.

## Status-Change Detection

Compare current status to previous status and label first rows separately.

## Date-Gap Detection

Use `LAG(date_column)` and compare the current date to the previous date. Date-difference syntax varies by platform.

## Sequence-Gap Detection

Use `event_sequence - previous_sequence`. A difference of 1 is usually expected, 0 suggests a duplicate sequence, and values above 1 suggest a gap.

## First and Last Row Detection

`LAG` returning `NULL` identifies the first row. `LEAD` returning `NULL` identifies the last row.

## Line-by-Line Example

```sql
WITH sales_comparison AS (
    SELECT
        sale_date,
        region,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY region
            ORDER BY sale_date
        ) AS previous_sales
    FROM daily_sales_history
)
SELECT
    sale_date,
    region,
    total_sales,
    previous_sales,
    total_sales - previous_sales AS sales_change
FROM sales_comparison;
```

The CTE creates one comparison row per region and sale date. `LAG(total_sales)` gets the previous sales value within each region. The final query calculates the difference.

| Function | Direction | Boundary With No Neighbour | Common Use |
| --- | --- | --- | --- |
| `LAG` | Backward | First row | Previous value, change from prior row |
| `LEAD` | Forward | Last row | Next status, next event, final row checks |
