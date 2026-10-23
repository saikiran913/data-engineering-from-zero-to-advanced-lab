# Dataclass Defaults and Safety

Simple immutable defaults are straightforward:

```python
from dataclasses import dataclass

@dataclass
class SourceConfig:
    enabled: bool = True
```

Do not put a mutable list or dictionary directly in a dataclass field:

```python
# Do not use: tags: list[str] = []
```

Use a factory so every instance receives its own collection:

```python
from dataclasses import dataclass, field

@dataclass
class SourceConfig:
    tags: list[str] = field(default_factory=list)
```

`first.tags.append("daily")` does not add the tag to `second.tags`. A frozen dataclass (`@dataclass(frozen=True)`) prevents reassignment of its fields after creation. It is useful for simple configuration made from immutable values such as strings, numbers, and tuples. Freezing does not recursively make a nested mutable list immutable, so choose field types deliberately.
