"""Day 058: parse valid controlled text and format it again."""

from datetime import datetime

raw_timestamp = "2026-09-16 14:30:00"
parsed_time = datetime.strptime(raw_timestamp, "%Y-%m-%d %H:%M:%S")

# Invalid dates and mismatched patterns raise ValueError, so use known valid text here.
print("Parsed:", parsed_time)
print("Date label:", parsed_time.strftime("%Y-%m-%d"))
print("Readable label:", parsed_time.strftime("%Y-%m-%d %H:%M:%S"))
print("ISO output:", parsed_time.isoformat())
