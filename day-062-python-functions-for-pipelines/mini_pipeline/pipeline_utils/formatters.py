"""Presentation helpers only; they do not validate records."""


def format_record_result(record_id, validation_result):
    return f"{record_id}: {validation_result['status']} - {validation_result['reason']}"


def format_summary(total, pass_count, review_count, fail_count):
    return f"Summary: total={total}, pass={pass_count}, review={review_count}, fail={fail_count}"
