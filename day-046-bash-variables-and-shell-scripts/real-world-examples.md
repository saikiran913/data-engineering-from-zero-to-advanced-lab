# Real-World Examples

| # | Situation | Reusable variable or script idea | Input | Validation | Safe output | Limitation |
|---|---|---|---|---|---|---|
| 1 | Store source path | `input_file="sample-data/orders_sample.csv"` | Orders CSV | Check file | Print path | One file only |
| 2 | Store log path | `log_file="sample-data/pipeline_log.txt"` | Log file | Check file | Print path | Local sample |
| 3 | Count supplied CSV lines | `bash scripts/02-count-lines.sh file` | CSV argument | `$#` and `-f` | Line count | Header included |
| 4 | Filter supplied log | `bash scripts/03-filter-log.sh log ERROR` | Log and term | Two arguments | Matches and count | Case-sensitive |
| 5 | Validate expected file | `-f` check | File path | File exists | Success/error | Does not inspect content quality |
| 6 | Validate expected folder | `-d` check | Directory path | Directory exists | Success/error | Does not scan deeply |
| 7 | Count ERROR lines | command substitution | Log file | File exists | Error count | Text pattern only |
| 8 | Count WARN lines | command substitution | Log file | File exists | Warning count | Pattern must be exact |
| 9 | Loop through two CSVs | explicit `for` loop | Known CSVs | Per-file check | Counts | Manual list |
| 10 | Loop through supplied files | `"$@"` | Arguments | Per-file check | Reviewed/missing summary | Input order matters |
| 11 | Summarise sample directory | `06-safe-summary.sh` | `sample-data` | `-d` and known files | stdout summary | Known files only |
| 12 | Create usage message | `$#` check | Missing args | Argument count | stderr usage | Message must stay current |
| 13 | Stop on missing argument | `exit 1` | Missing arg | `$#` | Non-zero exit | Caller must notice |
| 14 | Return non-zero exit code | failed validation | Bad path | `-f` or `-d` | Failure signal | Exact code is simple |
| 15 | Print error to stderr | `echo "... " >&2` | Bad input | Validation | Separate error stream | Still needs inspection |
| 16 | Reuse command substitution | `count=$(...)` | Command stdout | Test first | Stored count | Captures stdout only |
| 17 | Quote path with spaces | `"$input_file"` | Spaced path | Quoting | One path value | Avoid complex shell parsing |
| 18 | Safe summary without changes | read-only script | Sample files | Known checks | stdout | No source writes |
| 19 | Dry-run concept | print planned action | Future task | Review plan | No changes | Concept only today |
| 20 | Idempotent read-only check | run twice safely | Same files | Same inputs | Same style output | Output time may differ in future |
| 21 | Future ingestion wrapper | validate input before load | File path | Exists and readable | Message only | No loading today |
| 22 | Future data-quality wrapper | standard checks | Sample file | File exists | Counts | Simple checks only |
| 23 | Future cloud CLI wrapper | validate local arguments first | Planned command | Dry-run first | Message only | No cloud commands today |
| 24 | No-script-needed one-off command | direct shell command | One quick check | Visual review | Terminal output | Script would be extra |
