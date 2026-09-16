# Formatting Datetimes

`strftime()` turns a datetime into text.

```python
event_time.strftime("%Y-%m-%d")
event_time.strftime("%Y-%m-%d %H:%M:%S")
event_time.isoformat()
```

Use explicit year-month-day in machine contexts. Avoid ambiguous `01/02/2026`. Formatting does not change the underlying datetime. An aware datetime's ISO output includes its offset, making timezone context visible.
