# Day 040 Query Explanations

Day 040 uses read-only workload analysis to explain index selection thinking. It does not create indexes.

## Index Mental Model

Business purpose: understand that an index is an additional access structure that may help some reads.

Evidence used: row counts, distinct counts, query workload, and candidate cases.

Why it matters: indexes should be considered from evidence, not guesswork.

Common risk: believing an index changes query results. It should not change the logical result.

## Scans Versus Lookups

Business purpose: compare broad table access with narrower access.

Evidence used: exact lookup patterns such as `order_id`.

Why it matters: selective lookups can be stronger index candidates.

Common risk: assuming a scan is always bad or a lookup is always chosen.

## Selectivity

Business purpose: estimate how narrow a column is.

Evidence used: `distinct_values / total_rows`.

Why it matters: high-selectivity columns often narrow rows better than low-selectivity flags.

Common risk: treating selectivity as the only decision.

## Cardinality

Business purpose: count distinct values.

Evidence used: `COUNT(DISTINCT column_name)`.

Why it matters: cardinality supports selectivity thinking.

Common risk: confusing high cardinality with automatic index benefit.

## Filter Patterns

Business purpose: identify frequent `WHERE` columns.

Evidence used: query workload frequency, importance, and filter columns.

Common risk: indexing every filtered column.

## Join Patterns

Business purpose: identify columns used to connect tables.

Evidence used: join columns such as `customer_id`.

Common risk: assuming every join column is automatically a good candidate.

## Sort Patterns

Business purpose: review `ORDER BY` patterns.

Evidence used: sort columns and frequency.

Common risk: assuming an index always removes sorting work.

## Composite Index Thinking

Business purpose: review columns commonly filtered together.

Evidence used: multi-column filter workload such as `customer_id, order_date`.

Common risk: ignoring leading-column order.

## Read/Write Trade-Offs

Business purpose: remember indexes have cost.

Evidence used: read frequency, write frequency, table size, and index count bands.

Common risk: over-indexing write-heavy ingestion tables.

## Strong Versus Weak Candidates

Business purpose: classify candidates for review.

Evidence used: selectivity band, frequency band, read/write pattern, and main reason.

Common risk: treating educational candidate ratings as real tuning formulas.

## Line-by-Line Selectivity Query

| Query part | Meaning |
|---|---|
| `WITH stats AS (...)` | Builds a reusable row-count and distinct-count step |
| `COUNT(*) AS total_rows` | Counts all rows |
| `COUNT(DISTINCT customer_id)` | Counts unique customer IDs |
| `CASE WHEN total_rows = 0 THEN NULL` | Avoids division by zero |
| `100.0 * distinct_customer_ids / total_rows` | Calculates a simple percentage |
| Final `SELECT` | Shows selectivity evidence for review |

## Signal Table

| Signal | Why it matters | Caution |
|---|---|---|
| High selectivity | May narrow rows efficiently | Not enough alone |
| High frequency | Repeated queries may justify effort | Check importance too |
| Join use | Relationship queries may benefit | Validate both sides |
| Sort use | Some designs may support sorting | Platform behaviour varies |
| Write-heavy workload | Index maintenance can hurt writes | Be conservative |
| Small table | Scan may be cheap | Avoid over-design |

