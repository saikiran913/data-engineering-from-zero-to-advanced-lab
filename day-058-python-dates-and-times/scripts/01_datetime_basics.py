"""Day 058: construct and inspect fixed date/time values."""

from datetime import date, time, datetime

run_date = date(2026, 9, 16)
cutoff_time = time(18, 0)
event_time = datetime(2026, 9, 16, 14, 30, 5)

print("Date:", run_date)
print("Time:", cutoff_time)
print("Datetime:", event_time)
print("Components:", event_time.year, event_time.month, event_time.day)
print("Clock components:", event_time.hour, event_time.minute, event_time.second)
print("Date part:", event_time.date())
print("Time part:", event_time.time())
