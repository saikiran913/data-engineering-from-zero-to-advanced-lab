# Common Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | `2records = 10` | starts with number | invalid syntax | use `record_count` |
| 2 | `source-name = "a"` | hyphen used | Python reads subtraction | use `source_name` |
| 3 | `class = "orders"` | reserved keyword | keyword already means something | choose another name |
| 4 | `x = 100` | vague name | business meaning hidden | use `row_count` |
| 5 | mixed naming | inconsistent style | harder to read | use `snake_case` |
| 6 | confusing `=` and `==` | assignment versus comparison | logic changes | use each deliberately |
| 7 | `"100"` treated as number | string is text | bad arithmetic | convert safely |
| 8 | ID converted to int | leading zeros lost | identifier changes | keep ID as string |
| 9 | empty string confused with `None` | both are different | wrong missing logic | define missing rule |
| 10 | zero confused with `None` | zero is a value | false missing alert | keep separate |
| 11 | `False` confused with `None` | false is known state | wrong status logic | check explicitly |
| 12 | `"False"` confused with `False` | text versus boolean | validation errors | inspect type |
| 13 | `bool("False")` misunderstood | non-empty string is truthy | unsafe parsing | do not use as text parser |
| 14 | invalid integer conversion | malformed text | raises `ValueError` | validate first |
| 15 | invalid float conversion | malformed decimal | raises `ValueError` | validate first |
| 16 | converting `None` directly | no value | conversion fails | check `is None` |
| 17 | unnecessary ID conversion | identifier not quantity | meaning damaged | keep as string |
| 18 | accidental type reassignment | value changes type | later code surprises | use clear names |
| 19 | dynamic typing means types do not matter | false assumption | pipeline risk | stay type-aware |
| 20 | comparing values without type check | values may look alike | misleading result | inspect value and type |
| 21 | business meaning ignored | type chosen blindly | wrong model | ask what value means |
| 22 | float precision ignored | decimals have limits | amount risk | document precision needs |
| 23 | whitespace string ignored | `" "` is not empty | validation misses issue | standardise later |
| 24 | `true` or `false` | wrong capitalisation | `NameError` | use `True` and `False` |
| 25 | `none` | wrong capitalisation | `NameError` | use `None` |
| 26 | quote mismatch | string not closed | `SyntaxError` | match quotes |
| 27 | external package added unnecessarily | extra dependency | setup complexity | use standard library here |
| 28 | conversion hides data-quality issue | bad values disappear | source issue missed | log or investigate later |
| 29 | missing value silently replaced | no business rule | incorrect reporting | agree rule first |
| 30 | CSV values assumed typed | CSV text may be strings | wrong calculations | inspect and convert |
| 31 | JSON null and empty string treated same | different signals | data meaning lost | map deliberately |
| 32 | string ID used in arithmetic | ID is not quantity | nonsense result | keep identifiers separate |
