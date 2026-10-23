# Recoverable Record Errors

An invalid record can be kept as a small **in-memory** review result with a safe synthetic identifier and clear reason:

```python
{
    "record_id": "REC-003",
    "status": "REVIEW",
    "reason": "amount is not numeric",
}
```

Check required keys before parsing. If `amount` is absent, this example reports FAIL; if present but blank, it reports REVIEW. A nonnumeric value or unsupported status is reviewed, while valid values pass. A genuinely optional missing field could use a documented default, but a required field cannot. These choices are educational policies, not universal business rules.

Keep one outcome per processed row and reconcile `processed = PASS + REVIEW + FAIL`. The [record script](scripts/03_recoverable_record_errors.py) retains the results in a list and prints only synthetic review IDs/reasons. It creates no real review queue or dead-letter service. Repeating a malformed row does not repair it; route it to review or correction instead of retrying.
