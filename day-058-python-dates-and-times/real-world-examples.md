# Real-World Examples

| # | Input | Intended type | Timezone contract | Operation | Safe design note |
| --- | --- | --- | --- | --- | --- |
| 1 | `2026-09-16` | date | none | daily run | date-only needs no zone |
| 2 | event text | datetime | UTC | parse | validate format |
| 3 | ingestion time | aware datetime | UTC | arrival tracking | keep event separate |
| 4 | processing time | aware datetime | UTC | pipeline tracking | document meaning |
| 5 | source time | aware datetime | UTC | freshness | fixed reference |
| 6 | two hours | timedelta | UTC | threshold | document rule |
| 7 | old source | aware datetime | UTC | late flag | do not hide |
| 8 | future source | aware datetime | UTC | review | negative age |
| 9 | UTC event | aware datetime | UTC | exchange | retain offset |
| 10 | London display | aware datetime | Europe/London | convert | DST-aware |
| 11 | India display | aware datetime | Asia/Kolkata | convert | use zone name |
| 12 | naive source | naive datetime | documented | clarify | do not assume UTC |
| 13 | aware source | aware datetime | embedded | compare | compatible only |
| 14 | `YYYY-MM-DD` | date | none | parse | match format |
| 15 | date and time | datetime | documented | parse | check separator |
| 16 | event datetime | text | UTC | partition label | state basis |
| 17 | aware datetime | text | UTC | ISO output | offset useful |
| 18 | event window | datetime | UTC | window | explicit bounds |
| 19 | exact start | datetime | UTC | include | `<=` start |
| 20 | exact end | datetime | UTC | exclude | `<` end |
| 21 | event/processed | timedelta | UTC | latency | retain both |
| 22 | missing time | None | contract | review | check first |
| 23 | run date | date | none | partition | no clock needed |
| 24 | cutoff clock | time | local contract | compare | date differs |
| 25 | `01/02/2026` | text | unknown | reject | ambiguous |
| 26 | London summer | aware datetime | London | display | zone handles DST |
| 27 | `+01:00` | aware datetime | fixed offset | caution | not full zone |
| 28 | 30 days | timedelta | none | duration | not calendar month |
| 29 | raw text | string | source stated | retain | traceability |
| 30 | event/processing | two datetimes | UTC | compare | different concepts |
| 31 | event partition | date | event zone | derive | contract rule |
| 32 | processing partition | date | processing zone | derive | may differ |
| 33 | exact boundary | datetime | UTC | window | exclusive end |
| 34 | zone mismatch | mixed | unclear | review | normalise first |
| 35 | date-only field | date | none | use date | zone not needed |
