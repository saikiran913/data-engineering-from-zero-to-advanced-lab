"""Day 051: basic type conversion."""

record_count_text = "100"
amount_text = "45.75"
batch_number = 7

record_count = int(record_count_text)
amount = float(amount_text)
batch_label = str(batch_number)

print("record_count:", record_count, type(record_count))
print("amount:", amount, type(amount))
print("batch_label:", batch_label, type(batch_label))

# int("one hundred") would raise ValueError.
# float("not-an-amount") would raise ValueError.
# int(None) would fail because None is not numeric text.
