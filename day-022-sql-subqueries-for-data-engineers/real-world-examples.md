# Real-World Examples

## Scenario 1: Customers With Purchases

Business question: which customers placed at least one order?

Pattern: `EXISTS`.

```sql
SELECT c.customer_id, c.customer_name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
```

Validation: compare with a count of non-null customer IDs in `orders`.

## Scenario 2: Customers Without Purchases

Pattern: `NOT EXISTS`. Risk: using `NOT IN` without filtering `NULL`.

## Scenario 3: Orders Above Average Value

Pattern: scalar subquery with `AVG(order_amount)`. Validate by running the average query first.

## Scenario 4: Orders Without Successful Payment

Pattern: `NOT EXISTS` with `payment_status = 'SUCCESS'`. This supports payment exception reporting.

## Scenario 5: Products Never Sold

Pattern: `NOT EXISTS` from `products` to `daily_sales`. Validate that the product key is `product_id`.

## Scenario 6: Source Records Missing From Target

Pattern: correlated `NOT EXISTS` using `record_id`. The result should be reviewed before any pipeline decision.

## Scenario 7: Target Records Not Present in Source

Pattern: reverse the source-target check. This can reveal unexpected records in the target.

## Scenario 8: Days With Above-Average Sales

Pattern: `FROM`-clause subquery to calculate daily totals, then filter the result.

## Scenario 9: Review Mismatched Values

Pattern: subquery returning mismatch IDs. Validate source and target totals separately before deciding the cause.

## Why These Patterns Matter

Subqueries support data-quality checks, pipeline validation, reconciliation, exception reporting, and clean-layer testing. They help a data engineer ask a smaller question first and then use the answer in a larger query.
