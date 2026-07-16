# Sample Tables for Day 019

Day 019 uses similar datasets stored separately by region, month, channel, or file part.

## Regional Order Tables

Shared schema:

`order_id`, `customer_id`, `order_date`, `order_amount`, `order_status`, `payment_status`, `country`

| File | Region | Expected Use | Important Validation |
| --- | --- | --- | --- |
| `uk_orders` | UK | Regional order combination | Exact duplicate shared with another file |
| `india_orders` | India | Regional order combination | Exact duplicate row and repeated ID with changed values |
| `usa_orders` | USA | Regional order combination | Exact duplicate shared with another file |

## Monthly Order Tables

| File | Purpose | Why It Can Be Combined | Intentional Learning Issue |
| --- | --- | --- | --- |
| `january_orders` | January order file | Same order schema | Monthly file source |
| `february_orders` | February order file | Same order schema | Contains a late-arriving January order |

The file month does not always equal the business event month.

## Campaign Performance Tables

Shared schema:

`performance_date`, `campaign_id`, `channel`, `country`, `impressions`, `clicks`, `cost`, `conversions`, `revenue`

| File | Channel | Expected Use | Important Validation |
| --- | --- | --- | --- |
| `search_campaign_performance` | Search | Channel combination | Cost and conversion checks |
| `social_campaign_performance` | Social | Channel combination | Country coverage |
| `email_campaign_performance` | Email | Channel combination | Smaller source row count |

## Website Event Files

| File | Purpose | Why It Can Be Combined | Intentional Learning Issue |
| --- | --- | --- | --- |
| `website_events_part_1` | First event file part | Same event schema | Baseline events |
| `website_events_part_2` | Second event file part | Same event schema | One exact duplicate and one repeated event ID with changed details |

## union_output_examples

This file documents educational examples of `UNION` and `UNION ALL` behaviour.

## Schema Compatibility Map

| Dataset Group | Shared Column Count | Shared Logical Order | Can Use UNION ALL? |
| --- | ---: | --- | --- |
| Regional orders | 7 | Yes | Yes |
| Monthly orders | 7 | Yes | Yes |
| Campaign performance | 9 | Yes | Yes |
| Website event parts | 7 | Yes | Yes |

## Intentional Learning Issues

- exact duplicate rows
- repeated IDs with different values
- late-arriving records
- separate source origins
- need for source labels
