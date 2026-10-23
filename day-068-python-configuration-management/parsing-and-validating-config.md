# Parsing and Validating Configuration

Parsing converts a raw value to a Python type. Validation checks the contract: required values, allowed choices, and bounds. Do both before passing settings into processing functions.

```python
def parse_positive_int(raw_value: object, setting_name: str) -> int:
    if type(raw_value) not in (int, str):
        raise ValueError(f"{setting_name} must be a positive integer")
    try:
        value = int(raw_value)
    except (TypeError, ValueError) as exc:
        raise ValueError(f"{setting_name} must be a positive integer") from exc
    if value <= 0:
        raise ValueError(f"{setting_name} must be a positive integer")
    return value

def parse_bool(raw_value: object, setting_name: str) -> bool:
    if isinstance(raw_value, bool):
        return raw_value
    if isinstance(raw_value, str):
        normalized = raw_value.strip().lower()
        if normalized in ("true", "1", "yes"):
            return True
        if normalized in ("false", "0", "no"):
            return False
    raise ValueError(f"{setting_name} must be a Boolean setting")
```

Python's `bool` is a subclass of `int`, so reject it before accepting a numeric setting. The type check also prevents truncating a JSON float such as `2.5` to `2`. JSON `true` already becomes Python `True`, while environment and INI values are text. A mode can be checked against `{"development", "validation", "production"}`. A required name should reject `None`, `""`, and `"   "` after trimming. Missing, wrong type, wrong choice, and out-of-range are distinct failures. Error messages should name the setting and rule, not echo a potentially sensitive value. Catch expected `TypeError`/`ValueError` locally; avoid a blanket `except Exception` that masks programming errors.
