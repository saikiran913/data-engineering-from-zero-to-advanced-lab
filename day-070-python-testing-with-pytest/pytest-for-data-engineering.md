# pytest for Data Engineering

Data Engineering utilities often have small, explicit contracts that make good unit tests.

| Function | Business rule | Valuable test |
|---|---|---|
| `normalize_status` | Standardize case and outer space | Canonical, blank, and `None` |
| `normalize_country_code` | Standardize text, not map countries | `" uk "` → `"UK"` |
| `parse_amount` | Convert finite numeric text | Valid, whitespace, zero, negative, invalid |
| `parse_iso_date` | Strict fixed calendar date | Leap day and impossible day |
| `missing_required_fields` | Identify absent or blank fields | Missing, zero, False, and order |
| `is_non_negative_amount` | Amount boundary at zero | Zero true, negative false |
| `build_clean_record` | New dict, status normalized | Input unchanged |
| `count_statuses` | Count already-normalized labels | Repeated status, empty list |

Day 069's failure policy is testable too: an invalid record can be a returned REVIEW result while a malformed required string may raise `ValueError`. Tests should reflect the documented choice rather than silently changing it. Fixed synthetic inputs make repeatability possible; no live pipeline, current clock, network, database, or credentials are needed.
