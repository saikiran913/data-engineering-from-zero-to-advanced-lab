# Beginner Summary

Control totals are simple validation metrics. They help data engineers prove that data changed in expected ways between pipeline stages.

Counts and distinct-key counts answer different questions. `COUNT(*)` counts rows. `COUNT(column)` counts non-null values in a column. `COUNT(DISTINCT column)` counts unique non-null values. A source file can have 25 rows but only 24 distinct orders if one order is duplicated.

Sums help reconcile important numeric measures. For example, completed order amount in the clean layer should match completed amount in reporting when filters and grouping align. Refund totals and pending counts can be checked in the same way.

Minimum and maximum values provide boundary evidence. `MIN(order_date)` and `MAX(order_date)` can reveal missing early dates, unexpected future dates, or shifted populations. `MIN(order_amount)` and `MAX(order_amount)` can reveal negative, zero, or unusually high values.

Grouped controls are important because a grand total can hide problems. A total may match overall while one country group is too high and another is too low. Grouped controls by date, country group, status, or source file make those issues visible.

Source and target populations must be aligned before comparison. Filters and date ranges must also be aligned. A completed-sales total should compare completed rows to completed reporting measures, not all rows to one filtered metric.

Accepted plus review should reconcile when those populations are exhaustive. Stage-to-clean controls may be exact when every accepted row should become exactly one clean row. Clean-to-reporting row counts usually differ because reporting is aggregated.

Expected differences should be documented. Tolerances should not be guessed. One matching control does not prove the whole pipeline is correct. Failed controls should produce review evidence, not automatic data correction.

Mental model: define the population, choose the control, calculate both sides, compare the difference, explain it, then inspect groups and exceptions.

Required warnings:

> A control total is only meaningful when the source population, target population, grain, filters, and expected relationship are defined consistently.

> Matching one total does not prove that all records are correct. A grand total can match while individual groups, keys, dates, or categories are wrong.

> Differences are not automatically failures. Deduplication, review exclusions, business filters, and aggregation can create expected differences that must be documented.

> Control totals should produce validation evidence. They should not automatically modify source or target data.

All Day 034 SQL remains read-only. Day 035 will deepen completeness validation through missing dates, missing categories, null coverage, and file-level checks.
