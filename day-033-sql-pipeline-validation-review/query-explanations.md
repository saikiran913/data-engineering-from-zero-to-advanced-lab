# Day 033 Query Explanations

Day 033 uses validation SQL as evidence. Each query compares a defined population at a defined grain. When a result shows a difference, the next step is review, not automatic correction.

## File Map

| File | Business Question | Source Tables | Operation Used | Output Shape | Expected Behaviour | Common Validation |
|---|---|---|---|---|---|---|
| `row-count-validation.sql` | Did rows move between stages as expected? | source, stage, clean, reporting | `COUNT`, CTEs | count summaries | differences must be explained | source-to-stage and accepted-review counts |
| `key-and-duplicate-validation.sql` | Are business keys complete and unique? | source, stage, clean, reporting | `COUNT(DISTINCT)`, `GROUP BY`, `HAVING` | duplicate and distinct-key checks | clean and reporting grains should be unique | duplicate keys |
| `control-total-validation.sql` | Do numeric totals reconcile? | source, stage, clean, reporting | `SUM`, CTEs | metric comparisons | totals should match after documented rules | amount and count differences |
| `completeness-validation.sql` | Are required values, dates, categories, and files present? | source, stage, reporting | null checks, expected lists | completeness evidence | required fields should be present | nulls, missing files, missing dates |
| `source-target-reconciliation.sql` | Which keys exist only on one side? | source, stage, clean | joins | source-only, target-only, mismatch rows | unexplained keys need review | missing and extra keys |
| `grouped-reconciliation.sql` | Do totals match by group? | clean, reporting | grouped CTEs and joins | group-level comparisons | grouped totals should reconcile | date and country differences |
| `exception-reporting.sql` | What needs investigation? | clean, reporting | CTEs, `UNION ALL` | exception rows | issues remain visible | duplicate, target-only, null metric exceptions |
| `validation-summary.sql` | What is the overall validation status? | stage, clean, reporting, rules | summary CTEs | one row per check | `PASS` or `REVIEW` based on rule | issue counts |
| `pipeline-checkpoint-review.sql` | Which checks fit each scenario? | rule and case files | filters and grouping | case summaries | stage decisions are documented | rule coverage |
| `validation-debugging-lab.sql` | How can validation mislead us? | source, clean, reporting | targeted checks | diagnostic evidence | one check is not enough | grouped checks after totals |
| `integrated-validation-workflow.sql` | How do checks work together? | all main datasets | CTEs and `UNION ALL` | summary and exception outputs | evidence supports review | counts, keys, totals |

## Row Counts

Row counts answer "how many rows are here?" They are useful first checks but not proof that data is equivalent. A source extract may have duplicate order events, while clean output should have one row per order.

## Keys and Duplicates

Distinct-key checks compare total rows with unique business keys. Duplicate checks use `GROUP BY` and `HAVING`. Reporting grain is checked with a grouped composite key: `report_date` plus `country_group`.

## Control Totals

Control totals compare numeric evidence such as completed amount, refund amount, and completed order count. They catch issues that row counts may miss.

## Grouped Reconciliation

Grouped reconciliation compares totals by date and country group. This is important because grand totals can hide offsetting issues.

## Completeness

Completeness checks ask whether required values are present. Day 033 checks nulls, source files, dates, statuses, and country groups.

## Source-Only and Target-Only Keys

Source-only keys exist in source but not target. Target-only keys exist in target but not source. Either can be expected or unexplained. The query output is evidence for review.

## Exception Reporting

Exception reports preserve issue details. They include stage name, key, check type, actual value, severity, and review message. They should not modify data.

## SQL Platform Notes

`COUNT(DISTINCT col1, col2)` differs across SQL platforms, so Day 033 uses grouped checks for composite keys. String concatenation and casting syntax can also vary by platform.
