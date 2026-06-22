# Day 008 Beginner Summary

Data quality means how accurate, complete, consistent, valid, and trustworthy data is for its intended use. Data can exist in a file, table, or dashboard and still be wrong. For example, an order amount may be missing, a customer may appear twice, a date may be written in the wrong format, or a dashboard may show old data.

Data quality matters because companies use data to make decisions. If the data is wrong, the decision may also be wrong. A sales dashboard that counts duplicate orders can show revenue higher than reality. A marketing report with inconsistent country names can split one country into several groups. A stale dashboard can make users think they are seeing current information when they are actually seeing old numbers.

Missing values are one common data quality issue. A missing value means an important field is blank, null, empty, or unavailable. Missing middle name may not matter, but missing `order_amount`, `customer_id`, or `transaction_date` can be serious. The importance of a missing value depends on business context.

Duplicate records are another common issue. A duplicate record is the same record appearing more than once. This can happen when a file is loaded twice, an API retries an event, a pipeline is rerun, or a source system sends repeated records. Duplicates can overstate revenue, clicks, payments, orders, or user activity.

Invalid formats and wrong data types also cause problems. A date may appear as `2026-06-22` in one system and `22/06/2026` in another. An amount may be stored as text instead of a number. An email may be missing the `@` symbol. These issues can break pipelines, calculations, filters, and joins.

Inconsistent values happen when the same meaning is written in different ways. For example, `UK`, `U.K.`, `United Kingdom`, and `Britain` may all refer to the same place. If these values are not standardized, reports grouped by country become confusing and unreliable.

Validation checks are rules used to confirm whether data looks correct and usable. Common checks include row count checks, null checks, duplicate checks, data type checks, range checks, accepted value checks, source-to-target checks, and freshness checks. These checks help catch problems before users rely on reports.

Some checks are technical checks. These confirm structure and format, such as whether a file exists, required columns are present, values are not null, and data types are correct. Other checks are business checks. These confirm business meaning, such as revenue should not be negative, delivery date should not be before order date, and refund amount should not exceed purchase amount.

Data quality connects directly with ETL and ELT. In ETL, checks may happen before data is loaded and after it reaches the target. In ELT, raw data may be loaded first, but checks should happen before business-ready tables are created. Batch pipelines may check file arrival, row counts, and daily totals. Streaming pipelines may check event format, duplicate event IDs, event time, and event volume.

Data engineers play an important role in data quality. They define validation rules, monitor pipelines, handle missing values and duplicates, investigate mismatches, alert stakeholders, document rules, and help analysts understand whether data can be trusted.

When a quality check fails, the correct action depends on severity. A small optional field issue may only need a warning. A missing order table, incorrect revenue total, or stale critical dashboard may require stopping the pipeline, sending an alert, and fixing the issue before users rely on the data.

Before Day 009, remember this: data quality is not only a technical topic. It also requires business understanding. Not every null is bad. Not every duplicate is wrong. The right data quality rule depends on what the data means and how it will be used.
