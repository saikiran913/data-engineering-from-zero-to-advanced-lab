"""Day 058: controlled UTC parsing, freshness, and window validation."""

from datetime import datetime, timedelta, timezone

raw_timestamp = " 2026-09-16 13:30:00 "
clean_timestamp = raw_timestamp.strip()
event_time = datetime.strptime(clean_timestamp, "%Y-%m-%d %H:%M:%S")
# The source contract explicitly says this parsed wall time is UTC.
event_time = event_time.replace(tzinfo=timezone.utc)
reference_time = datetime(2026, 9, 16, 14, 0, tzinfo=timezone.utc)
window_start = datetime(2026, 9, 16, 0, 0, tzinfo=timezone.utc)
window_end = datetime(2026, 9, 17, 0, 0, tzinfo=timezone.utc)
age = reference_time - event_time

if event_time > reference_time:
    freshness = "REVIEW"
elif age <= timedelta(hours=2):
    freshness = "PASS"
else:
    freshness = "FAIL"

print(f"Raw timestamp: {raw_timestamp!r}")
print(f"Event UTC: {event_time.isoformat()}")
print(f"Age: {age}")
print(f"Freshness: {freshness}")
print(f"In daily window: {window_start <= event_time < window_end}")
