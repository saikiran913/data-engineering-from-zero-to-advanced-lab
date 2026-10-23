"""Demonstrate concise function contracts for record processing."""

from math import isfinite


def normalize_status(raw_status: str) -> str:
    """Return an uppercase status after removing edge whitespace."""
    return raw_status.strip().upper()


def parse_amount(raw_amount: str | None) -> float | None:
    """Parse a finite amount, returning None for missing or invalid input.

    Args:
        raw_amount: Source amount text, or None when absent.

    Returns:
        Finite float, or None for absent, blank, invalid, or non-finite text.

    Side effects: None. Conversion errors are handled as None.
    """
    if raw_amount is None or not raw_amount.strip():
        return None
    try:
        amount = float(raw_amount)
    except ValueError:
        return None
    return amount if isfinite(amount) else None


def main() -> None:
    print("One-line docstring:", normalize_status.__doc__)
    print("Parser contract first line:", parse_amount.__doc__.splitlines()[0])
    print("Normalized:", normalize_status(" ready "))
    print("Parsed amount:", parse_amount("12.50"))
    print("Invalid amount:", parse_amount("bad"))
    print("Non-finite amount:", parse_amount("nan"))


if __name__ == "__main__":
    main()
