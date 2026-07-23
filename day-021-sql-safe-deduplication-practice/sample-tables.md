# Sample Tables for Day 021

Day 021 uses versioned records to practise safe deduplication with `ROW_NUMBER`.

## raw_orders_duplicate_versions

| Column | Meaning |
| --- | --- |
| `order_id` | Order business key |
| `customer_id` | Customer identifier |
| `order_status` | Order version status |
| `order_amount` | Order value |
| `updated_at` | Business update time |
| `loaded_at` | File/load ingestion time |
| `source_file` | Source file name |

Business key: `order_id`.

Duplicate versions exist because of status progression, corrected amounts, retry loads, equal update timestamps, and late-loaded older records. Possible rule: keep latest `updated_at`, then latest `loaded_at`. Review condition: same key and same timestamps with different values.

## customer_contacts_versions

Business key often starts with `customer_id`, depending on the output. Versions exist because emails, phone numbers, and statuses change.

| Column | Meaning |
| --- | --- |
| `customer_id` | Customer key |
| `email` | Email address |
| `phone_number` | Phone number |
| `contact_status` | Contact status |
| `updated_date` | Business update date |
| `loaded_at` | Load time |
| `source_file` | Source file |

Possible rule: keep latest contact version by `updated_date`, then `loaded_at`. Review condition: latest row has missing contact details.

## payment_transaction_versions

Business key: `transaction_id`.

Includes `PENDING`, `SUCCESS`, `FAILED`, and `REFUNDED`. Latest may not be enough; a preferred status rule may be more appropriate.

## website_event_versions

Business key: `event_id`.

Includes retries, corrected event timestamps, repeated event IDs, and same event timestamp with different receive time.

## campaign_performance_versions

Composite business key: `campaign_id + performance_date + channel + country`.

Repeated versions may represent corrected metrics from later files. Possible rule: keep latest `loaded_at`. Review condition: same load time with conflicting metrics.

## deduplication_rule_examples

This file documents example rules rather than transactional data.

| Column | Meaning |
| --- | --- |
| `scenario_id` | Rule scenario identifier |
| `dataset_name` | Dataset where rule applies |
| `business_key` | Key used to group records |
| `duplicate_reason` | Why duplicates may exist |
| `recommended_rule` | Suggested business rule |
| `tie_breaker` | Secondary ordering column |
| `review_required` | Whether manual review is required |
| `reason_for_review` | Why review may be needed |
