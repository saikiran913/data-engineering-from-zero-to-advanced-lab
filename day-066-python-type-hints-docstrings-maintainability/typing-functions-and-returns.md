# Typing Functions and Returns

A return hint should describe every normal branch. Python 3.10+ uses `| None` for a deliberately optional value.

```python
from math import isfinite

def normalize_status(status: str) -> str:
    return status.strip().upper()

def parse_amount(raw_amount: str | None) -> float | None:
    if raw_amount is None or raw_amount.strip() == "":
        return None
    try:
        amount = float(raw_amount)
    except ValueError:
        return None
    return amount if isfinite(amount) else None
```

Here `None` means no usable finite number was parsed. It does not say whether the source was absent, blank, malformed, or non-finite; a richer result is needed when those reasons matter.

| # | Signature | Contract |
|---|---|---|
| 1 | `normalize_status(text: str) -> str` | One string result |
| 2 | `parse_amount(text: str | None) -> float | None` | Number or documented failure marker |
| 3 | `has_id(record_id: str) -> bool` | Presence check |
| 4 | `count_rows(rows: list[dict[str, str]]) -> int` | Row count |
| 5 | `classify(status: str) -> tuple[str, str]` | Status and reason |
| 6 | `show_result(result: str) -> None` | Display side effect only |
| 7 | `is_large(amount: float, minimum: float = 100.0) -> bool` | Default threshold |
| 8 | `format_id(prefix: str, number: int) -> str` | Two required inputs |
| 9 | `select_source(name: str | None) -> str | None` | Optional input and result |

For a tuple result, callers can write `status, reason = classify("READY")`. Keep that same two-item shape on every normal branch. Use a keyword call for a threshold when it clarifies intent: `is_large(120.0, minimum=100.0)`.
