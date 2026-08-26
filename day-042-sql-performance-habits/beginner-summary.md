# Beginner Summary

Day 042 is about practical SQL performance habits. The main idea is simple: keep only what the query needs, reduce rows and columns safely, avoid unnecessary joins and sorts, then prove that the rewritten query still returns the same business result.

Projection means choosing columns. `SELECT *` can be useful for quick exploration, but stable queries should usually list columns explicitly. This makes the output contract clearer and avoids carrying unused columns through later steps.

Filtering means choosing rows. If a report needs completed August orders, the query should not carry cancelled orders or unrelated dates through every step. Filtering earlier can reduce later work, but only when it is logically safe. Moving filters across outer joins or aggregations can change results.

Joins should have a reason. A join may add a required column, apply a business filter, enforce an eligibility rule, or support validation. If a joined table contributes nothing, it may be unnecessary. But never remove a join until its business role is understood.

Row multiplication happens when joins increase row counts. This can be expected, such as one order joining to many item lines. It can also be accidental, such as joining on duplicate keys when the output should remain one row per order.

Pre-aggregation can help when the downstream grain allows it. Aggregating item lines to order level before joining to orders is useful when the final output is order-level. Aggregating by customer too early is wrong if the report still needs order-level detail.

`DISTINCT` should be used intentionally. It is fine when the business question asks for unique values. It should not be used to hide an incorrect join or undefined grain.

`ORDER BY` should have a purpose. Sorting is required for readable reports and top-N logic, but unnecessary sorting can add work.

Repeated logic, such as repeated aggregations or repeated `CASE` expressions, can make queries harder to maintain. CTEs can improve readability, but CTE performance behaviour varies by platform.

Remember the final warnings:

> A faster query is not better if it changes the business result. Performance rewrites must preserve the intended grain, filters, joins, and calculations.

> Filtering earlier can reduce work, but only when the filter is logically safe at that stage. Moving a filter across joins or aggregations can change results.

> `DISTINCT` can remove duplicate rows, but it should not be used to hide an incorrect join or an undefined output grain.

> Day 042 teaches general performance habits. Actual performance depends on the SQL platform, optimizer, data volume, statistics, storage design, and workload.

Day 043 will consolidate performance reasoning through broader query-review exercises and validation-first optimization thinking.

