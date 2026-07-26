# Common Window Function Mistakes Review

## Ranking Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Query |
|---|---|---|---|---|
| Wrong function | Using `ROW_NUMBER` when ties must remain | Tied top rows may disappear | Use `RANK` | Count rows where rank is 1 |
| Wrong partition | Ranking all countries together | Each country may need its own winner | Add `PARTITION BY country` | Count distinct countries in output |
| Wrong direction | Ordering sales ascending for top sales | Returns bottom rows | Use `ORDER BY total_sales DESC` | Inspect top and bottom samples |
| Arbitrary tie-breaker | Sorting by an unrelated column | The selected row may not be explainable | Document a business tie-breaker | Show tied source values |
| Top three confusion | Assuming rank 1 to 3 means exactly three rows | Ties can create more than three rows | Choose row-count or tie policy | Count selected rows |

## `LAG` and `LEAD` Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Query |
|---|---|---|---|---|
| Wrong sequence | Ordering by load time when event date is needed | Compares the wrong rows | Order by business date and load tie-breaker | Inspect sequence |
| Missing tie-breaker | Duplicate dates have unstable order | Previous value may change between runs | Add `loaded_at` | Count duplicate dates |
| Boundary null confusion | Treating first-row `NULL` as bad data | Review queues get false alerts | Label boundary rows | Count first rows |
| Late-arriving data | File load order differs from business date | Trends may look wrong | Order by business date | Compare loaded date and metric date |
| Default zero hiding history | Replacing missing previous value with zero too early | Missing history is hidden | Keep boundary null visible | Count boundary rows |

## Cumulative Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Query |
|---|---|---|---|---|
| Missing explicit frame | Platform default may surprise beginners | Results may vary by platform | Use `ROWS BETWEEN ...` | Review frame clause |
| Wrong grain | Running total over duplicate rows | Double counting may occur | Prepare correct grain first | Count rows per entity-date |
| Duplicate rows | Repeated source rows inflate totals | Final totals are too high | Investigate duplicate rows | Reconcile final totals |
| Missing-date interpretation | Three rows are treated as three calendar days | Gaps are ignored | Call it a three-row frame | Check date gaps |
| No reconciliation | Final running value is never checked | Errors can pass silently | Compare final total to source total | Run grouped source total |

## Mixed-Query Mistakes

| Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Query |
|---|---|---|---|---|
| Too many calculations at once | Hard to isolate bad logic | One mistake affects many columns | Build CTE stages | Validate each stage |
| Nested windows | Window functions inside window arguments | Many platforms reject this | Split into CTEs | Review each calculated column |
| Repeated logic | Same expression copied many times | Inconsistent edits are easy | Use clear CTE names | Compare stage outputs |
| Ambiguous columns | Joined sources have same names | Query meaning is unclear | Qualify column names | Inspect selected aliases |
| No validation | Query is trusted because it runs | Silent logic errors remain | Add review queries | Use counts and reconciliation |
| Filtering too early | Rows needed for history disappear | Previous or running values change | Calculate first, filter later | Compare source row counts |
| Filtering too late | Too many rows reach final output | Reports become noisy | Add final review flags | Count issue rows |
