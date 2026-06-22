# Day 008 Practice Questions

## Section 1: Simple Questions

1. What does data quality mean?
2. Why does data quality matter?
3. What is a missing value?
4. What is a duplicate record?
5. What is an invalid format?
6. What is an inconsistent value?
7. What is a validation check?
8. What does a row count check do?
9. What does a null check do?
10. What does a duplicate check do?
11. What does a range check do?
12. What does stale data mean?

## Section 2: Identify the Data Quality Issue

Identify the issue type.

1. `order_id` is blank.
2. Same `transaction_id` appears twice.
3. Order amount is `abc`.
4. Country appears as `UK` and `United Kingdom`.
5. Dashboard last updated three days ago.
6. Order date is `31/31/2026`.
7. Quantity is `-10`.
8. Payment status is `Maybe`.
9. Source has 1,000 rows but target has 900.
10. Email does not contain `@`.
11. Completed order has no payment amount.
12. Delivery date is before order date.
13. File arrived with zero rows.
14. `campaign_id` does not exist in campaign table.
15. Click-through rate is 180%.

## Section 3: Choose the Right Validation Check

Choose a suitable validation check.

1. Customer IDs are missing.
2. Order IDs are duplicated.
3. Date format is wrong.
4. Payment status has an unexpected value.
5. File did not arrive.
6. Dashboard is stale.
7. Source and target totals do not match.
8. Quantity is negative.
9. Required column is missing.
10. Email format is invalid.
11. Order has no matching customer.
12. Row count is unusually low.

## Section 4: Technical Check or Business Check?

Classify each as technical or business.

1. File exists.
2. Required columns are present.
3. Revenue should not be negative.
4. Delivery date should not be before order date.
5. Amount is numeric.
6. Refund should not exceed purchase amount.
7. Order ID is unique.
8. Cancelled order should not count as revenue.
9. Email contains `@`.
10. Completed payment has payment amount.
11. CSV has expected column count.
12. Customer ID exists in customer table.

## Section 5: Warning or Failure?

Decide whether each issue should be a warning or failure. Some answers depend on business rules.

1. Optional middle name is missing.
2. Order amount is missing.
3. Daily order table has zero rows.
4. One optional phone number is missing.
5. Source and target sales totals do not match.
6. Country value is inconsistent for a few rows.
7. Payment status is invalid.
8. Dashboard refresh is 10 minutes late.
9. Completed order has no payment amount.
10. Marketing campaign name has inconsistent casing.

## Section 6: Think Like a Data Engineer

1. What quality issue exists if source has 10,000 rows but target has 8,000?
2. Which validation check would catch repeated order IDs?
3. Should a pipeline stop if the daily orders file has zero rows? Why?
4. Who should be informed if a source system stops sending payment status?
5. How can duplicate orders affect a revenue dashboard?
6. How could you prevent a wrong date format issue next time?

## Section 7: Mini Assignment

Choose one business scenario:

- E-commerce
- Banking
- Food delivery
- Marketing analytics
- Hospital appointments
- Payroll

Document:

1. Important datasets
2. Critical columns
3. Possible missing value issues
4. Possible duplicate issues
5. Possible format issues
6. Possible business rule issues
7. Validation checks required
8. What should happen if a check fails
9. Final dashboard or report affected
10. Business decision affected

## Answer Key

### Section 1

1. Data quality means how trustworthy data is for its intended use.
2. It matters because poor data can create wrong reports and decisions.
3. A missing value is a blank, null, empty, or unavailable value.
4. A duplicate record is the same record appearing more than once.
5. Invalid format means data does not follow the expected pattern.
6. An inconsistent value is the same meaning written in different ways.
7. A validation check is a rule used to confirm data looks correct.
8. It checks expected record counts.
9. It checks for missing values.
10. It checks for repeated records.
11. It checks whether values are within expected limits.
12. Stale data is old data that has not refreshed as expected.

### Section 2

1. Missing value
2. Duplicate record
3. Wrong data type or invalid value
4. Inconsistent value
5. Stale data
6. Invalid date format
7. Out-of-range value
8. Unexpected or invalid accepted value
9. Source-to-target mismatch
10. Invalid format
11. Missing value and business rule issue
12. Business rule issue
13. File not empty or row count issue
14. Broken relationship
15. Out-of-range value

### Section 3

1. Null check
2. Duplicate check or unique key check
3. Date format check
4. Accepted values check
5. File arrival check
6. Freshness check
7. Source-to-target total check
8. Range check
9. Required column check
10. Format validation check
11. Referential integrity check
12. Row count check

### Section 4

1. Technical
2. Technical
3. Business
4. Business
5. Technical
6. Business
7. Technical
8. Business
9. Technical
10. Business
11. Technical
12. Technical or business, depending on how the relationship is used

