# Real-World Examples

## Scenario 1: Order Status History

| version | status | meaning |
| --- | --- | --- |
| 1 | CREATED | Order opened |
| 2 | PAID | Payment accepted |
| 3 | SHIPPED | Order fulfilled |

Likely reason: normal status progression.

Business key: `order_id`.

Possible rule: keep latest `updated_at` for a current-state order table.

Risk: a history table should keep all versions.

Validation: confirm one selected row per `order_id`.

## Scenario 2: Corrected Order Amount

A later order version changes `order_amount`. The latest row may be correct, but audit columns should remain visible.

Possible rule: keep latest update and retain `source_file`, `updated_at`, and `loaded_at`.

## Scenario 3: Payment Retries

| status | possible meaning |
| --- | --- |
| FAILED | Attempt failed |
| PENDING | Not final |
| SUCCESS | Payment accepted |

Possible rule: prefer `SUCCESS` over timestamp-only logic. Risk: refund logic may need separate business review.

## Scenario 4: Re-Delivered Website Event

A source may send the same event more than once. `event_timestamp` tells when the event happened. `received_at` tells when the platform received it. These are not interchangeable.

## Scenario 5: Corrected Campaign File

The same campaign/date/channel/country may arrive in two files with revised metrics. A latest-loaded-file rule can select corrected metrics when the business trusts later delivery.

## Scenario 6: Unresolved Timestamp Tie

Two records share the same business key and same `updated_at`, but values differ. Without a reliable tie-breaker, the correct action is review, not arbitrary automatic selection.

## Practical Validation Checklist

- confirm the business key
- confirm the ordering rule
- inspect duplicate groups
- retain audit columns
- identify ties
- flag unresolved groups
- validate one selected row per key
- document the rule
