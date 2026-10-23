# Return Value Design

Return one clear scalar, Boolean, tuple, or dictionary according to a documented contract.

```python
return "FAIL", "Missing order_id"
```

Do not return `True` in one normal branch and a string in another. Use `None` only when it has documented meaning.

A scalar suits parsing, a Boolean suits a simple yes/no predicate, a tuple can suit a small status/reason pair, and a dictionary is clear when labels matter. Choose one pattern for a helper and document caller unpacking or key access. A full record validator in this day consistently returns a dictionary with `status` and `reason`.
