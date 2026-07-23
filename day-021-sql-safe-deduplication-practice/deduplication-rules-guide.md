# Deduplication Rules Guide

## What is a Deduplication Rule?

A deduplication rule explains which record should be selected from a duplicate group and why.

`ROW_NUMBER` implements the rule. It does not decide the rule.

## Rule Documentation Template

| Field | Description |
| --- | --- |
| Rule name | Short rule label |
| Dataset | Dataset affected |
| Business purpose | Why the rule exists |
| Business key | Columns defining a duplicate group |
| Duplicate reason | Why duplicate versions appear |
| Selection rule | Which row should be selected |
| Primary ordering column | Main sort column |
| Ordering direction | `ASC` or `DESC` |
| Tie-breaker | Secondary sort column |
| Null-handling rule | How missing values are handled |
| Review condition | When automatic selection is unsafe |
| Audit columns retained | Source and timestamp fields retained |
| Rule owner | Team or role responsible |
| Validation checks | Checks after selection |
| Last reviewed date | Date rule was reviewed |

## Example Rules

| Rule name | Dataset | Business key | Selection rule | Tie-breaker | Review condition |
| --- | --- | --- | --- | --- | --- |
| latest_order_state | orders | `order_id` | latest `updated_at` | latest `loaded_at` | conflicting same timestamps |
| latest_contact | contacts | `customer_id` | latest `updated_date` | latest `loaded_at` | missing phone or email |
| preferred_payment | payments | `transaction_id` | prefer `SUCCESS` | latest `updated_at` | inconsistent amounts |
| event_retry | events | `event_id` | earliest event time or latest received, based on rule | `received_at` | conflicting event names |
| campaign_reload | campaign metrics | composite campaign key | latest `loaded_at` | `source_file` | same load with different metrics |

## Automatic Versus Manual Rules

Automate only when the business key, ordering rule, tie-breaker, and review condition are clear. Flag records for review when values conflict or the tie-breaker is unreliable.

## Rule-Change Risk

If business definitions change, a clean layer may need to be rebuilt from preserved raw history.

## Auditability

Fields such as `source_file`, `loaded_at`, and original timestamps should remain visible in selected outputs.
