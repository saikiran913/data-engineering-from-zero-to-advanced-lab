# Day 008 - Data Quality Fundamentals: Missing Values, Duplicates, and Validation Checks

## Learning Goal

By the end of Day 008, you will understand what data quality means, why it matters, common data quality issues, and the basic validation checks data engineers use before data is trusted for reports and analytics.

## Connection to Previous Days

- Day 005 introduced ETL and ELT.
- Day 006 introduced batch and streaming.
- Day 007 introduced data formats.
- Day 008 explains how data engineers check whether data is reliable before it is used for reporting or analytics.

## What is Data Quality?

Data quality means how accurate, complete, consistent, valid, and trustworthy the data is for its intended use.

Data can exist, but still be wrong or unusable.

Examples:

- Order amount is missing.
- Customer appears twice.
- Country is written as `UK`, `U.K.`, `United Kingdom`, and `Britain`.
- Date is written in different formats.
- Price is stored as text instead of number.
- Dashboard shows yesterday's data instead of today's data.

## Why Data Quality Matters

Poor data quality can lead to:

- Wrong dashboards
- Wrong business decisions
- Incorrect customer communication
- Revenue reporting mistakes
- Marketing budget mistakes
- Failed pipelines
- Compliance and audit problems
- Loss of trust in data teams

Simple example: if duplicate orders are counted twice, the sales dashboard may show higher revenue than reality.

## Simple Data Quality Flow

```text
Source Data
    |
    v
Data Ingestion
    |
    v
Raw Data
    |
    v
Data Quality Checks
    |
    v
Clean Data
    |
    v
Business-Ready Data
    |
    v
Dashboard / Report
```

The source creates data. Ingestion brings it into the data platform. Raw data is checked and cleaned. Business-ready data is then used by dashboards and reports.

## Common Types of Data Quality Issues

| Issue Type | Simple Meaning | Example |
| --- | --- | --- |
| Missing values | Important data is blank | `customer_id` is empty |
| Duplicate records | Same record appears more than once | Same order loaded twice |
| Invalid formats | Value does not match expected format | Email has no `@` |
| Wrong data types | Value is stored as the wrong kind of data | Amount stored as text |
| Inconsistent values | Same meaning written differently | `UK`, `U.K.`, `United Kingdom` |
| Out-of-range values | Value is unrealistic or outside allowed range | Discount is 150% |
| Stale data | Data is old or not refreshed | Dashboard last updated three days ago |
| Incomplete data | Record is missing important fields | Order has no payment status |
| Unexpected values | Value is not expected | Payment status is `Maybe` |
| Broken relationships | Related records do not match | Order has unknown customer ID |
| Incorrect business logic | Rule is wrong | Cancelled order counted as revenue |
| Source-to-target mismatch | Loaded data does not match source | Source has 1,000 rows, target has 900 |

## Missing Values

Missing values are blank, empty, or unknown values.

Examples:

- `customer_id` is blank
- Email address is missing
- Country is null
- Order amount is empty
- Payment status is not available

| Column | Value | Problem |
| --- | --- | --- |
| customer_id | blank | Order cannot be linked to a customer |
| order_amount | null | Revenue cannot be calculated correctly |
| email | blank | Customer cannot receive communication |
| country | null | Country-level reporting is incomplete |

Not every missing value is equally serious. Missing middle name may not be critical. Missing order amount, customer ID, or delivery address can be serious.

## Duplicate Records

Duplicate records are repeated records.

Examples:

- Same order loaded twice
- Same customer registered twice
- Same payment event received twice
- Same file processed twice
- Same marketing click counted twice

Duplicates are dangerous because they can inflate counts and totals. If the same order appears twice, revenue may be overreported.

Duplicates can happen because of repeated file loading, API retry, pipeline rerun, source system issue, missing unique key, or manual data entry.

## Invalid Formats

Invalid formats happen when data does not follow the expected pattern.

Examples:

- Date is `06/09/2026` in one system and `2026-09-06` in another.
- Email does not contain `@`.
- Phone number contains letters.
- Price is stored as `one hundred`.
- Postcode is stored incorrectly.
- Timestamp is missing timezone.

Format validation matters because systems need consistent patterns to process data correctly.

## Wrong Data Types

Data type issues happen when a value is stored as the wrong kind of data.

Examples:

- Order amount stored as text
- Date stored as plain string
- Customer ID stored inconsistently as number and text
- Quantity stored as decimal when it should be whole number
- Boolean value stored as `Yes`, `Y`, `true`, `1`, and `Active`

Data type consistency matters for calculations, filtering, and joining datasets.

## Inconsistent Values

Inconsistent values happen when the same meaning appears in different forms.

Examples:

- `UK`, `U.K.`, `United Kingdom`, `Britain`
- `Male`, `M`, `male`
- `Completed`, `complete`, `COMP`, `Done`
- `Google Ads`, `google_ads`, `GoogleAds`
- `Paid Social`, `Social Paid`, `social_paid`

Inconsistent values make grouping and reporting difficult.

## Out-of-Range Values

Out-of-range values are present, but unrealistic or outside allowed limits.

Examples:

- Age = 250
- Quantity = -5
- Order amount = -999
- Discount = 150%
- Future date for a completed transaction
- Click-through rate above 100%

Range checks help identify values that should be reviewed.

## Stale Data

Stale data means the data is old or not refreshed as expected.

Examples:

- Dashboard was last updated three days ago.
- Yesterday's file did not arrive.
- Streaming pipeline stopped receiving events.
- Daily report is showing last week's numbers.

Users lose trust when reports are stale.

## Broken Relationships

Broken relationships happen when related datasets do not match.

Examples:

- Order has `customer_id`, but that customer does not exist in the customer table.
- Payment exists without a matching order.
- Product sale references a deleted product.
- Campaign click references an unknown campaign.

Relationship checks are important when datasets are joined.

## What Are Validation Checks?

Validation checks are rules used to confirm whether data looks correct and usable.

Examples:

- Required fields should not be null.
- Dates should follow expected format.
- Amounts should be numeric.
- Order IDs should be unique.
- File should not be empty.
- Row count should be within expected range.
- Total sales should not suddenly drop to zero.

## Common Validation Checks

| Validation Check | What It Means | Simple Example |
| --- | --- | --- |
| File arrival check | Expected file arrived | Daily sales file exists |
| File not empty check | File has data | File has more than zero rows |
| Row count check | Count is expected | Today has around 10,000 rows |
| Column count check | Number of columns is expected | CSV has 8 columns |
| Required column check | Important columns exist | `order_id` is present |
| Null value check | Important values are not missing | `customer_id` is not null |
| Duplicate check | Repeated records are detected | `order_id` appears once |
| Data type check | Values match expected type | Amount is numeric |
| Date format check | Date follows expected pattern | `2026-06-22` |
| Range check | Value is in allowed range | Rating is 1 to 5 |
| Accepted values check | Value is in allowed list | Status is Paid, Failed, Pending, or Refunded |
| Unique key check | Key appears once | `transaction_id` is unique |
| Referential integrity check | Related records exist | Order customer exists in customer table |
| Source-to-target count check | Source and target counts match | 1,000 source rows and 1,000 target rows |
| Source-to-target total check | Totals match | Source and target sales total match |
| Freshness check | Data is updated recently enough | Dashboard refreshed by 8 AM |
| Anomaly check | Unusual values are detected | Sales did not suddenly drop to zero |

## Row Count Check

A row count check compares the expected number of records with the actual number.

Examples:

- Yesterday's file usually has around 10,000 rows, but today it has 10 rows.
- Source table has 5,000 records, but target table has 4,500 records.
- File arrived but contains zero rows.

This helps detect missing, incomplete, or wrongly loaded data.

## Null Check

A null check identifies missing values in important columns.

Examples:

- `customer_id` should not be null.
- `order_id` should not be null.
- `order_amount` should not be null.
- `transaction_date` should not be null.

Some columns can allow nulls and some cannot. Context matters.

## Duplicate Check

A duplicate check identifies repeated records.

Examples:

- `order_id` appears more than once.
- `transaction_id` appears more than once.
- Customer email appears multiple times when it should be unique.

Duplicates may be valid in some cases and invalid in others. Business context decides.

## Data Type Check

A data type check confirms that values match the expected type.

Examples:

- Amount should be numeric.
- Date should be date.
- Quantity should be integer.
- Email should be text.
- `is_active` should be true or false.

## Accepted Values Check

Accepted values check confirms that values are from an allowed list.

Examples:

- `payment_status` should be Paid, Failed, Pending, or Refunded.
- `country_code` should follow expected country code list.
- `order_status` should be Created, Shipped, Delivered, or Cancelled.

## Range Check

Range check confirms that values are within a reasonable range.

Examples:

- Discount should be between 0 and 100.
- Quantity should be greater than 0.
- Order amount should not be negative.
- Rating should be between 1 and 5.

## Source-to-Target Check

A source-to-target check compares data from the original source to the loaded target.

Examples:

- Source has 1,000 orders and target should also have 1,000 orders.
- Source sales total is 50,000 and target sales total should match.
- Source file has 20 columns and target table expects 20 mapped columns.

This is important in ETL and ELT because data can be lost or changed during movement.

## Freshness Check

Freshness check confirms data was updated recently enough.

Examples:

- Daily dashboard should refresh by 8 AM.
- Hourly pipeline should have data from the last hour.
- Streaming system should receive recent events.

## Data Quality in ETL and ELT

| Process | Where Quality Checks May Happen |
| --- | --- |
| ETL | Before loading, during transformation, and after loading |
| ELT | After raw loading, during transformation, and before business-ready tables |

In ETL, checks may stop bad data before it reaches the target. In ELT, raw data may land first, then checks are applied before trusted outputs are created.

## Data Quality in Batch and Streaming

Batch checks:

- File arrived
- Row count is expected
- Duplicates are removed
- Daily totals are reasonable

Streaming checks:

- Event format is valid
- Duplicate event is handled
- Event time is valid
- Required fields are present
- Event volume is not suddenly zero

## Data Quality and File Formats

CSV issues:

- Missing headers
- Wrong delimiter
- Extra commas
- Wrong date format

JSON issues:

- Invalid JSON
- Missing keys
- Unexpected nested structure

XML issues:

- Missing closing tag
- Schema mismatch

Parquet issues:

- Schema mismatch
- Unreadable file
- Incompatible column type

Avro issues:

- Schema evolution problem
- Invalid message structure

## Technical Checks vs Business Checks

| Type | Meaning | Examples |
| --- | --- | --- |
| Technical checks | Confirm basic structure and format | Null check, duplicate check, data type check, file exists check, column count check |
| Business checks | Confirm data follows business meaning | Revenue should not be negative, delivery date should not be before order date, refund should not exceed purchase |

## Example: E-Commerce Order Quality Checks

| Column | Possible Quality Check | Reason |
| --- | --- | --- |
| order_id | Not null and unique | Each order needs a trusted identifier |
| customer_id | Not null | Orders must link to customers |
| order_date | Valid date | Reports need correct timing |
| order_amount | Numeric and greater than zero | Revenue calculations need valid amounts |
| country | Standard values | Country reporting should group correctly |
| payment_status | Accepted list | Payment reporting needs valid statuses |
| delivery_status | Accepted list | Operations reporting needs valid statuses |

## What Happens When Data Quality Fails?

Possible actions:

- Stop the pipeline
- Send alert
- Quarantine bad records
- Load valid records and report invalid records
- Mark records for review
- Retry the pipeline
- Contact source system owner
- Document the issue
- Fix transformation logic
- Rerun pipeline after correction

The right action depends on business impact.

## Data Quality Severity

| Severity | Meaning | Example |
| --- | --- | --- |
| Low | Minor issue, does not block reporting | Optional middle name missing |
| Medium | Important issue, may affect some reports | Some country values are inconsistent |
| High | Major issue, may create wrong business decisions | Sales total does not match source |
| Critical | Pipeline or report should not be trusted | Daily orders table is empty |

## Role of a Data Engineer

| Responsibility | Example |
| --- | --- |
| Understand business expectations | Know which fields are critical |
| Define validation rules | Decide required null, range, and duplicate checks |
| Check source data | Validate input files and source tables |
| Check target data | Compare loaded data with source |
| Monitor pipelines | Track failures and stale data |
| Handle missing values | Flag or fix missing critical fields |
| Handle duplicates | Identify repeated orders or events |
| Investigate mismatches | Compare source and target totals |
| Document rules | Explain quality expectations |
| Alert stakeholders | Notify teams when data cannot be trusted |
| Support analysts | Help explain report issues |
| Improve data reliability | Add better checks over time |

## Beginner Analogy: Exam Marks Sheet

Imagine an exam marks sheet.

Problems may include:

- Missing student marks
- Duplicate student entries
- Marks above 100
- Wrong subject name
- Total marks not matching
- Student ID missing
- Old marks sheet uploaded again

These are similar to real data quality problems in companies.

## Beginner Analogy: Grocery Bill

A grocery bill can also have data quality issues:

- Item repeated twice
- Price missing
- Quantity negative
- Total does not match item sum
- Date missing
- Payment status incorrect

Validation checks help catch these problems before people trust the result.

## Common Beginner Confusions

1. Data existing does not mean data is correct.
2. A dashboard can look professional but still show wrong numbers.
3. Null values are not always bad, but important fields should not be missing.
4. Duplicate records are not always wrong; context matters.
5. Data quality is both technical and business-related.
6. Data engineers do not only move data; they also protect trust in data.
7. Validation checks should happen before users rely on reports.
8. Source systems can also send bad data.
9. Fixing data quality often needs business understanding.
10. Data quality rules should be documented.

## Key Takeaways

- Data quality means data is fit for its intended use.
- Data can exist and still be wrong.
- Missing values can break reporting and operations.
- Duplicates can inflate counts and totals.
- Invalid formats make processing difficult.
- Inconsistent values make grouping unreliable.
- Out-of-range values may signal errors.
- Stale data reduces trust.
- Broken relationships affect joined datasets.
- Validation checks help catch issues early.
- Technical and business checks are both important.
- ETL, ELT, batch, and streaming pipelines all need quality checks.
- Not every null or duplicate is automatically wrong.
- Business context decides severity.
- Data engineers protect trust in data.

## Next Day Preview

Day 009 will introduce Basic SQL for Data Engineers: tables, SELECT, WHERE, ORDER BY, and LIMIT.

## Navigation

- Previous: [Day 007 - Common Data Formats](../day-007-common-data-formats/)
- Next: Day 009 - Basic SQL for Data Engineers - Coming Soon
- [Back to Main Learning Path](../README.md)

