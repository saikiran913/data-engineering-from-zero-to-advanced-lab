"""Validate numeric boundaries and required record fields."""

import math


def is_non_negative_amount(amount: float) -> bool:
    """Return whether a finite numeric amount is at least zero."""
    if isinstance(amount, bool) or not isinstance(amount, (int, float)):
        raise TypeError("amount must be numeric")
    return math.isfinite(amount) and amount >= 0


def missing_required_fields(record: dict, required_fields: tuple[str, ...]) -> list[str]:
    """List missing/blank keys in requested order without changing the record."""
    return [
        field for field in required_fields
        if field not in record or record[field] is None
        or (isinstance(record[field], str) and not record[field].strip())
    ]
