# Common CTE Mistakes

## Mistake 1: Forgetting the Final Query

A CTE definition must be followed by a final `SELECT`. Safer approach: always write the final query immediately after the CTE.

## Mistake 2: Missing Comma Between CTEs

Multiple CTEs are separated by commas. Missing commas make the statement invalid.

## Mistake 3: Extra Comma Before Final Query

Do not place a comma after the last CTE before the final `SELECT`.

## Mistake 4: Referencing a Later CTE Before It Is Defined

Later CTEs can reference earlier CTEs, not the other way around.

## Mistake 5: Using Unclear Names

Names like `cte1` and `x` hide meaning. Use names such as `valid_orders`.

## Mistake 6: Assuming a CTE Is Permanent

A CTE lasts only for one SQL statement and does not store data by itself.

## Mistake 7: Assuming a CTE Is Always Faster

CTEs improve structure, but speed depends on the SQL platform and data. Do not make performance assumptions.

## Mistake 8: Using Too Many Tiny CTEs

Too many tiny steps can make a query feel scattered. Combine steps when they share one clear purpose.

## Mistake 9: Using One Huge CTE

One large CTE can hide business rules. Split it when validation becomes difficult.

## Mistake 10: Not Validating Each Step

Run each CTE body separately and check row counts, nulls, duplicates, keys, and totals.

## Mistake 11: Changing the Data Grain Accidentally

One row per order is different from one row per customer. Aggregation changes the grain.

## Mistake 12: Row Multiplication After Joins

Joining to a table with multiple matching rows can increase row count. Validate before trusting totals.

## Mistake 13: Filtering Too Early

Filtering early can remove records needed for validation. Keep review outputs when needed.

## Mistake 14: Filtering Too Late

Filtering late can allow invalid rows into aggregations. Decide the rule deliberately.

## Mistake 15: Dropping Audit Columns Too Soon

Fields such as `source_file` and `updated_at` help troubleshoot results.

## Mistake 16: Duplicate Column Names

Use aliases when two columns have the same name.

## Mistake 17: Ambiguous Columns in Joins

Qualify columns with table aliases, such as `o.customer_id`.

## Mistake 18: Repeating Expensive Logic Unnecessarily

If the same preparation step is used more than once in a statement, a named CTE can make the logic easier to review. Do not assume this automatically changes performance.
