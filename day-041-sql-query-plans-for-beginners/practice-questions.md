# Practice Questions

## Section 1: Simple Questions

1. What is a query plan?
2. What does `EXPLAIN` show conceptually?
3. Why can plan formats differ by SQL platform?
4. Is a table scan always bad?
5. Is an index lookup always good?
6. What does a filter operator do?
7. What does a join operator do?
8. Why can joins increase row counts?
9. What does a sort operator do?
10. What does an aggregate operator do?
11. Are estimated rows the same as actual rows?
12. Is plan cost the same as elapsed time?

## Section 2: Choose the Main Plan Concern

1. A single-order lookup estimates 1 row.
2. A monthly report scans most orders.
3. A customer-order join returns many rows per customer.
4. A query sorts a very large intermediate result.
5. A grouped report reads many rows then returns five groups.
6. A status filter matches most of the table.
7. A plan changes after the table grows from thousands to millions of rows.
8. A cost value looks high in one database and low in another database.
9. An analyze-style command may execute the query.
10. A small reference table is scanned.

## Section 3: True or False

1. A query plan is the database's strategy for producing a result.
2. Cost values can be compared directly across all databases.
3. A table scan can be reasonable.
4. Estimated rows are guaranteed actual row counts.
5. Joins can multiply rows.
6. Sorting many rows can require work.
7. Aggregation always means the database processes only a few rows.
8. `EXPLAIN ANALYZE` behaviour should be checked before use.
9. The same SQL can produce different plans after data volume changes.
10. Plan reading should replace validation.

## Section 4: Write Review Queries

Write a query to:

1. List all plan steps from `query_plan_catalog`.
2. Find only `TABLE_SCAN` steps.
3. Find only `FILTER` steps.
4. Find only `JOIN` steps.
5. Find only `SORT` steps.
6. Find only `AGGREGATE` steps.
7. Show plan steps with estimated rows greater than or equal to 1000.
8. Show plan steps with estimated cost greater than or equal to 50.
9. Count plan steps by operator.
10. Summarize total estimated cost by plan.

## Section 5: Spot the Mistake

1. A learner says every scan is bad.
2. A learner says every lookup is good.
3. A learner compares cost from two different database products.
4. A learner treats estimated rows as actual rows.
5. A learner runs analyze-style commands on production without checking behaviour.
6. A learner ignores the business question.
7. A learner ignores join row multiplication.
8. A learner ignores a large sort.
9. A learner ignores aggregate input size.
10. A learner says one operator explains the whole query.

## Section 6: Mini Assignment

Imagine a reporting query joins orders to customers, filters recent orders, groups by customer segment, and sorts by total amount.

Explain:

1. the business question
2. source tables
3. likely plan operators
4. where row counts might shrink
5. where row counts might grow
6. why sorting could matter
7. why aggregation could still process many rows
8. which estimates you would review
9. why cost is not elapsed time
10. what evidence you would collect before action

## Answer Key

### Section 1

1. A query plan is the database's strategy for producing a query result.
2. It shows planning information for a query.
3. Each database has its own optimizer and plan format.
4. No. Small or necessary scans can be reasonable.
5. No. It depends on selectivity and context.
6. It applies `WHERE` conditions.
7. It combines related rows from inputs.
8. One input row can match many rows on the other side.
9. It orders rows.
10. It groups and summarises rows.
11. No. Estimated rows are predictions.
12. No. Cost is a platform-specific estimate.

### Section 2

1. Selective lookup estimate.
2. Scan may be reasonable.
3. Join row multiplication.
4. Large sort.
5. Aggregate input size.
6. Low selectivity.
7. Data volume changed.
8. Platform-specific cost.
9. Safety warning.
10. Small scan may be fine.

### Section 3

1. True
2. False
3. True
4. False
5. True
6. True
7. False
8. True
9. True
10. False

### Section 4 Sample Patterns

```sql
SELECT
    plan_id,
    query_name,
    step_number,
    operator_name
FROM query_plan_catalog
ORDER BY plan_id, step_number;
```

```sql
SELECT
    operator_name,
    COUNT(*) AS step_count
FROM query_plan_catalog
GROUP BY operator_name
ORDER BY step_count DESC;
```

### Section 5

Each example is a mistake because it jumps to conclusions without context, platform knowledge, or validation evidence.

