# Designing Business-Ready Outputs

## What is Business-Ready Data?

Business-ready data is cleaned, standardised, labelled, and understandable for reporting or analysis.

## Raw Layer vs Clean Layer vs Business Layer

```text
Raw Layer
  |
  v
Clean Layer
  |
  v
Business Layer
  |
  v
Dashboard / Report
```

Raw data is original. Clean data is standardised. Business data has useful labels and fields for analysis.

## What Makes an Output Business-Ready?

- Clear column names.
- Standardised values.
- Important `NULL`s handled carefully.
- Raw values preserved where useful.
- Derived labels documented.
- Business rules applied consistently.
- Unnecessary columns removed.
- Values ready for grouping and filtering.
- Output easy for analysts to understand.

## Example Business-Ready Outputs

Customer outputs usually include clean names, country, email, status, and opt-in labels. Order outputs include clean statuses, country, value band, and health label. Product outputs include clean category, active flag, stock status, and price band. Campaign outputs include clean channel, country, status, and budget band. Performance outputs include clean channel, performance label, and conversion label.

## Data Cleaning Rules vs Business Rules

| Rule Type | Meaning | Example |
| --- | --- | --- |
| Cleaning rule | Standardises messy values | `paid` -> `Paid` |
| Business rule | Adds business meaning | `Paid + Delivered` -> `Healthy` |

## Rule Documentation Template

| Output Column | Source Column(s) | Rule Type | Rule Description | Example | Notes |
| --- | --- | --- | --- | --- | --- |
| order_value_band | order_amount | Business rule | Create amount range label | 750 -> Premium | Thresholds require approval |

## Review Checklist Before Publishing Business-Ready Output

- Are raw values preserved somewhere?
- Are clean labels consistent?
- Are `NULL` replacements justified?
- Are thresholds documented?
- Are business users aligned?
- Are grouped counts checked?
- Are unknown values reviewed?
- Are column names readable?
- Are dashboards using clean fields?
- Are rules versionable and maintainable?
