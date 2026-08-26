# Real-World Examples

## 1. Single Order Lookup

Business situation: support needs one order by `order_id`.

Source tables: `orders_plan_sample`.

Plan focus: selective filter and possible lookup.

```sql
SELECT
    order_id,
    customer_id,
    order_amount
FROM orders_plan_sample
WHERE order_id = 'OP5001';
```

Expected result: one matching order. A data engineer reviews whether the plan estimates a small row count.

Common mistake: assuming a lookup must happen on every platform.

## 2. Delivered Orders Report

Business situation: operations wants all delivered orders.

Source tables: `orders_plan_sample`.

Plan focus: broader filter.

```sql
SELECT
    order_id,
    order_status,
    order_amount
FROM orders_plan_sample
WHERE order_status = 'Delivered';
```

Expected result: many rows may match because status is low-cardinality.

Common mistake: expecting an index-style lookup to always be useful.

## 3. Country Summary

Business situation: reporting needs order totals by country group.

Source tables: `orders_plan_sample`.

Plan focus: aggregation.

```sql
SELECT
    country_group,
    COUNT(*) AS order_count,
    SUM(order_amount) AS total_amount
FROM orders_plan_sample
GROUP BY country_group
ORDER BY country_group;
```

Expected result: fewer output rows than input rows, but all input rows may be processed.

## 4. Customer Order History

Business situation: analytics needs orders with customer segments.

Source tables: `orders_plan_sample`, `customers_plan_sample`.

Plan focus: join and row multiplication.

```sql
SELECT
    o.order_id,
    o.customer_id,
    c.customer_segment,
    o.order_amount
FROM orders_plan_sample o
INNER JOIN customers_plan_sample c
    ON o.customer_id = c.customer_id
ORDER BY o.customer_id, o.order_id;
```

Expected result: customers with multiple orders appear multiple times.

## 5. Recent Orders

Business situation: a pipeline checks recent activity.

Source tables: `orders_plan_sample`.

Plan focus: date filter and sort.

```sql
SELECT
    order_id,
    order_date,
    order_amount
FROM orders_plan_sample
WHERE order_date >= '2026-04-10'
ORDER BY order_date;
```

Expected result: only recent rows are sorted.

## 6. High-Value Orders

Business situation: finance reviews high-value orders.

Source tables: `orders_plan_sample`.

Plan focus: selective numeric filter.

```sql
SELECT
    order_id,
    order_amount,
    country_group
FROM orders_plan_sample
WHERE order_amount >= 500
ORDER BY order_amount DESC;
```

Expected result: fewer rows than all orders.

## 7. Active Customers

Business situation: CRM reporting needs active customers.

Source tables: `customers_plan_sample`.

Plan focus: low-cardinality filter.

```sql
SELECT
    customer_id,
    customer_status,
    customer_segment
FROM customers_plan_sample
WHERE customer_status = 'Active';
```

Expected result: status filters may still return many rows.

## 8. Joined Segment Summary

Business situation: reporting needs order amount by customer segment.

Source tables: orders and customers.

Plan focus: join followed by aggregate.

```sql
SELECT
    c.customer_segment,
    COUNT(*) AS order_count,
    SUM(o.order_amount) AS total_amount
FROM orders_plan_sample o
INNER JOIN customers_plan_sample c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_amount DESC;
```

Expected result: grouped output after joined rows are processed.

## 9. Large Sort Warning

Business situation: a dashboard sorts every order by amount.

Plan focus: sort population size.

```sql
SELECT
    order_id,
    order_amount
FROM orders_plan_sample
ORDER BY order_amount DESC;
```

Expected result: all selected rows are sorted.

## 10. Plan Comparison

Business situation: two versions of a report produce the same columns.

Source tables: `plan_comparison_cases`.

```sql
SELECT
    case_id,
    query_goal,
    main_difference,
    beginner_interpretation
FROM plan_comparison_cases
ORDER BY case_id;
```

Expected result: learners identify the main difference before guessing.

## 11. Cost Awareness

Business situation: a plan step has a high cost.

Source tables: `query_plan_catalog`.

```sql
SELECT
    plan_id,
    query_name,
    operator_name,
    estimated_cost
FROM query_plan_catalog
WHERE estimated_cost >= 50
ORDER BY estimated_cost DESC;
```

Expected result: high-cost steps are reviewed as clues, not final proof.

## 12. Estimated Rows Awareness

Business situation: a filter estimate looks too high.

Source tables: `query_plan_catalog`.

```sql
SELECT
    plan_id,
    query_name,
    operator_name,
    estimated_rows
FROM query_plan_catalog
WHERE estimated_rows >= 1000
ORDER BY estimated_rows DESC;
```

Expected result: high estimates point to possible broad work.

## 13. Operator Reference Review

Business situation: a learner sees an unfamiliar plan operator.

Source tables: `plan_operator_catalog`.

```sql
SELECT
    operator_name,
    basic_meaning,
    beginner_caution
FROM plan_operator_catalog
ORDER BY operator_name;
```

Expected result: operator names become plain-language ideas.

## 14. Plan Change After Growth

Business situation: a query was fast last month but slower this month.

Source tables: `plan_comparison_cases`.

```sql
SELECT
    case_id,
    query_goal,
    plan_a_summary,
    plan_b_summary,
    beginner_interpretation
FROM plan_comparison_cases
WHERE beginner_interpretation LIKE '%volume%';
```

Expected result: learners connect data growth to possible plan changes.

## 15. No-Problem Case

Business situation: a small reference table scan appears in a plan.

Source tables: `query_plan_casebook`.

```sql
SELECT
    case_id,
    business_question,
    main_operator,
    recommended_review
FROM query_plan_casebook
WHERE main_risk LIKE '%small%';
```

Expected result: learners avoid overreacting to harmless scans.

