# Query Explanations

## Window-Function Concept

Business question: how can records be ranked without losing detail? Window functions keep each input row visible and add a calculated ranking column.

## ROW_NUMBER

Use `ROW_NUMBER` when exactly one row should be selected. It always creates unique sequence numbers, so tied values still receive different row numbers.

## RANK

Use `RANK` when tied rows should share the same rank and gaps after ties are acceptable.

## DENSE_RANK

Use `DENSE_RANK` when tied rows should share the same rank and rank numbers should not skip.

## Partitioned Ranking

Partition columns define where ranking restarts. For example, `PARTITION BY category` ranks products separately inside each category.

## Global Ranking

Global ranking has no `PARTITION BY`. All eligible rows are ranked together.

## Top-Per-Group

Use a CTE to calculate ranks, then filter `rank_value = 1`. Use `RANK` to preserve all tied top rows or `ROW_NUMBER` to select one documented winner.

## Bottom-Per-Group

Use ascending window ordering when lowest values should be ranked first.

## Ranking After Aggregation

First aggregate to the correct grain, then rank the aggregate result. This avoids ranking raw rows when the business question is about totals.

## CTE Product Ranking Example

```sql
WITH ranked_products AS (
    SELECT
        product_id,
        category,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM product_sales
    WHERE total_sales IS NOT NULL
)
SELECT
    product_id,
    category,
    total_sales,
    sales_rank
FROM ranked_products
WHERE sales_rank = 1;
```

The CTE reads product rows, partitions by category, orders by sales descending, and assigns `sales_rank`. The final query filters rank 1 safely. Validation should check ties, nulls, partition counts, and output grain.

| Function | Ties Share Value? | Gaps After Ties? | Exactly One Row Guaranteed? |
| --- | --- | --- | --- |
| `ROW_NUMBER` | No | No | Yes, with a partition and filter |
| `RANK` | Yes | Yes | No |
| `DENSE_RANK` | Yes | No | No |
