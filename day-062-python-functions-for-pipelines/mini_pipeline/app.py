"""In-memory orchestration for Day 062; no filesystem, network, or database I/O."""
from pipeline_utils.formatters import format_record_result, format_summary
from pipeline_utils.parsers import parse_amount, parse_event_date
from pipeline_utils.transforms import normalize_record
from pipeline_utils.validators import validate_record


def main():
    raw_records = [
        {"record_id": "R-1", "status": " ready ", "country": "UK", "amount": "18.50", "event_date": "2026-02-01"},
        {"record_id": "R-2", "status": "unknown", "country": "USA", "amount": "9", "event_date": "2026-02-02"},
        {"record_id": "R-3", "status": "completed", "country": "India", "amount": "bad", "event_date": "invalid"},
    ]
    required_fields = ["record_id", "status", "country"]
    allowed_statuses = {"READY", "COMPLETED"}
    results = []
    for raw_record in raw_records:
        clean_record = normalize_record(raw_record)
        clean_record = {**clean_record, "amount": parse_amount(raw_record.get("amount")), "event_date": parse_event_date(raw_record.get("event_date"))}
        validation_result = validate_record(clean_record, required_fields, allowed_statuses, minimum_amount=0)
        results.append({"record_id": raw_record["record_id"], **validation_result})
        print(format_record_result(raw_record["record_id"], validation_result))
    pass_count = sum(row["status"] == "PASS" for row in results)
    review_count = sum(row["status"] == "REVIEW" for row in results)
    fail_count = sum(row["status"] == "FAIL" for row in results)
    print(format_summary(len(results), pass_count, review_count, fail_count))


if __name__ == "__main__":
    main()
