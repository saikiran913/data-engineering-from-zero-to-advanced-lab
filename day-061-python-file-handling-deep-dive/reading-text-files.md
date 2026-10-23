# Reading Text Files

Use `.read()`, `.readline()`, `.readlines()`, or line iteration. `rstrip("\n")` removes newline only; `strip()` removes edge whitespace. Keep line numbers with `enumerate`.

Use `.read()` only when the whole file comfortably fits in memory. For recurring pipeline logs or larger files, iterate one line at a time. Treat blank lines and whitespace-only lines as separate cases when their business meaning matters.
