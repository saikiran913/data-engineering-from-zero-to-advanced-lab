# Real-World Examples

| # | Situation | Input | Command or pipeline | Output | Safety note | Limitation |
|---|---|---|---|---|---|---|
| 1 | Count error log lines | `pipeline_log.txt` | `grep "ERROR" sample-data/pipeline_log.txt | wc -l` | Error count | Inspect matches too | Case-sensitive by default |
| 2 | Count warning log lines | `pipeline_log.txt` | `grep "WARN" sample-data/pipeline_log.txt | wc -l` | Warning count | Warnings need review | Pattern may match text unexpectedly |
| 3 | List unique statuses | `status_values.txt` | `sort sample-data/status_values.txt | uniq` | Unique status list | Sort before `uniq` | Text only |
| 4 | Count unique statuses | `status_values.txt` | `sort sample-data/status_values.txt | uniq | wc -l` | Unique count | Inspect list first | Blank lines can affect counts |
| 5 | Extract simple CSV status column | `orders_sample.csv` | `cut -d',' -f4 sample-data/orders_sample.csv` | Fourth field | Header appears | Not robust CSV parsing |
| 6 | Capture warnings | `pipeline_log.txt` | `grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt` | Review file | `>` overwrites | Use practice target only |
| 7 | Append investigation note | Text note | `echo "Warnings reviewed" >> practice-output/review_notes.txt` | Notes file | Appends can grow forever | Keep notes reviewed |
| 8 | Redirect stderr from missing file | Missing path | `cat sample-data/does-not-exist.txt 2> practice-output/errors.txt` | Error file | Inspect errors | Wording varies |
| 9 | Capture all output conceptually | Any safe command | `command > practice-output/all-output.txt 2>&1` | Combined file | Separation is lost | Use carefully |
| 10 | Inspect last log lines then filter | `pipeline_log.txt` | `tail sample-data/pipeline_log.txt | grep "INFO"` | Recent info lines | Check source first | Tail size varies by default |
| 11 | Filter before counting | Log file | `grep "ERROR" sample-data/pipeline_log.txt | wc -l` | Count | Inspect matches first | Pattern quality matters |
| 12 | Separate normal and error output | Text command | `cat sample-data/README.txt > practice-output/out.txt 2> practice-output/errors.txt` | Two files | Review both | Empty error file can be normal |
| 13 | Simple row-count check | CSV file | `wc -l sample-data/orders_sample.csv` | Line count | Header included | Not all file formats are line-based |
| 14 | Compare status frequencies conceptually | Status file | `sort sample-data/status_values.txt | uniq` | Status list | Count separately | No frequency count yet |
| 15 | Create review artifact | Warning lines | `grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt` | Text artifact | Practice folder only | Overwrite risk |
| 16 | Use `tee` during investigation | Info lines | `grep "INFO" sample-data/pipeline_log.txt | tee practice-output/info_lines.txt` | Screen and file | `tee` writes | Can overwrite |
| 17 | Avoid overwriting source | Any source file | `grep "WARN" sample-data/pipeline_log.txt > practice-output/warnings.txt` | Safe copy | Do not target source | Source unchanged |
| 18 | Header-row effect | CSV status field | `cut -d',' -f4 sample-data/orders_sample.csv | sort | uniq` | Includes `order_status` | Header is not data | Simple CSV only |
| 19 | Simple command chaining | Log file | `grep "INFO" sample-data/pipeline_log.txt | head` | First info matches | Test each stage | Defaults vary |
| 20 | Empty result scenario | Log file | `grep "CRITICAL" sample-data/pipeline_log.txt` | No stdout | Not always failure | Check exit status later |
| 21 | Path with spaces | Practice folder | `echo "note" > "practice-output/review note.txt"` | Spaced file path | Quote path | Keep in practice folder |
| 22 | Bash versus PowerShell | Same idea | `grep "ERROR" sample-data/pipeline_log.txt` | Bash text match | PowerShell differs | Use shell-specific help |
| 23 | CLI output capture future use | Tool output | `command > practice-output/tool-output.txt` | Captured output | Inspect target first | Generic concept |
| 24 | Complex CSV/JSON limitation | Structured files | `cut -d',' -f4 sample-data/orders_sample.csv` | Simple field output | Not a parser | Use proper tools later |

