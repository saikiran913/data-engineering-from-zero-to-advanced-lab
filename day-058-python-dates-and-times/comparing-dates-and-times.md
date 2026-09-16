# Comparing Dates and Times

```python
event_time < cutoff_time
start <= event_time <= end
start <= event_time < end
```

Use compatible date or datetime objects. An inclusive start and exclusive end avoids overlap between adjacent pipeline windows. Test values just before, exactly at, and just after each boundary. Do not compare naive and aware datetimes without an explicit conversion rule.
