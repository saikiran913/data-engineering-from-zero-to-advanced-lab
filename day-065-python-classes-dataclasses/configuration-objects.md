# Configuration Objects

Rules that belong together can be passed as one typed configuration value:

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class ValidationConfig:
    allowed_statuses: tuple[str, ...]
    minimum_amount: float = 0.0

config = ValidationConfig(("READY", "COMPLETED"), minimum_amount=0.0)

def amount_is_valid(amount, config):
    return amount >= config.minimum_amount
```

A tuple suits a fixed list of allowed values. Freezing prevents accidental reassignment such as `config.minimum_amount = -1`. It does not prove that the threshold makes business sense: validate configuration semantics explicitly when needed. Passing `config` makes dependencies visible to a function or component. Do not read a hidden global configuration inside a validator.
