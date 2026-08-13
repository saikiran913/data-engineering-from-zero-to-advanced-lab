# Day 035 Query Explanations

Day 035 checks whether expected data is present. The SQL files use read-only queries to compare expected populations with actual populations.

| File | Main Question | Completeness Type | Output |
|---|---|---|---|
| `required-field-completeness.sql` | Are required fields populated? | field completeness | null and blank counts |
| `missing-key-checks.sql` | Are expected business keys present? | key completeness | source-only, stage-only, missing clean keys |
| `expected-record-checks.sql` | Do expected records exist? | record completeness | expected-versus-actual status |
| `date-coverage-checks.sql` | Are expected dates present? | date coverage | missing dates and boundaries |
| `category-and-status-coverage.sql` | Are expected categories present? | category and status coverage | missing and unexpected categories |
| `source-file-completeness.sql` | Did expected files arrive? | file coverage | missing and unexpected source files |
| `stage-completeness-reconciliation.sql` | Did records move between stages? | stage completeness | source-stage, stage-clean, clean-reporting gaps |
| `completeness-percentages.sql` | What percentage is complete? | coverage percentage | safe percentage calculations |
| `completeness-exception-reporting.sql` | What needs review? | exception reporting | investigation rows |
| `completeness-summary.sql` | What is the check status? | summary | `PASS` or `REVIEW` rows |
| `completeness-debugging-lab.sql` | What can mislead us? | debugging | follow-up checks |
| `integrated-completeness-workflow.sql` | How do checks work together? | integrated workflow | summary and exceptions |

## Important Reminders

- Completeness does not prove correctness.
- Nulls depend on business rules.
- Expected exclusions must be documented.
- Missing rows should be investigated, not invented.
- Date coverage needs explicit expected dates, not only min and max dates.

## Platform Notes

Blank-string handling, date casting, multi-column distinct syntax, and exact percentage formatting vary by SQL platform. These examples use simple portable patterns where possible.
