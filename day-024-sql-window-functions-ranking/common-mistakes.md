# Common Ranking Mistakes

| Mistake | Why It Matters | Safer Approach |
| --- | --- | --- |
| Ranking the wrong grain | Raw rows can misrepresent business entities | Aggregate to the correct grain first |
| Forgetting `PARTITION BY` | Creates one global ranking | Add business group columns |
| Too many partition columns | Ranking restarts too often | Use only required grouping columns |
| Too few partition columns | Unrelated records are compared | Include country, category, period, or other needed groups |
| Wrong ordering direction | Top and bottom results flip | Confirm `ASC` or `DESC` |
| Confusing outer and window ordering | Display order is not rank logic | Check `ORDER BY` inside `OVER` |
| Using `ROW_NUMBER` when ties should remain | Tied records are split | Use `RANK` or `DENSE_RANK` |
| Using `RANK` when one row is required | Multiple rows can be returned | Use `ROW_NUMBER` with approved tie-breakers |
| Misunderstanding skipped ranks | Rank gaps can surprise readers | Explain `RANK` tie behaviour |
| Misunderstanding dense ranks | Dense ranks do not skip values | Use when level numbers should be compact |
| Filtering ranking alias too early | Many SQL platforms reject it | Filter in a CTE |
| Ignoring nulls | Null ordering can vary | Exclude or review null measures |
| Ignoring duplicates | Duplicates can look like ties | Validate duplicate rows separately |
| Arbitrary tie-breakers | Results can be unfair or unstable | Document the rule |
| Assuming top three means three rows | Ties can return more rows | Count output rows |
| Ranking before aggregation | Totals may be wrong | Aggregate first |
| Treating rank 1 as approved truth | Rank reflects supplied ordering only | Validate business rule |
| Not validating partitions | Missing groups can go unnoticed | Count partitions and rows |
