# Function Contracts

For each reusable function state its name, purpose, parameters, missing-value rule, output, expected exceptions, and side effects.

```text
Input: str or None
Output: canonical str or None
Side effects: none
```

Clear contracts make a pipeline function predictable and reusable.

For example, `normalize_status(raw_status)` has one purpose: produce a canonical status. Its parameter conceptually accepts `str` or `None`; missing input returns `None`; output is canonical `str` or `None`; expected failures are handled as normal input; side effects are none. Apply the same eight questions to every helper: name, purpose, parameters, conceptual types, missing-value behaviour, output, exceptions, and side effects.
