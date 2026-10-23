# Safe Defaults

A default is the value used when an optional setting is not supplied. It should be documented, non-sensitive, and already have the intended type.

| Setting | Synthetic default | Reasonable? |
|---|---|---|
| `batch_size` | integer `100` | Yes, if the documented range permits it |
| `enable_debug` | Boolean `False` | Yes for a quiet demo |
| `mode` | `"development"` | Yes for this synthetic lesson, not a production security policy |
| `source_name` | None | Required; report absence |
| Credential for a real integration | None | Never invent a token or permissive fallback |

Missing and invalid are different. An absent optional override can leave the prior value in place. A supplied `""`, `"  "`, `"0"`, or `"not-a-number"` should be handled according to the explicit contract; do not silently use the default after an invalid override. Fail fast on required values or invalid settings before processing records. A production-like mode label in an example is only a choice value, not proof of secure deployment.

> Safe defaults are appropriate for non-sensitive, optional settings. Required secrets, credentials, and security-critical settings should not silently fall back to hard-coded or insecure values.
