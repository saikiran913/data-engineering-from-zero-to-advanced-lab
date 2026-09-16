# Data Engineering Validation Scenarios

| # | Input variables | Business rule | Condition | Expected result | Reason |
|---|---|---|---|---|---|
| 1 | `record_count = 120` | source has rows | `record_count > 0` | `PASS` | rows exist |
| 2 | `record_count = 0` | source cannot be empty | `record_count == 0` | `FAIL` | empty source |
| 3 | `record_count = None` | count must be available | `record_count is None` | `REVIEW` | missing metric |
| 4 | `error_count = 0` | no errors | `error_count == 0` | `PASS` | clean validation |
| 5 | `error_count = 3` | low errors need review | `0 < error_count <= 5` | `REVIEW` | small issue count |
| 6 | `error_count = 20` | high errors fail | `error_count > 5` | `FAIL` | threshold exceeded |
| 7 | `completeness_pct = 99.5` | at least 99% | `completeness_pct >= 99.0` | `PASS` | threshold met |
| 8 | `completeness_pct = 98.9` | at least 99% | `completeness_pct >= 99.0` | `REVIEW` | just below threshold |
| 9 | `completeness_pct = 99.0` | exact threshold allowed | `completeness_pct >= 99.0` | `PASS` | boundary included |
| 10 | `status = "READY"` | status supported | `status in ("READY", "RETRY")` | `PASS` | allowed status |
| 11 | `status = "UNKNOWN"` | status supported | `status not in ("READY", "RETRY")` | `REVIEW` | unsupported status |
| 12 | `status = "CANCELLED"` | cancelled blocked | `status == "CANCELLED"` | `FAIL` | blocked status |
| 13 | `has_required_column = True` | column present | `has_required_column` | `PASS` | schema check passed |
| 14 | `has_required_column = False` | column present | `not has_required_column` | `FAIL` | required column missing |
| 15 | `has_rows = True`, `schema_valid = True` | all checks pass | `has_rows and schema_valid` | `PASS` | both true |
| 16 | `status = "RETRY"` | one status allowed | `status in ("READY", "RETRY")` | `PASS` | retry allowed |
| 17 | `status = "HELD"` | neither allowed | `status in ("READY", "RETRY")` | `REVIEW` | needs review |
| 18 | `amount = 25.0` | positive amount | `amount > 0` | `PASS` | valid positive value |
| 19 | `amount = 0` | zero amount allowed for review | `amount == 0` | `REVIEW` | zero needs business check |
| 20 | `amount = -1.0` | no negative amount | `amount < 0` | `FAIL` | invalid amount |
| 21 | `value = None` | value missing | `value is None` | `REVIEW` | no value supplied |
| 22 | `country_code = ""` | required text | `country_code == ""` | `FAIL` | blank required field |
| 23 | `flag_text = "False"`, `flag = False` | text not boolean | `flag_text == flag` | `False` | different types |
| 24 | `schema_valid = True`, `is_fresh = True` | both required | `schema_valid and is_fresh` | `PASS` | both true |
| 25 | `schema_valid = False`, `is_fresh = True` | both required | `schema_valid and is_fresh` | `FAIL` | schema invalid |
| 26 | `error_count = 4`, `null_rate = 2.0` | two review signals | `error_count > 0 or null_rate > 1.0` | `REVIEW` | either needs review |
| 27 | `error_count = 120` | severe first | `error_count > 100` before `> 0` | `FAIL` | order prevents wrong review |
| 28 | `status = "PAUSED"` | fallback handles unknown | `else` | `REVIEW` | unexpected state visible |
