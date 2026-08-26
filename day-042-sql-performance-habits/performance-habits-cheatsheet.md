# Performance Habits Cheatsheet

## Projection Checklist

- Avoid `SELECT *` in stable queries.
- Select only required columns.
- Keep output contracts clear.
- Confirm no downstream column is removed accidentally.

## Filtering Checklist

- Filter to the required business population.
- Use the correct business date.
- Filter earlier only when logically safe.
- Validate counts, dates, and totals.

## Join Checklist

- Confirm why each join exists.
- Check whether the join supplies a column, filter, or rule.
- Check join-key uniqueness.
- Watch for row multiplication.

## Aggregation Checklist

- Define output grain.
- Aggregate early only if downstream grain allows it.
- Do not lose required detail.
- Compare grouped totals.

## DISTINCT Checklist

- Use `DISTINCT` only when unique output is the business requirement.
- Do not use it to hide a bad join.
- Investigate duplicate causes.

## ORDER BY Checklist

- Sort final output only when required.
- Keep top-N sorts when needed.
- Avoid intermediate sorting without a purpose.

## Repeated-Work Checklist

- Look for repeated aggregates.
- Look for repeated `CASE` expressions.
- Use CTEs for clarity.
- Remember CTE physical behaviour varies by platform.

## Rewrite Validation Checklist

- Row count
- Distinct key count
- Control totals
- Grouped totals
- Min/max dates
- Missing keys
- Extra keys
- Column contract
- Output grain

## Query-Plan Follow-Up Questions

- Did the rewrite reduce columns?
- Did it reduce rows?
- Did it reduce joins?
- Did it remove unnecessary sorts?
- Did it preserve the same business result?
- Does plan evidence support the hypothesis?

