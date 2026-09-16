"""Day 052: if, elif, and else."""

error_count = 3

if error_count == 0:
    status = "PASS"
elif error_count <= 5:
    status = "REVIEW"
else:
    status = "FAIL"

print("error_count:", error_count)
print("validation status:", status)

boundary_error_count = 5

if boundary_error_count == 0:
    boundary_status = "PASS"
elif boundary_error_count <= 5:
    boundary_status = "REVIEW"
else:
    boundary_status = "FAIL"

print("boundary_error_count:", boundary_error_count)
print("boundary status:", boundary_status)
