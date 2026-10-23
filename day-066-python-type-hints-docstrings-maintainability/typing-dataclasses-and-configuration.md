# Typing Dataclasses and Configuration

Day 065 introduced dataclass records. Their annotations declare fields and help construct readable objects:

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class ValidationConfig:
    minimum_amount: float
    allowed_statuses: tuple[str, ...]

config = ValidationConfig(0.0, ("READY", "COMPLETED"))
```

The field names and intended types are visible at construction. `frozen=True` prevents reassignment of fields after creation, but the annotation does not check that `minimum_amount` is really numeric or that a status tuple contains approved values. Explicit validation remains necessary. If a dataclass needs an independent list per instance, use `field(default_factory=list)` from Day 065.

Use a plain function for a stateless one-step cleanup; do not introduce a class solely to hold an annotation. Pass the configuration object to the function or component that uses it, keeping the dependency visible.
