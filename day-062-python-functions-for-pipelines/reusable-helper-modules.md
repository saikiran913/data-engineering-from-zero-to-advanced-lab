# Reusable Helper Modules

```text
pipeline_utils/
├── parsers.py
├── transforms.py
├── validators.py
└── formatters.py
```

| Module | Responsibility |
|---|---|
| `parsers` | Convert raw representations safely |
| `transforms` | Normalize values and return new records |
| `validators` | Apply business rules with consistent results |
| `formatters` | Present already-decided results |
| `app.py` | Orchestrate stages and configuration |

Keep modules focused. Avoid circular imports, wildcard imports, `sys.path` modifications, top-level workflow execution on import, and modules that both validate and format. Imports should describe real dependencies, not hide them.
