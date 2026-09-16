# Real-World Examples

| # | Variable | Sample value | Expected type | Why | Risk if wrong |
|---|---|---|---|---|---|
| 1 | `row_count` | `5000` | `int` | count of rows | text count cannot be added safely |
| 2 | `file_size_bytes` | `204800` | `int` | byte count | decimal/text confusion |
| 3 | `order_amount` | `89.95` | `float` | decimal amount | bad calculations |
| 4 | `conversion_rate` | `0.075` | `float` | ratio | percent meaning unclear |
| 5 | `order_id` | `"ORD-1001"` | `str` | identifier | invalid conversion |
| 6 | `customer_id` | `"00125"` | `str` | leading zeros matter | zeros disappear |
| 7 | `file_name` | `"orders.csv"` | `str` | filename text | wrong path logic |
| 8 | `table_name` | `"daily_orders"` | `str` | table label | unreadable code |
| 9 | `load_status` | `"READY"` | `str` | category | inconsistent status handling |
| 10 | `is_valid` | `True` | `bool` | validation state | text truthiness trap |
| 11 | `has_errors` | `False` | `bool` | error state | confused with missing |
| 12 | `review_note` | `""` | `str` | empty optional text | confused with `None` |
| 13 | `last_error` | `None` | `NoneType` | no current error | treated as text |
| 14 | `amount_text` | `"45.75"` | `str` observed | imported CSV value | must validate before float |
| 15 | `bad_amount_text` | `"unknown"` | `str` | malformed input | conversion failure |
| 16 | `api_is_active` | `True` | `bool` | API boolean | correct if real boolean |
| 17 | `api_is_active_text` | `"False"` | `str` | API text | `bool()` gives wrong result |
| 18 | `json_note` | `None` | `NoneType` | JSON null concept | missing rule needed |
| 19 | `optional_text` | `""` | `str` | supplied empty text | may be valid blank |
| 20 | `zero_amount` | `0` | `int` | real zero | not missing |
| 21 | `missing_amount` | `None` | `NoneType` | missing value | cannot calculate directly |
| 22 | `status_code` | `"A1"` | `str` | category code | arithmetic makes no sense |
| 23 | `country_code` | `"UK"` | `str` | country label | inconsistent formatting |
| 24 | `schema_version` | `"001"` | `str` | version label | leading zeros lost |
| 25 | `retry_count` | `3` | `int` | whole count | text comparison wrong |
| 26 | `amount_today` | `"100.5"` | `str` observed | type drift from float | validation should catch drift |
