# Date, Time, and Datetime Basics

```python
from datetime import date, time, datetime, timezone

run_date = date(2026, 9, 16)
cutoff_time = time(18, 0)
event_time = datetime(2026, 9, 16, 14, 30)
```

`date` stores a calendar date. `time` stores a clock reading. `datetime` stores both. Read `.year`, `.month`, `.day`, `.hour`, `.minute`, and `.second`. Use `.date()` and `.time()` to extract a datetime part.

`date.today()` and `datetime.now()` use a dynamic environment clock. When UTC matters, use `datetime.now(timezone.utc)`.

Practice: create a date, time, and datetime; inspect six components; extract date/time; describe dynamic now; and explain why UTC context matters.
