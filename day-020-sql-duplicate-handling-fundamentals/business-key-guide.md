# Business Key Guide for Duplicate Investigation

## What is a Business Key?

A business key is a column or group of columns that identifies a real business record.

## Business Key vs Technical Key

| Concept | Simple Meaning | Example |
| --- | --- | --- |
| Technical key | System-generated or table-level identifier | `contact_id` |
| Business key | Business-defined identifier | `order_id` |

## Single-Column Business Key

Examples:

- `order_id`
- `transaction_id`
- `event_id`
- `contact_id`

## Composite Business Key

Sometimes multiple columns identify a record:

- `performance_date + campaign_id + channel + country`
- `customer_id + email`
- `summary_year + summary_month + country`

## Grain

Grain means what one row represents.

Examples:

- one row per order
- one row per payment attempt
- one row per website event
- one row per campaign per date per country
- one row per customer contact

## Why Grain Matters

Duplicates cannot be understood without knowing what one row should represent.

## Business Key Examples by Table

| Table | Possible Grain | Possible Business Key | Notes |
| --- | --- | --- | --- |
| raw_orders_with_duplicates | One row per order | order_id | Repeated IDs need review |
| payment_transactions | One row per transaction | transaction_id | order_id can repeat |
| website_events_with_duplicates | One row per event | event_id | user_id repeats normally |
| campaign_performance_duplicates | One row per campaign/date/channel/country | performance_date + campaign_id + channel + country | Composite key |
| customer_contacts | One row per contact | contact_id | email may repeat |

## Repeated Does Not Always Mean Duplicate

Repeated `customer_id` in orders, repeated `campaign_id` across dates, repeated `order_id` in payment attempts, and repeated `user_id` in events may be valid.

## Questions to Ask Before Deduplicating

- What should one row represent?
- Which columns identify one business record?
- Can values update over time?
- Can multiple attempts be valid?
- Can late-arriving corrections happen?
- Which record should be kept if duplicates exist?
- Should suspicious records be flagged instead of removed?
- Who owns the business rule?

## Documentation Template

| Dataset | Grain | Business Key | Duplicate Rule | Keep Rule | Notes |
| --- | --- | --- | --- | --- | --- |
| raw_orders | One row per order | order_id | Review repeats | Not decided yet | Example |
