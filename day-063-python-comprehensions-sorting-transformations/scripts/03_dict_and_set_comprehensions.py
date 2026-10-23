"""Build lookups and unique collections without changing inputs."""

records = [
    {"order_id": "ORD-1", "status": "ready", "source": "north"},
    {"order_id": "ORD-2", "status": "complete", "source": "north"},
    {"order_id": "ORD-3", "status": "ready", "source": "south"},
]
status_by_id = {record["order_id"]: record["status"].upper() for record in records}
source_names = {record["source"].upper() for record in records}
status_lengths = {status: len(status) for status in set(status_by_id.values())}

print("Status lookup:", status_by_id)
print("Unique sources in display order:", sorted(source_names))
print("Status lengths:", status_lengths)
