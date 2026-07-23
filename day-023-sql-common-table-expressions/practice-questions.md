# Practice Questions

## Section A: Concept Checks

1. What does CTE stand for?
2. What keyword begins a CTE section?
3. Is a CTE a permanent table?
4. What is the final query?
5. How are multiple CTEs separated?
6. Can a later CTE reference an earlier CTE?
7. Can an earlier CTE reference a later CTE?
8. Why are clear CTE names useful?
9. What is output grain?
10. How is a CTE different from a subquery?
11. How is a CTE different from a view?
12. Why should each CTE step be validated?
13. Do CTEs automatically improve performance?
14. Why are recursive CTEs out of scope today?
15. What checks should be used for validation?

## Section B: Predict the Result

1. What does `active_customers` return?
2. What does `valid_orders` return after filtering positive amounts?
3. Which CTE depends on `valid_orders` in a customer total query?
4. What does the final query return from `customer_totals`?
5. Does aggregation change grain from order to customer?
6. Can a join multiply rows?
7. What does `missing_target_records` return?
8. What does `row_num = 1` return in a latest-record CTE?

## Section C: Complete the SQL

1. Write an active customers CTE.
2. Write a valid orders CTE.
3. Write customer totals from valid orders.
4. Write latest order version using `ROW_NUMBER`.
5. Write successful payments CTE.
6. Find orders without successful payments.
7. Find source records missing in target.
8. Find value mismatches.
9. Build daily sales totals.
10. Build an exception queue.

## Section D: Fix the Mistake

1. A query defines a CTE but has no final query.
2. Two CTEs are written without a comma.
3. The final CTE has an extra comma before `SELECT`.
4. `first_step` references `second_step` before it exists.
5. A CTE is named `x`.
6. A join uses unqualified `customer_id`.
7. A payment query joins on the wrong key.
8. A join creates unexpected extra rows.
9. Validation steps are skipped.
10. A learner says the CTE created a saved table.

## Section E: Design the CTE Workflow

For each scenario, define CTE names, input tables, purpose, output grain, validation checks, and final output:

1. Clean current order table.
2. Customer revenue summary.
3. Orders without successful payment.
4. Payments without matching orders.
5. Source records missing in target.
6. Target-only records.
7. Value mismatch report.
8. Daily sales anomaly report.

## Answer Key

### Section A

1. Common Table Expression.
2. `WITH`.
3. No. It exists only for one SQL statement.
4. The last query that returns the output.
5. With commas.
6. Yes.
7. No.
8. They explain each step's purpose.
9. What one row represents.
10. A CTE is named at the top; a subquery is usually nested.
11. A view is saved; a CTE is not saved.
12. Clear formatting does not guarantee correct logic.
13. No.
14. They are more advanced and solve different problems.
15. Row counts, nulls, duplicates, keys, totals, and grain checks.

### Section B

1. Active customer rows.
2. Orders with usable positive amounts.
3. `customer_totals`.
4. One row per customer summary.
5. Yes.
6. Yes, when there are multiple matches.
7. Source records not found in target.
8. The selected latest row per order based on ordering.

### Section C: Sample Answers

```sql
-- 1. Active customers.
WITH active_customers AS (
    SELECT customer_id, customer_name, country
    FROM customers
    WHERE customer_status = 'ACTIVE'
)
SELECT *
FROM active_customers;

-- 2 and 3. Valid orders to customer totals.
WITH valid_orders AS (
    SELECT order_id, customer_id, order_amount
    FROM raw_orders
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
),
customer_totals AS (
    SELECT customer_id, SUM(order_amount) AS total_order_value
    FROM valid_orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals;

-- 7. Source records missing in target.
WITH source_data AS (
    SELECT record_id, business_key
    FROM source_records
),
target_data AS (
    SELECT record_id
    FROM target_records
)
SELECT s.record_id, s.business_key
FROM source_data AS s
LEFT JOIN target_data AS t
    ON s.record_id = t.record_id
WHERE t.record_id IS NULL;
```

### Section D

1. Add a final `SELECT`.
2. Add a comma between CTE definitions.
3. Remove the comma before the final query.
4. Define dependencies in the correct order.
5. Rename it by purpose.
6. Qualify columns with aliases.
7. Use the correct key, such as `order_id`.
8. Check duplicate matches and row count.
9. Run each step separately and reconcile totals.
10. Correct the misconception: the CTE is temporary for one statement.

### Section E

Valid answers should include clear CTE names, one purpose per step, correct input tables, output grain, validation checks, and a final query. Alternative workflows are acceptable when the business logic is correct and readable.
