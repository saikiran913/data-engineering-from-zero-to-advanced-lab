# Query Explanations

## Vertical Thinking Is Not the Focus Today

Day 027 focuses on window calculations over rows that already belong to one analytical dataset. Some validation outputs use `UNION ALL` to stack similar review messages, but the main lesson is choosing and validating window functions.

## `function-choice-practice.sql`

Business question: which function family fits the request?

Source tables used: all sample tables.

Operation used: `GROUP BY`, ranking, `LAG`, `LEAD`, cumulative frames, and moving frames.

Output shape: small practice outputs that show the function choice and validation step.

Why it matters: a data engineer should not choose a function because it is familiar. The function must match the question.

## `ranking-review.sql`

Business question: which rows are top, bottom, tied, or uniquely selected?

Source tables used: customer, product, campaign, pipeline, and regional history.

Operation used: `ROW_NUMBER`, `RANK`, and `DENSE_RANK`.

Output shape: ranked rows and validation summaries.

Common validation: count partitions, selected rows, tied top rows, and null measures.

## `lag-lead-review.sql`

Business question: what changed compared with the previous or next row?

Source tables used: customer activity, product history, campaign history, regional sales, and pipeline quality.

Operation used: `LAG` and `LEAD`.

Expected row behaviour: first rows may have no previous value, and last rows may have no next value.

Common validation: boundary count, duplicate ordering count, missing dates, and review status.

## `cumulative-review.sql`

Business question: what is the value so far, or over recent rows?

Source tables used: customer, regional, pipeline, campaign, and product history.

Operation used: aggregate window functions with explicit `ROWS` frames.

Output shape: original rows plus running or moving metrics.

Common validation: reconcile final cumulative totals with grouped source totals.

## `mixed-window-analysis.sql`

Business question: how can ranking, row comparison, and cumulative metrics appear in one review workflow?

Operation used: CTE stages. Each stage adds a clear calculation.

Why it matters: mixed window queries are useful, but they can hide mistakes. Validate one calculated column at a time.

## `debugging-window-queries.sql`

Business question: what can go wrong?

Operation used: labelled teaching examples with safer corrected queries.

Why it matters: many window-function problems are business-rule mistakes, not syntax errors.

## `validation-workflows.sql`

Business question: can the result be trusted?

Operation used: source counts, null checks, duplicate-ordering checks, boundary checks, reconciliation, and `UNION ALL` review queues.

Output shape: small review tables that identify records or counts needing investigation.

## Important Distinctions

| Concept | What to Remember |
|---|---|
| Exact row position | Use ranking |
| Previous or next value | Use `LAG` or `LEAD` |
| Value so far | Use cumulative frame |
| Recent rows | Use moving frame |
| One summary row per group | Use `GROUP BY` |
| Validation | Run separate checks before trusting combined output |

## Final Reminder

A review query should identify records for investigation. It should not automatically delete, overwrite, or approve source data.
