"""Day 053: basic for loop over file names."""

file_names = ["orders.csv", "customers.csv", "products.csv"]

for file_name in file_names:
    print(f"Reviewing file: {file_name}")

print("File review loop complete.")
