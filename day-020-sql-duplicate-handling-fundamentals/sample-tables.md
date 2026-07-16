# Sample Tables for Day 020

Day 020 uses raw-style datasets with intentional duplicate and duplicate-looking examples.

## raw_orders_with_duplicates

| Column | Meaning |
| --- | --- |
| order_id | Order business identifier |
| customer_id | Customer identifier |
| order_date | Date order happened |
| order_amount | Order value |
| order_status | Order status |
| payment_status | Payment status |
| country | Order country |
| source_file | File where row came from |

Includes exact duplicate rows, repeated order IDs with changed statuses, retry files, and late-arriving corrections.

## customer_contacts

Includes repeated emails, case differences, extra spaces, blank emails, and repeated customers with multiple contact records.

## website_events_with_duplicates

Includes exact duplicate event rows, repeated event IDs with changed timestamps, and repeated users with different events.

## campaign_performance_duplicates

Includes repeated campaign/date/channel/country keys with identical and changed metric values.

## payment_transactions

Includes exact duplicate transactions, repeated transaction IDs with changed statuses, and same order IDs with multiple payment attempts.

## duplicate_output_examples

Documents educational duplicate scenarios and safe actions.

## Possible Business Keys

| Table | Possible Grain | Possible Business Key | Notes |
| --- | --- | --- | --- |
| raw_orders_with_duplicates | One row per order record | order_id | Repeats may be retries or corrections |
| customer_contacts | One row per contact record | contact_id | Email may repeat |
| website_events_with_duplicates | One row per event | event_id | user_id repeats normally |
| campaign_performance_duplicates | One row per campaign/date/channel/country | performance_date + campaign_id + channel + country | Composite key |
| payment_transactions | One row per transaction | transaction_id | order_id can repeat for attempts |
