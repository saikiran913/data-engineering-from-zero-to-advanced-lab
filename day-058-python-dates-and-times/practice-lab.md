# Parse, Compare, and Validate Data Engineering Timestamps

1. Verify Python with `python --version`.
2. Run `python scripts/01_datetime_basics.py`.
3. Run `python scripts/02_parse_and_format.py`.
4. Run `python scripts/03_timedelta_arithmetic.py`.
5. Run `python scripts/04_datetime_comparisons.py`.
6. Run `python scripts/05_timezone_awareness.py`.
7. Run `python scripts/06_data_engineering_freshness_workflow.py`.
8. Parse `"2026-09-16 14:30:00"` with `strptime()` in the REPL.
9. Inspect components and format as a date.
10. Add one hour with `timedelta`.
11. Compare two compatible timestamps.
12. Create a UTC-aware value and convert it with `ZoneInfo`.
13. Build a freshness check with a fixed reference timestamp.
14. Test just before start, exact start, just before end, and exact end.

## Lab Checklist

- I understand date, time, datetime, and timedelta.
- I can parse and format timestamp text.
- I can calculate durations and compare compatible values.
- I understand naive versus aware values.
- I understand UTC/local conversion, freshness, and window checks.
