"""Day 056: unique values, membership, and simple set operations."""

source_ids = ["SRC-1", "SRC-2", "SRC-1", "SRC-3"]
unique_ids = set(source_ids)
allowed = {"PENDING", "COMPLETED"}
observed = {"COMPLETED", "FAILED"}
empty_values = set()

unique_ids.add("SRC-4")
unique_ids.discard("SRC-2")
print("Unique IDs:", unique_ids)
print("Empty set:", empty_values)
print("COMPLETED allowed:", "COMPLETED" in allowed)
print("All statuses:", allowed | observed)
print("Shared statuses:", allowed & observed)
print("Unexpected statuses:", observed - allowed)
