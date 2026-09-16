"""Day 055: indexing and slicing."""

files = ["orders.csv", "customers.csv", "products.csv", "payments.csv"]

print("All files:", files)
print("Index 0:", files[0])
print("Index 1:", files[1])
print("Last item with -1:", files[-1])
print("First two files:", files[0:2])
print("First two files with omitted start:", files[:2])
print("From index 1 onward:", files[1:])
print("Full slice copy:", files[:])
print("Every second file:", files[::2])

# files[10] would raise IndexError because that index does not exist.
