"""Day 058: check deterministic inclusive/exclusive time boundaries."""

from datetime import datetime

window_start = datetime(2026, 9, 16, 0, 0)
window_end = datetime(2026, 9, 17, 0, 0)
examples = [
    datetime(2026, 9, 15, 23, 59, 59),
    window_start,
    datetime(2026, 9, 16, 12, 0),
    datetime(2026, 9, 16, 23, 59, 59),
    window_end,
]

for event_time in examples:
    in_window = window_start <= event_time < window_end
    print(event_time, "in window:", in_window)
