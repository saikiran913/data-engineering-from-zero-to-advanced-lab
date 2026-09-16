"""Day 057: deliberate replacement and controlled name checks."""

file_name = "orders_2026_01.csv"
technical_name = "daily-orders"

print("Technical name:", technical_name.replace("-", "_"))
print("Expected prefix:", file_name.startswith("orders_"))
print("Expected suffix:", file_name.endswith(".csv"))
print("Contains 2026:", "2026" in file_name)
print("Position of csv:", file_name.find("csv"))
print("Missing token position:", file_name.find("archive"))
