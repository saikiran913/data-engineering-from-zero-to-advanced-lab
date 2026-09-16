"""Day 058: convert one aware UTC instant using standard-library zones."""

from datetime import datetime, timezone
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError

utc_time = datetime(2026, 9, 16, 13, 30, tzinfo=timezone.utc)

print("UTC:", utc_time.isoformat())
try:
    london_time = utc_time.astimezone(ZoneInfo("Europe/London"))
    india_time = utc_time.astimezone(ZoneInfo("Asia/Kolkata"))
    print("London:", london_time.isoformat())
    print("India:", india_time.isoformat())
except ZoneInfoNotFoundError:
    print("ZoneInfo data is unavailable in this Python environment.")
    print("UTC remains valid; use a runtime with IANA timezone data for local conversion.")
