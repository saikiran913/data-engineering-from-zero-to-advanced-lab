"""Day 052: Boolean operators."""

has_rows = True
schema_valid = True
has_errors = False
status = "READY"

all_required_checks_pass = has_rows and schema_valid
status_allowed = status in ("READY", "RETRY")
status_not_blocked = status not in ("FAILED", "CANCELLED")
no_errors = not has_errors

print("has_rows and schema_valid:", all_required_checks_pass)
print('status in ("READY", "RETRY"):', status_allowed)
print('status not in ("FAILED", "CANCELLED"):', status_not_blocked)
print("not has_errors:", no_errors)
print("Final decision condition:", all_required_checks_pass and status_allowed and no_errors)
