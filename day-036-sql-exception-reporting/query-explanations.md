# Day 036 Query Explanations

Day 036 turns validation findings into investigation-friendly outputs. The goal is not only to find a problem. The goal is to return enough evidence for another person to understand what needs review.

## Exception Output Shape

Most Day 036 queries use a consistent review-queue shape:

| Output column | Beginner meaning |
|---|---|
| `exception_level` | Whether the issue is about one record, one metric, or one stage |
| `stage_name` | Where the issue was found |
| `entity_key` | The record, metric, file, or group affected |
| `issue_category` | A controlled family of issues |
| `issue_type` | A specific issue name |
| `expected_value` | What the rule expected |
| `actual_value` | What the data showed |
| `difference_value` | The gap, when a numeric difference is helpful |
| `severity` | Review priority based on documented rules |
| `source_file` | Source lineage when available |
| `record_date` | Business date or file date context |
| `review_message` | A plain-language investigation note |

## Exception Level Comparison

| Exception level | Typical entity key | Example |
|---|---|---|
| Record | `order_id` | One order has a null customer ID |
| Metric | metric name or report group | Completed order amount does not match between clean and reporting |
| Stage | file name, stage name, or group key | Reporting has a missing expected country-date group |

## Record-Level Exception

Business purpose: identify individual rows that need review.

Exception grain: one output row per issue on one source or clean record.

Entity key: usually `order_id`.

Evidence: fields such as `customer_id`, `order_amount`, `order_status`, `source_file`, and `order_date`.

Category: examples include `REQUIRED_FIELD`, `VALUE_MISMATCH`, `STATUS_MISMATCH`, and `DUPLICATE_KEY`.

Severity: a null required customer or null amount can be `HIGH_REVIEW`; a negative amount may be `REVIEW` until the business context is confirmed.

Common risk: treating a record-level exception as an automatic correction instruction. The query reports evidence; it does not fix the data.

## Metric-Level Exception

Business purpose: compare important totals between stages.

Exception grain: one row per metric or report group that does not reconcile.

Entity key: a metric name such as `COMPLETED_ORDER_AMOUNT`, or a group key such as `2026-05-07|India`.

Evidence: expected total, actual total, and difference.

Category: usually `CONTROL_TOTAL`, `VALUE_MISMATCH`, or `REQUIRED_FIELD`.

Severity: metric mismatches that affect reporting are often `HIGH_REVIEW`.

Common risk: reporting only that a metric failed without showing expected and actual values.

## Stage-Level Exception

Business purpose: identify issues affecting a full pipeline stage or population.

Exception grain: one row per broken stage rule, file, group, or duplicate grain.

Entity key: examples include an `order_id`, source file name, reporting group, or stage name.

Evidence: row count, duplicate count, missing group, unexpected group, or date coverage detail.

Category: examples include `DUPLICATE_KEY`, `MISSING_RECORD`, `UNEXPECTED_RECORD`, `DATE_COVERAGE`, and `SOURCE_FILE`.

Severity: stage failures that can affect many records should receive clear review priority.

Common risk: mixing stage-level and record-level results without an `exception_level` label.

## Issue Categories

Business purpose: group similar issues for summary reporting.

Exception grain: category labels apply to every exception row.

Entity key: category is not the entity key; it describes the issue family.

Evidence: the same category should mean the same kind of investigation across files.

Severity: category can influence severity, but severity should still be documented.

Common risk: free-text categories such as `bad data`, `wrong`, or `problem`.

## Severity Levels

Business purpose: help reviewers prioritise work.

Exception grain: severity is assigned per issue row.

Entity key: the affected entity remains separate from severity.

Evidence: severity should be based on rule design, not personal judgement.

Category: any category can have a severity, but the rule catalog should explain why.

Common risk: creating too many severity labels, which makes the queue harder to use.

## Expected Versus Actual Values

Business purpose: show what the rule expected and what the data actually contained.

Exception grain: one issue row should contain its own comparison evidence.

Entity key: the comparison must point back to the affected entity.

Evidence: examples include `NON_NULL_CUSTOMER_ID` versus `NULL`, or `310.00` versus `315.00`.

Category: expected and actual values support categories such as `REQUIRED_FIELD` and `VALUE_MISMATCH`.

Common risk: providing only a review message without the values needed to check the issue.

## Entity Key

Business purpose: make the exception findable.

Exception grain: the entity key should match the level and grain of the exception.

Evidence: `order_id` is useful for order records; `order_date|country_group` is useful for grouped reporting.

Category: entity key is independent of category.

Severity: high severity without an entity key is difficult to investigate.

Common risk: using a vague key such as `unknown row`.

## Review Message

Business purpose: explain the next review action in plain language.

Exception grain: one message per issue row.

Entity key: the message should refer to the affected entity or stage where useful.

Evidence: a good message points reviewers toward source, clean, or reporting evidence.

Category: the message should match the issue category and type.

Common risk: vague messages such as `check this`.

## UNION ALL Queue

Business purpose: combine several aligned exception outputs into one review queue.

Exception grain: each branch must return the same queue columns in the same order.

Entity key: each branch can populate entity keys differently, but the column meaning must stay consistent.

Evidence: each branch should provide expected value, actual value, source context, and a review message.

Category: every branch should use controlled issue categories.

Severity: every branch should return a documented severity value.

Common risk: using `UNION` to hide duplicate exception rows. In a review queue, duplicate-looking rows may reveal overlapping rules that need investigation.

## Line-by-Line Combined Queue Explanation

In `multi-rule-exception-queue.sql`, a combined queue starts by building rule families:

| Query part | Meaning |
|---|---|
| `WITH null_customer AS (...)` | Creates one temporary result for missing customer IDs |
| `negative_amount AS (...)` | Creates another temporary result for negative amounts |
| `source_missing_from_clean AS (...)` | Creates a third temporary result for source records not found in clean data |
| Repeated output columns | Keeps every branch aligned for `UNION ALL` |
| Literal labels such as `'RECORD'` | Fill standard queue columns with clear values |
| `CAST(... AS VARCHAR(100))` | Keeps mixed values compatible in text evidence columns |
| `UNION ALL` | Stacks all exception rows while preserving every issue |
| Final `SELECT` | Returns the combined review queue |

## Duplicate Exception Handling

Business purpose: detect when the same rule reports the same issue more than once.

Exception grain: one conceptual duplicate key usually includes level, stage, entity key, category, and issue type.

Entity key: repeated entity keys are not always duplicates; the issue type also matters.

Evidence: count repeated exception keys to find overlapping rules.

Category: duplicates within the same category may indicate rule overlap.

Severity: duplicate high-review issues can inflate queue priority.

Common risk: collapsing different issue types on the same order into one row.

## Investigation Context

Business purpose: reduce repeated lookup work during review.

Exception grain: context belongs to each issue row when possible.

Entity key: context should help the reviewer locate the affected entity.

Evidence: useful fields include source file, load batch, business date, country group, and stage name.

Category: context explains where an issue came from, not what kind of issue it is.

Severity: high-review rows especially need strong context.

Common risk: producing a queue that says a record failed but does not show where it came from.

## Exception Summaries

Business purpose: help teams understand volume and priority.

Exception grain: summaries group exception rows by severity, category, level, or stage.

Entity key: summaries usually do not list every entity key, but they should be traceable to detail rows.

Evidence: count exception rows and, where useful, affected entities.

Category: category summaries show which rule families are creating the most review work.

Severity: severity summaries show which issues need attention first.

Common risk: confusing exception-row count with affected-record count.
