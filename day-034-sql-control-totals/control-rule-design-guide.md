# Control Rule Design Guide

A control rule explains what should be compared and how the result should be interpreted.

## Define the Control

| Item | Meaning |
|---|---|
| Control ID | Stable name for the rule |
| Control name | Human-readable name |
| Stage pair | Source-to-stage, stage-to-clean, or clean-to-reporting |
| Source object | Dataset on the left side |
| Target object | Dataset on the right side |
| Source grain | What one source row represents |
| Target grain | What one target row represents |
| Business key | Key used for comparison |
| Source filter | Filter applied to source population |
| Target filter | Filter applied to target population |
| Control type | Count, distinct key, sum, boundary, or grouped control |
| Measure | Column being measured |
| Group columns | Columns used for grouped controls |
| Expected relationship | Exact match or expected difference |
| Expected difference | Documented reason for a difference |
| Tolerance if approved | Allowed variance if the business approves it |
| Severity | Review importance |
| Evidence query | SQL that produces the evidence |
| Owner role | Who reviews the result |
| Review date | When it was reviewed |

## Exact Match Examples

- accepted stage count equals clean count when every accepted row becomes one clean row
- clean completed amount equals reporting completed amount when filters align
- reporting grain has no duplicate date and country group

## Expected Difference Examples

- source row count can be greater than staged distinct order count because duplicates are removed
- stage count equals accepted plus review
- reporting row count is usually smaller than clean row count because reporting is aggregated

## Severity Guidance

| Severity | Meaning |
|---|---|
| High | Can affect correctness or trust |
| Medium | Needs review but may not block learning output |
| Low | Useful evidence or documentation check |

## Rule Quality Checklist

- Is the population defined?
- Is the grain defined?
- Are filters aligned?
- Is the expected relationship documented?
- Is the difference direction clear?
- Is there grouped evidence when needed?
- Is the result read-only?
