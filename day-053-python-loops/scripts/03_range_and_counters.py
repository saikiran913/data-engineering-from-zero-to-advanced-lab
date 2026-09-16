"""Day 053: range, counters, and accumulators."""

iteration_count = 0
total_batch_number = 0

for batch_number in range(1, 6):
    print(f"Processing batch number: {batch_number}")
    iteration_count += 1
    total_batch_number += batch_number

print("Iterations:", iteration_count)
print("Total of batch numbers:", total_batch_number)
