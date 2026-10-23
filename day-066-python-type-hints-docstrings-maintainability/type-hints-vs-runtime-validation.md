# Type Hints vs Runtime Validation

These are three separate concerns:

| Concern | Question | Example |
|---|---|---|
| Static type hint | What type is intended? | `amount: float` |
| Runtime type or shape check | What value actually arrived? | Is text present and convertible? |
| Business validation | Is the parsed value allowed? | Amount is nonnegative |

```python
def validate_amount(amount: float) -> bool:
    return amount >= 0
```

The annotation does not turn `"12.50"` into a float. Passing that string directly to `validate_amount` can raise `TypeError` when Python compares it with zero. Parse and check external data first:

```python
from math import isfinite

def parse_amount(raw: str | None) -> float | None:
    if raw is None or not raw.strip():
        return None
    try:
        amount = float(raw)
    except ValueError:
        return None
    return amount if isfinite(amount) else None

amount = parse_amount("12.50")
is_valid = amount is not None and validate_amount(amount)
```

For dictionary records, check required keys before indexing: `if "status" not in record: ...`. Normalize a status and check it against allowed codes separately. A `TypedDict` or dataclass annotation documents a shape but does not reject missing fields or unsupported values at runtime. An editor or static type checker can flag likely mismatches, but this lesson needs no such tool to demonstrate explicit checks.
