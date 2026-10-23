# Comments, Naming, and Style

Names should reveal business meaning. A docstring describes a function's contract; an inline comment explains a decision that the code alone would not show.

Before:

```python
def f(x):
    # Multiply x by 100.
    return x * 100
```

After, when the unit conversion is intentional:

```python
PENCE_PER_POUND = 100

def pounds_to_pence(amount_pounds: float) -> int:
    """Convert a nonnegative whole-pence pound amount to pence."""
    # Round to avoid keeping a fractional penny from floating-point input.
    return round(amount_pounds * PENCE_PER_POUND)
```

Use names such as `raw_status`, `normalized_status`, `minimum_amount`, and `validation_result`. Keep conditionals clear and indentation at four spaces. A named constant makes a business threshold visible and searchable. PEP 8 and PEP 257 offer useful Python style and docstring conventions; the lesson needs no extra tooling to follow their basic spirit. Avoid comments that merely repeat the next line, and update comments when rules change.
