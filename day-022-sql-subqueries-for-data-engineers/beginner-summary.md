# Beginner Summary

## What Learners Should Remember

A subquery is a query inside another query. The inner query solves one smaller step, and the outer query uses the result. This is useful when a data question depends on another data question.

For example, to find orders above average value, first calculate the average order amount. Then use that one value to filter the orders table. That inner average query is a scalar subquery because it returns one value.

`IN` compares a value with a list returned by the inner query. A common example is finding customers whose `customer_id` appears in the orders table. For beginner use, the inner query should return one comparable column.

`NOT IN` means the value should not appear in the inner query result. It needs special care because `NULL` values can make the result confusing. A safer `NOT IN` query filters out `NULL` values inside the subquery. For missing-record validation, `NOT EXISTS` is often clearer and safer.

`EXISTS` checks whether at least one matching row exists. `NOT EXISTS` checks whether no matching row exists. These patterns often use a correlated subquery, where the inner query refers to the current row from the outer query. The condition that connects the two queries is very important.

A subquery in the `FROM` clause creates a temporary table-like result. This is useful when you first need to group data, such as calculating total order value per customer, and then filter the grouped result.

Subqueries are especially useful for Data Engineering validation. They can help find customers without orders, orders without payments, products without sales, source records missing from targets, target records missing from sources, and values above expected aggregates.

## Mental Model

Answer a smaller question first. Check that answer. Then use it to solve the larger question.

## Final Warnings

> A subquery is not automatically better than a JOIN or a CTE. The best choice depends on the problem, readability, platform, and team standards. Beginners should first focus on correctness and clarity.

> Before using a subquery inside a larger query, run the inner query by itself and confirm that it returns the expected rows and columns.

## What Comes Next

Day 023 - SQL Common Table Expressions for Data Engineers: Readable Query Steps, Reusable Logic, and Validation Workflows.

CTEs provide another way to break complex logic into named steps.
