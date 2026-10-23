"""Pytest collects test_-named functions in this test_-named module."""

from pipeline_utils.cleaning import normalize_status
from pipeline_utils.validation import missing_required_fields


def test_discovery_collects_meaningful_cleaning_check() -> None:
    assert normalize_status(" review ") == "REVIEW"


def test_discovery_collects_independent_required_field_check() -> None:
    assert missing_required_fields({"amount": 0}, ("amount",)) == []
