"""Compare loops and simple list comprehensions using in-memory values."""

statuses = [" ready ", "completed", " review "]
with_loop = []
for status in statuses:
    with_loop.append(status.strip().upper())

with_comprehension = [status.strip().upper() for status in statuses]
assert with_loop == with_comprehension

amounts = [5, 12, 20]
amounts_with_tax = [round(amount * 1.1, 2) for amount in amounts]
print("Raw statuses:", statuses)
print("Clean statuses:", with_comprehension)
print("Adjusted amounts:", amounts_with_tax)
