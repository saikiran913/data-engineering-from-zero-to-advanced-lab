# Typing Collections and Records

These annotations describe common collection shapes:

```python
source_names: list[str] = ["orders", "customers"]
allowed_statuses: set[str] = {"READY", "COMPLETED"}
status_mapping: dict[str, str] = {"done": "COMPLETED"}
status_and_reason: tuple[str, str] = ("PASS", "Valid")
```

`list[str]` means a list of strings. A dictionary annotation names key and value types. `tuple[str, str]` describes exactly two string positions. These hints communicate intended shape; they do not inspect values when Python runs.

```python
def collect_ids(records: list[dict[str, str]]) -> list[str]:
    return [record["record_id"] for record in records]
```

Use a small `TypedDict` when a known dictionary shape needs named fields:

```python
from typing import TypedDict

class RawOrder(TypedDict):
    record_id: str
    raw_amount: str

def label_order(record: RawOrder) -> str:
    return record["record_id"]
```

`TypedDict` is a static shape hint. It is neither a runtime schema validator nor a dataclass object from Day 065: the actual value is still a dictionary. A missing key can still raise `KeyError`. Avoid annotating everything as `Any`; use `Any` only when the value shape genuinely cannot yet be described and document why. Keep nested hints shallow enough to read.
