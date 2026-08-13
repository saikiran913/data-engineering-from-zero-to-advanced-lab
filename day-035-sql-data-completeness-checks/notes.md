# Day 035 Notes - SQL Data Completeness Checks

## What Is Data Completeness?

Data completeness asks whether the required data expected for a defined population is present. It does not prove that values are correct; it only checks whether expected data exists.

## Completeness Dimensions

| Completeness Dimension | Example Question |
|---|---|
| Field completeness | Is `customer_id` present when required? |
| Key completeness | Did every expected order ID arrive? |
| Record completeness | Did all expected records reach the next stage? |
| Date completeness | Are all expected reporting dates represented? |
| Category completeness | Are all expected statuses or groups present? |
| File completeness | Did all expected source files arrive? |

## Required Versus Optional Fields

Business rules define requiredness. Grain matters too. A field required in clean orders may be optional in an early source extract. A null can be valid for an optional field, but a null in a required business key usually needs review.

## Nulls Versus Blanks

`NULL` means no value is stored. An empty string is a text value with no characters. A whitespace-only value looks blank to people but may not be null. Source systems handle blanks differently, so checks should document what they are looking for.

## Key Completeness

Key completeness compares expected keys with actual keys. Useful outputs include source-only keys, target-only keys, and missing expected keys.

## Expected-Record Completeness

An expected-record check compares an expected catalogue or expected population with the actual dataset. Some missing records may be explained by documented filters, deduplication, or review rules. Unresolved missing records need review.

## Date Coverage

Date coverage can use minimum date, maximum date, and explicitly listed expected dates. Min and max dates are useful, but they do not prove all middle dates are present.

## Category and Status Coverage

Expected categories can include country groups and statuses such as `COMPLETED`, `PENDING`, `REFUNDED`, and `CANCELLED`. Missing categories may be valid if no records are expected, but that should be documented.

## File Completeness

File completeness checks expected file names against actual file names. A missing, duplicate, or extra file can explain missing records. File scheduling remains conceptual in this lesson.

## Stage Completeness

Source-to-stage checks compare source keys to stage keys. Stage-to-clean checks compare accepted stage rows to clean output. Clean-to-reporting checks usually need grouped completeness because reporting is aggregated.

## Completeness Percentage

```text
complete records / expected records * 100
```

Handle zero expected records carefully. Duplicates can distort percentages, and a percentage alone is not enough. Always keep an issue list.

## Expected Exclusions

Expected exclusions include duplicate source events removed, review rows excluded from clean output, and cancelled orders excluded from completed-sales reporting.

## Unexplained Gaps

Unexplained gaps include an accepted order missing from clean, an expected report date absent, a required source file missing, or an expected status category absent without explanation.

## Safe Completeness Workflow

1. Define expected population.
2. Define actual population.
3. Define grain.
4. Define key.
5. Define required fields.
6. Define expected dates.
7. Define expected categories.
8. Define expected files.
9. Compare expected and actual.
10. Count gaps.
11. Calculate simple coverage where useful.
12. Build exception output.
13. Explain expected exclusions.
14. Review unexplained gaps.

## Common Mistakes

- treating every null as failure
- no required-field definition
- no expected population
- comparing different grains
- counting duplicates as completeness
- only checking min and max dates
- no category, status, or file coverage
- ignoring source-only and target-only records
- assuming 100 percent field completeness means values are correct
- divide-by-zero in percentages
- using percentage without issue list
- generating missing records instead of reporting gaps
