# Reusable Configuration Loaders

Separate boundary work from pure decisions:

```text
read_json_config(path)             — file I/O at the entry boundary
merge_settings(defaults, file, env) — pure, approved-key merge
validate_settings(merged)          — pure type and rule checks
run_pipeline(validated_config)     — business processing
```

```python
from dataclasses import dataclass

@dataclass(frozen=True)
class Settings:
    source_name: str
    batch_size: int
    enabled: bool

def process_count(record_count: int, settings: Settings) -> int:
    return min(record_count, settings.batch_size) if settings.enabled else 0
```

The validated object makes each function's inputs clear, as in Days 062, 065, and 066. Do not let `process_count` secretly call `os.getenv()` or read a file. The entry point reads the bundled file, supplies a simulated environment mapping, validates, then passes the resulting typed settings to business logic. In a later real application, the entry point could deliberately read selected actual environment names. A pure merge function is easy to exercise with fixed mappings and no machine-dependent setup. Catch specific read, decode, and validation errors at a boundary that can explain them; avoid `except Exception`.
