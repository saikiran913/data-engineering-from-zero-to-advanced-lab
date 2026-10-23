"""Compare eager and lazy expressions, then consume deliberately."""

values = [1, 2, 3]
eager = [value * value for value in values]
lazy = (value * value for value in values)

print("Eager type:", type(eager).__name__, "values:", eager)
print("Lazy type:", type(lazy).__name__)
print("First lazy value:", next(lazy))
remaining = list(lazy)
print("Deliberately materialised remaining values:", remaining)
print("Second consumption after exhaustion:", list(lazy))
