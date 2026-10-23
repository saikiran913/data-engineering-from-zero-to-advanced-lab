"""Expected failures and approximate floating-point comparison."""

import pytest

from pipeline_utils.cleaning import normalize_status
from pipeline_utils.parsing import parse_amount, parse_iso_date
from pipeline_utils.transformations import count_statuses
from pipeline_utils.validation import is_non_negative_amount


def test_invalid_amount_raises_value_error() -> None:
    with pytest.raises(ValueError):
        parse_amount("invalid")


def test_blank_amount_raises_value_error() -> None:
    with pytest.raises(ValueError):
        parse_amount("  ")


def test_none_amount_raises_value_error() -> None:
    with pytest.raises(ValueError):
        parse_amount(None)


def test_malformed_date_raises_value_error() -> None:
    with pytest.raises(ValueError):
        parse_iso_date("2023-02-29")


def test_wrong_date_shape_raises_value_error() -> None:
    with pytest.raises(ValueError):
        parse_iso_date("20240131")


def test_unexpected_cleaning_type_raises_type_error() -> None:
    with pytest.raises(TypeError):
        normalize_status(7)


def test_nonnumeric_validation_input_raises_type_error() -> None:
    with pytest.raises(TypeError):
        is_non_negative_amount("5")


def test_missing_status_in_aggregation_raises_value_error() -> None:
    with pytest.raises(ValueError):
        count_statuses([{"amount": 5}])


def test_float_calculation_uses_approximation() -> None:
    assert 0.1 + 0.2 == pytest.approx(0.3)
