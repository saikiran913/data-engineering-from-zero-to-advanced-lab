# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| `AVG OVER` | Windowed average | Moving sales average |
| Boundary row | Early or final row with partial frame | First row in moving average |
| `COUNT OVER` | Windowed count | Count rows so far |
| Cumulative average | Average from start to current row | Sales average so far |
| Cumulative count | Count from start to current row | Load count so far |
| Cumulative maximum | Highest value so far | Highest sales observed |
| Cumulative metric | Metric from start through current row | Running records loaded |
| Cumulative minimum | Lowest value so far | Shortest duration so far |
| Current row | Row being calculated | Today's sales row |
| `CURRENT ROW` | Frame endpoint at current row | Stop calculation here |
| Data grain | What one row represents | One region-date row |
| Explicit frame | Written frame definition | `ROWS BETWEEN ...` |
| Frame | Rows included in calculation | Current plus two previous rows |
| Frame row count | Number of rows in frame | Early row count of 1 |
| `MAX OVER` | Windowed maximum | Highest value so far |
| `MIN OVER` | Windowed minimum | Lowest value so far |
| Moving average | Average over recent rows | Three-row average |
| Moving sum | Sum over recent rows | Three-row sum |
| Null measure | Missing metric value | Blank spend |
| Ordering column | Column defining sequence | `sale_date` |
| Partition | Group where calculation restarts | Region |
| Preceding row | Row before current row | Previous sales date |
| `RANGE` | Value-based frame style | Out of scope for examples |
| Rolling metric | Moving metric over recent rows | Moving average |
| Row-based window | Frame that counts rows | Two previous rows |
| `ROWS` | Physical row frame style | Day 026 frame type |
| Running total | Total so far | Cumulative sales |
| `SUM OVER` | Windowed sum | Running total |
| `UNBOUNDED PRECEDING` | Start at first row | From beginning of partition |
| Window frame | Rows included in window calculation | Unbounded to current row |
| Windowed aggregate | Aggregate used over row window | `SUM(...) OVER (...)` |
