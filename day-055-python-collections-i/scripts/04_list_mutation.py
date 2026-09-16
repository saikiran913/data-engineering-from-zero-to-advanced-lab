"""Day 055: list mutation."""

statuses = ["PASS", "FAIL", "PASS"]

print("Original statuses:", statuses)

statuses[1] = "REVIEW"
print("After replacing index 1:", statuses)

statuses.append("PASS")
print("After append:", statuses)

statuses.extend(["REVIEW", "FAIL"])
print("After extend:", statuses)

copy_of_statuses = statuses.copy()
copy_of_statuses.append("PASS")

print("Original after copy mutation:", statuses)
print("Copy after mutation:", copy_of_statuses)
