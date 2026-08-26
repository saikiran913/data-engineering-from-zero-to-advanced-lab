# Glossary

| Term | Simple meaning |
|---|---|
| Aggregation strategy | Choosing when and where to group rows |
| Business result | The real answer the query must provide |
| Column pruning | Keeping only needed columns |
| Correctness validation | Checks that prove a rewrite still means the same thing |
| CTE reuse | Using a named query step to avoid repeated logic |
| DISTINCT | SQL keyword that removes duplicate result rows |
| Early filtering | Applying filters earlier when logically safe |
| Filter pushdown concept | Moving filters closer to source rows conceptually |
| Intermediate result | Data produced between query steps |
| Join input | Rows and columns entering a join |
| Join reduction | Removing or narrowing joins safely |
| Many-to-many join | Join where both sides can repeat keys |
| Naive query | A first version that may carry unnecessary work |
| Optimized query concept | A clearer reduced-work version that preserves meaning |
| ORDER BY | SQL clause that sorts rows |
| Output grain | What one output row represents |
| Performance habit | A regular query-writing practice that avoids waste |
| Performance rewrite | A query change intended to reduce unnecessary work |
| Pre-aggregation | Grouping rows before a later join or step |
| Projection | Choosing columns in `SELECT` |
| Query shape | The structure of filters, joins, CTEs, sorts, and aggregations |
| Query simplification | Making SQL clearer and smaller while preserving meaning |
| Repeated work | Reused logic written multiple times |
| Row multiplication | More rows after a join |
| Row pruning | Keeping only needed rows |
| Semantic equivalence | Same business meaning after a rewrite |
| Unnecessary join | A join with no required business purpose |
| Unnecessary sort | Sorting with no required output reason |
| Wide row | A row carrying many columns |
| Workload | The real set of queries and usage patterns |

