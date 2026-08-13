# Beginner Summary

Pipeline validation provides evidence that data moved correctly. It checks whether source, stage, clean, and reporting outputs are complete, consistent, and aligned with documented rules.

Row counts are useful, but they are not enough. Two datasets can have the same number of rows while containing different keys or different amounts. A source file can have duplicate order events, while clean output should have one row per order. A reporting table can have fewer rows because it aggregates clean orders by date and country group.

Distinct keys and duplicates matter. If clean output promises one row per order, then `order_id` should not appear more than once. If reporting output promises one row per date and country group, that composite key should be unique.

Control totals add numeric evidence. A completed amount total from clean orders should reconcile to completed amount totals in reporting after documented rules are applied. Grouped totals are even stronger because they can reveal issues hidden by global totals.

Completeness includes keys, columns, dates, categories, and files. A validation workflow should check for missing business keys, null required values, missing source files, missing dates, unexpected categories, and null reporting metrics.

Source-only and target-only records should be investigated. A source-only order may be expected if the row was sent to review. A target-only clean order may indicate an unexplained manual adjustment or pipeline issue. The key is to document expected differences and send unexplained differences to review.

Validation thresholds should not be guessed. If a tolerance is allowed, it is a business rule. It should be documented in plain language.

Exception reports preserve evidence for investigation. They should show the stage, key, issue type, expected value, actual value, difference, severity, and review message. Failed checks should not automatically delete, overwrite, or correct data.

The mental model for Day 033 is: count it, key it, total it, group it, check completeness, compare records, explain differences, and report exceptions.

Required warnings:

> Matching row counts do not prove that two datasets are equivalent. Keys, totals, completeness, duplicates, dates, categories, and representative records should also be validated.

> A difference is not automatically an error. Some differences are expected because of documented filtering, deduplication, business rules, or aggregation. Expected differences must be explained and reconciled.

> Validation thresholds and tolerances are business rules. They should be documented rather than guessed inside SQL.

> Exception reports identify records or metrics that need investigation. They should not automatically delete, overwrite, or correct source data.

All Day 033 validation SQL remains read-only. Day 034 will deepen source-to-target validation practice through integrated comparisons, rule application, and review summaries.
