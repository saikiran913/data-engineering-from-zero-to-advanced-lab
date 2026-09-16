"""Day 060: validate amount values."""

def validate_amount(raw_value):
    if raw_value is None or raw_value.strip() == "":
        return "REVIEW"
    try:
        amount = float(raw_value)
    except ValueError:
        return "FAIL"
    return "PASS" if amount >= 0 else "FAIL"


for value in [None, " ", "12.50", "bad", "-1"]:
    print(repr(value), validate_amount(value))
