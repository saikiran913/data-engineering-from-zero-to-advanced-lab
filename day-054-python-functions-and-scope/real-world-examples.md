# Real-World Examples

| # | Scenario | Function name | Inputs | Output | Business purpose | Side-effect expectation |
|---|---|---|---|---|---|---|
| 1 | normalize status | `normalize_status` | status text | clean text | consistent categories | none |
| 2 | normalize source | `normalize_source_name` | source text | clean text | stable labels | none |
| 3 | validate row count | `validate_record_count` | count/None | status | source validation | none |
| 4 | classify errors | `classify_error_count` | error count | status | threshold result | none |
| 5 | completeness | `calculate_completeness` | valid/total | float/None | quality metric | none |
| 6 | allowed status | `validate_status` | status | PASS/FAIL | status control | none |
| 7 | staging label | `build_stage_name` | source | text | naming convention | none |
| 8 | percentage | `calculate_percentage` | part/total | float/None | metric calculation | none |
| 9 | negative amount | `validate_amount` | amount | status | data-quality check | none |
| 10 | lowercase label | `normalize_source_name` | label | lowercase text | standardisation | none |
| 11 | undefined ratio | `calculate_ratio` | count/zero | None | avoid division by zero | none |
| 12 | missing row count | `validate_record_count` | None | REVIEW | missing metric | none |
| 13 | freshness | `classify_freshness` | Boolean | status | source recency | none |
| 14 | country code | `normalize_country_code` | text | uppercase text | consistent code | none |
| 15 | schema flag | `validate_schema_flag` | Boolean | status | schema validation | none |
| 16 | normalize + validate | two functions | raw status | status | clean then check | none |
| 17 | loop validator | `validate_record_count` | counts | statuses | reused rule | none |
| 18 | orchestration | `main` | hard-coded values | printed summary | coordinate calls | print only |
| 19 | hidden global anti-pattern | `classify_errors` | hidden threshold | unclear | avoid dependency | risky |
| 20 | print-vs-return anti-pattern | `calculate_total` | values | None | not reusable | print side effect |
| 21 | refactor large function | small functions | focused inputs | focused outputs | clarity | limited |
| 22 | deterministic transform | `normalize_status` | same text | same output | predictable | none |
| 23 | side effect concept | `write_report` | values | external change | future topic | not used today |
| 24 | clear interface | `calculate_completeness` | two counts | float/None | documented calculation | none |
| 25 | default threshold | `classify_error_count` | count, limit | status | optional limit | none |
| 26 | workflow | multiple functions | raw values | summary values | pipeline step | print in main |
| 27 | reused sources | validator | several counts | statuses | no copy-paste | none |
| 28 | no function needed | `record_count > 0` | one value | Boolean | trivial one-off | none |
