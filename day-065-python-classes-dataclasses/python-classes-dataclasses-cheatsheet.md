# Python Classes and Dataclasses Cheatsheet

| Need | Pattern | Meaning |
|---|---|---|
| Class | `class Source:` | Blueprint for objects |
| Initializer | `def __init__(self, name): self.name = name` | Store instance state |
| Instance | `source = Source("orders")` | One object |
| Method | `def is_enabled(self): return self.enabled` | Behaviour using instance state |
| Dataclass | `@dataclass` above a record class | Generated initializer and representation |
| Safe mutable field | `field(default_factory=list)` | Independent list per instance |
| Frozen config | `@dataclass(frozen=True)` | Prevent field reassignment |

```python
from dataclasses import dataclass, field

@dataclass
class Record:
    record_id: str
    status: str
    tags: list[str] = field(default_factory=list)
```

```text
record only → dict/dataclass
logic only → function
state + behaviour → class
```

Annotations describe intended types; validate inputs and business rules explicitly. Keep component methods focused.
