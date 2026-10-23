# Python Maintainability Cheatsheet

| Need | Pattern |
|---|---|
| Scalar input and return | `def label(name: str) -> str:` |
| No useful return | `def show(text: str) -> None:` |
| Optional value | `raw_status: str | None` |
| List | `list[str]` |
| Dictionary | `dict[str, str]` |
| Set | `set[str]` |
| Fixed pair | `tuple[str, str]` |
| Dataclass field | `amount: float` inside `@dataclass` |
| Docstring | `"""Explain the function's purpose and contract."""` |
| Stable result | Return the same status/reason shape on every branch |
| Runtime check | Parse raw text before numeric comparison |
| Entry point | `if __name__ == "__main__": main()` |

```text
name the business rule → annotate input/output → document missing/error behaviour
→ validate actual values → keep one responsibility → verify examples
```

`str | None` requires Python 3.10+. An annotation or `TypedDict` is not a runtime validator. Keep a comment only when it explains a decision that the code and docstring do not already make clear.
