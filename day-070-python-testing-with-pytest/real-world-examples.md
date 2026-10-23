# Real-World Testing Examples

Every example is synthetic and uses a fixed input. The “check” column is an assertion or an expected exception in a pytest test.

| # | Function / contract | Input | Expected result | Check and why |
|---|---|---|---|---|
| 1 | Normalize status | `" ready "` | `"READY"` | Equality; clean labels |
| 2 | Preserve canonical status | `"COMPLETED"` | Same | Equality; no unwanted change |
| 3 | Optional status | `None` | `None` | `is None`; missing allowed |
| 4 | Blank status | `"   "` | `""` | Equality; boundary |
| 5 | Internal spaces | `" needs review "` | `"NEEDS REVIEW"` | Equality; only outer trim |
| 6 | Country code | `" uk "` | `"UK"` | Equality; case standardisation |
| 7 | Numeric parse | `"12.5"` | `12.5` | Equality; ordinary amount |
| 8 | Numeric whitespace | `" 8.25 "` | `8.25` | Equality; input hygiene |
| 9 | Zero parse | `"0"` | `0.0` | Equality; boundary |
| 10 | Negative parse | `"-4"` | `-4.0` | Equality; parsing separate from validation |
| 11 | Invalid numeric | `"invalid"` | `ValueError` | `pytest.raises`; explicit failure |
| 12 | Missing numeric text | `None` | `ValueError` | `pytest.raises`; no fake zero |
| 13 | Date parse | `"2024-01-31"` | Fixed `date` | Equality; no current clock |
| 14 | Leap day | `"2024-02-29"` | Valid date | Equality; calendar edge |
| 15 | Impossible day | `"2023-02-29"` | `ValueError` | `pytest.raises`; invalid date |
| 16 | Strict date shape | `"20240131"` | `ValueError` | `pytest.raises`; contract format |
| 17 | Amount boundary | `0.0` | True | `is True`; threshold inclusive |
| 18 | Negative boundary | `-0.01` | False | `is False`; threshold exclusive |
| 19 | Missing required key | `{}` | Key name list | List equality; completeness |
| 20 | False and zero present | `False`, `0` | No missing fields | Empty-list equality |
| 21 | Source non-mutation | Raw status dict | Unchanged raw dict | Equality after call |
| 22 | New cleaned record | Raw status dict | New dict with uppercase status | Value and identity checks |
| 23 | Empty aggregation | `[]` | `{}` | Equality; empty input |
| 24 | Status counts | READY twice, COMPLETED once | `{READY:2, COMPLETED:1}` | Dict equality; reporting |
| 25 | Repeated-call independence | Different lists | Separate counts | Two asserts; no state leak |
| 26 | Floating calculation | `0.1 + 0.2` | Approximately `0.3` | `pytest.approx`; precision |
| 27 | Wrong status type | `7` | `TypeError` | `pytest.raises`; contract |
| 28 | Discovery regression | Correct test name | Collected node | `--collect-only`; skipped tests risk |

These tests express data contracts. They do not inspect private implementation steps or rely on a live pipeline.
