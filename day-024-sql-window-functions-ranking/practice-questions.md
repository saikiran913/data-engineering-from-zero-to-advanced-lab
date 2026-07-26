# Practice Questions

## Section A: Concept Checks

1. What does a window function do?
2. How is a window function different from `GROUP BY`?
3. What does `OVER` define?
4. What does `PARTITION BY` do?
5. Which `ORDER BY` controls ranking?
6. What does `ROW_NUMBER` do with ties?
7. What does `RANK` do with ties?
8. Why can `RANK` skip numbers?
9. What does `DENSE_RANK` do with ties?
10. When should `ROW_NUMBER` be considered?
11. When should tied rows be preserved?
12. Why should null ranking values be reviewed?
13. Why can top three ranks return more than three rows?
14. Why does data grain matter?
15. Why should rank 1 be validated?

## Section B: Predict the Ranking

Calculate `ROW_NUMBER`, `RANK`, and `DENSE_RANK`.

1. `100, 90, 80`
2. `100, 90, 90, 80`
3. `100, 100, 90, 90, 70`
4. Ascending: `10, 20, 20, 30`
5. Group A: `50, 40`; Group B: `90, 90, 80`
6. `500, 500, 500`
7. `300, 200, 100, 100`
8. Ascending: `5, 5, 10`
9. Group UK: `2400, 2400, 800`
10. Group Data: `95, 90, 90, 78`

## Section C: Complete the SQL

1. Rank employees within department.
2. Rank customers within country.
3. Rank products within category.
4. Return tied top campaigns.
5. Return exactly one row per region.
6. Find bottom-ranked sales days.
7. Return top three dense employee levels.
8. Rank after aggregating customer totals.
9. Review null ranking values.
10. Detect tied product sales.

## Section D: Choose the Function

1. Exactly one top customer per country.
2. All tied top products per category.
3. Dense leaderboard of employee scores.
4. Competition ranking with skipped numbers.
5. One current record per key.
6. Top three performance levels.
7. Preserve tied lowest sales days.
8. Choose one campaign using documented tie-breakers.
9. Show all tied conversion leaders.
10. Rank product-period revenue levels without gaps.

## Section E: Fix the Mistake

1. Ranking raw order rows when the question asks for customer totals.
2. Forgetting `PARTITION BY country`.
3. Using `ORDER BY total_sales ASC` for top customers.
4. Filtering `rank_value` in the same query level.
5. Using `ROW_NUMBER` when ties must remain.
6. Using `RANK` when exactly one row is required.
7. Ignoring null total sales.
8. Adding arbitrary tie-breakers to `RANK`.
9. Assuming top three ranks returns exactly three rows.
10. Not counting partitions before ranking.

## Answer Key

Section A: Window functions calculate per-row values without collapsing rows. `OVER` defines the window, `PARTITION BY` creates groups, and window `ORDER BY` controls ranking. `ROW_NUMBER` makes unique numbers, `RANK` shares ties and skips numbers, and `DENSE_RANK` shares ties without gaps.

Section B examples: `100, 90, 90, 80` gives `ROW_NUMBER` 1,2,3,4; `RANK` 1,2,2,4; `DENSE_RANK` 1,2,2,3. `100, 100, 90, 90, 70` gives `ROW_NUMBER` 1,2,3,4,5; `RANK` 1,1,3,3,5; `DENSE_RANK` 1,1,2,2,3.

Section C sample:

```sql
WITH ranked_products AS (
    SELECT
        product_id,
        category,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rank_value
    FROM product_sales
    WHERE total_sales IS NOT NULL
)
SELECT *
FROM ranked_products
WHERE rank_value = 1;
```

Section D: choose `ROW_NUMBER` for exactly one row, `RANK` for preserving tied winners with gaps, and `DENSE_RANK` for dense levels without gaps.

Section E: fix mistakes by confirming grain, adding the right partition, choosing the correct ordering direction, filtering ranking aliases in a CTE, reviewing nulls, documenting tie-breakers, and validating partition and output counts.
