# Day 058 — Python Dates and Times

Datetime objects, parsing, formatting, timezone awareness, comparisons, and freshness checks make time-based data safer to process.

## Connect to Day 057

Day 057 taught string cleaning and parsing. Many timestamps arrive as strings. Day 058 teaches how to convert those strings into structured date/time objects and use them safely.

## Learning Objectives

Learn `date`, `time`, `datetime`, `timedelta`, date/time components, `strptime()`, `strftime()`, ISO-style output, arithmetic, comparisons, explicit boundaries, naive and aware datetimes, UTC, `timezone.utc`, `ZoneInfo`, local conversion, daylight-saving awareness, freshness, event time, processing time, and timestamp contracts.

## Why Dates and Times Matter

Data Engineers check source freshness, process event and ingestion timestamps, assign partition dates, validate date windows, investigate late-arriving records, compare event and processing time, and convert UTC values for local reporting.

## Important Warnings

> A timestamp string is not the same as a `datetime` object. Parse text into a known format before performing date/time arithmetic or comparisons.

> Naive datetimes do not contain timezone information. Do not mix naive and timezone-aware datetimes in the same comparison or calculation without an explicit conversion rule.

> Local clock time can be affected by daylight-saving transitions. Prefer UTC for storage and cross-system exchange when the business requirements allow it, and convert to local time for presentation or local-business logic.

> Date/time boundaries must be explicit. Decide whether a start/end boundary is inclusive or exclusive, and document the timezone used by the rule.

## Recommended Learning Order

1. `notes.md`
2. `date-time-datetime-basics.md`
3. `parsing-datetime-strings.md`
4. `formatting-datetimes.md`
5. `timedelta-and-date-arithmetic.md`
6. `comparing-dates-and-times.md`
7. `naive-and-aware-datetimes.md`
8. `utc-and-timezones.md`
9. `freshness-and-date-window-checks.md`
10. `data-engineering-time-contracts.md`
11. inspect `scripts/`
12. complete `practice-lab.md`
13. use `troubleshooting-guide.md`
14. review `python-datetime-cheatsheet.md`
15. complete `practice-questions.md`
16. read `beginner-summary.md`
17. read `glossary.md`

## Safe-Learning Note

All examples use the Python standard library. They make no file, network, or database writes. Fixed timestamps are used where deterministic output matters.

## Navigation

- Previous Day: [Day 057 - Python Strings for Data Engineers](../day-057-python-strings-for-data-engineers/)
- Next Day: [Day 059 - Python Filesystem Basics](../day-059-python-filesystem-basics/)
- [Back to Main Learning Path](../README.md)
