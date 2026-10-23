# Required vs Optional Settings

A setting is **required** when processing cannot proceed correctly without it. Required does not mean secret: `source_name` is a harmless but mandatory identifier in this example. Optional settings may have documented safe defaults.

| Setting | Contract | Missing behavior | Validation |
|---|---|---|---|
| `source_name` | Required non-empty string | Error | Trim; reject blank |
| `batch_size` | Optional positive integer | Use demo default `100` | Reject zero, negative, bool, invalid text |
| `mode` | Optional choice | Use demo default `development` | Allow development, validation, production |
| `enabled` | Optional Boolean | Use demo default `False` | Parse listed text forms |
| `max_retries` | Optional non-negative integer | Use documented default | Reject negative and bool |
| Conceptual `API_TOKEN` | Required only if a real integration needs one | Error, never fake a value | Do not read or display one in Day 068 |

Distinguish a missing setting (`None`), an empty setting (`""`), a wrong type (`"large"` for a size), and a wrong range (`0`). They tell the learner what to fix without revealing any secret. Day 068 does not implement authentication or use a real service.
