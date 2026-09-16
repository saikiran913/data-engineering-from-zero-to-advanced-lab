"""Day 055: list basics."""

source_files = ["orders.csv", "customers.csv", "products.csv", "orders.csv"]

print("Source files:", source_files)
print("Number of files:", len(source_files))
print("First file:", source_files[0])
print("Last file:", source_files[-1])
print("Contains orders.csv:", "orders.csv" in source_files)
print("Contains payments.csv:", "payments.csv" in source_files)

for source_file in source_files:
    print(f"Reviewing: {source_file}")

print("Lists can contain duplicate values.")
