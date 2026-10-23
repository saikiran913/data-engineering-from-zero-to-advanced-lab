"""Copying, aggregation, and repeated-call behavior."""

from pipeline_utils.transformations import build_clean_record, count_statuses


def test_build_clean_record_returns_new_dictionary() -> None:
    source = {"status": " ready ", "amount": 5}
    result = build_clean_record(source)
    assert result == {"status": "READY", "amount": 5}
    assert result is not source


def test_build_clean_record_preserves_original() -> None:
    source = {"status": " ready "}
    build_clean_record(source)
    assert source == {"status": " ready "}


def test_build_clean_record_does_not_invent_status() -> None:
    assert build_clean_record({"amount": 5}) == {"amount": 5}


def test_count_statuses_nonempty() -> None:
    records = [{"status": "READY"}, {"status": "READY"}, {"status": "COMPLETED"}]
    assert count_statuses(records) == {"READY": 2, "COMPLETED": 1}


def test_count_statuses_empty() -> None:
    assert count_statuses([]) == {}


def test_count_statuses_does_not_mutate_records() -> None:
    records = [{"status": "READY"}]
    assert count_statuses(records) == {"READY": 1}
    assert records == [{"status": "READY"}]


def test_repeated_calls_do_not_share_state() -> None:
    first = count_statuses([{"status": "READY"}])
    second = count_statuses([{"status": "COMPLETED"}])
    assert first == {"READY": 1}
    assert second == {"COMPLETED": 1}
