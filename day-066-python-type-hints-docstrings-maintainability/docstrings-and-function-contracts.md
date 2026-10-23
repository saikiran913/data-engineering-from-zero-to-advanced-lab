# Docstrings and Function Contracts

A docstring is a triple-quoted string immediately inside a module, class, or function. A short one-line docstring can be enough:

```python
def normalize_status(raw_status: str) -> str:
    """Remove edge whitespace and return an uppercase status."""
    return raw_status.strip().upper()
```

For a parser with missing-value behaviour, document the full contract:

```python
from math import isfinite

def parse_amount(raw_amount: str | None) -> float | None:
    """Parse a finite amount; return None for missing or invalid text.

    Args:
        raw_amount: Source text or a missing value.

    Returns:
        Finite number, or None when no usable number is available.

    Side effects: None. Conversion errors and non-finite values become None.
    """
    if raw_amount is None or raw_amount.strip() == "":
        return None
    try:
        amount = float(raw_amount)
    except ValueError:
        return None
    return amount if isfinite(amount) else None
```

For a validator, describe what a status means and which failures become exceptions versus normal results. For a display function, mention printing as a side effect. `help(parse_amount)` and `parse_amount.__doc__` expose the docstring. A docstring is useful only if it matches the implementation. Inline comments explain a non-obvious decision inside a function; an external Markdown guide explains the broader lesson. A trivial private helper does not need a long form.
