"""Day 051: strings and booleans."""

source_name = "orders"
empty_value = ""
record_count_text = "100"
is_valid = True
has_errors = False

print(f"Source: {source_name}")
print("empty_value:", repr(empty_value), type(empty_value))
print("record_count_text:", record_count_text, type(record_count_text))
print("is_valid:", is_valid, type(is_valid))
print("has_errors:", has_errors, type(has_errors))
print("record_count_text == '100':", record_count_text == "100")
print('bool("False"):', bool("False"))
print('bool("False") is True because it is a non-empty string.')
