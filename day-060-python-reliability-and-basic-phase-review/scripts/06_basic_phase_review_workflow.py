"""Day 060: integrate strings and validation."""
def check_status(raw_status):
    if raw_status is None:
        return "REVIEW"
    return "PASS" if raw_status.strip().upper() == "COMPLETED" else "FAIL"

for value in [" completed ", None, "unknown"]:
    print(repr(value), check_status(value))
