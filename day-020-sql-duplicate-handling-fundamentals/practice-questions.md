# Practice Questions

## Section 1: Simple Questions

1. What is a duplicate?
2. What is an exact duplicate row?
3. What is a duplicate business key?
4. Give one example of normal repeated data.
5. What does `DISTINCT` do?
6. What does `GROUP BY` help with?
7. Why is `HAVING COUNT(*) > 1` useful?
8. What is a business key?
9. What is a composite key?
10. Why is `source_file` useful?
11. What is safe deduplication?
12. Why should raw data not be deleted blindly?

## Section 2: Exact Duplicate or Business Key Duplicate?

Classify each scenario:

1. Same full order row appears twice.
2. Same `order_id` appears with different `payment_status`.
3. Same `transaction_id` appears twice with same values.
4. Same `customer_id` appears in five orders.
5. Same `user_id` appears in many website events.
6. Same `campaign_id` appears on different dates.
7. Same `campaign_id` and `performance_date` appears twice.
8. Same email appears with different case and spaces.
9. Same `event_id` appears with different timestamp.
10. Same order appears in retry file.

## Section 3: DISTINCT or GROUP BY?

Choose the better tool:

1. List unique countries.
2. Find repeated order IDs.
3. List unique payment statuses.
4. Find repeated emails.
5. Count repeated transaction IDs.
6. List unique event types.
7. Find duplicate campaign/date keys.
8. Show unique source files.
9. Investigate repeated event IDs.
10. List unique payment methods.

## Section 4: Choose the Correct Query

1. Distinct countries: `SELECT DISTINCT country FROM raw_orders_with_duplicates;`
2. Repeated order IDs: `SELECT order_id, COUNT(*) FROM raw_orders_with_duplicates GROUP BY order_id HAVING COUNT(*) > 1;`
3. Repeated cleaned emails: use `LOWER(TRIM(email))`, `GROUP BY`, and `HAVING`.
4. Inspect one order: filter `WHERE order_id = 'ORD1005'`.
5. Count rows by source file: group by `source_file`.

## Section 5: Write Duplicate Investigation Queries

Write SQL to:

1. List distinct countries.
2. List distinct payment statuses.
3. Count total order rows.
4. Count distinct order IDs.
5. Find repeated order IDs.
6. Inspect one repeated order ID.
7. Find repeated cleaned emails.
8. Find repeated event IDs.
9. Find repeated transaction IDs.
10. Find repeated campaign/date/channel/country keys.
11. Count rows by source file.
12. Count events by source file.
13. Count payments by source file.
14. Find repeated payment order IDs and explain why they may be valid.
15. Find repeated customer IDs in orders and explain why they may be normal.

## Section 6: Spot the Mistake

1. Using `DISTINCT` to solve duplicate order IDs blindly.
2. Thinking repeated `customer_id` in orders is always bad.
3. Thinking repeated `user_id` in events is always bad.
4. Grouping by too many columns and missing duplicate keys.
5. Grouping by too few columns and flagging valid rows.
6. Deleting raw duplicates without business approval.
7. Using exact duplicate removal to hide duplicate ingestion.
8. Ignoring `source_file`.
9. Not cleaning email before duplicate checks.
10. Confusing exact duplicates with business key duplicates.
11. Treating multiple payment attempts as always duplicate.
12. Not documenting the keep rule.

## Section 7: Business Key Thinking

Identify the likely business key for orders, payment transactions, website events, campaign performance daily table, monthly sales summary, customer contacts, support tickets, product catalog, order items, customer table, daily pipeline run table, and campaign table.

## Section 8: Safe Deduplication Decision

Decide whether to keep, flag, investigate, or deduplicate later:

1. Exact duplicate row from same source file.
2. Same `order_id` with changed status.
3. Same `transaction_id` with different payment status.
4. Customer with multiple orders.
5. User with multiple events.
6. Campaign/date row repeated with same metrics.
7. Campaign/date row repeated with different metrics.
8. Same email with different customer IDs.
9. Retry file created duplicate rows.
10. Late-arriving correction.

## Section 9: Think Like a Data Engineer

1. What is the suspected business key?
2. Is repetition expected?
3. Is `DISTINCT` enough?
4. Is `GROUP BY` plus `HAVING` needed?
5. What source information should be inspected?
6. What rule should be documented?

## Section 10: Mini Assignment

Imagine you are validating a raw daily data load. Count total rows, count distinct business keys, find repeated order IDs, transaction IDs, event IDs, cleaned emails, and campaign keys. Inspect retry files, explain normal repetition, explain suspicious repetition, explain why `DISTINCT` is not enough, and document a safe investigation workflow.

## Answer Key

- Use `DISTINCT` for unique lists.
- Use `GROUP BY` and `HAVING COUNT(*) > 1` for repeated-key checks.
- Repeated `customer_id` in orders is usually normal.
- Repeated `transaction_id` is usually suspicious.
- Exact duplicate rows repeat all selected values.
- Duplicate business keys repeat expected identifiers.
- `source_file` helps trace duplicate ingestion.
- Safe deduplication requires business rules.
