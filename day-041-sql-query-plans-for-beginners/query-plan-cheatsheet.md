# Day 041 Query Plan Cheatsheet

## Conceptual `EXPLAIN` Pattern

```sql
-- PLATFORM-SPECIFIC EXAMPLE - REVIEW BEFORE USE
-- EXPLAIN
-- SELECT column1, column2
-- FROM table_name
-- WHERE column1 = 'value';
```

Meaning: ask the database to show planning information. Syntax and output vary by platform.

## Analyze-Style Warning

```sql
-- CAUTION: Some platforms execute the query for analyze-style output.
-- PLATFORM-SPECIFIC EXAMPLE - REVIEW BEFORE USE
-- EXPLAIN ANALYZE
-- SELECT ...;
```

## Common Operators

| Operator | Simple meaning | Beginner reminder |
|---|---|---|
| `TABLE_SCAN` | Reads a table or substantial portion | Not automatically bad |
| `INDEX_LOOKUP` | Uses an access path to narrow rows | Not automatically good |
| `FILTER` | Applies `WHERE` conditions | Check rows before and after |
| `JOIN` | Combines rows from inputs | Watch row multiplication |
| `SORT` | Orders rows | Large sorts can be expensive |
| `AGGREGATE` | Groups and summarises rows | May process many input rows |
| `LIMIT` | Restricts final output | Does not always reduce earlier work |

## Estimated Rows

Estimated rows are expected row counts. They are not guaranteed actual rows.

## Cost

Cost is a platform-specific optimizer estimate. It is not elapsed time and should not be compared across database systems.

## Plan Review Checklist

- What is the query purpose?
- Which tables are read?
- Is the access broad or selective?
- Where are filters applied?
- What row counts are estimated?
- Are joins multiplying rows?
- Is sorting applied to many rows?
- Is aggregation processing many rows?
- Are cost values being compared only within the same context?
- Is more evidence needed before action?

## Scan Reminder

A table scan can be fine when the table is small or the query needs most rows.

## Lookup Reminder

A lookup can be useful when the filter is selective and an access path exists, but the optimizer decides.

## UNION With Day 040 Thinking

Day 040 introduced indexes. Day 041 uses plans to ask: did the database choose a scan, a lookup, or another path for this query?

