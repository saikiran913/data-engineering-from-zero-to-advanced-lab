"""Day 058: calculate fixed durations and dates."""

from datetime import datetime, timedelta, timezone

event_time = datetime(2026, 9, 16, 12, 30, tzinfo=timezone.utc)
reference_time = datetime(2026, 9, 16, 14, 0, tzinfo=timezone.utc)
age = reference_time - event_time

print("One day later:", (event_time + timedelta(days=1)).isoformat())
print("One hour later:", (event_time + timedelta(hours=1)).isoformat())
print("Age:", age)
print("Age seconds:", age.total_seconds())
# Thirty days is a duration, not a guaranteed calendar month.
