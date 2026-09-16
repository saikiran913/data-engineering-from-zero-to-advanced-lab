# Python Datetime Cheatsheet

```python
from datetime import date, time, datetime, timedelta, timezone
from zoneinfo import ZoneInfo

run_date = date(2026, 9, 16)
parsed = datetime.strptime("2026-09-16 14:30:00", "%Y-%m-%d %H:%M:%S")
label = parsed.strftime("%Y-%m-%d")
utc_time = datetime(2026, 9, 16, 13, 30, tzinfo=timezone.utc)
london_time = utc_time.astimezone(ZoneInfo("Europe/London"))
age = timedelta(hours=2)
```

| Pattern | Meaning |
| --- | --- |
| `strptime()` | Parse text to datetime |
| `strftime()` | Format datetime to text |
| `isoformat()` | ISO-style output |
| `timedelta` | Duration |
| `timezone.utc` | UTC context |
| `astimezone()` | Convert aware instant |

```text
raw timestamp → parse → confirm timezone → compare/calculate → format
```
