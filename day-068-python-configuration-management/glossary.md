# Glossary

| Term | Beginner meaning | Example |
|---|---|---|
| Boolean parsing | Converting a supported text form to True or False | `"false"` to `False` |
| Code default | Built-in fallback for an optional, safe setting | `batch_size=100` |
| Config file | Local document holding settings | Bundled JSON or INI |
| Config loader | Function that reads or assembles settings | `read_json_config(path)` |
| Config validation | Checking merged settings against rules | Size must be positive |
| Configuration | Values controlling program behavior | Mode and batch size |
| Environment override | Approved setting supplied by process environment | `DAY068_BATCH_SIZE` |
| Environment variable | Named text available to a process | `DAY068_MODE` |
| Fail-fast | Stop before processing when required config is invalid | Reject blank source name |
| INI | Section-based text config format | `[pipeline]` |
| JSON | Structured text format with typed values | `{"enabled": true}` |
| Missing setting | Name not supplied by a source | `None` from `os.getenv` |
| Optional setting | Setting allowed to use a documented default | `max_retries` |
| Override | Later value replacing an earlier value | Env size replaces file size |
| Parse | Convert raw representation to a type | `int("25")` |
| Precedence | Declared priority among sources | Defaults < file < env |
| Process environment | Variables visible to a running process | Selected `DAY068_` names |
| Required setting | Setting that must be supplied | `source_name` |
| Safe default | Non-sensitive fallback with acceptable behavior | Demo mode development |
| Secret | Value whose disclosure would be harmful | A real token |
| Sensitive value | Information that should not be output | Credential value |
| Setting contract | Name, type, source, priority, and rules | Positive `batch_size` |
| Source priority | Order for choosing competing sources | Environment wins here |
| Type conversion | Turning raw text into Python value | `getboolean()` |
| Validation | Checking an effective value against a rule | Mode is an allowed choice |

The order is alphabetical; similar-sounding terms have distinct jobs. Parsing converts representation, while validation checks acceptability.
