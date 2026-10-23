# Dataclass Basics

The standard-library `dataclasses` module removes routine record boilerplate:

```python
from dataclasses import dataclass

@dataclass
class OrderRecord:
    order_id: str
    status: str
    amount: float

record = OrderRecord(
    order_id="ORD-1001",
    status="READY",
    amount=100.0,
)
print(record)
```

`@dataclass` generates an initializer and a readable representation. Two records with equal field values compare equal by default. The annotations document intended types; Python does **not** check them automatically at runtime. For example, passing `amount="bad"` can still construct the dataclass. Business validation needs explicit code, such as a validator function or a deliberate `__post_init__` check when construction must be rejected.

Use a dataclass when records have a stable, named set of fields. A dictionary remains useful for changing or sparse metadata. `dataclasses.asdict(record)` can convert a dataclass to a new dictionary when a dictionary is needed downstream.
