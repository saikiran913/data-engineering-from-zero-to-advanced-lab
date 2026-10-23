# Practice Questions

Work through the questions before reading the answer key. All examples use Python 3.10+ and synthetic in-memory data.

## Section 1: Concepts (12)

1. What information does `status: str` convey?
2. What does `-> bool` convey in a function signature?
3. Does Python automatically reject `"bad"` passed to a `float`-annotated parameter?
4. What is the job of a docstring that a type hint cannot do?
5. What does `-> None` say about a function's result?
6. What is the difference between `float | None` and `float`?
7. What does a runtime parser check that an annotation does not?
8. Why might a type checker flag a call even though Python executes it?
9. What is a side effect? Name one.
10. What is a predictable return contract?
11. Why should business thresholds have clear names?
12. When is a plain function preferable to a configured class?

## Section 2: Read or Repair Annotations (10)

1. Read `def clean(value: str) -> str:` in plain words.
2. A parser returns a float or `None`. Repair `def parse(raw: str) -> float:`.
3. A function prints and returns nothing useful. Give its return hint.
4. A function returns `("PASS", "Valid")`. Give its return hint.
5. A validator returns `True` or `False`. Give its return hint.
6. Repair `def count(ids: list[str]) -> str:` when it returns `len(ids)`.
7. A normalizer accepts a missing status and returns `None` for it. Give input and return hints.
8. Repair `def sources() -> tuple[str, str]: return ["orders", "events"]` without changing the value.
9. What does `minimum: float = 0.0` communicate?
10. Why is annotating an unknown raw value as `Any` on every function unhelpful?

## Section 3: Choose Collection and Optional Hints (8)

1. Hint for a list of source-name strings.
2. Hint for a set of allowed status strings.
3. Hint for a mapping from alias string to canonical string.
4. Hint for an exact status/reason pair of strings.
5. Hint for an amount text that may be missing.
6. Hint for a parsed amount that may fail.
7. Hint for a list of records where each record maps text keys to text values.
8. When would a small `TypedDict` help, and what does it not do?

## Section 4: Write or Improve Docstrings (8)

1. Write a one-line docstring for trimming and uppercasing a status.
2. Document what `None` means when `parse_amount` fails.
3. Explain in a docstring what a `validate_status` Boolean represents.
4. Document a formatter that prints a result and returns `None`.
5. Add a failure note for a parser that raises `ValueError` rather than returning `None`.
6. Explain why `"""Return x."""` is inadequate for a business validator.
7. State the input assumption for a function that requires already parsed numeric amount.
8. A docstring says "returns PASS" but code may return REVIEW. What should change?

## Section 5: Runtime Check or Business Rule? (8)

1. Is `"12.50"` convertible to a float a runtime conversion check or business rule?
2. Is amount at least zero a type check or business rule?
3. Is a required `record_id` key present a runtime shape check or business rule?
4. Is an unknown status code permitted a business rule or type hint?
5. Can `TypedDict` reject a missing key when Python runs?
6. Does `amount: float` convert `"12.50"` automatically?
7. How should blank amount text be handled before numeric comparison?
8. Why check `status is None` before calling `.strip()`?

## Section 6: Maintainability Decisions (8)

1. A parser reads a hidden global threshold. What change makes the dependency visible?
2. The same status rule appears in three places. What should be refactored?
3. A validation function prints and returns a different type on each branch. What two changes help?
4. A cleanup function modifies the raw dictionary. What should it return instead?
5. A single function parses, validates, prints, and writes output. How should it be divided?
6. The code uses the literal `100` in several business comparisons. What should be named?
7. A `try` block catches `Exception` and returns PASS. What is the risk and remedy?
8. A one-line stateless status cleanup is wrapped in a class. Which simpler form fits?

## Integrated Mini-Case

Raw order dictionaries contain `record_id`, `raw_amount`, and `raw_status`, each of which may be blank or missing. Design a typed amount parser, status normalizer, and validator. Return a consistent status/reason result. Explain which checks are runtime shape/conversion checks, which are business rules, what `None` means, and how to document the contract. Show how an orchestrator processes a valid row, an unknown status, and an invalid amount without changing the raw dictionaries.

## Answer Key

### Section 1

1. The intended value is a string.
2. The function intends to return a Boolean.
3. No; annotations are not runtime enforcement.
4. It explains purpose, meaning, missing-value policy, failures, or side effects.
5. It returns no useful value; normal completion returns `None`.
6. The first permits a documented `None` result; the second does not.
7. The actual value's presence, shape, and convertibility.
8. A checker uses hints to detect a likely mismatch, while Python does not enforce them automatically.
9. An observable action besides a return, such as printing.
10. The same documented result shape on every normal branch.
11. Their meaning and update point become clear; duplicate literals can drift.
12. When behaviour is stateless and depends only on explicit parameters.

### Section 2

1. Accept a string and return a string.
2. `def parse(raw: str) -> float | None:` if missing/invalid text can produce `None`; use `str | None` input if raw input may be absent.
3. `-> None`.
4. `-> tuple[str, str]`.
5. `-> bool`.
6. `def count(ids: list[str]) -> int:`.
7. `def normalize(status: str | None) -> str | None:`.
8. Change return hint to `-> list[str]`.
9. It is a float parameter with default value `0.0`.
10. It hides useful constraints and weakens static feedback.

### Section 3

1. `list[str]`.
2. `set[str]`.
3. `dict[str, str]`.
4. `tuple[str, str]`.
5. `str | None`.
6. `float | None`.
7. `list[dict[str, str]]`.
8. It documents stable named dictionary keys for static tools; it does not validate an actual dictionary at runtime.

### Section 4

1. `"""Return a trimmed, uppercase status."""`
2. `"""Return a parsed float, or None for missing or invalid text."""`
3. `"""Return True when the normalized status is allowed."""`
4. `"""Print the formatted result; return no useful value."""`
5. `"""Raise ValueError when source text cannot be parsed as an amount."""` as part of an accurate parser contract.
6. It does not identify the business rule, what `x` means, or what failure looks like.
7. State that `amount` must already be a numeric value, not raw text.
8. Update the docstring to describe all actual outcomes, or change the code if its behaviour is wrong.

### Section 5

1. Runtime conversion check.
2. Business rule after parsing.
3. Runtime shape check; a rule may additionally require nonblank ID text.
4. Business rule.
5. No.
6. No.
7. Treat it as missing/invalid according to the documented parser contract, then return a controlled result.
8. `None` has no `.strip()` method; the check avoids an error.

### Section 6

1. Pass the threshold as a named parameter or configuration value.
2. Put the rule in one focused helper and call it from each site.
3. Return a consistent status/reason shape and move printing to the entry point.
4. Return a new cleaned dictionary, preserving the original.
5. Separate parser, validator, presentation, and I/O boundaries with a small orchestrator.
6. A constant or parameter such as `MINIMUM_AMOUNT` with a clear unit and meaning.
7. It hides programming errors and may approve bad data; catch expected failures such as `ValueError` and return a deliberate failure result.
8. A plain function.

### Integrated Mini-Case

```python
from math import isfinite

def parse_amount(raw: str | None) -> float | None:
    """Return a finite float, or None for missing or invalid amount text."""
    if raw is None or not raw.strip():
        return None
    try:
        amount = float(raw)
    except ValueError:
        return None
    return amount if isfinite(amount) else None

def normalize_status(raw: str | None) -> str | None:
    """Return uppercase status, or None for missing or blank text."""
    if raw is None or not raw.strip():
        return None
    return raw.strip().upper()

def validate(
    record_id: str | None,
    amount: float | None,
    status: str | None,
    allowed: set[str],
) -> tuple[str, str]:
    """Return one classification and reason for parsed order values."""
    if record_id is None or not record_id.strip():
        return "FAIL", "Missing ID"
    if amount is None or amount < 0:
        return "FAIL", "Invalid amount"
    if status is None:
        return "FAIL", "Missing status"
    if status not in allowed:
        return "REVIEW", "Unknown status"
    return "PASS", "Valid"

raw_orders: list[dict[str, str | None]] = [
    {"record_id": "A-1", "raw_amount": "12.50", "raw_status": " ready "},
    {"record_id": "B-2", "raw_amount": "4", "raw_status": " unknown "},
    {"record_id": "C-3", "raw_amount": "bad", "raw_status": "READY"},
]
original = [row.copy() for row in raw_orders]
outcomes: list[tuple[str, str]] = []
for raw in raw_orders:
    outcomes.append(validate(
        raw.get("record_id"),
        parse_amount(raw.get("raw_amount")),
        normalize_status(raw.get("raw_status")),
        {"READY", "COMPLETED"},
    ))
assert [status for status, _ in outcomes] == ["PASS", "REVIEW", "FAIL"]
assert raw_orders == original
```

Presence and conversion checks inspect actual input. Allowed statuses and nonnegative amounts are business rules. `None` means parsing or normalization could not produce a usable value, as stated in the docstrings. The tuple result remains a status/reason pair on every branch; the loop is the orchestrator and does not mutate the raw records.
