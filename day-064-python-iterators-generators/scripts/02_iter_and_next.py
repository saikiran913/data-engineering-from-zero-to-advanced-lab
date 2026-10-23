"""Advance an iterator, handle exhaustion, and create a fresh one."""

values = ["a", "b", "c"]
iterator = iter(values)
for position in range(len(values)):
    print("Position", position + 1, next(iterator))

try:
    next(iterator)
except StopIteration:
    print("The iterator is exhausted.")

fresh_iterator = iter(values)
print("Fresh iterator first value:", next(fresh_iterator))
