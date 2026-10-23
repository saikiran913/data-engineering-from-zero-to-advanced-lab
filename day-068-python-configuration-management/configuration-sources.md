# Configuration Sources

The source describes **where** a setting originates; its type and validity are separate questions.

| Source | Strength | Main risk | Typical use |
|---|---|---|---|
| In-code defaults | Simple and visible | Must stay non-sensitive | Optional demo batch size |
| Environment variables | Process-specific overrides | Always text; easy to misread | Override a known setting name |
| JSON file | Structured numbers, Booleans, lists | Malformed or wrong shape | Bundled pipeline options |
| INI file | Readable sections | Values begin as text | Simple grouped settings |

Configuration controls behavior; a source record is the business input. A public `mode=validation` setting is not a secret. A token or password would be a secret even if supplied by an environment variable. No source automatically makes a secret safe to log.

For this lesson, priority is **defaults < file < simulated environment**. If the default batch size is 100, the file says 50, and the permitted override says `"25"`, the final batch size is integer 25 after conversion. Another team may choose a different contract; the important point is to document and test its choice. Do not merge every environment variable indiscriminately.
