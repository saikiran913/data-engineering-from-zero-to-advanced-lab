"""Day 060: safely convert integer text."""

def parse_integer(raw_value):
    try:
        return int(raw_value)
    except ValueError:
        return None


for value in ["100", "abc"]:
    print(value, "->", parse_integer(value))
