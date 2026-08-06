# Practice Questions

## Section A: Concept Checks

1. What does a table store?
2. What does a view usually store?
3. How long does a CTE last?
4. What is a subquery?
5. What does persistence mean?
6. What does reuse mean?
7. Why does history matter?
8. What does freshness mean?
9. What is the raw layer?
10. What is the clean layer?
11. What is the reporting layer?
12. What is grain?
13. Why do dependencies matter?
14. Who can be a consumer?
15. Why is auditability important?
16. What validation should every interface have?
17. What is a current-state interface?
18. What is a stored history interface?
19. What makes an interface business-ready?
20. Why is no interface always best?

## Section B: Choose the Interface

Choose table, view, CTE, subquery, simple query, or no new interface. Explain briefly.

1. Store all raw event deliveries for replay.
2. Reuse valid-order logic across five reports.
3. Compare one order amount with the average amount.
4. Build a one-time duplicate-event check.
5. Serve a dashboard with stable daily totals.
6. Preserve monthly reporting history.
7. Create a readable three-step validation query.
8. Expose current customer profile.
9. Check customers in India once.
10. Share payment exception logic with multiple analysts.
11. Keep source audit history.
12. Avoid repeating customer sales logic.
13. Run a quick source row count.
14. Provide stable extract columns.
15. Investigate one suspicious order.

## Section C: Complete the SQL

1. Write CTE-based valid-order logic.
2. Write a subquery for orders above average.
3. Write a conceptual reporting view illustration.
4. Aggregate daily order sales.
5. Review raw event duplicates.
6. Validate customer key uniqueness.
7. Reconcile completed order totals.
8. Build a current-state order query.
9. Create an exception queue.
10. Identify consumer-interface mismatches.
11. Compare source and interface counts.
12. Create an interface summary from decision cases.

## Section D: Fix the Mistake

1. A view is chosen even though raw history must be stored.
2. A table is proposed for one tiny calculation.
3. A CTE is copied into ten reports.
4. A subquery is deeply nested and unreadable.
5. Raw tables are exposed directly to dashboard users.
6. A table has a clean name but no validation.
7. Grain is undocumented.
8. Consumer needs are ignored.
9. Dependencies are not listed.
10. Current-state and history needs are mixed.
11. Audit columns are removed.
12. No exception output exists.

## Section E: Design the Interface

For each scenario, define source grain, output grain, persistence, reuse, history, freshness, consumer, interface, and validation.

1. Raw event archive.
2. Clean customer master.
3. Valid order reporting.
4. Daily regional sales dashboard.
5. Monthly sales history.
6. One-time duplicate investigation.
7. Source-target validation.
8. Latest customer profile.
9. Order exception report.
10. Average order comparison.

## Section F: Mini Case Study

Design interfaces for a small data workflow with raw events, clean customer data, orders, daily reporting, dashboard consumers, analyst consumers, and audit consumers. Include raw, clean, reporting, exception, and validation outputs.

## Answer Key

### Section A

1. Rows.
2. Reusable query definition.
3. One SQL statement.
4. A query inside another query.
5. Whether rows or objects remain beyond one query.
6. Whether logic or data is used again.
7. It supports audit, replay, and trend needs.
8. How current the output must be.
9. Source-aligned history layer.
10. Standardised layer with documented rules.
11. Consumer-focused layer.
12. What one row represents.
13. Upstream changes can affect output.
14. A report, dashboard, pipeline, extract, application, analyst, or validation process.
15. It supports investigation.
16. Row count, keys, nulls, totals, dates, dependencies, and consumers where relevant.
17. Interface showing latest accepted state.
18. Interface preserving past rows.
19. Documented grain, rules, dependencies, and validation.
20. Requirements decide the choice.

### Section B

1. Table.
2. View or clean table, depending on persistence.
3. Subquery.
4. CTE or simple query.
5. Reporting table or view.
6. Reporting table.
7. CTE.
8. Current-state view or clean table.
9. Simple query.
10. Exception view.
11. Raw table.
12. View or reporting table.
13. Simple query.
14. Reporting table or view.
15. Simple query.

### Section C: Example SQL

```sql
-- CTE-based valid-order logic.
WITH valid_orders AS (
    SELECT
        order_id,
        customer_id,
        order_amount
    FROM order_transactions
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
      AND order_status = 'COMPLETED'
)
SELECT
    customer_id,
    SUM(order_amount) AS completed_order_amount
FROM valid_orders
GROUP BY customer_id;
```

```sql
-- Subquery for orders above average.
SELECT
    order_id,
    customer_id,
    order_amount
FROM order_transactions
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM order_transactions
    WHERE order_amount > 0
);
```

```sql
-- Key uniqueness validation.
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM clean_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Section D

1. Use a raw or history table.
2. Use a simple query or subquery.
3. Create a reusable view or stored interface.
4. Use CTEs for readability.
5. Provide a clean or reporting interface.
6. Validate before trusting.
7. Document grain.
8. Review consumers.
9. Document dependencies.
10. Separate current-state and history interfaces.
11. Preserve useful audit fields.
12. Create an exception output.

### Section E

Answers may vary, but every answer should include grain, persistence, reuse, history, freshness, consumers, dependency notes, and validation checks.

### Section F

A strong design uses a raw table for event history, a clean customer interface for one row per customer, valid-order logic for accepted order rows, an exception output for invalid rows, a reporting table or view for daily dashboard metrics, and validation summaries for keys, totals, nulls, and reporting duplicates.
