# Data Engineering Time Contracts

Document every timestamp field before using it in a pipeline.

| Field | Meaning | Timezone | Example |
| --- | --- | --- | --- |
| `event_time` | Source event occurrence | UTC | `2026-09-16T13:30:00+00:00` |
| `processed_at` | Pipeline processing time | UTC | `2026-09-16T13:45:00+00:00` |

For each field define: field name, meaning, source timezone, stored timezone, expected format, whether missing is allowed, precision, comparison/window rule, and late or future timestamp behaviour.

UTC is often useful for storage and exchange, but it is not the only valid business choice. A partition date can be derived from event time or processing time; state which. Avoid ambiguous local timestamps without an offset or documented zone.
