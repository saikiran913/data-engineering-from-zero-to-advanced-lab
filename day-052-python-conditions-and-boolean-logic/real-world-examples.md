# Real-World Examples

| # | Scenario | Variables | Condition | Decision | Explanation |
|---|---|---|---|---|---|
| 1 | file row count | `record_count = 100` | `record_count > 0` | `PASS` | source has rows |
| 2 | empty file | `record_count = 0` | `record_count == 0` | `FAIL` | empty source |
| 3 | missing row count | `record_count = None` | `record_count is None` | `REVIEW` | metric absent |
| 4 | schema validation | `schema_valid = True` | `schema_valid` | `PASS` | expected columns found |
| 5 | freshness validation | `is_fresh = False` | `not is_fresh` | `REVIEW` | source is late |
| 6 | duplicate threshold | `duplicate_count = 2` | `duplicate_count <= 5` | `REVIEW` | low issue count |
| 7 | null-rate threshold | `null_rate = 1.5` | `null_rate > 1.0` | `REVIEW` | above tolerance |
| 8 | completeness threshold | `completeness_pct = 99.2` | `>= 99.0` | `PASS` | acceptable completeness |
| 9 | status allowlist | `status = "READY"` | `status in ("READY", "RETRY")` | `PASS` | allowed status |
| 10 | status blocklist | `status = "CANCELLED"` | `status in ("FAILED", "CANCELLED")` | `FAIL` | blocked status |
| 11 | amount negative | `amount = -5` | `amount < 0` | `FAIL` | invalid business value |
| 12 | amount zero | `amount = 0` | `amount == 0` | `REVIEW` | may need rule |
| 13 | optional field absent | `review_note = None` | `is None` | `PASS` | optional can be missing |
| 14 | required field blank | `country_code = ""` | `country_code == ""` | `FAIL` | required text blank |
| 15 | multiple checks pass | `has_rows = True`, `schema_valid = True` | `has_rows and schema_valid` | `PASS` | both required |
| 16 | schema pass, freshness fail | `schema_valid = True`, `is_fresh = False` | `schema_valid and is_fresh` | `REVIEW` | one check failed |
| 17 | no errors | `error_count = 0` | `== 0` | `PASS` | clean result |
| 18 | low errors | `error_count = 3` | `<= 5` | `REVIEW` | inspect small issues |
| 19 | severe errors | `error_count = 200` | `> 100` | `FAIL` | severe threshold |
| 20 | unknown status | `status = "PAUSED"` | fallback | `REVIEW` | unexpected value |
| 21 | retry allowed | `status = "RETRY"` | `in ("READY", "RETRY")` | `PASS` | retry is accepted |
| 22 | manual-review state | `status = "HELD"` | `status == "HELD"` | `REVIEW` | manual check needed |
| 23 | type mismatch | `record_count = "100"` | `type` check first | `REVIEW` | numeric text needs conversion |
| 24 | rule precedence | `error_count = 150` | severe before broad | `FAIL` | order matters |
| 25 | overlapping thresholds | `error_count = 4` | `> 0` and `<= 5` | `REVIEW` | both overlap |
| 26 | boundary exactly equal | `error_count = 5` | `<= 5` | `REVIEW` | boundary included |
| 27 | unexpected fallback | `status = "UNKNOWN"` | `else` | `REVIEW` | state not ignored |
| 28 | clear reason | `schema_valid = False` | `not schema_valid` | `FAIL` | reason explains invalid schema |
