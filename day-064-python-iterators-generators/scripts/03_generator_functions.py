"""A bounded generator preserves local state between yields."""


def generate_record_ids(limit):
    record_id = 1
    while record_id <= limit:
        yield f"REC-{record_id:03d}"
        record_id += 1


record_ids = generate_record_ids(3)
print("Calling the function returns:", type(record_ids).__name__)
print("First ID:", next(record_ids))
print("Remaining IDs:")
for record_id in record_ids:
    print(record_id)

print("New generator, same bounded sequence:", list(generate_record_ids(3)))
