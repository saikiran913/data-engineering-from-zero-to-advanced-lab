# Beginner Summary

Date and time strings are not datetime objects. Parse text with `datetime.strptime()` before arithmetic or comparisons, then format a datetime as text with `strftime()`. The format must exactly match the source contract.

`date` is calendar-only, `time` is clock-only, `datetime` combines them, and `timedelta` is duration. Subtract compatible datetimes to calculate age or latency. A 30-day timedelta is not always one calendar month.

Use explicit boundaries such as `start <= event_time < end`. This includes the start, excludes the end, and prevents adjacent pipeline windows from overlapping. Test values around every boundary.

Naive datetimes lack timezone context; aware datetimes include it. Do not mix them in a comparison. UTC is useful for cross-system exchange. Convert aware UTC values to local time with real zone rules through `ZoneInfo`, because daylight-saving time can change local offsets.

```text
Raw timestamp
→ parse
→ attach/confirm timezone meaning
→ normalize/convert
→ compare or calculate
→ format for output
```

> A timestamp string is not the same as a `datetime` object. Parse text into a known format before performing date/time arithmetic or comparisons.

> Naive datetimes do not contain timezone information. Do not mix naive and timezone-aware datetimes in the same comparison or calculation without an explicit conversion rule.

> Local clock time can be affected by daylight-saving transitions. Prefer UTC for storage and cross-system exchange when the business requirements allow it, and convert to local time for presentation or local-business logic.

> Date/time boundaries must be explicit. Decide whether a start/end boundary is inclusive or exclusive, and document the timezone used by the rule.

Day 059 will apply string and datetime skills to safely reading local files.
