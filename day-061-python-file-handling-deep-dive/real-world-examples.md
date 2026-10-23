# Real-World File Handling Examples

| # | Situation | Pattern | Check |
|---|---|---|---|
| 1 | Daily orders CSV arrives | `DictReader` | Required columns |
| 2 | Regional sales files arrive | Loop over reviewed paths | Source filename |
| 3 | A configuration controls statuses | `json.load` | Required keys |
| 4 | A config is malformed | Catch `JSONDecodeError` | Do not continue silently |
| 5 | Notes contain blank lines | Iterate and test `.strip()` | Retain meaningful content |
| 6 | An amount is text | `float()` in `try` | Non-negative value |
| 7 | A customer ID is blank | `.strip() == ""` | Mark FAIL |
| 8 | Status has extra spaces | `.strip().upper()` | Allowed values |
| 9 | A quoted comment has commas | `csv` module | Correct parsed cell |
| 10 | Pipeline produces a clean CSV | `DictWriter` | Header and row count |
| 11 | Pipeline writes a summary | `json.dump(indent=2)` | Reparse JSON |
| 12 | Input must remain unchanged | Read from `sample-data/` | File hash unchanged |
| 13 | Output may be replaced | `w` in `output/` | Destination reviewed |
| 14 | Log needs history | Controlled `a` mode | No duplicate rerun entries |
| 15 | A file path is missing | Catch `FileNotFoundError` | Helpful error message |
| 16 | Access is denied | Catch `PermissionError` | Escalate access issue |
| 17 | Source encoding differs | Catch decode error | Confirm encoding |
| 18 | Header changed unexpectedly | Compare field names | Stop safely |
| 19 | A new optional field arrives | Explicit output fields | Decide inclusion |
| 20 | A validation result needs review | Add REVIEW status | Reason present |
| 21 | Raw archive is retained | Never overwrite source | Separate output |
| 22 | A report needs provenance | Add `source_file` | Traceable summary |
| 23 | Large text input arrives | Iterate lines | Avoid unnecessary `.read()` |
| 24 | A process fails mid-read | Use `with` | File closes safely |
| 25 | A process fails mid-write | Write only generated files | Inspect incomplete result |
| 26 | Dates look unusual | Preserve row and flag it | Investigate later |
| 27 | Unknown status appears | Normalise then REVIEW | Do not relabel as valid |
| 28 | Duplicate delivery is suspected | Compare file names/counts | Preserve evidence |
| 29 | Output is consumed downstream | Use stable field order | Schema check |
| 30 | A source has empty rows | Skip only with a documented rule | Count skipped rows |
| 31 | Configuration lists expected columns | Read JSON before CSV | Validate schema |
| 32 | A file is in the wrong folder | Use day-relative paths | Correct layout |
| 33 | A bug writes to input path | Separate variables `source`/`output` | Review mode and path |
| 34 | Team reviews a failure | Keep reason and row number | Reproducible diagnosis |

Each example follows the same principle: preserve source data, make transformations visible, and verify generated output.
