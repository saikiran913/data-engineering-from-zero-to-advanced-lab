# Common Configuration Mistakes

| # | Mistake | Why it matters | Safer correction |
|---|---|---|---|
| 1 | `bool("false")` | Non-empty text is true | Use an explicit Boolean parser |
| 2 | Treating env `"25"` as an int | It is a string | Convert and check bounds |
| 3 | Treating missing as `""` | Missing is usually `None` | Test both cases |
| 4 | Accepting whitespace source name | It has no useful identifier | Strip and reject blank |
| 5 | Hard-coded secret fallback | Masks absent credentials | Require a real value at a real integration boundary |
| 6 | Committing a real `.env` | Leaks secrets | Keep real secret files out of Git |
| 7 | Assuming `.env` auto-loads | Standard Python does not load it | Use documented actual environment values; no dotenv here |
| 8 | Printing the whole environment | May expose secrets | Inspect only known harmless names |
| 9 | Logging a whole config | Future keys may be sensitive | Log safe setting names or categories only |
| 10 | Reversing precedence accidentally | Overrides do not win as expected | Merge defaults, then file, then approved env |
| 11 | Undocumented priority | Operators cannot predict results | Publish the contract |
| 12 | Skipping final validation | Later source can introduce bad text | Validate after merging |
| 13 | Importing arbitrary env keys | Unknown settings can alter behavior | Use an allowlist |
| 14 | Accepting size zero | Pipeline may do no intended work | Enforce positive bound |
| 15 | Accepting `True` as size 1 | `bool` subclasses `int` | Reject bool before integer conversion |
| 16 | Treating optional as required | Prevents safe default | Record required status per key |
| 17 | Treating required as optional | Hides missing source identity | Fail fast |
| 18 | Silently discarding malformed override | Surprising effective value | Reject explicit invalid input |
| 19 | Assuming file exists | Open may fail | Check path and handle `FileNotFoundError` |
| 20 | Ignoring JSON syntax error | Cannot trust partial config | Report malformed JSON by file name |
| 21 | Assuming JSON root is object | JSON list is valid syntax | Check `isinstance(config, dict)` |
| 22 | Ignoring missing INI section | Getter cannot find setting | Check expected section |
| 23 | Ignoring missing INI key | Contract is incomplete | Check key or provide documented optional default |
| 24 | Using raw INI `"no"` as Boolean | Non-empty string is truthy | Use `getboolean()` |
| 25 | Ignoring `ConfigParser.read()` result | Missing file may look like empty config | Check read paths |
| 26 | Reading env inside pure processing function | Makes tests machine-dependent | Pass validated config in |
| 27 | Changing global config repeatedly | Behavior varies by call order | Build settings once at entry |
| 28 | Mixing raw and validated values | Types become unpredictable | Return a typed dict or dataclass |
| 29 | Printing full config on exception | Could reveal sensitive fields | Name only setting and rule |
| 30 | Tests use real machine environment | Results vary by host | Use simulated mappings |
| 31 | Putting real credentials in practice data | Public repository exposure | Keep fixtures synthetic and non-secret |
| 32 | Reading relative path from an unknown directory | File appears missing | Derive bundled path from `__file__` |
| 33 | Assuming valid JSON means valid settings | Shape and bounds may be wrong | Run contract checks |
| 34 | Using a production label as security proof | A string does not secure a system | Treat mode as a choice only |

When debugging, identify the setting and source without printing its value if it might be sensitive.
