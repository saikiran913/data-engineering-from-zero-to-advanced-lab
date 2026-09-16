"""Day 057: edge whitespace and controlled case standardisation."""

raw_status = "  completed  "
print("Raw:", repr(raw_status))
print("Left stripped:", repr(raw_status.lstrip()))
print("Right stripped:", repr(raw_status.rstrip()))
clean_status = raw_status.strip()
canonical_status = clean_status.upper()
print("Clean:", repr(clean_status))
print("Canonical:", canonical_status)
print("Lower case:", canonical_status.lower())
print("Blank after strip:", "   ".strip() == "")
