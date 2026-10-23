"""Required-field and numeric-boundary checks."""

from pipeline_utils.validation import is_non_negative_amount, missing_required_fields


def test_zero_amount_is_allowed() -> None:
    assert is_non_negative_amount(0.0) is True


def test_positive_amount_is_allowed() -> None:
    assert is_non_negative_amount(12.5) is True


def test_negative_amount_is_rejected() -> None:
    assert is_non_negative_amount(-0.01) is False


def test_missing_key_is_reported() -> None:
    assert missing_required_fields({"amount": 2}, ("order_id", "amount")) == ["order_id"]


def test_none_value_is_reported() -> None:
    assert missing_required_fields({"order_id": None}, ("order_id",)) == ["order_id"]


def test_empty_string_is_reported() -> None:
    assert missing_required_fields({"order_id": ""}, ("order_id",)) == ["order_id"]


def test_whitespace_string_is_reported() -> None:
    assert missing_required_fields({"order_id": "  "}, ("order_id",)) == ["order_id"]


def test_zero_and_false_are_present_values() -> None:
    assert missing_required_fields({"amount": 0, "enabled": False}, ("amount", "enabled")) == []


def test_missing_fields_preserve_requested_order() -> None:
    assert missing_required_fields({}, ("source", "amount", "order_id")) == ["source", "amount", "order_id"]


def test_field_check_does_not_mutate_record() -> None:
    record = {"order_id": "REC-001", "amount": 0}
    assert missing_required_fields(record, ("order_id", "amount")) == []
    assert record == {"order_id": "REC-001", "amount": 0}


def test_non_finite_amount_is_rejected() -> None:
    assert is_non_negative_amount(float("nan")) is False
