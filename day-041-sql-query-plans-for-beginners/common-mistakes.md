# Common Beginner Mistakes

| Mistake | Why it is risky | Better habit |
|---|---|---|
| Calling every table scan bad | Scans can be reasonable for small tables or broad reports | Ask whether the query needs many rows |
| Calling every lookup good | A lookup can be inefficient if many rows match | Check selectivity and context |
| Treating cost as time | Cost is an optimizer estimate, not elapsed time | Use cost as a clue only |
| Comparing costs across platforms | Different systems calculate cost differently | Compare only within the same environment |
| Treating estimated rows as actual rows | Estimates can be wrong | Validate with execution evidence when appropriate |
| Ignoring the query purpose | Plan steps only make sense in context | Start with the business question |
| Blaming one operator | One operator rarely explains everything alone | Review the whole plan |
| Over-optimising small-table scans | Small scans may not matter | Focus on meaningful workload impact |
| Ignoring join row multiplication | Joins can create more rows than expected | Check join keys and grain |
| Ignoring sort work | Large sorts can be expensive | Check row counts near the sort |
| Ignoring aggregate input size | Aggregates may process many rows before summarising | Review input row estimates |
| Running analyze-style commands carelessly | Some variants execute the query | Verify platform behaviour first |
| Assuming plan output is universal | Plans differ by database | Read platform documentation |
| Ignoring data growth | A good plan today may change later | Recheck plans as volume changes |
| Assuming the optimizer is always deterministic across systems | Optimizers differ | Use evidence from the actual environment |

## Simple Rule

Plans are evidence, not a final verdict. A beginner should use them to ask better questions.

