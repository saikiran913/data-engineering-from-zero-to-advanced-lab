# Exception Rule Design Guide

An exception rule explains when a validation finding should become a review item.

## Rule Template

| Field | Meaning |
|---|---|
| Rule ID | Stable rule identifier |
| Exception level | Record, metric, or stage |
| Stage name | Where the issue is detected |
| Entity key | Affected record, group, file, or metric |
| Issue category | High-level controlled category |
| Issue type | Specific issue inside the category |
| Expected value | What the rule expected |
| Actual value | What was observed |
| Difference value | Numeric or descriptive difference |
| Severity | Rule-based priority |
| Source lineage | Source file or stage context |
| Audit timestamp | Extracted, cleaned, or loaded timestamp |
| Review message | What should be investigated |

## Severity Guidance

| Severity | Meaning |
|---|---|
| `INFO` | Observation or expected exception |
| `REVIEW` | Investigation required |
| `HIGH_REVIEW` | Important issue under the example rule |

Severity should be documented. It should not be guessed from personal preference.

## Good Review Message

```text
Clean order has no matching source record. Review lineage.
```

## Weak Review Message

```text
Bad data.
```

## Checklist

- Is the exception level clear?
- Is the stage clear?
- Is the entity key present?
- Is the issue category controlled?
- Is the issue type specific?
- Are expected and actual values useful?
- Is audit context preserved?
- Is severity rule-based?
- Is the output read-only?
