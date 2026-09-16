# Practice Questions

## A. Concept Checks

1. What is a date? 2. What is a time? 3. What is a datetime? 4. What is a timedelta? 5. Is timestamp text a datetime? 6. What parses text? 7. What formats text? 8. What does `%Y` mean? 9. What does `%m` mean? 10. What does `%M` mean? 11. What is UTC? 12. What is naive? 13. What is aware? 14. Why not mix them? 15. What is a timezone contract? 16. What is freshness? 17. What is event time? 18. What is processing time? 19. What is latency? 20. What is a window? 21. What is inclusive? 22. What is exclusive? 23. Why use exclusive end? 24. Why use fixed examples? 25. Why keep raw text? 26. Why validate before parsing? 27. What can DST change? 28. Why use zone names? 29. What does `astimezone()` do? 30. Why not use a fixed offset always? 31. What does `isoformat()` show? 32. Why document partition basis? 33. Why check future time? 34. Is 30 days one calendar month? 35. What is local reporting time? 36. What is source timezone?

## B. Identify the Type

Identify string, date, time, datetime, or timedelta: 1. `"2026-09-16"`; 2. `date(2026,9,16)`; 3. `time(14,30)`; 4. `datetime(2026,9,16,14,30)`; 5. `timedelta(hours=2)`; 6. raw timestamp; 7. partition date; 8. cutoff clock; 9. event instant; 10. age; 11. formatted ISO output; 12. run date; 13. processing instant; 14. one-day duration; 15. source clock time; 16. parsed value.

## C. Choose Parse or Format

Choose parse or format: 1. text to datetime; 2. datetime to date string; 3. source timestamp text; 4. report label; 5. `strptime`; 6. `strftime`; 7. raw input; 8. ISO output; 9. validate date string; 10. display time; 11. source field conversion; 12. partition label; 13. text comparison preparation; 14. readable message; 15. input contract; 16. output contract.

## D. Match Format Codes

Match `%Y`, `%m`, `%d`, `%H`, `%M`, `%S`: 1–6 their meanings; 7 year in `2026`; 8 month in `09`; 9 day in `16`; 10 hour in `14`; 11 minute in `30`; 12 second in `05`; 13 identify month code; 14 identify minute code; 15 choose `%Y-%m-%d`; 16 choose `%Y-%m-%d %H:%M:%S`.

## E. Predict Comparison

For compatible fixed values: 1. earlier < later; 2. later > earlier; 3. same == same; 4. start <= start; 5. end < end; 6. event < end; 7. event at end in `< end`; 8. event at end in `<= end`; 9. one-hour age <= two hours; 10. three-hour age <= two hours; 11. future > reference; 12. equal dates; 13. just-before start >= start; 14. just-after start >= start; 15. exact start in inclusive start; 16. exact end in exclusive end; 17. UTC converted instant; 18. naive versus aware ordering.

## F. Boundary Reasoning

For `start <= event < end`, classify: 1. just before start; 2. exact start; 3. one second after start; 4. just before end; 5. exact end; 6. after end; 7. next adjacent start; 8. no overlap reason; 9. no gap reason; 10. inclusive end risk; 11. exclusive start risk; 12. timezone requirement; 13. exact midnight; 14. late record.

## G. Naive or Aware?

Classify: 1. `datetime(2026,1,1)`; 2. `datetime(..., tzinfo=timezone.utc)`; 3. parsed text without offset; 4. offset-bearing ISO input parsed appropriately; 5. local clock with no zone; 6. UTC now; 7. London-converted UTC time; 8. date object; 9. time object; 10. source says UTC but text lacks offset; 11. offset-bearing source; 12. unknown source timezone; 13. processing UTC; 14. documented local event.

## H. Freshness Calculations

With fixed UTC reference 14:00: 1. source 13:30; 2. 12:00; 3. 11:59; 4. 14:00; 5. 14:01; 6. threshold two hours; 7. threshold 30 minutes; 8. future source; 9. missing source; 10. age zero; 11. negative age; 12. PASS; 13. REVIEW; 14. subtraction direction.

## I. Timezone Reasoning

Answer: 1. why UTC; 2. why ZoneInfo; 3. London summer offset; 4. London winter offset; 5. fixed offset risk; 6. local presentation; 7. storage contract; 8. source timezone; 9. mixed comparison; 10. DST transition; 11. IANA zone name; 12. aware conversion; 13. ambiguous local clock; 14. date-only field.

## J. Mini Case Study

Given raw event text `" 2026-09-16 13:30:00 "`, source contract UTC, `processed_at` 14:00 UTC, a two-hour threshold, and a daily UTC window: clean, parse, identify naive state, apply UTC meaning, calculate latency, classify freshness, check the window, format ISO output, explain exclusive end, explain DST risk, and distinguish event date from processing date.

## Answer Key

A: date is calendar-only, time clock-only, datetime combines both, and timedelta is duration. `strptime()` parses and `strftime()` formats. `%m` is month and `%M` minute. UTC is a shared reference; naive lacks timezone and aware includes it. Boundaries and contracts must be explicit; DST changes local offsets; 30 days is not a calendar month.

B: raw and formatted values are strings; calendar-only values are dates; clock-only are times; event/processing instants are datetimes; ages are timedeltas. C: parse inputs and `strptime`; format display, labels, ISO output, and `strftime`. D: `%Y` year, `%m` month, `%d` day, `%H` hour, `%M` minute, `%S` second.

E: 1–4 true; 5 false; 6 true; 7 false; 8 true; 9 true; 10 false; 11–12 true; 13 false; 14–15 true; 16 false; 17 true; 18 invalid without conversion. F: only exact start through just-before end are inside; exact end belongs to next window. G: plain constructed or parsed values are naive; UTC, offset, and ZoneInfo values are aware; date/time objects are neither datetime category.

H: age is reference minus source. At two hours passes under `<=`; older is late; future is negative; missing is review. I: UTC supports exchange, ZoneInfo applies regional rules, and a fixed offset is not a full zone rule. J: strip, parse `%Y-%m-%d %H:%M:%S`, attach UTC by contract, calculate 30 minutes, pass freshness, and use exclusive end to avoid duplicate windows.
