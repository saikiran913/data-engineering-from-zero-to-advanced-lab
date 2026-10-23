"""Status and country-code normalization contracts."""

from pipeline_utils.cleaning import normalize_country_code, normalize_status


def test_normalize_status_trims_and_uppercases() -> None:
    assert normalize_status(" completed ") == "COMPLETED"


def test_normalize_status_keeps_canonical_text() -> None:
    assert normalize_status("READY") == "READY"


def test_normalize_status_blank_string() -> None:
    assert normalize_status("   ") == ""


def test_normalize_status_none() -> None:
    assert normalize_status(None) is None


def test_normalize_country_code() -> None:
    assert normalize_country_code(" uk ") == "UK"


def test_normalize_country_code_blank() -> None:
    assert normalize_country_code("\t") == ""


def test_normalize_country_code_none() -> None:
    assert normalize_country_code(None) is None


def test_normalize_status_does_not_change_source_string() -> None:
    original = " completed "
    assert normalize_status(original) == "COMPLETED"
    assert original == " completed "


def test_normalize_status_preserves_internal_spaces() -> None:
    assert normalize_status(" needs review ") == "NEEDS REVIEW"
