"""Show a list iterable, its iterator, and loop consumption."""

statuses = ["READY", "COMPLETED", "REVIEW"]
status_iterator = iter(statuses)

print("List is iterable:", statuses)
print("Iterator type:", type(status_iterator).__name__)
print("First value:", next(status_iterator))
print("Remaining values:")
for status in status_iterator:
    print(status)

print("A fresh loop over the list starts again:")
for status in statuses:
    print(status)
