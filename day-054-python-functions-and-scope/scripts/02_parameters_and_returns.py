"""Day 054: parameters, arguments, and return values."""


def calculate_total(first_value, second_value):
    """Return the sum of two values."""
    return first_value + second_value


def classify_errors(error_count, review_limit=5):
    """Classify an error count using a default review limit."""
    if error_count == 0:
        return "PASS"

    if error_count <= review_limit:
        return "REVIEW"

    return "FAIL"


total = calculate_total(10, 20)
status_from_positional = classify_errors(3)
status_from_keyword = classify_errors(error_count=8, review_limit=10)

print("Returned total:", total)
print("Status from positional argument:", status_from_positional)
print("Status from keyword arguments:", status_from_keyword)
print("print displays information; return sends a value back to the caller.")
