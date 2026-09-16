# UTC and Timezones

```python
from datetime import datetime, timezone
from zoneinfo import ZoneInfo

utc_time = datetime(2026, 9, 16, 13, 30, tzinfo=timezone.utc)
london_time = utc_time.astimezone(ZoneInfo("Europe/London"))
```

UTC is a common exchange and storage reference. Use IANA zone names such as `Europe/London`, `Asia/Kolkata`, and `America/New_York` for local business rules. Fixed offsets are not permanent zone rules because daylight-saving time changes offsets by date. `ZoneInfo` relies on timezone data available in the runtime; do not install packages automatically for this lesson.
