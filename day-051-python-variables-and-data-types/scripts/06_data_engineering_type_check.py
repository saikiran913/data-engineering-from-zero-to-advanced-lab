"""Day 051: inspect simple Data Engineering values."""

order_id = "ORD-1001"
order_amount = 250.75
is_complete = True
review_note = None

print("order_id")
print("  value:", order_id)
print("  type:", type(order_id))
print("  meaning: stable order identifier")

print("order_amount")
print("  value:", order_amount)
print("  type:", type(order_amount))
print("  meaning: numeric order amount")

print("is_complete")
print("  value:", is_complete)
print("  type:", type(is_complete))
print("  meaning: load completion flag")

print("review_note")
print("  value:", review_note)
print("  type:", type(review_note))
print("  meaning: optional note that is not currently available")
