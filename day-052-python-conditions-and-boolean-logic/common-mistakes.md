# Common Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | `=` instead of `==` | assignment used as comparison | syntax or logic failure | use `==` for equality |
| 2 | incorrect indentation | block not recognised | `IndentationError` | indent four spaces |
| 3 | inconsistent indentation | mixed spacing | hard to parse | keep spacing consistent |
| 4 | missing colon | `if condition` incomplete | `SyntaxError` | add `:` |
| 5 | `else status == "FAIL"` | `else` has no condition | invalid syntax | use `elif` for condition |
| 6 | branch order wrong | broad rule first | severe case missed | check severe rules first |
| 7 | unreachable `elif` | earlier rule captures it | branch never runs | reorder conditions |
| 8 | overlapping rules misunderstood | same value matches many rules | wrong outcome | document precedence |
| 9 | boundary omitted | `==` case missing | gaps in logic | test exact thresholds |
| 10 | exact threshold mishandled | `>` used instead of `>=` | boundary wrong | choose operator carefully |
| 11 | `and` instead of `or` | requires too much | allowed case rejected | match business rule |
| 12 | `or` instead of `and` | too permissive | bad data passes | require all needed checks |
| 13 | `not` on wrong expression | inverted wrong part | surprising result | use parentheses |
| 14 | no parentheses | precedence unclear | review difficulty | group logic explicitly |
| 15 | truthiness for zero | `if not row_count` | zero and missing confused | use `row_count == 0` |
| 16 | `None` confused with zero | missing treated as value | bad validation | use `is None` |
| 17 | `None` compared numerically | `None > 0` | `TypeError` | check present first |
| 18 | empty string confused with `None` | blank and missing mixed | wrong rule | check explicitly |
| 19 | `"False"` treated as `False` | text not Boolean | logic passes wrongly | inspect type |
| 20 | `bool("False")` misunderstood | non-empty string truthy | wrong decision | parse deliberately later |
| 21 | case-sensitive status mismatch | `"ready"` not `"READY"` | unexpected review | standardise later |
| 22 | numeric string vs number | `"100" > 20` | type error | convert safely first |
| 23 | unsupported status falls through | no fallback | invisible issue | add `else` |
| 24 | no fallback branch | unexpected states ignored | weak validation | use explicit fallback |
| 25 | result has no reason | outcome unexplained | hard to debug | print clear reason |
| 26 | one giant expression | unreadable | hard to review | name conditions |
| 27 | same condition repeated | duplicated logic | inconsistent updates | simplify rules |
| 28 | unclear rule names | `check1` | meaning hidden | use `has_rows` |
| 29 | independent `if`s for exclusive chain | multiple outcomes | conflict | use `elif` chain |
| 30 | `elif` for independent checks | later checks skipped | missing issues | use separate `if`s |
| 31 | clever over readable | hard to maintain | review risk | prefer clarity |
| 32 | syntax correct, rule wrong | Python runs | business result wrong | verify requirement |
| 33 | missing state untested | `None` surprises code | failure later | test `None` |
| 34 | boundaries untested | threshold bug | incorrect classification | test below/exact/above |
| 35 | external package added | unnecessary dependency | setup burden | use standard library |
