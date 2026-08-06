# Practice Questions

## Section A: Concept Checks

1. What is an upstream dependency?
2. What is a downstream consumer?
3. Why is a view a shared interface?
4. What is a column contract?
5. What is output grain?
6. Why can a grain change be high-risk?
7. Why can adding a column still matter?
8. Why is `SELECT *` risky for consumers?
9. What does row-count validation check?
10. What does key-count validation check?
11. Why compare null counts?
12. Why reconcile totals?
13. How can a filter change alter meaning?
14. How can a join change multiply rows?
15. How can aggregation change grain?
16. Why inspect representative samples?
17. What is an expected change?
18. Why communicate view changes?

## Section B: Identify the Risk

For each scenario, identify likely impact, required validation, affected consumers, and possible breaking change.

1. Add `updated_at` to `vw_valid_orders`.
2. Rename `completed_order_amount`.
3. Remove `email_address`.
4. Include inactive customers.
5. Add payments to order details.
6. Change inner join to left join.
7. Change daily campaign view to monthly.
8. Include cancelled orders in totals.
9. Replace null country with `UNKNOWN`.
10. Change amount from numeric to text.
11. Build a view on top of three other views.
12. Change status standardisation rules.

## Section C: Complete the SQL

1. Row-count comparison.
2. Distinct-key comparison.
3. Duplicate-key check.
4. Null comparison.
5. Total reconciliation.
6. Old-only records.
7. New-only records.
8. Changed values.
9. Join-impact comparison.
10. Filter-impact comparison.
11. Aggregation-impact comparison.
12. Validation summary.

## Section D: Fix the Mistake

1. SQL runs, so the change is approved.
2. No consumer inventory exists.
3. Grain is not documented.
4. Column is renamed without checking consumers.
5. Join to payments is added without key validation.
6. Filter changes are not compared.
7. Aggregation grain changes without total reconciliation.
8. Added column ignores fixed-schema consumers.
9. No representative samples are inspected.
10. Expected changes are not documented.
11. Business meaning changes but alias stays the same.
12. Audit columns are removed too early.

## Section E: Design the Review Workflow

For each scenario, define dependencies, consumers, current grain, proposed grain, main risk, old/new checks, sample checks, and review summary.

1. Active-customer filter change.
2. Customer sales alias rename.
3. Order-payment join change.
4. Campaign latest-load rule change.
5. Daily campaign to monthly summary.
6. Null country handling change.
7. Current-order deduplication change.
8. Audit-column addition.
9. Status standardisation change.
10. Create new downstream reporting view.

## Section F: Mini Case Study

A customer sales dashboard uses a customer view, an order view, and a reporting summary. A proposed change adds refunded-like orders and joins payment status. Design a review:

1. Identify dependencies.
2. Identify consumers.
3. Define old logic.
4. Define proposed logic.
5. Compare row counts.
6. Compare keys.
7. Reconcile totals.
8. Check join multiplication.
9. Inspect samples.
10. Give a final recommendation.

## Answer Key

### Section A

1. A source object, column, type, grain, or rule used by a view.
2. A report, extract, query, application, or view that uses the view.
3. Consumers depend on its columns, grain, and meanings.
4. Expected column names, types, meanings, and null behaviour.
5. What one output row represents.
6. Counts, keys, and totals can change.
7. Fixed schemas and `SELECT *` consumers can be affected.
8. It hides column expectations and can shift output.
9. Whether old and new outputs have the same number of rows.
10. Whether expected keys still identify rows correctly.
11. Null changes can affect filters, groups, and reports.
12. Important totals should match or have documented differences.
13. It can add or remove records.
14. One-to-many relationships can create extra rows.
15. Grouped rows may replace detail rows.
16. Aggregates can hide row-level problems.
17. A planned difference with a documented reason.
18. Consumers need time and context to adjust.

### Section C: Example SQL

```sql
-- Row-count comparison.
WITH old_logic AS (
    SELECT order_id
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_logic AS (
    SELECT order_id
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT
    (SELECT COUNT(*) FROM old_logic) AS old_count,
    (SELECT COUNT(*) FROM new_logic) AS new_count;
```

```sql
-- Duplicate-key check.
WITH proposed_output AS (
    SELECT order_id
    FROM orders_source
    WHERE customer_id IS NOT NULL
      AND order_amount > 0
)
SELECT
    order_id,
    COUNT(*) AS row_count
FROM proposed_output
GROUP BY order_id
HAVING COUNT(*) > 1;
```

```sql
-- Total reconciliation.
WITH old_logic AS (
    SELECT order_amount
    FROM orders_source
    WHERE order_status = 'COMPLETED'
),
new_logic AS (
    SELECT order_amount
    FROM orders_source
    WHERE order_status IN ('COMPLETED', 'REFUNDED')
)
SELECT
    (SELECT SUM(order_amount) FROM old_logic) AS old_total,
    (SELECT SUM(order_amount) FROM new_logic) AS new_total;
```

### Section D

1. Compare outputs before approval.
2. Create a consumer inventory.
3. Document expected grain.
4. Check required columns.
5. Count rows per key.
6. Compare old and new filters.
7. Reconcile totals and document grain.
8. Review fixed-schema consumers.
9. Inspect representative samples.
10. Label expected differences.
11. Rename or document the changed meaning.
12. Preserve audit columns when investigation matters.

### Section E

Good answers identify dependencies and consumers, write old and proposed logic separately, compare rows, keys, nulls, totals, dates, and samples, then produce a clear review summary.

### Section F

A strong recommendation is to avoid changing the shared dashboard view directly until old/new comparisons, payment join multiplication checks, consumer review, and total reconciliation are complete. If the grain changes to one row per payment attempt, create a separate view or clearly document the new grain.
