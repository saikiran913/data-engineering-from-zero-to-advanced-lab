"""Ordinary and boundary parsing behavior."""

from datetime import date

from pipeline_utils.parsing import parse_amount, parse_iso_date


def test_parse_amount_valid_text() -> None:
    assert parse_amount("12.5") == 12.5


def test_parse_amount_outer_whitespace() -> None:
    assert parse_amount(" 8.25 ") == 8.25


def test_parse_amount_zero() -> None:
    assert parse_amount("0") == 0.0


def test_parse_amount_negative_parses_before_validation() -> None:
    assert parse_amount("-4") == -4.0


def test_parse_iso_date_fixed_day() -> None:
    assert parse_iso_date("2024-01-31") == date(2024, 1, 31)


def test_parse_iso_date_leap_day() -> None:
    assert parse_iso_date("2024-02-29") == date(2024, 2, 29)


def test_parse_amount_returns_float() -> None:
    assert isinstance(parse_amount("7"), float)
