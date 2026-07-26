# Day 025 LAG and LEAD Cheatsheet

## Basic LAG

```sql
LAG(value_column) OVER (
    ORDER BY ordering_column
) AS previous_value
```

## Basic LEAD

```sql
LEAD(value_column) OVER (
    ORDER BY ordering_column
) AS next_value
```

## Partitioned LAG

```sql
LAG(total_sales) OVER (
    PARTITION BY region
    ORDER BY sale_date
) AS previous_sales
```

## Offset 2

```sql
LAG(unit_price, 2) OVER (
    PARTITION BY product_id
    ORDER BY price_date
) AS price_two_rows_back
```

## Default Value

```sql
LAG(total_sales, 1, 0) OVER (
    PARTITION BY region
    ORDER BY sale_date
) AS previous_sales_defaulted
```

Use defaults carefully because they can hide missing history.

## Safe Percentage Change

```sql
CASE
    WHEN previous_value IS NULL THEN NULL
    WHEN previous_value = 0 THEN NULL
    ELSE (current_value - previous_value) * 100.0 / previous_value
END
```

## Validation Checklist

- Confirm grain.
- Confirm partition.
- Confirm ordering.
- Add tie-breaker when needed.
- Review boundary nulls.
- Avoid blind default values.
- Avoid division by zero.
- Check duplicate timestamps.
- Validate final output.
