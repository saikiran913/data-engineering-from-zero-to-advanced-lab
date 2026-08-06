# Handoff Contract Guide

A handoff contract explains what one stage gives to the next stage. It helps downstream users understand the grain, rules, keys, audit columns, and limitations of the data.

## Why Handoff Contracts Matter

Without a handoff contract, downstream logic may reinterpret the data differently. One team may treat `paid` as completed. Another may count only `completed`. One query may keep latest received records, while another keeps latest business event records.

A contract reduces confusion by making rules explicit.

## Contract Template

| Field | What to Write |
|---|---|
| Stage name | Name of the output being handed off |
| Purpose | Why the stage exists |
| Source object | Input dataset or previous stage |
| Input grain | What one input row represents |
| Output grain | What one output row represents |
| Business key | Main key used by the stage |
| Required columns | Columns the next stage requires |
| Audit columns | Traceability columns such as `source_file` and `received_at` |
| Standardisation rules | Mapping or cleanup rules applied |
| Deduplication rule | Business key, ordering rule, and tie-breaker |
| Accepted rule | What allows a row to move forward |
| Review rule | What sends a row to investigation |
| Validation checks | Counts, keys, dates, totals, nulls, and duplicates |
| Downstream handoff | Next stage or reporting use |
| Known limitations | What the output does not guarantee |

## Example: Source to Standardised Stage

| Field | Example |
|---|---|
| Stage name | source standardisation |
| Purpose | Map raw statuses and add country group |
| Source object | `raw_customer_orders` |
| Input grain | One row per received source order event |
| Output grain | One row per standardised source order event |
| Business key | `source_event_id` |
| Required columns | `source_event_id`, `order_id`, `raw_status`, `standard_status` |
| Audit columns | `source_file`, `received_at` |
| Standardisation rules | Join `raw_status` to `source_status_mapping` |
| Deduplication rule | None at this stage |
| Accepted rule | Mapping exists and status is supported |
| Review rule | Missing or unsupported mapping |
| Validation checks | Row count matches raw source; unmapped statuses reviewed |
| Downstream handoff | Candidate selection |
| Known limitations | Does not choose latest order record |

## Example: Clean Handoff

| Field | Example |
|---|---|
| Stage name | clean customer orders |
| Purpose | Provide one clean row per order |
| Source object | accepted staged candidates |
| Input grain | One accepted candidate row |
| Output grain | One clean row per order |
| Business key | `order_id` |
| Required columns | `order_id`, `customer_id`, `order_status`, `order_amount`, `order_date`, `country_group` |
| Audit columns | `source_event_id`, `source_file`, `received_at`, `cleaned_at` |
| Standardisation rules | Status already standardised |
| Deduplication rule | Candidate selected by latest event timestamp and received timestamp |
| Accepted rule | Valid key, customer, status, and amount |
| Review rule | Null key, missing customer, invalid amount, unsupported status, unresolved tie |
| Validation checks | Unique clean `order_id`; no missing critical fields |
| Downstream handoff | Reporting summary |
| Known limitations | Review rows are not included in reporting |

## Review Checklist

- Is the stage purpose clear?
- Is the input grain documented?
- Is the output grain documented?
- Is the business key documented?
- Are audit columns preserved?
- Are accepted and review rules visible?
- Are row counts reconciled?
- Are clean keys unique when required?
- Is reporting grain unique when required?
- Are known limitations written down?
