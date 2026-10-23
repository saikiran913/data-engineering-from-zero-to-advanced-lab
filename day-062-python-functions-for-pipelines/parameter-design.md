# Parameter Design

Use required parameters for essential input and keyword arguments for clarity.

```python
def classify_amount(amount, minimum_amount=0):
    return amount >= minimum_amount
```

Avoid hidden constants when a caller should control a rule. Avoid too many unrelated parameters. Never use mutable defaults such as `errors=[]`; use `None` and create a list inside if needed.

Required parameters represent essential input. Multiple parameters are appropriate when each is needed for the single responsibility. Keyword calls improve readability for thresholds and configuration. A growing signature can be a smell: pass a small configuration object or split responsibilities instead of adding unrelated arguments.
