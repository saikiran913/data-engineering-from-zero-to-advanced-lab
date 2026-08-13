# Beginner Summary

Completeness checks verify whether expected data is present. They do not prove that values are correct.

Field completeness and record completeness are different. Field completeness asks whether required columns, such as `customer_id` or `order_date`, are populated. Record completeness asks whether expected rows, such as expected order IDs or reporting dates, exist in the actual dataset.

Required fields depend on business rules. A null is not automatically an error. A field can be optional in one dataset and required in another. Blank strings may also need review because they can look like missing values even when they are not stored as `NULL`.

Missing keys should be compared against an expected population. Expected records and actual records should be compared explicitly. Unexpected extra records also matter because target-only records can show data that did not come from the expected source path.

Date coverage requires more than min and max checks. A dataset can have the correct earliest and latest dates while missing a middle date. Category coverage, status coverage, and source-file coverage are also important because reports can be incomplete even when total row count looks reasonable.

Completeness percentages need correct denominators. Duplicates can distort percentages, and a divide-by-zero case should be handled safely. A percentage should be supported by an issue list.

Expected exclusions should be documented. Review rows may be intentionally excluded from clean output. Cancelled orders may be excluded from completed-sales reporting. Unexplained gaps require review.

Mental model: define what should exist, compare it with what actually exists, explain valid gaps, and report anything unexplained.

Required warnings:

> Completeness checks answer whether expected data is present. They do not prove that the values themselves are correct.

> A null is not automatically an error. Whether a field is required depends on the business rule for that column and dataset grain.

> Missing records must be interpreted in context. Some rows may be intentionally excluded by documented filters, deduplication, or review rules.

> Completeness checks should identify gaps and exceptions for investigation. They should not invent missing values or automatically modify source data.

All Day 035 SQL remains read-only. Day 036 will focus on turning validation findings into clean review queues and investigation-friendly exception outputs.
