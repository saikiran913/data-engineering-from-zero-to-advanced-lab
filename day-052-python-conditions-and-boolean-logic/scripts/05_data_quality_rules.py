"""Day 052: simple data-quality rules."""

record_count = 125
error_count = 2
schema_valid = True
is_fresh = True

has_rows = record_count > 0
has_low_errors = error_count <= 5
has_no_errors = error_count == 0
required_checks_pass = has_rows and schema_valid and is_fresh

if not required_checks_pass:
    validation_status = "FAIL"
    reason = "A required check failed"
elif has_no_errors:
    validation_status = "PASS"
    reason = "Required checks passed and no errors were found"
elif has_low_errors:
    validation_status = "REVIEW"
    reason = "Required checks passed, but a small number of errors need review"
else:
    validation_status = "FAIL"
    reason = "Too many errors were found"

print("validation_status:", validation_status)
print("reason:", reason)
