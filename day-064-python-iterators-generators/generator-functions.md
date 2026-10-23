# Generator Functions

A function containing `yield` is a generator function. Calling it returns a generator object; the body runs as values are requested.

```python
def generate_statuses():
    yield "READY"
    yield "COMPLETED"
    yield "REVIEW"

statuses = generate_statuses()
for status in statuses:
    print(status)
```

At each `yield`, execution pauses and local state is kept. The next request resumes after that `yield`.

```python
def generate_record_ids(limit):
    record_id = 1
    while record_id <= limit:
        yield f"REC-{record_id:03d}"
        record_id += 1

for record_id in generate_record_ids(3):
    print(record_id)
```

The explicit `limit` bounds the example. Do not use an unbounded generator in a beginner script unless the consumer and stopping rule are both clear. Use `return` for one final function result; use `yield` when callers should receive a sequence over time.
