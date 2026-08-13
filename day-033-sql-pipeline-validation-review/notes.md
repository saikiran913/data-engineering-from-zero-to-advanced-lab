# Day 033 Notes - SQL Pipeline Validation Review

## What Is Pipeline Validation?

Pipeline validation checks whether data is complete, consistent, reconciled, and suitable for downstream handoff. It helps answer: did the data move from source to destination correctly?

Validation is evidence. It should describe the source population, target population, grain, key, expected relationship, actual result, and any exception.

## Validation Is More Than Row Counts

| Validation Dimension | Example Question |
|---|---|
| Row count | Did all expected rows arrive? |
| Keys | Are required business keys present? |
| Duplicates | Is the expected grain unique? |
| Totals | Do important numeric totals reconcile? |
| Completeness | Are required dates, categories, and files present? |
| Exceptions | Which records require investigation? |

## Row-Count Validation

Row-count validation compares counts between stages. Useful counts include source count, staged count, accepted count, review count, clean count, and reporting count.

Equal counts are not always expected. Raw source data may contain duplicate events. Staging may separate accepted and review rows. Clean output may exclude review rows. Reporting output may aggregate many clean rows into fewer report rows.

## Distinct-Key Validation

Row count tells how many rows exist. Distinct-key count tells how many unique business keys exist. If clean data promises one row per order, `order_id` should be unique.

Composite keys use more than one column. Reporting metrics may be unique by `report_date` and `country_group`. Because multi-column `COUNT(DISTINCT ...)` syntax varies by platform, Day 033 uses grouped checks.

## Control Totals

A control total is a numeric value used to validate movement or transformation. Examples:

- sum of `order_amount`
- sum of completed amount
- count of completed orders
- count of refunds
- pending order count

Control totals provide evidence that row counts alone cannot provide.

## Grouped Control Totals

Global totals can hide problems. A total may match overall while one country is overstated and another is understated. Grouped control totals compare metrics by date, country group, status, source file, or reporting category.

## Completeness

Completeness asks whether required data is present.

| Completeness Type | Beginner Question |
|---|---|
| Record completeness | Are expected records present? |
| Key completeness | Are business keys present? |
| Column completeness | Are required columns populated? |
| Date completeness | Are expected dates represented? |
| Category completeness | Are expected statuses or groups present? |
| File completeness | Did expected source files appear? |

Nulls are not always failures. Whether null is allowed depends on business meaning.

## Source-File Completeness

Source-file checks compare expected files with received files. A missing file, duplicate file, or late file can explain row-count differences. Day 033 keeps scheduling and delivery tooling out of scope.

## Date Completeness

Date checks use minimum dates, maximum dates, missing expected dates, and extra unexpected dates. Business calendars can be more complicated in real systems, but this lesson keeps the concept simple.

## Category Completeness

Category checks confirm expected statuses and groups. Missing, unexpected, or null categories can cause reporting gaps.

## Source-Target Reconciliation

Source-target reconciliation compares keys and values across stages:

- source-only keys exist in source but not target
- target-only keys exist in target but not source
- matched keys exist in both
- changed values may indicate transformation, error, or expected business logic
- expected exclusions must be documented
- unexplained exclusions need review

## Expected Versus Unexplained Differences

Expected differences include duplicate raw events removed, review records excluded from clean output, cancelled records excluded from completed-sales metrics, and reporting rows aggregated.

Unexplained differences include a clean key missing with no review reason, an amount total changing unexpectedly, one reporting group missing, or a target-only order with no source record.

## Tolerance Concept

Some checks require an exact match. Others may allow a documented tolerance or expected variance. Tolerances are business rules. They should not be guessed inside SQL.

## Exception Reporting

Exception reports list records or metrics needing investigation. They may include:

- stage name
- entity key
- check type
- expected value
- actual value
- difference
- severity
- review message

Exception reports should not automatically delete, overwrite, or correct source data.

## Validation Summary

Useful validation summary fields include check ID, stage, check type, expected value, actual value, difference, issue count, status, and review message.

## Safe Validation Workflow

1. Define source population.
2. Define target population.
3. Align grain.
4. Define expected differences.
5. Compare row counts.
6. Compare distinct keys.
7. Inspect duplicates.
8. Compare control totals.
9. Compare grouped totals.
10. Check completeness.
11. Create exceptions.
12. Produce summary.
13. Investigate unexplained differences.
14. Document evidence.

## Common Mistakes

- relying only on row count
- comparing different grains
- missing expected-difference rules
- skipping distinct-key checks
- skipping duplicate checks
- skipping numeric controls
- skipping grouped reconciliation
- skipping date, category, or file coverage
- treating all nulls as failures
- ignoring target-only or source-only rows
- inventing arbitrary tolerance
- hiding exceptions in aggregate totals
- assuming a zero-row result proves the query logic is correct
- using an incomplete source population
- comparing different date ranges
- keeping no validation evidence
- automatically correcting data instead of sending it to review
