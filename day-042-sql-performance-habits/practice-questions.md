# Practice Questions

## Section A: Concept Checks

1. What is projection?
2. Why is `SELECT *` risky in stable queries?
3. When can `SELECT *` be acceptable?
4. What is filtering?
5. What is early filtering?
6. Why can moving a filter be unsafe?
7. What is column pruning?
8. What is row pruning?
9. What is join reduction?
10. How do you decide if a join is needed?
11. What is row multiplication?
12. When is row multiplication valid?
13. Why can `DISTINCT` hide a join problem?
14. What is output grain?
15. When can pre-aggregation help?
16. When can pre-aggregation be wrong?
17. Why should `ORDER BY` have a purpose?
18. When is sorting required?
19. What is repeated work?
20. Why can CTEs improve readability?
21. Are CTEs always faster?
22. What is semantic equivalence?
23. Why are row counts alone not enough?
24. How can query plans support performance hypotheses?

## Section B: Improve or Leave It?

Classify each as `good rewrite candidate`, `needs context`, `unsafe rewrite`, or `already reasonable`.

1. A stable report uses `SELECT *`.
2. A one-time exploration query uses `SELECT *`.
3. A query joins customers but uses no customer columns or filters.
4. A join applies an active-customer rule.
5. A query sorts output for top 10 orders.
6. A machine feed sorts every row but no consumer needs order.
7. `DISTINCT` is used after an order-to-item join.
8. Item lines are pre-aggregated to order level for an order-level report.
9. Orders are aggregated to customer level while order detail is still required.
10. A CTE is introduced only for readability.
11. A rewrite changes `order_date` to `loaded_at`.
12. A small exact lookup is already readable.
13. A query repeats the same `CASE` expression five times.
14. A row count matches but totals differ.
15. A total matches but keys differ.
16. A filter is moved across a `LEFT JOIN`.

## Section C: Complete the SQL

Write read-only SQL to:

1. Select only `order_id`, `customer_id`, and `order_amount`.
2. Filter completed August orders.
3. Build a safely filtered order CTE.
4. Review customer join necessity from `query_pattern_catalog`.
5. Check duplicate customer IDs.
6. Check order-to-item row multiplication.
7. Pre-aggregate item totals by order.
8. Show why customer-level pre-aggregation loses order detail.
9. Replace `DISTINCT` after item join with item pre-aggregation.
10. Remove unnecessary `ORDER BY`.
11. Refactor a repeated `CASE` expression into a CTE.
12. Refactor repeated completed-order aggregation.
13. Compare old and new row counts.
14. Compare old and new distinct order keys.
15. Compare old and new order totals.
16. Reconcile totals by country group.

## Section D: Fix the Mistake

1. `SELECT *` in a pipeline output.
2. Carrying unused columns through a CTE.
3. Applying date filter after a large join.
4. Moving an outer-join filter into `WHERE`.
5. Removing a join that provides a business filter.
6. Joining orders to items and expecting one row per order.
7. Using `DISTINCT` to hide duplicate rows.
8. Aggregating by customer when order detail is required.
9. Sorting a dataset that does not need order.
10. Sorting before filtering.
11. Repeating the same `CASE`.
12. Repeating the same aggregate.
13. Assuming a CTE is faster.
14. Assuming shorter SQL is faster.
15. Validating only row count.
16. Changing the date field during a rewrite.

## Section E: Review the Query

For each scenario, state business goal, grain, required columns, filters, joins, aggregation, distinct reason, sort reason, repeated work, validation, and rewrite decision.

1. Completed order revenue by country.
2. Top 10 completed orders by amount.
3. Customer segment revenue.
4. Unique country list.
5. Order-level item totals.
6. Item-level product category revenue.
7. Active-customer completed orders.
8. Optional customer status report.
9. Monthly channel dashboard.
10. One customer lookup.

## Section F: Mini Case Study

Use all supplied files to design a consolidated performance-habit review. Define the business output, reduce projection, apply safe filters, review joins, check row multiplication, choose aggregation stage, remove unnecessary `DISTINCT` if appropriate, remove unnecessary sort, reduce repeated work, create an improved query, validate counts, keys, totals, grouped outputs, and document remaining uncertainty.

## Answer Key

### Section A

1. Choosing columns.
2. It returns unused columns and creates unclear contracts.
3. Brief exploration.
4. Keeping required rows.
5. Applying filters earlier when logically safe.
6. It can change joins or aggregation meaning.
7. Keeping needed columns only.
8. Keeping needed rows only.
9. Removing or narrowing joins safely.
10. Check whether it supplies a column, filter, rule, or validation.
11. More rows after a join.
12. One-to-many detail joins.
13. It removes symptoms without explaining the cause.
14. What one output row represents.
15. When downstream needs aggregated grain.
16. When detail grain is still required.
17. Sorting can add work.
18. Reports, top-N, or logic that needs order.
19. Duplicated calculations or query branches.
20. They name logical steps clearly.
21. No.
22. Same business meaning.
23. Keys or totals can still differ.
24. Plans show broad signals such as scans, joins, sorts, estimates, and cost.

### Section B

1. Good rewrite candidate.
2. Already reasonable.
3. Needs context, then possibly good candidate.
4. Unsafe to remove blindly.
5. Already reasonable.
6. Good rewrite candidate.
7. Needs investigation.
8. Good rewrite candidate.
9. Unsafe rewrite.
10. Needs context.
11. Unsafe rewrite.
12. Already reasonable.
13. Good rewrite candidate.
14. Review.
15. Review.
16. Unsafe without validation.

### Section C Sample Answers

```sql
SELECT
    order_id,
    customer_id,
    order_amount
FROM orders_performance_sample;
```

```sql
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_performance_sample
WHERE order_status = 'COMPLETED'
  AND order_date >= '2026-08-01'
  AND order_date < '2026-09-01';
```

```sql
SELECT
    customer_id,
    COUNT(*) AS customer_row_count
FROM customers_performance_sample
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

```sql
WITH item_totals AS (
    SELECT
        order_id,
        SUM(line_amount) AS item_total_amount
    FROM order_items_performance_sample
    GROUP BY order_id
)
SELECT
    order_id,
    item_total_amount
FROM item_totals;
```

### Section D

The general fix is to reduce only unnecessary work, document grain, preserve business rules, and validate counts, keys, totals, grouped outputs, dates, and columns.

