def validate_amount(raw_value):
    try:
        return "PASS" if float(raw_value) >= 0 else "FAIL"
    except ValueError:
        return "FAIL"
