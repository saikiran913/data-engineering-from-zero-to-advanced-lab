# Python Pipeline Functions Cheatsheet

## Contract

```text
name → parameters → behavior → return value → side effects
```

```python
def validate_amount(amount, minimum_amount=0):
    ...

validate_amount(amount=15, minimum_amount=10)
```

| Pattern | Reminder |
|---|---|
| Pure function | Same input gives same output; no hidden globals or mutation |
| Validation return | Always return the same documented structure |
| Default | Use safe immutable values; use `None` instead of `[]`/`{}` |
| Composition | `parse → transform → validate → format` |
| Record handling | Return a new dictionary rather than mutating the raw record |

Checklist: clear inputs, clear output, no hidden globals, limited side effects, one responsibility, consistent return type.
