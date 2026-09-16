"""Day 053: end-to-end validation loop summary."""

source_checks = (
    ("orders", "PASS"),
    ("customers", "REVIEW"),
    ("products", "FAIL"),
    ("payments", "PASS"),
)

pass_count = 0
review_count = 0
fail_count = 0

for source_label, validation_outcome in source_checks:
    print(f"Source: {source_label}")
    print(f"Outcome: {validation_outcome}")

    if validation_outcome == "PASS":
        pass_count += 1
        print("Reason: validation passed")
    elif validation_outcome == "REVIEW":
        review_count += 1
        print("Reason: review needed")
    else:
        fail_count += 1
        print("Reason: validation failed")

print("Final summary")
print("PASS:", pass_count)
print("REVIEW:", review_count)
print("FAIL:", fail_count)
