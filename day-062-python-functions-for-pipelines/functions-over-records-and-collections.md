# Functions Over Records and Collections

A one-record function is the foundation. Apply it in a visible loop when processing a collection.

```python
clean_records = []
for record in records:
    clean_records.append(normalize_record(record))
```

Dictionaries and lists are mutable. Returning a new record avoids changing raw evidence that a later stage may need. Collection helpers can collect results or count classifications, but should not hide the one-record contract. Preserve record IDs and validation reasons for troubleshooting.
