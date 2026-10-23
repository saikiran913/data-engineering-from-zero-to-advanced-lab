# Maintainable Pipeline Design

```text
raw record → parse fields → normalize fields → validate record → create result → summarize
```

One function should have one clear responsibility. A parser converts source text; a normalizer produces canonical labels; a validator applies business rules; an orchestrator connects the stages. Pass allowed statuses and thresholds as configuration instead of reading hidden globals.

```python
def normalize_status(raw_status: str) -> str:
    return raw_status.strip().upper()

def validate_status(status: str, allowed_statuses: set[str]) -> bool:
    return status in allowed_statuses
```

Choose a stable result structure, such as `{"validation_status": "REVIEW", "reason": "Unknown status"}` on every branch. Do not print inside a parser if its return will be reused; keep presentation in the entry point. Avoid mutating a raw record while cleaning it, and catch only expected conversion errors. Plain functions are enough when no persistent object state is needed. Logging and operational visibility are Day 067 topics; the current scripts use simple display output for learning.
