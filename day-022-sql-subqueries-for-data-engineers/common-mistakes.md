# Common Subquery Mistakes

## Mistake 1: Scalar Subquery Returns Many Rows

Wrong: using `=` with a subquery that returns many customer IDs.

Safer: use `IN` for a list, or make the inner query return one aggregate value.

## Mistake 2: IN Subquery Returns Multiple Columns

`IN` beginner examples should return one comparable column. Return `customer_id`, not `customer_id` and `order_id` together.

## Mistake 3: NOT IN with NULL

If the inner query returns `NULL`, `NOT IN` may return unexpected results.

```sql
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);
```

`NOT EXISTS` is often safer for missing-record checks.

## Mistake 4: Missing Correlation Condition

An `EXISTS` subquery without `o.customer_id = c.customer_id` may become true for every customer if any order exists. Always connect the inner query to the current outer row.

## Mistake 5: Wrong Comparison Key

Comparing `order_id` with `customer_id` answers the wrong question. Match business keys carefully.

## Mistake 6: Incompatible Data Types

Do not compare numeric IDs to text labels or dates to amounts. Corresponding values should have compatible meanings and types.

## Mistake 7: No Alias for FROM Subquery

Many platforms require an alias:

```sql
) AS customer_totals
```

## Mistake 8: Too Much Nesting

Deeply nested queries are hard to test. Split the logic, or consider a CTE when the query becomes too large.

## Mistake 9: Not Running the Inner Query Separately

Always run the inner query first. Confirm it returns the expected rows and columns.

## Mistake 10: Using a Subquery When a Simple Filter Is Enough

If the problem is `country = 'UK'`, use a simple `WHERE` filter. Do not add a subquery just to look clever.

## Mistake 11: Assuming Subqueries Always Perform Better

Performance depends on the platform, data size, and optimiser. Correctness and clarity come first for beginners.

## Mistake 12: Ignoring Duplicate Values Returned by the Inner Query

Duplicate values in an `IN` list may not change matching logic, but they can reveal source issues. `DISTINCT` may help readability, but it can also hide a data-quality problem.

## Mistake 13: Mixing Business Questions

"Customers with any order" is different from "customers with successful orders". Add the correct filter in the inner query.

## Mistake 14: Treating Validation Output as an Automatic Deletion List

Validation results are review inputs. Investigate missing or mismatched records before taking action.
