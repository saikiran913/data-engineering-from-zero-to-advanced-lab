# Configuration Precedence

This lesson's declared contract is:

```text
code defaults  <  config file  <  environment overrides
```

Only an explicitly supplied, approved key replaces an earlier value. An absent override leaves the file or default value in place. A present blank override is **not** absence; it must follow the setting's blank-value policy.

| Setting | Default | JSON file | Environment | Final typed value |
|---|---|---|---|---|
| `batch_size` | `100` | `50` | `"25"` | `25` |
| `mode` | `development` | `validation` | absent | `validation` |
| `enabled` | `False` | `True` | `"false"` | `False` |

```python
approved_env_names = {"DAY068_BATCH_SIZE": "batch_size", "DAY068_ENABLED": "enabled"}
overrides = {
    setting: simulated_env[name]
    for name, setting in approved_env_names.items()
    if name in simulated_env
}
merged = {**defaults, **file_settings, **overrides}
```

This merge chooses a raw value; it does not convert `"25"` or `"false"` automatically. Parse and validate after merging. Unknown environment keys are ignored by this example because only an explicit allowlist is read. Some applications instead reject unknown names; choose and document one policy. Never absorb arbitrary process environment data into a settings dictionary.

> Configuration precedence must be predictable and documented. Changing a setting in the environment should not silently conflict with a config-file value without a known override rule.
