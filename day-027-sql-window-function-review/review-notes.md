# Day 027 Review Notes

## What a Window Function Review Means

A review day helps you slow down and ask whether the query matches the business question. Days 024 to 026 taught individual techniques. Day 027 asks: which one should be used, and how can the result be checked?

| Business question type | Common functions |
|---|---|
| Position within a group | `ROW_NUMBER`, `RANK`, `DENSE_RANK` |
| Previous or next row | `LAG`, `LEAD` |
| Cumulative or recent-row summary | `SUM OVER`, `COUNT OVER`, `AVG OVER`, `MIN OVER`, `MAX OVER` |

## Step 1: Identify Business Grain

Business grain means what one row represents. A customer activity table may have one row per customer per activity date. A campaign table may have one row per campaign per metric date. A pipeline table may have one row per pipeline per load date.

If the grain is wrong, the window result will also be wrong.

## Step 2: Define the Partition

`PARTITION BY` defines where the calculation restarts. Ranking customers per country uses `PARTITION BY country`. Comparing a campaign with its own previous day uses `PARTITION BY campaign_id`.

## Step 3: Define the Ordering

Window `ORDER BY` defines sequence. Ranking usually orders by a metric descending. Row comparison and cumulative analysis usually order by a date ascending.

## Step 4: Choose Tie Behaviour

Use `ROW_NUMBER` when exactly one row must be selected and a tie-breaker is documented. Use `RANK` when tied rows should share a rank and gaps are acceptable. Use `DENSE_RANK` when tied rows should share a rank without gaps.

## Step 5: Choose Boundary Behaviour

`LAG` on the first row and `LEAD` on the last row usually return `NULL`. That is not automatically an error. It is often the expected boundary of the sequence.

## Step 6: Choose the Frame

Cumulative and moving calculations need a frame. Use explicit `ROWS` frames:

```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```

or:

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

## Step 7: Validate

Validate source counts, null ordering values, duplicate ordering values, expected first and last rows, tied values, final cumulative totals, and moving-frame row counts.

## When to Aggregate First

If the source has several rows per product per date, but the question asks for product totals by category, aggregate first. Then apply ranking to the grouped result.

## When Not to Use a Window Function

Use simpler SQL when it answers the question:

- One summary row per group: use `GROUP BY`.
- Filter rows by status: use `WHERE`.
- Add related columns from another table: use a simple join.
- Count all rows in a table: use `COUNT`.

## Mixed-Function Workflow

1. Clean and validate source rows.
2. Aggregate first if the source is too detailed.
3. Add ranking columns.
4. Add previous or next row columns.
5. Add cumulative or moving columns.
6. Add review flags with clear business meaning.
7. Validate each calculated column separately.

## Common Review Questions

1. What does one source row represent?
2. What should one output row represent?
3. Should the calculation restart by country, product, campaign, region, or pipeline?
4. Which column defines sequence?
5. Is the sequence unique?
6. Are there duplicate ordering values?
7. Are null ordering values present?
8. Should ties remain visible?
9. Is exactly one row needed?
10. Are boundary nulls expected?
11. Is the frame cumulative or moving?
12. Does the final cumulative value reconcile to the source total?
13. Were rows filtered too early?
14. Does the query need `GROUP BY` before a window function?
15. Does a simpler query answer the question?
16. Are calculated columns validated before being combined?
17. Does the output identify investigation records without changing source data?
