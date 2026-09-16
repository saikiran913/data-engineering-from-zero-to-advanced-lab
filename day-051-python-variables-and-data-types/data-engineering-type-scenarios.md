# Data Engineering Type Scenarios

| # | Source value | Observed Python value | Observed type | Expected business type | Risk | Recommended thinking |
|---|---|---|---|---|---|---|
| 1 | row count | `1200` | `int` | integer count | low | keep as `int` |
| 2 | amount | `42.75` | `float` | decimal amount | precision assumptions | document amount meaning |
| 3 | order ID | `"ORD-1001"` | `str` | identifier text | wrong conversion | keep as string |
| 4 | customer ID | `"00125"` | `str` | identifier text | leading zeros lost | do not convert |
| 5 | filename | `"orders.csv"` | `str` | text | low | keep descriptive |
| 6 | status | `"READY"` | `str` | text category | inconsistent values | standardise values |
| 7 | validation | `True` | `bool` | boolean | text confusion | keep as true boolean |
| 8 | error message | `None` | `NoneType` | optional text | treated as empty text | define missing rule |
| 9 | optional comment | `""` | `str` | text | confused with missing | decide empty versus missing |
| 10 | numeric text | `"100"` | `str` | maybe integer | text arithmetic | convert only if safe |
| 11 | invalid numeric text | `"one hundred"` | `str` | maybe integer | conversion failure | validate first |
| 12 | boolean text | `"False"` | `str` | maybe boolean | `bool()` trap | parse deliberately later |
| 13 | actual boolean | `False` | `bool` | boolean | confused with missing | keep distinct from `None` |
| 14 | zero amount | `0` | `int` | numeric amount | treated as missing | zero may be valid |
| 15 | missing amount | `None` | `NoneType` | missing numeric | failed conversion | check before conversion |
| 16 | country code empty | `""` | `str` | country text | unknown meaning | decide validation rule |
| 17 | country code whitespace | `" "` | `str` | country text | looks blank | clean later |
| 18 | JSON null | `None` | `NoneType` | missing value | system confusion | map carefully |
| 19 | API numeric-as-text | `"45.75"` | `str` | float | bad calculation | validate then convert |
| 20 | type drift | `"100.5"` | `str` | float | pipeline break | compare expected type |
| 21 | date string | `"2026-01-15"` | `str` | date concept | date logic unsafe | date parsing is future scope |
| 22 | percentage | `0.12` | `float` | ratio | format confusion | document decimal versus percent |
| 23 | file size | `2048` | `int` | bytes | low | keep as integer |
| 24 | no-conversion ID | `"78910"` | `str` | identifier text | accidental arithmetic | keep string if it identifies |
