# INI Configuration Files

INI uses bracketed sections and `key = value` lines. The bundled [example](sample-config/pipeline_settings.ini) has `[pipeline]` and `[validation]` sections. Values start as text, so getters can convert common types.

```python
import configparser

parser = configparser.ConfigParser()
read_paths = parser.read("sample-config/pipeline_settings.ini", encoding="utf-8")
if not read_paths:
    raise FileNotFoundError("pipeline_settings.ini was not read")
batch_size = parser.getint("pipeline", "batch_size")
enabled = parser.getboolean("pipeline", "enabled")
source_name = parser.get("pipeline", "source_name")
```

`getint()` rejects non-integer text; `getboolean()` recognizes documented common spellings such as `yes` and `no`. Neither proves the value is valid for your pipeline: `0` may parse as an integer yet fail the positive-size rule. Missing sections and keys raise configuration errors. Check that `read()` actually read the file, because it may return an empty list for a missing path. INI interpolation can interpret percent signs specially; the sample avoids that complication. Script 04 derives an absolute path from `__file__` and does not require installing anything.
