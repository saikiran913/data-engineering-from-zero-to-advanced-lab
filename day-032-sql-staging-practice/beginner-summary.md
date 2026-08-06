# Beginner Summary

Day 032 is a practical staging lab. Day 031 introduced the idea of intermediate results and staging layers. Day 032 shows how those ideas become a staged SQL workflow.

Raw data is rarely perfect. A source file may contain different status spellings such as `complete`, `completed`, and `paid`. A single order may appear more than once. Some records may have missing customer IDs, missing amounts, negative amounts, zero amounts, unsupported statuses, or late-arriving timestamps. If these issues go directly into reporting, the final numbers can be confusing or wrong.

The first important lesson is to standardise before complex business logic. Source standardisation means converting inconsistent raw values into consistent values. In this lab, `raw_status` is joined to `source_status_mapping` so the learner can see both the original raw value and the standard status. Keeping the original value is important because it supports debugging and source conversations.

The next lesson is grain. Grain means what one row represents. In the raw file, one row is one received source order event. In the candidate stage, one row should represent one selected candidate per order. In the clean layer, one row should represent one clean order. In the reporting layer, one row should represent one report date and country group. If grain is not clear, row counts become hard to understand.

Deduplication is another core idea. In this lab, repeated order events are ranked with `ROW_NUMBER`. The documented rule uses `order_id` as the business key and orders events by latest `event_timestamp`, latest `received_at`, and then `source_event_id`. This rule is visible in SQL, but it is still only a rule. `ROW_NUMBER` does not invent business truth. The business rule must be agreed and documented.

After candidate selection, validation flags decide whether rows are accepted or sent to review. Accepted rows meet the documented rules and can move forward. Review rows have issues such as null keys, missing customer IDs, missing amounts, negative amounts, zero amounts, unsupported statuses, missing mappings, or unresolved ties. Review rows should not be deleted silently. They are useful evidence for investigation.

A clean handoff means the receiving stage understands what it is getting. For clean customer orders, the expected grain is one row per order. The clean layer should have stable keys, standardised statuses, valid measures, and useful audit columns such as `source_event_id`, `source_file`, `received_at`, and `cleaned_at`.

Reporting should happen after the clean grain is stable. The reporting summary in this day groups clean orders by order date and country group. It calculates completed counts, completed amount totals, refund counts, refund totals, and pending counts. Reporting output should be checked for duplicate reporting keys, null measures, and total mismatches.

Checkpoint reconciliation is the habit of comparing stages. Sometimes row counts should match, such as raw events to standardised events. Sometimes they should not match, such as raw events to clean orders, because many raw events may become one clean order. In those cases, distinct keys, totals, and documented differences matter more than equal row counts.

The mental model for Day 032 is: prepare, standardise, deduplicate, validate, separate, clean, aggregate, reconcile, and hand off.

Important warnings:

> A multi-step transformation is only useful when each stage has one clear purpose, a documented grain, and validation checks.

> Deduplication, filtering, and standardisation rules must be documented. A staging query should not silently decide business truth.

> Accepted records and review records should reconcile to the defined staged population. Unexplained differences require investigation.

> A clean handoff means the receiving stage understands the grain, keys, rules, audit columns, and known limitations of the data.

All Day 032 SQL remains read-only. Real persistence, deployment, scheduling, cleanup, and ownership are platform-specific and out of scope.

Day 033 will focus more deeply on pipeline validation, control totals, completeness checks, and exception reporting.
