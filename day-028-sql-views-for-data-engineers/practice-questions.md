# Practice Questions

## Section A: Concept Checks

1. What is a SQL view?
2. What does `CREATE VIEW` do?
3. How is a view different from a table?
4. How is a view different from a CTE?
5. How is a view different from a subquery?
6. What is a materialized view at a conceptual level?
7. What is source grain?
8. What is output grain?
9. Why do dependencies matter?
10. Why should reusable views avoid `SELECT *`?
11. Why do stable aliases matter?
12. How can joins multiply rows?
13. How do aggregated views change grain?
14. Why preserve audit columns?
15. Do views automatically improve performance?
16. Do views automatically guarantee security?
17. Where should consumer ordering usually happen?
18. Why are validation queries needed?

## Section B: Read the View Definition

For each view, identify the source objects, output grain, key, exposed columns, hidden risks, and likely validation.

1. `vw_active_customers`
2. `vw_valid_orders`
3. `vw_successful_payments`
4. `vw_order_customer_details`
5. `vw_order_payment_attempt_details`
6. `vw_customer_order_summary`
7. `vw_campaign_clean_reporting`
8. `vw_data_quality_review_queue`

## Section C: Complete the SQL

1. Create an active customer view that excludes email address.
2. Create a valid order view.
3. Create a successful payment view.
4. Create a joined order-customer view.
5. Create a customer summary view.
6. Create a latest order view using `ROW_NUMBER`.
7. Create a campaign reporting view.
8. Create a payment exception view.
9. Create a review queue with `UNION ALL`.
10. Write a validation query for duplicate customer IDs in a view.

## Section D: Fix the Mistake

1. A reusable view uses `SELECT *`.
2. A joined view does not document grain.
3. A view exposes `email_address` unnecessarily.
4. A summary view groups by too many columns.
5. A view has duplicate column names after a join.
6. A status alias is unclear.
7. A view hides null country rows without a review view.
8. A consumer assumes view output is sorted.
9. A view is built on five other views.
10. A view removes audit fields too early.
11. A view is shared without row-count validation.
12. A view replacement is assumed to be safe everywhere.

## Section E: Design the View

For each scenario, define view name, purpose, consumer, source objects, source grain, output grain, columns, filters, dependencies, and validation checks.

1. Active customer directory.
2. Valid order reporting.
3. Current order state.
4. Successful payment reporting.
5. Customer sales summary.
6. Campaign daily reporting.
7. Payment exception review.
8. Product category summary.
9. Restricted customer reporting.
10. Data-quality review queue.

## Section F: View Review Case Study

Imagine you are designing a reporting layer for customers and orders.

1. Inspect `raw_customers` and `raw_orders`.
2. Define a clean customer view.
3. Define a valid order view.
4. Create a customer sales summary view.
5. Create an exception view for invalid customer or order rows.
6. Validate row counts.
7. Validate uniqueness.
8. Reconcile totals.
9. Document dependencies.
10. Identify consumer-change risks.

## Answer Key

### Section A

1. A view is a named reusable query definition.
2. It saves a query definition under a view name.
3. A table stores rows; a standard view usually stores logic.
4. A CTE lasts for one statement; a view remains as a database object.
5. A subquery is embedded; a view is named and reusable.
6. A materialized view may store results physically, depending on platform support.
7. Source grain is what one input row represents.
8. Output grain is what one view row represents.
9. Dependencies matter because upstream changes can break or change view results.
10. `SELECT *` can expose changing schemas and unstable columns.
11. Stable aliases help consumers keep reports working.
12. Joins can return multiple rows per key when relationships are not one-to-one.
13. Aggregation changes detail rows into summary rows.
14. Audit columns support investigation.
15. No.
16. No.
17. In the consuming query with `ORDER BY`.
18. They prove the view matches its source rules and business purpose.

### Section C: Example SQL Answers

```sql
-- Active customer view.
CREATE VIEW vw_active_customers AS
SELECT
    customer_id,
    customer_name,
    country,
    signup_date,
    updated_at,
    source_file
FROM raw_customers
WHERE customer_status = 'ACTIVE';
```

```sql
-- Valid order view.
CREATE VIEW vw_valid_orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount,
    updated_at,
    source_file
FROM raw_orders
WHERE customer_id IS NOT NULL
  AND order_amount > 0
  AND order_status IN ('COMPLETED', 'PENDING', 'REFUNDED');
```

```sql
-- Duplicate customer validation.
SELECT
    customer_id,
    COUNT(*) AS row_count
FROM vw_active_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Section D

1. Use explicit columns.
2. Document one row per order, customer, payment attempt, or summary group.
3. Exclude unnecessary sensitive fields.
4. Group only by output-grain columns.
5. Use qualified columns and aliases.
6. Rename aliases for business clarity.
7. Create a review view for excluded rows.
8. Use `ORDER BY` in the consumer query.
9. Reduce dependency depth.
10. Preserve useful audit columns.
11. Validate before sharing.
12. Review platform-specific replacement behaviour first.

### Section E

Answers may vary, but every design should include purpose, consumer, source objects, source grain, output grain, explicit columns, filters, dependencies, and validation checks.

### Section F

A strong solution defines separate clean and exception views, documents that raw customers and raw orders contain versions, validates row counts and key uniqueness, reconciles completed order totals, lists dependencies, and warns that changing column names or meanings can break consumers.
