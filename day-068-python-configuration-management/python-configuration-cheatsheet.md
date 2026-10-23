# Python Configuration Cheatsheet

| Need | Pattern |
|---|---|
| Optional environment value | `os.getenv("DAY068_MODE", "development")` |
| Missing-aware lookup | `os.environ.get("DAY068_BATCH_SIZE")` |
| Bundled path | `Path(__file__).resolve().parent.parent / "sample-config" / "app_config.json"` |
| Read JSON | `with path.open("r", encoding="utf-8") as file: config = json.load(file)` |
| Read INI | `parser = configparser.ConfigParser(); read_paths = parser.read(path, encoding="utf-8")` |
| INI integer | `parser.getint("pipeline", "batch_size")` |
| INI Boolean | `parser.getboolean("pipeline", "enabled")` |
| Priority | `{**defaults, **file_settings, **approved_overrides}` |
| Required name | `isinstance(name, str) and bool(name.strip())` |
| Pass config | `process(records, validated_settings)` |

For a text Boolean, normalise with `raw.strip().lower()` and accept only documented forms such as `true/1/yes` and `false/0/no`; reject everything else. Convert and validate after merging. Check a positive integer with `isinstance(raw, bool)` first, then `int(raw)` and a `> 0` bound. Check `read_paths` and a JSON root object's type before accessing keys.

Never use `bool("false")`, rely on automatic `.env` loading, invent credential fallbacks, merge every environment variable, dump entire configs, or hide a bad override by quietly using a default. Error text should name the setting, not reveal its value.
