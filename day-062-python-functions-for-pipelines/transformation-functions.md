# Transformation Functions

Transformation functions turn raw values into consistent clean values. They should preserve the raw record and return new values or a new dictionary.

```python
def normalize_status(raw_status):
    return raw_status.strip().upper() if isinstance(raw_status, str) else None

def normalize_country_code(raw_country):
    mapping = {"uk": "GB", "usa": "US", "india": "IN"}
    return mapping.get(raw_country.strip().lower()) if isinstance(raw_country, str) else None

def parse_amount(raw_amount):
    try:
        return float(raw_amount)
    except (TypeError, ValueError):
        return None
```

`parse_event_date` can return an ISO `date` or `None`. `build_clean_record(record)` should use `{**record, ...}` instead of silently changing `record`. Parsing converts a representation; validation decides whether a converted value is acceptable.
