# Day 040 Practice Questions

## Section A: Concept Checks

1. What is an index?
2. Does an index change query meaning?
3. What is a full scan conceptually?
4. What is an index lookup conceptually?
5. What is selectivity?
6. What is cardinality?
7. Why can high selectivity be useful?
8. Why is low selectivity not an automatic no?
9. Why do frequent filters matter?
10. Why do frequent joins matter?
11. Why can sort patterns matter?
12. What is a composite index conceptually?
13. Why does leading-column order matter?
14. What is write overhead?
15. Why do indexes consume storage?
16. What is over-indexing?
17. Why does table size matter?
18. Why does workload frequency matter?
19. Why do operational and analytical systems differ?
20. Why is platform evidence needed?
21. Why should index DDL remain conceptual in Day 040?
22. Why is an index not a substitute for good SQL?

## Section B: Good Candidate or Not?

Classify each as strong candidate, possible candidate, weak candidate, platform review, or insufficient information.

1. Frequent exact lookup by high-selectivity `order_id`.
2. Frequent customer order history by `customer_id`.
3. Status dashboard filtering four statuses.
4. Rare admin lookup by source file.
5. Write-heavy ingestion table with many proposed indexes.
6. Customer/date filter used daily.
7. Analytical warehouse fact table with platform-specific pruning.
8. Small reference table with ten rows.
9. Frequent customer join on `customer_id`.
10. Low-frequency query on high-selectivity amount.
11. Sort-heavy recent order report.
12. Composite candidate with ignored column order.
13. Overlapping composite candidate.
14. Column appears once in a `WHERE` clause.
15. Read-heavy customer lookup by unique customer ID.

## Section C: Complete the SQL

1. Count rows in `orders_workload`.
2. Count distinct order IDs.
3. Calculate customer ID selectivity.
4. List high-selectivity columns from the profile catalog.
5. List low-selectivity columns from the profile catalog.
6. Summarise frequent filters.
7. Summarise join workload.
8. Summarise sort workload.
9. Count read-heavy workload entries.
10. Count write-heavy workload entries.
11. Classify candidate ratings educationally.
12. List strong candidates.
13. List weak candidates.
14. Review composite candidates.
15. Summarise trade-off cases by write frequency.

## Section D: Fix the Mistake

1. Index every column.
2. Index every `WHERE` column.
3. Ignore selectivity.
4. Ignore workload frequency.
5. Ignore table size.
6. Ignore write cost.
7. Treat low selectivity as never index.
8. Treat high selectivity as always index.
9. Ignore composite column order.
10. Assume every sort gets faster.
11. Treat warehouse and operational databases the same.
12. Leave `CREATE INDEX` executable.
13. Claim optimizer behaviour without evidence.
14. Optimise one rare query permanently.
15. Treat educational score as real tuning formula.

## Section E: Design the Index-Thinking Review

For each scenario, identify table, grain, query pattern, filter, join, sort, selectivity, frequency, importance, read/write pattern, candidate rating, and trade-off.

1. Exact order lookup.
2. Customer order history.
3. Recent order date report.
4. Status dashboard.
5. Country report.
6. Customer-order join.
7. Customer signup range.
8. Segment report.
9. Write-heavy order ingestion.
10. Composite customer/date filter.

## Section F: Mini Case Study

Using all supplied workload files:

1. Identify important queries.
2. Profile candidate columns.
3. Calculate selectivity.
4. Review filter frequency.
5. Review join frequency.
6. Review sort frequency.
7. Review read/write balance.
8. Identify strong candidates.
9. Identify weak candidates.
10. Propose one composite-index candidate conceptually.
11. Explain trade-offs.
12. Build final candidate summary.

## Answer Key

### Section A Answers

1. An index is an additional access structure.
2. No. It should not change logical results.
3. A scan examines a larger part of a table.
4. A lookup narrows candidate rows through an access structure conceptually.
5. Selectivity is distinct values divided by total rows approximately.
6. Cardinality is the number of distinct values.
7. It can narrow rows more effectively.
8. Workload, platform, and table design still matter.
9. Repeated patterns may justify extra structure.
10. Joins repeatedly compare key values.
11. Some index designs may interact with sorting.
12. A multi-column index concept.
13. Composite indexes are designed around column sequence.
14. Extra maintenance work during writes.
15. Index structures require extra space.
16. Too many, duplicate, overlapping, or unused indexes.
17. Small tables may not benefit much.
18. Rare queries may not justify permanent overhead.
19. Warehouses may use pruning, clustering, and columnar strategies.
20. Optimizer behaviour varies.
21. The lesson is safe and conceptual.
22. Bad query design still needs fixing.

### Section B Answers

| # | Classification | Reason |
|---|---|---|
| 1 | Strong candidate | Frequent, important, high selectivity |
| 2 | Possible candidate | Frequent customer filter, medium selectivity |
| 3 | Weak candidate | Low selectivity needs more evidence |
| 4 | Weak candidate | Rare and low selectivity |
| 5 | Platform review | Write-heavy trade-off |
| 6 | Strong candidate | Frequent composite pattern |
| 7 | Platform review | Warehouse behaviour differs |
| 8 | Weak candidate | Small table may scan cheaply |
| 9 | Possible candidate | Join column signal |
| 10 | Possible candidate | High selectivity but low frequency |
| 11 | Possible candidate | Sort can matter but needs evidence |
| 12 | Insufficient information | Need actual query pattern order |
| 13 | Platform review | Overlap needs evidence |
| 14 | Insufficient information | One WHERE occurrence is not enough |
| 15 | Strong candidate | Read-heavy unique lookup |

### Section C Sample Answers

```sql
-- 1 and 2. Row count and distinct order IDs.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_order_ids
FROM orders_workload;
```

```sql
-- 3. Customer ID selectivity.
WITH stats AS (
    SELECT
        COUNT(*) AS total_rows,
        COUNT(DISTINCT customer_id) AS distinct_customer_ids
    FROM orders_workload
)
SELECT
    CASE
        WHEN total_rows = 0 THEN NULL
        ELSE 100.0 * distinct_customer_ids / total_rows
    END AS customer_id_selectivity_percentage
FROM stats;
```

```sql
-- 4 and 5. Selectivity bands.
SELECT
    table_name,
    column_name,
    selectivity_band
FROM column_profile_catalog
WHERE selectivity_band IN ('HIGH', 'LOW');
```

```sql
-- 6. Frequent filters.
SELECT query_id, query_name, table_name, filter_columns
FROM query_workload_catalog
WHERE frequency_band = 'HIGH'
  AND filter_columns <> '';
```

```sql
-- 7 and 8. Join and sort workload.
SELECT query_id, query_name, join_columns, sort_columns
FROM query_workload_catalog
WHERE join_columns <> ''
   OR sort_columns <> '';
```

```sql
-- 9 and 10. Workload pattern counts.
SELECT read_or_write_pattern, COUNT(*) AS query_count
FROM query_workload_catalog
GROUP BY read_or_write_pattern;
```

```sql
-- 11 through 14. Candidate review.
SELECT
    case_id,
    candidate_columns,
    candidate_rating,
    main_reason
FROM index_candidate_cases
ORDER BY candidate_rating, case_id;
```

```sql
-- 15. Trade-off summary.
SELECT
    write_frequency,
    COUNT(*) AS case_count
FROM workload_tradeoff_cases
GROUP BY write_frequency;
```

### Section D Answers

1. Review workload first.
2. Add selectivity, frequency, and write-pattern evidence.
3. Profile cardinality.
4. Review frequency and importance.
5. Consider table size.
6. Review write maintenance.
7. Say low selectivity needs stronger evidence.
8. Say high selectivity is one signal only.
9. Match composite order to query patterns.
10. Validate sort behaviour in platform tools later.
11. Review platform type.
12. Comment DDL as conceptual only.
13. Avoid unsupported query-plan claims.
14. Review total workload.
15. Treat ratings as educational only.

### Section E Answer Guidance

Good answers should connect query pattern, selectivity, frequency, importance, table size, and read/write trade-off. Ratings can differ if the reasoning is documented.

### Section F Answer Guidance

A complete answer should identify exact lookups, customer/date filters, join-heavy customer patterns, weak low-cardinality status or country candidates, write-heavy ingestion risks, platform-review warehouse cases, and one conceptual composite candidate such as `customer_id, order_date`.

