# Troubleshooting Guide

| Problem | Check |
| --- | --- |
| `ValueError` from `strptime()` | Input, format, date, and separator must match |
| `%m` versus `%M` | `%m` is month; `%M` is minute |
| Parsed value has no timezone | `strptime()` without zone produces naive datetime |
| Naive/aware comparison fails | Use one explicit compatible contract |
| Conversion clock differs | Same instant can have different local time |
| London offset changes | DST is expected |
| ZoneInfo key missing | Check zone name and runtime timezone data; do not install packages automatically |
| Freshness seems wrong | Check zone, subtraction direction, threshold, future input |
| Window duplicates records | Check exclusive upper boundary |
| Current time changes output | Use fixed values for learning/tests |
| `strftime()` looks wrong | Recheck format codes |
| `isoformat()` has offset | Expected for aware datetime |

```text
1. print repr(raw_timestamp)
2. print parsed value
3. print type(value)
4. print value.tzinfo
5. verify source timezone contract
6. normalize/convert if needed
7. inspect timedelta sign
8. test exact boundaries
```
