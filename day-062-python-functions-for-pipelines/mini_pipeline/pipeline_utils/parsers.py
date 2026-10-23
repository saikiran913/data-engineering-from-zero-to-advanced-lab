"""Conversion helpers. Return None for values that cannot be parsed."""
from datetime import date


def parse_amount(raw_amount):
    """Return float or None; no side effects."""
    try:
        return float(raw_amount)
    except (TypeError, ValueError):
        return None


def parse_event_date(raw_date):
    """Return an ISO date or None; no side effects."""
    try:
        return date.fromisoformat(raw_date)
    except (TypeError, ValueError):
        return None
