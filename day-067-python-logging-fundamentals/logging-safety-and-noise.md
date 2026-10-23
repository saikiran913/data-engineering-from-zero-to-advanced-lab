# Logging Safety and Noise

Logs often remain visible to more people and for longer than the source code's immediate caller. Treat them as diagnostic output, not as a place to store raw data.

| Risk | Better choice |
|---|---|
| Password, token, or personal field in a message | Log only a safe category and count |
| Whole record printed during a failure | Log stage, safe error type, and aggregate count |
| One line per row in a large batch | Log bounded stage summaries |
| Ever-changing context keys | Reuse stable `run_id`, `source`, and `stage` keys |
| Same exception logged in multiple layers | One owner logs or handles it |
| Handler attached repeatedly | Configure once at entry |

Targeted DEBUG output may help during an investigation, but it should still use bounded counts rather than raw examples from real data. Even a small sample can contain sensitive information. Consider whether an exception message might include a value before logging it; the scripts use only synthetic, safe exception messages.

High-cardinality fields such as a unique record ID on every line make logs large and difficult to scan. Logs are not automatically encrypted or private. Day 067 uses console output only; later systems may handle retention and access separately.

> A log line should help diagnose an event, not expose confidential information. Never put passwords, tokens, or unnecessary personal or row-level data into logs.

> Avoid logging every record in a large pipeline. Prefer concise stage summaries, counts, bounded examples, and targeted debug information.
