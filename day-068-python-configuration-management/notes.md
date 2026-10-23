# Revision Notes

Configuration is a set of named values that controls how code runs. Records being processed are business data; Python functions and statements are executable logic. `batch_size=50` is a setting; an order status in a row is data. Keeping these separate lets the same reusable function run with different, validated settings.

```text
code defaults
     ↓
read config file
     ↓
apply environment overrides
     ↓
parse types + validate constraints
     ↓
pass trusted configuration into functions/components
```

For each setting document its source, priority, expected type, required or optional status, permitted values, and behavior when missing. For example, `batch_size` may default to integer 100, accept an explicit override, and require a positive integer. `source_name` may be required and reject blank text.

Merge only approved names. A later source wins for keys it actually provides; absence is not the same as an empty or whitespace-only override. Parse the final merged values because environment and INI values are text even when they look numeric or Boolean. A file can be syntactically valid yet violate the setting contract. You may check each source earlier for clarity, but final validation after merging is essential.

A malformed setting is a configuration error: it should be reported before processing records. A rejected order row is a business-data validation outcome. A stage crash is an operational error. Day 067's logs can safely identify the setting name or stage, but must not reveal sensitive values.

The examples avoid actual host environment changes. A simulated dictionary makes the override contract repeatable. The scripts read the bundled fixtures only; pure merge and validation functions receive their input mappings as parameters. This follows Days 062 and 065: pass a validated dictionary or simple dataclass to pipeline functions rather than hiding reads in those functions.

> Environment variables are strings. Values such as `"false"` and `"0"` are non-empty strings, so `bool("false")` is `True`; parse Boolean and numeric settings explicitly.

> Configuration precedence must be predictable and documented. Changing a setting in the environment should not silently conflict with a config-file value without a known override rule.
