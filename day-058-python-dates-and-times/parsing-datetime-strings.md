# Parsing Datetime Strings

```python
from datetime import datetime

raw_timestamp = "2026-09-16 14:30:00"
parsed = datetime.strptime(raw_timestamp, "%Y-%m-%d %H:%M:%S")
```

| Code | Meaning |
| --- | --- |
| `%Y` | Four-digit year |
| `%m` | Month |
| `%d` | Day |
| `%H` | Hour, 00–23 |
| `%M` | Minute |
| `%S` | Second |

The input and format must match. Wrong separators, impossible dates, or swapped fields fail parsing. Strip permitted edge whitespace first. `%z` represents numeric timezone offset conceptually. `fromisoformat()` can parse simple ISO-like text, but use explicit `strptime()` first so the contract remains visible.
