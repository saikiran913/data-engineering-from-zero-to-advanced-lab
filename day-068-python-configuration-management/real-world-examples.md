# Real-World Configuration Examples

All situations below are generic and synthetic. “Environment” refers to a selected, simulated `DAY068_` mapping unless a row says otherwise. Validate after applying the documented priority.

| # | Situation / setting | Source | Expected type | Decision or validation | Risk to avoid |
|---|---|---|---|---|---|
| 1 | Batch size omitted | Code default | int | Use 100, then check positive | Secret-like default |
| 2 | Batch size overridden | Environment `"25"` | int | Parse 25 | Keep string |
| 3 | Source name blank | JSON | string | Reject after strip | Process unidentified source |
| 4 | Optional feature disabled | Default | bool | Use False | Assume missing means error |
| 5 | Enabled says `"false"` | Environment | bool | Parse False | `bool("false")` |
| 6 | Enabled says `"perhaps"` | Environment | bool | Reject | Quietly use True |
| 7 | Batch size zero | Environment | int | Reject non-positive | Empty unintended batch |
| 8 | Batch size negative | JSON | int | Reject | Invalid slicing semantics |
| 9 | Max retries set to 2 | INI | int | Parse and require non-negative | Negative retries |
| 10 | Source format choice | JSON | string | Allow known names only | Unknown format silently accepted |
| 11 | Mode is validation | JSON | string | Check allowed set | Treat mode as security control |
| 12 | JSON fixture read | Bundled file | object | Check root dictionary | Trust syntax alone |
| 13 | INI pipeline section read | Bundled file | section | Verify read and getters | Missing section |
| 14 | INI section absent | INI | section | Raise clear error | Assume empty means default |
| 15 | JSON malformed | Bundled path concept | object | Catch decode failure by file name | Echo file contents |
| 16 | JSON root is list | JSON | object | Reject shape | Call `.get()` on list |
| 17 | Unknown config key | JSON | approved name | Reject or document ignore policy | Hidden typo |
| 18 | Required source missing | All sources | string | Fail fast | Invent source name |
| 19 | File says 50, env says 25 | File then env | int | Env wins, parse 25 | Reverse priority |
| 20 | Optional env key omitted | Environment | optional | Keep file value | Treat absence as empty |
| 21 | Error for batch size | Validator | diagnostic text | Name `batch_size` and rule | Print raw value |
| 22 | Logging config status | Console | safe summary | Log source/stage only | Log secret-bearing dict |
| 23 | Same config for two functions | Parameter | typed object | Pass validated settings | Hidden global read |
| 24 | Machine-independent exercise | Simulated map | string inputs | Fixed expected result | Host-dependent test |
| 25 | Synthetic order pipeline | JSON + simulated env | typed settings | Process first three rows | Real data or service call |
| 26 | Required ID rule in INI | INI | bool | `getboolean()` | Treat `"true"` as arbitrary text |
| 27 | Empty env override | Environment `""` | setting-specific | Reject if required/invalid | Treat as absent silently |
| 28 | Whitespace env name | Environment `"  "` | string | Strip and reject | Accept unusable name |

The examples demonstrate decisions, not real deployment infrastructure. In a real integration, credentials require a separate secure process outside this lesson.
