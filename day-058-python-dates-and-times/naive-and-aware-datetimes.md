# Naive and Aware Datetimes

```python
from datetime import datetime, timezone

naive_time = datetime(2026, 9, 16, 14, 30)
aware_time = datetime(2026, 9, 16, 14, 30, tzinfo=timezone.utc)
```

Naive datetimes contain no timezone. Aware datetimes carry timezone context. The same clock reading may mean different instants in different places.

Ask: what timezone does the source mean, is it embedded, should the pipeline normalise to UTC, and when should local conversion occur? Assigning `tzinfo` declares a known meaning; `astimezone()` converts an already-aware instant. Do not attach a timezone blindly to an unknown source.
