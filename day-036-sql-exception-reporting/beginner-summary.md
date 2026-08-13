# Beginner Summary

## What Learners Should Remember

An exception report turns a validation finding into reviewable evidence. In earlier days, you learned how to check row counts, control totals, required fields, missing keys, date coverage, and expected records. Day 036 takes the next step: when a check finds something unusual, the result should be shaped so another person can investigate it.

An exception is not automatically a confirmed defect. It means a rule found something that deserves attention. Some exceptions are serious, such as a missing customer ID or a reporting total that does not reconcile. Other exceptions may be expected, such as a source record that is excluded by a documented business rule. This is why exception reports should be clear and careful.

A useful beginner design is one row per issue. If one order has a null customer ID and a negative amount, that can become two exception rows. This is better than hiding one of the issues, because each issue may need a different explanation. The exception-row count and the affected-record count are therefore different ideas. Ten exception rows do not always mean ten affected records.

Every exception needs a stage. The stage tells the reviewer where the issue was found, such as source, clean, reporting, or stage-to-stage comparison. Every record-level exception also needs an entity key. For order data, this is often `order_id`. For reporting groups, the key may combine a report date and country group. The entity key is what allows the reviewer to find the affected item.

Issue categories should be controlled and understandable. Examples include `REQUIRED_FIELD`, `DUPLICATE_KEY`, `MISSING_RECORD`, `UNEXPECTED_RECORD`, `VALUE_MISMATCH`, `CONTROL_TOTAL`, and `DATE_COVERAGE`. Issue types should be more specific, such as `NULL_CUSTOMER_ID`, `DUPLICATE_ORDER_ID`, or `COMPLETED_AMOUNT_MISMATCH`. The category helps with summaries. The issue type explains the exact rule.

Severity should follow documented rules. A team may use simple labels such as `HIGH_REVIEW`, `REVIEW`, and `INFO`. These labels should not be guessed from mood or appearance. They should be tied to rule design and business impact. A missing required reporting field may be high review. A documented expected exception may be informational.

Expected and actual values make an exception easier to investigate. A row that says `ORDER_AMOUNT_MISMATCH` is useful, but a row that also shows the source amount, clean amount, and difference is much better. Audit fields also matter. Source file, load date, business date, stage name, and review message reduce repeated lookup work.

`UNION ALL` is useful for combining aligned exception outputs. One query can find missing customer IDs. Another can find negative amounts. Another can find source records missing from clean output. If each query returns the same queue columns in the same order, `UNION ALL` can stack those exception rows into one review queue. In this lesson, `UNION ALL` is preferred because the review queue should preserve all reported issues.

Duplicate exception rows should still be investigated. If the same issue appears twice with the same level, stage, entity key, category, and type, the rules may overlap. But different issue types on the same record should not be collapsed together. One order can have multiple real issues.

Exception summaries help reviewers prioritise. Counts by severity show how much urgent review work exists. Counts by category show which rule families are creating the most exceptions. Counts by stage show where the pipeline may need attention.

## Mental Model

Detect the issue, identify the affected entity, explain what was expected and observed, attach evidence, assign a documented severity, and hand it off for investigation.

## Final Warnings

An exception report should explain what needs investigation. It should not automatically decide how the underlying data must be corrected.

Severity levels are business rules. They should be documented consistently rather than guessed from the size or appearance of an issue.

Combining different exception types is useful only when their output columns have consistent meanings and compatible data types.

A review queue is not proof that every listed item is a confirmed defect. Some records may be expected exceptions or require business-context review.

## What Comes Next

Day 037 will introduce SQL Data Quality Scorecards: Combining Validation Checks, Pass/Review Statuses, and Dataset-Level Health Summaries. It will show how multiple validation results can be summarised into a simple educational scorecard without introducing automated production monitoring.
