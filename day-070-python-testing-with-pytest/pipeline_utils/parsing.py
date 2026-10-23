"""Parse required numeric text and ISO calendar dates."""

from datetime import date
import math
import re


def parse_amount(value: str) -> float:
    """Parse finite numeric text; reject blank or non-string input."""
    if not isinstance(value, str) or not value.strip():
        raise ValueError("amount must be non-blank numeric text")
    try:
        amount = float(value.strip())
    except ValueError as exc:
        raise ValueError("amount must be numeric text") from exc
    if not math.isfinite(amount):
        raise ValueError("amount must be finite numeric text")
    return amount


def parse_iso_date(value: str) -> date:
    """Parse a strict YYYY-MM-DD calendar date."""
    if not isinstance(value, str) or re.fullmatch(r"\d{4}-\d{2}-\d{2}", value) is None:
        raise ValueError("date must use YYYY-MM-DD")
    try:
        return date.fromisoformat(value)
    except ValueError as exc:
        raise ValueError("date must be a valid YYYY-MM-DD date") from exc
