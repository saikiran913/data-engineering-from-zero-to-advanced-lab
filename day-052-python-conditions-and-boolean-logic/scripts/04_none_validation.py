"""Day 052: None validation."""

row_count = None
zero_count = 0
is_complete = False
empty_message = ""

print("row_count is None:", row_count is None)
print("row_count is not None:", row_count is not None)
print("zero_count is None:", zero_count is None)
print("is_complete is None:", is_complete is None)
print("empty_message is None:", empty_message is None)

if row_count is not None and row_count > 0:
    print("Rows are available")
else:
    print("Row count is missing or not greater than zero")

print("None, 0, False, and empty string should be checked deliberately.")
