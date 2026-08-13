# Validation Rule Design Guide

A validation rule is a documented check. It should be clear enough that another person understands why the query exists and what the result means.

## Rule Template

| Field | Meaning |
|---|---|
| Rule ID | Stable identifier for the check |
| Stage name | Source, stage, clean, or reporting |
| Check type | Row count, duplicate key, total, completeness, or exception |
| Source population | Input side being checked |
| Target population | Output side being checked |
| Source grain | What one source row represents |
| Target grain | What one target row represents |
| Business key | Key used for comparison |
| Expected condition | What should be true |
| Expected difference | Difference allowed by documented rules |
| Severity | How important the issue is |
| Exception output | Whether detailed records should be listed |
| Review message | Plain-language explanation |

## Good Rule Example

| Field | Example |
|---|---|
| Rule ID | `RULE004` |
| Stage name | Clean |
| Check type | Duplicate key |
| Business key | `order_id` |
| Expected condition | One row per clean order |
| Expected difference | None |
| Severity | High |
| Exception output | Duplicate order IDs |
| Review message | Clean order grain should be one row per order |

## Tolerance Guidance

Some validation checks need exact matches. Some may allow a documented tolerance. A tolerance is not a guess. It is a business rule that should be written down.

Beginner examples:

- exact count match expected
- zero duplicate keys expected
- completed amount must match exactly
- null metric count must be zero
- date coverage must include expected business dates

## Evidence Checklist

- Does the rule name the populations?
- Does it define grain?
- Does it define the key?
- Does it explain expected differences?
- Does it produce exception rows when useful?
- Does it avoid changing data?
- Does it explain whether the result is `PASS` or `REVIEW`?
