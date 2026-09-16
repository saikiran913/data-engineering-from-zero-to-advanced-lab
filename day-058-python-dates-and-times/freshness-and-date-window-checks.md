# Freshness and Date-Window Checks

Use fixed aware UTC values for reproducible checks.

```python
from datetime import datetime, timedelta, timezone

source_time = datetime(2026, 9, 16, 12, 30, tzinfo=timezone.utc)
reference_time = datetime(2026, 9, 16, 14, 0, tzinfo=timezone.utc)
age = reference_time - source_time
is_fresh = age <= timedelta(hours=2)
```

Check future timestamps before freshness: `source_time > reference_time`. A common window is `window_start <= event_time < window_end`. Daily midnight-to-midnight windows need a defined timezone.

Event time is when an event happened; processing time is when the pipeline handled it. Their difference is latency. Check `None` before comparing any timestamp. PASS, REVIEW, and FAIL thresholds are example business rules and must be documented.
