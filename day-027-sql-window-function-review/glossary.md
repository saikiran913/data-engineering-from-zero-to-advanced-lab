# Glossary

| Term | Simple Meaning |
|---|---|
| `AVG OVER` | Calculates an average while keeping detail rows visible |
| `COUNT OVER` | Counts rows across a window while keeping detail rows visible |
| `DENSE_RANK` | Gives tied rows the same rank without rank gaps |
| `LAG` | Returns a value from a previous row |
| `LEAD` | Returns a value from a next row |
| `MAX OVER` | Finds the maximum value across a window |
| `MIN OVER` | Finds the minimum value across a window |
| `RANK` | Gives tied rows the same rank and leaves gaps |
| `ROW_NUMBER` | Assigns a unique sequence number to each row |
| `SUM OVER` | Calculates a sum across a window |
| aggregate-before-window | Group rows first, then apply a window calculation |
| boundary policy | Rule for first or last rows that have no previous or next row |
| business grain | What one row means in business terms |
| cumulative analysis | Analysis that includes current and earlier rows |
| cumulative frame | A frame from the first row in the sequence to the current row |
| data grain | The level of detail in the data |
| dense rank | Ranking that keeps ties without gaps |
| exception queue | A read-only list of records that need review |
| explicit frame | A written frame clause that defines included rows |
| final reconciliation | Comparing final calculated totals with source totals |
| frame row count | Number of rows included in a window frame |
| global rank | Rank across the full result instead of inside groups |
| group rank | Rank that restarts inside each partition |
| input grain | The grain of the source table |
| moving average | Average over a limited set of recent rows |
| moving sum | Sum over a limited set of recent rows |
| output grain | The grain of the final result |
| partition | A group where a window calculation restarts |
| ranking | Assigning positions to rows |
| review queue | A list of rows that need investigation |
| rolling analysis | Analysis over recent rows |
| row comparison | Comparing a row with previous or next rows |
| running total | A total that grows as rows move forward |
| sequence | The ordered row path used by a window function |
| tie policy | Rule for equal ranking values |
| tie-breaker | Extra ordering column used to decide between equal values |
| validation | Checks that help confirm the query result is trustworthy |
| window function | SQL function that calculates across related rows without collapsing them |
| window ordering | The `ORDER BY` inside `OVER` |
