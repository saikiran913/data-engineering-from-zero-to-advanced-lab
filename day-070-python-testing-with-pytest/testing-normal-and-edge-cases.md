# Testing Normal and Edge Cases

Choose inputs from the **function contract**, not an arbitrary number of examples. A normal case shows intended everyday behavior; a boundary or invalid case checks where behavior changes.

| Input class | Package example | Expected check |
|---|---|---|
| Normal valid | `" completed "` status | `"COMPLETED"` |
| Already canonical | `"READY"` | Stays `"READY"` |
| Optional `None` | `normalize_status(None)` | Returns `None` |
| Blank text | `normalize_status("  ")` | Returns `""` |
| Zero boundary | `is_non_negative_amount(0)` | True |
| Negative boundary | `is_non_negative_amount(-0.01)` | False |
| Missing required key | Record lacks `order_id` | List contains `order_id` |
| Invalid numeric text | `parse_amount("bad")` | Raises `ValueError` |
| Invalid date | `parse_iso_date("2023-02-29")` | Raises `ValueError` |
| Empty collection | `count_statuses([])` | `{}` |
| Non-mutation | `build_clean_record(source)` | New dict; original unchanged |

Negative numeric text still **parses** to a float; the validation function decides whether it is acceptable. `0` and `False` are present required-field values under the documented contract, not automatically missing. Those distinctions make tests useful for Data Engineering rather than a collection of random inputs.
