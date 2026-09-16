"""Day 053: count validation outcomes."""

validation_results = ["PASS", "PASS", "REVIEW", "FAIL", "PASS"]

pass_count = 0
review_count = 0
fail_count = 0

for result in validation_results:
    if result == "PASS":
        pass_count += 1
    elif result == "REVIEW":
        review_count += 1
    else:
        fail_count += 1

print("PASS:", pass_count)
print("REVIEW:", review_count)
print("FAIL:", fail_count)
