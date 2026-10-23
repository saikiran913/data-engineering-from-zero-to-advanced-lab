# Bounded Retries and Backoff

Retry limits control *how many calls* may occur. Backoff controls a possible pause **between** failed calls. These examples calculate delays only; they never sleep or contact a service.

For base delay 2 seconds and cap 3 seconds, use `min(max_delay, base_delay * 2 ** (attempt_number - 1))` after a retryable failure when another attempt remains.

| Failed attempt | Next attempt exists? | Fixed delay (2s) | Increasing delay, capped at 3s |
|---|---|---|---|
| 1 | Yes | 2 | 2 |
| 2 | Yes | 2 | 3 (`min(3, 4)`) |
| 3 | No | None | None |

With `max_attempts=3`, there are three total calls at most and two retries. No delay follows a successful call or the final unsuccessful call. An increasing delay can reduce immediate repeated pressure; it cannot guarantee recovery. A real operation might also need a total time budget so a run cannot wait too long. Concurrent retry storms and jitter are later production topics, not mechanisms implemented here. The [backoff script](scripts/05_retry_safety_and_backoff.py) only prints hand-checkable values.
