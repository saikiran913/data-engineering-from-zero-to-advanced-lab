# Refactoring Walkthrough

Suppose a small script repeatedly trims statuses, compares amounts to a literal zero, prints inside the decision logic, and returns different shapes on different branches. It can appear compact while hiding its contract.

## Before

```python
def check(x):
    if not x.get("id") or x.get("amount") is None:
        print("bad")
        return "FAIL"
    if x["amount"] < 0:
        print("bad")
        return "FAIL"
    if x["status"].strip().upper() != "READY":
        return ("REVIEW", "Unknown status")
    return ("PASS", "Valid")
```

The two FAIL branches duplicate logic and return a string where other branches return a tuple. A caller cannot safely unpack every result.

## After

```python
MINIMUM_AMOUNT = 0.0

def normalize_status(raw_status: str) -> str:
    """Return an uppercase status with edge whitespace removed."""
    return raw_status.strip().upper()

def classify_record(record: dict[str, object], minimum_amount: float) -> tuple[str, str]:
    """Classify a pre-parsed record; return status and reason."""
    record_id = record.get("id")
    amount = record.get("amount")
    raw_status = record.get("status")
    if not isinstance(record_id, str) or not record_id.strip():
        return "FAIL", "Missing ID"
    if not isinstance(amount, (int, float)) or amount < minimum_amount:
        return "FAIL", "Invalid amount"
    if not isinstance(raw_status, str):
        return "FAIL", "Missing status"
    if normalize_status(raw_status) != "READY":
        return "REVIEW", "Unknown status"
    return "PASS", "Valid"

def main() -> None:
    rows = [
        {"id": "A-1", "amount": 10.0, "status": " ready "},
        {"id": "B-2", "amount": 5.0, "status": " unknown "},
        {"id": "", "amount": 3.0, "status": "READY"},
    ]
    for row in rows:
        print(row.get("id"), classify_record(row, MINIMUM_AMOUNT))

if __name__ == "__main__":
    main()
```

The improved version names the threshold, separates normalization from classification, returns one tuple shape, and leaves printing in `main()`. It also checks missing and wrong-shaped input before comparison. Compare outcomes for valid, unknown-status, and missing-ID examples: PASS, REVIEW, FAIL in that order. The intended classifications remain the same; reason text is now explicit.
