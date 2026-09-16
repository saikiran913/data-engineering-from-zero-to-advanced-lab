# Day 058 Notes

## Why Dates and Times Are Special

Text can look like a timestamp but has no structured time semantics until parsed. Timezone changes what a clock reading means, and boundaries decide which records belong in a window.

| Type | Example meaning |
| --- | --- |
| `date` | Calendar date |
| `time` | Clock time |
| `datetime` | Date and time |
| `timedelta` | Duration |

```text
raw timestamp text
→ parse
→ datetime
→ normalise timezone
→ compare/calculate
→ format for output
```

Event time says when an event happened. Processing time says when a pipeline handled it. Freshness measures data age. A partition date may derive from event time or processing time; document which rule applies.
