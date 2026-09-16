# Timedelta and Date Arithmetic

`timedelta` represents a duration, not a timestamp.

```python
from datetime import timedelta

tomorrow = run_date + timedelta(days=1)
age = reference_time - event_time
is_fresh = age <= timedelta(hours=2)
```

Subtracting compatible datetimes produces a timedelta. Use `total_seconds()` when a complete seconds count is useful. A negative age can identify a future timestamp. `timedelta(days=30)` is a duration, not universally one calendar month.
