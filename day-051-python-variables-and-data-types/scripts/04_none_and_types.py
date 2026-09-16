"""Day 051: None and type awareness."""

last_error = None
zero_count = 0
is_complete = False
empty_comment = ""

print("last_error:", last_error, type(last_error))
print("zero_count:", zero_count, type(zero_count))
print("is_complete:", is_complete, type(is_complete))
print("empty_comment:", repr(empty_comment), type(empty_comment))

print()
print("Is last_error None?", last_error is None)
print("Is zero_count None?", zero_count is None)
print("None, 0, False, and an empty string are different values.")
