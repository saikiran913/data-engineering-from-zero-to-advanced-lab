# Completeness Rule Design Guide

A completeness rule describes what should exist and how gaps should be reviewed.

## Rule Template

| Field | Meaning |
|---|---|
| Rule ID | Stable rule name |
| Completeness type | Field, key, record, date, category, status, or file |
| Expected population | What should exist |
| Actual population | Where to check |
| Grain | What one row represents |
| Business key | Key used for comparison |
| Required field | Field that must be populated |
| Expected value | Expected key, date, category, or file |
| Exclusion rule | Documented reason a gap may be valid |
| Duplicate rule | How duplicates affect the check |
| Expected condition | What should be true |
| Severity | Review importance |
| Exception query | Query that lists gaps |
| Evidence query | Summary query |
| Owner role | Who reviews the result |
| Review date | When the rule was reviewed |

## Good Rule Example

| Field | Example |
|---|---|
| Completeness type | Date coverage |
| Expected population | expected report dates |
| Actual population | `reporting_customer_orders` |
| Grain | one reporting row per date and country group |
| Expected condition | every expected report date appears |
| Severity | High |
| Exception output | missing report dates |

## Checklist

- Is requiredness defined?
- Is the expected population explicit?
- Is the actual population explicit?
- Is the grain clear?
- Are expected exclusions documented?
- Does the exception output preserve evidence?
- Does the rule avoid fabricating missing data?
