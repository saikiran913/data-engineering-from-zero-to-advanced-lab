# Type Hints Basics

An annotation after a parameter name describes the expected input. `->` describes the intended return. Read `def normalize(value: str) -> str:` as “accept a string and return a string.” Python does not reject a wrong runtime value just because the annotation says `str`.

| # | Example | Read it as |
|---|---|---|
| 1 | `source_name: str = "orders"` | Text value |
| 2 | `row_count: int = 3` | Whole number |
| 3 | `amount: float = 12.5` | Numeric amount |
| 4 | `is_valid: bool = True` | True/false flag |
| 5 | `def label(name: str) -> str:` | String in and out |
| 6 | `def add(a: int, b: int) -> int:` | Two integers to one integer |
| 7 | `def positive(value: float) -> bool:` | Numeric check returns Boolean |
| 8 | `def show(message: str) -> None:` | Displays a message, returns no useful value |
| 9 | `def missing() -> None:` | Returns `None` |

`None` is a runtime value. `-> None` documents a function that returns no useful result; it does not mean “any type.” A checker or editor can use annotations to flag likely mistakes before execution, but runtime validation still needs code.

```python
def normalize_status(status: str) -> str:
    return status.strip().upper()

print(normalize_status(" ready "))
```
