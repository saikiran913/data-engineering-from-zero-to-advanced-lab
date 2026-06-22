# Day 008 Notes - Data Quality Fundamentals

## What Data Quality Means

Data quality means how fit the data is for its intended use. Good data should be accurate, complete, consistent, valid, timely, and trustworthy.

Data quality depends on business context. A missing middle name may be acceptable, but a missing order amount is usually serious.

## Why Data Quality Matters

Poor data quality can cause wrong reports, incorrect decisions, failed pipelines, audit issues, and loss of trust.

Example: if duplicate orders are counted twice, revenue appears higher than reality.

## Missing Values

Missing values are blank, null, empty, or unavailable values.

Examples:

- Missing customer ID
- Missing order amount
- Missing transaction date
- Missing email address

Some missing values are acceptable. Critical business fields usually need stricter checks.

## Duplicates

Duplicates happen when the same record appears more than once.

Examples:

- Same `order_id` appears twice.
- Same file is loaded twice.
- Same payment event arrives twice.

Duplicates can overstate counts, revenue, clicks, or transactions.

## Invalid Formats

Invalid format means data does not follow the expected pattern.

Examples:

- Email without `@`
- Date written in multiple formats
- Phone number with letters
- Invalid JSON or broken XML

## Wrong Data Types

Wrong data type means a value is stored as the wrong kind of data.

Examples:

- Amount stored as text
- Date stored as plain string
- Quantity stored as decimal when it should be whole number

Wrong data types can break calculations and joins.

## Inconsistent Values

Inconsistent values represent the same idea in different ways.

Examples:

- `UK`, `U.K.`, `United Kingdom`
- `Paid`, `paid`, `P`
- `Google Ads`, `google_ads`, `GoogleAds`

Inconsistency makes grouping and reporting unreliable.

## Out-of-Range Values

Out-of-range values are unrealistic or outside expected limits.

Examples:

- Age = 250
- Discount = 150%
- Rating = 9 when valid values are 1 to 5

## Stale Data

Stale data is old data that has not refreshed as expected.

Examples:

- Dashboard last updated three days ago
- Daily file did not arrive
- Stream stopped receiving events

## Broken Relationships

Broken relationships happen when connected datasets do not match.

Examples:

- Order references a customer that does not exist.
- Payment references an unknown order.
- Campaign click references an unknown campaign.

## Validation Checks

Validation checks are rules used to confirm whether data looks correct and usable.

Common checks include row count checks, null checks, duplicate checks, type checks, range checks, accepted value checks, source-to-target checks, and freshness checks.

## Row Count Checks

Row count checks compare expected and actual record counts.

Example: source has 1,000 rows, but target has 900 rows.

## Null Checks

Null checks identify missing values in important columns.

Example: `order_id` should not be null.

## Duplicate Checks

Duplicate checks identify repeated records.

Example: `transaction_id` should appear only once.

## Data Type Checks

Data type checks confirm values match the expected type.

Example: amount should be numeric.

## Accepted Value Checks

Accepted value checks confirm a value belongs to an approved list.

Example: `payment_status` should be Paid, Failed, Pending, or Refunded.

## Range Checks

Range checks confirm values are within reasonable limits.

Example: discount should be between 0 and 100.

## Source-to-Target Checks

Source-to-target checks compare original data with loaded data.

Examples:

- Count should match.
- Total amount should match.
- Required columns should map correctly.

## Freshness Checks

Freshness checks confirm data was updated recently enough.

Example: daily dashboard should refresh by 8 AM.

## Technical Checks vs Business Checks

Technical checks validate structure, format, and basic correctness.

Examples:

- File exists
- Required columns exist
- Data type is correct
- No duplicate key

Business checks validate business meaning.

Examples:

- Refund amount should not exceed purchase amount.
- Delivery date should not be before order date.
- Cancelled orders should not count as revenue.

## Quality Checks in ETL

In ETL, checks can happen before loading, during transformation, and after loading.

Bad data may be stopped before it reaches the final target.

## Quality Checks in ELT

In ELT, raw data may be loaded first. Quality checks often happen during transformation and before business-ready tables are created.

## Quality Checks in Batch Processing

Batch checks often include:

- File arrival
- File not empty
- Row count
- Duplicate count
- Daily total checks
- Freshness checks

## Quality Checks in Streaming

Streaming checks often include:

- Event format
- Required fields
- Duplicate event IDs
- Event time validity
- Event volume
- Processing delay

## Quality Checks by File Format

CSV:

- Header exists
- Delimiter is correct
- Column count matches

JSON:

- JSON is valid
- Required keys exist
- Nested structure is expected

XML:

- Tags match
- Schema is valid

Parquet and Avro:

- Schema matches
- File or message can be read by expected tools

## Handling Failed Checks

Data engineers may stop the pipeline, send an alert, quarantine bad records, retry the job, contact the source owner, fix transformation logic, or rerun the pipeline.

The right action depends on severity and business impact.

## Data Quality and Business Trust

Users trust dashboards when numbers are reliable over time. Data quality checks help protect that trust.

