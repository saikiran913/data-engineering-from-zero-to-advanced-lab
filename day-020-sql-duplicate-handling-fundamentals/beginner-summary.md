# Beginner Summary

Duplicate handling matters because repeated data can change the numbers people trust. Duplicate orders can inflate revenue. Duplicate campaign rows can inflate impressions, clicks, cost, and revenue. Duplicate payment transactions can confuse payment reporting. Duplicate customer contacts can affect customer counts. A data engineer needs to investigate duplicates carefully before deciding what to do.

The first important idea is that not all repeated values are wrong. A `customer_id` can appear in many orders because one customer can place many orders. A `user_id` can appear in many website events because one user can view pages, click buttons, sign up, and purchase. A `campaign_id` can appear on many dates because campaigns run over time. These are normal repetitions when they match the grain of the table.

An exact duplicate row means all selected values are the same. If the same order row appears twice with the same order ID, customer ID, date, amount, status, payment status, country, and source file, it may be an exact duplicate. Exact duplicates often happen when the same file is loaded twice or a retry process loads rows again.

A duplicate business key is different. A business key is a column or group of columns that identifies a business record. Examples include `order_id`, `transaction_id`, `event_id`, or a composite key such as `performance_date + campaign_id + channel + country`. If the same `order_id` appears twice with different statuses, the rows are not exact duplicates, but the business key is repeated. That requires investigation.

`DISTINCT` is useful, but limited. It returns unique output rows for the selected columns. `SELECT DISTINCT country` returns each country once. `SELECT DISTINCT order_status, payment_status` returns each unique status combination once. But `DISTINCT` does not automatically deduplicate a table by business key. If the same `order_id` appears with two different amounts, both rows remain when both columns are selected.

To investigate repeated keys, use `GROUP BY`, `COUNT`, and `HAVING`. For example, grouping by `order_id` and keeping only groups where `COUNT(*) > 1` shows order IDs that appear more than once. The same pattern works for transaction IDs, event IDs, cleaned emails, and composite campaign keys.

Cleaning values can matter before duplicate checks. Emails may differ only by case or spaces. `USER@EMAIL.COM`, `user@email.com`, and ` user@email.com ` may represent the same email. Using `LOWER(TRIM(email))` before grouping gives a better duplicate investigation result.

Source information is also important. A `source_file` column can show whether repeated rows came from an original file, retry file, or later file. This helps explain whether a duplicate is caused by ingestion, late-arriving correction, or normal repeated activity.

Duplicates can appear after raw file stacking because all rows are preserved. That is often useful because it keeps source issues visible. Duplicate-looking rows can also appear after joins because one-to-many relationships repeat values. That is not always a data problem.

Safe deduplication means using business rules to decide what should happen. A rule might keep the latest updated record, keep a successful payment over a failed one, flag suspicious rows, or quarantine rows for review. Day 020 does not remove records. It focuses on investigation.

This investigation mindset is important in real pipelines. Raw data should usually be preserved so teams can trace what arrived from the source. A clean or business layer may later apply deduplication rules, but those rules should be visible and agreed. If a dashboard removes records without explanation, users may not know whether the output is correct or simply hiding a source problem.

Before Day 021, remember this: do not delete raw data blindly, do not use `DISTINCT` as a universal fix, distinguish exact duplicates from duplicate business keys, understand table grain, inspect source files, and document every deduplication assumption.
