# Day 036 Notes - SQL Exception Reporting

## What Is an Exception?

An exception is a record, metric, group, or stage result that does not meet a documented validation rule or requires review.

## Exception Versus Error

An exception needs investigation. A confirmed error is a problem that business context has established is incorrect. Do not assume every exception is a confirmed defect.

## Exception Levels

| Level | Meaning | Example |
|---|---|---|
| Record-level | One affected business record | null customer ID |
| Metric-level | A count, total, or grouped metric mismatch | completed total mismatch |
| Stage-level | A stage, file, or population-level issue | missing expected report group |

## What Makes an Exception Investigable?

A good exception includes stage, entity key, issue category, issue type, expected value, actual value, difference, severity, source or target context, audit timestamp, source file, and review message.

## Issue Categories and Types

Use stable categories such as `REQUIRED_FIELD`, `DUPLICATE_KEY`, `MISSING_RECORD`, `UNEXPECTED_RECORD`, `VALUE_MISMATCH`, `STATUS_MISMATCH`, `COMPLETENESS`, `CONTROL_TOTAL`, `REPORTING_GRAIN`, `SOURCE_FILE`, and `DATE_COVERAGE`.

Issue type should be more specific. For example:

```text
issue_category = REQUIRED_FIELD
issue_type = NULL_CUSTOMER_ID
```

## Severity Levels

Educational levels used in this day:

- `INFO` means an observation or expected exception worth recording
- `REVIEW` means investigation is required
- `HIGH_REVIEW` means the example rule treats it as potentially important

Real severity rules require team and business agreement.

## Expected and Actual Values

Expected and actual values may be text, numeric, or date-like. When combining exception outputs with `UNION ALL`, platforms may require casting to compatible data types.

## Entity Keys

Entity keys identify what is affected:

- order ID
- customer ID
- date-country group
- source file
- metric name
- stage name

## Review Messages

Good review messages say what happened, where it happened, and what to review. "Bad data" is too vague. "Accepted order is missing from clean output. Review stage-to-clean handoff." is better.

## One Record, Multiple Issues

Two valid designs exist: one row per record with multiple flags, or one row per issue. Day 036 prefers one row per issue because it is easier to group and investigate.

## Combining Exception Types

Combined queues should use consistent columns, consistent meanings, compatible data types, and `UNION ALL`. Do not use `UNION` merely to hide accidental duplicates.

## Duplicate Exceptions

Duplicate exception rows can happen when two rules overlap. Define a conceptual key such as stage, entity key, issue type, and evidence date. Investigate duplicates instead of hiding them.

## Exception Summaries

Summarise by stage, issue category, issue type, severity, source file, and reporting date. Remember that exception-row count and affected-record count are different.

## Safe Exception Workflow

1. Define validation rule.
2. Identify failing population.
3. Define issue category.
4. Define issue type.
5. Define severity rule.
6. Capture entity key.
7. Capture expected value.
8. Capture actual value.
9. Capture audit context.
10. Write review message.
11. Align output schema.
12. Combine exceptions.
13. Check duplicate exceptions.
14. Summarise queue.
15. Hand off for review.

## Common Mistakes

- vague issue names
- no entity key
- no stage
- no expected or actual value
- no audit context
- random severity
- too many severity levels
- one giant free-text issue category
- duplicate exception rows
- using `UNION` to hide duplicates
- automatically deleting exception records
- unclear review messages
- mixing metric and record grain without documenting it
- no summary by category
- no distinction between expected and unexpected exceptions
