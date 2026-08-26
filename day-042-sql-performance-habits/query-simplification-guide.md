# Query Simplification Guide

## Step 1: State the Business Result

Write down what the query must answer before changing it.

## Step 2: Define Grain

Decide what one output row represents: one order, one customer, one item line, or one summary group.

## Step 3: Keep Required Columns

Remove columns that do not support output, filters, joins, calculations, or validation.

## Step 4: Keep Required Rows

Filter to the needed business population.

## Step 5: Review Every Join

Ask whether each join supplies a required column, filter, rule, or validation relationship.

## Step 6: Check Join-Key Uniqueness

Use grouped counts to find duplicate keys before joining.

## Step 7: Reduce Join Inputs

Carry only needed join columns and useful attributes.

## Step 8: Choose Aggregation Stage

Aggregate early only when the required grain allows it.

## Step 9: Question DISTINCT

Ask whether unique rows are the real business requirement or whether `DISTINCT` is hiding a problem.

## Step 10: Question ORDER BY

Keep sorting when final order or top-N logic is required. Remove it when no consumer requires order.

## Step 11: Remove Repeated Logic

Use clear CTEs or derived columns for repeated calculations.

## Step 12: Validate Equivalence

Compare counts, keys, totals, grouped outputs, and date ranges.

## Step 13: Inspect Plan Evidence Later

Use query plans to support the hypothesis. Platform behaviour still matters.

## Query-Review Template

| Review item | Notes |
|---|---|
| Query goal |  |
| Output grain |  |
| Required columns |  |
| Row filters |  |
| Joins |  |
| Join keys |  |
| Aggregation grain |  |
| DISTINCT reason |  |
| Sort reason |  |
| Repeated logic |  |
| Correctness checks |  |
| Plan questions |  |
| Rewrite decision |  |

