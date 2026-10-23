# Environment Variables

An environment variable is a named text value available to a process. The shell or launcher may supply it; child processes can inherit values, while exact shell commands differ by platform. Reading with `os.getenv` does not change the host environment.

```python
import os

mode = os.getenv("DAY068_MODE", "development")
raw_size = os.getenv("DAY068_BATCH_SIZE")
same_lookup = os.environ.get("DAY068_BATCH_SIZE")
```

Without a default, a missing key returns `None`. `os.environ["DAY068_BATCH_SIZE"]` raises `KeyError` if absent. A present empty string `""` is not `None`; `"   "` is another present string that becomes blank only after `.strip()`. Decide whether each should be rejected or treated as an explicit value.

Environment values are strings. `int("25")` produces 25, but invalid text raises `ValueError`. `bool("false")` and `bool("0")` are both `True` because those strings are non-empty. Use a small documented Boolean parser instead. A JSON Boolean, in contrast, is already a Python `bool` after reading.

Prefix learning variables with `DAY068_` to reduce collisions. Script 02 reads one harmless real setting but does not rely on its value; its repeatable examples use an in-memory dictionary. Do not print `dict(os.environ)`, log secret values, or modify machine/user environment settings for this lesson. Standard Python does not automatically read a `.env` file.

> Environment variables are strings. Values such as `"false"` and `"0"` are non-empty strings, so `bool("false")` is `True`; parse Boolean and numeric settings explicitly.
