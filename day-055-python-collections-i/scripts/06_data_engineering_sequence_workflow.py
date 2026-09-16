"""Day 055: sequence workflow with hard-coded values."""

source_files = ["orders.csv", "customers.csv", "products.csv", "payments.csv"]

print("First source:", source_files[0])
print("Last source:", source_files[-1])
print("First two sources:", source_files[:2])

for source_file in source_files:
    print(f"Queued source: {source_file}")

validation_results = (
    ("orders.csv", "PASS"),
    ("customers.csv", "REVIEW"),
    ("products.csv", "PASS"),
    ("payments.csv", "FAIL"),
)

pass_count = 0
review_count = 0
fail_count = 0

for source_file, validation_status in validation_results:
    print(f"{source_file}: {validation_status}")

    if validation_status == "PASS":
        pass_count += 1
    elif validation_status == "REVIEW":
        review_count += 1
    else:
        fail_count += 1

print("Summary")
print("PASS:", pass_count)
print("REVIEW:", review_count)
print("FAIL:", fail_count)
