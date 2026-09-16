# Common Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | missing colon after `for` | invalid syntax | loop will not run | add `:` |
| 2 | missing colon after `while` | invalid syntax | loop will not run | add `:` |
| 3 | incorrect indentation | body unclear | `IndentationError` | use four spaces |
| 4 | iterating wrong variable | wrong data used | bad result | check iterable name |
| 5 | unclear loop variable | meaning hidden | hard to read | use descriptive names |
| 6 | counter outside intended block | every item counted | wrong summary | indent update correctly |
| 7 | counter initialized inside loop | resets each iteration | final count wrong | initialize before loop |
| 8 | counter never updated | remains zero | missing summary | use `+= 1` |
| 9 | accumulator reset each iteration | total lost | wrong total | initialize once before loop |
| 10 | infinite while loop | condition never false | script appears stuck | update condition |
| 11 | while condition never changes | same as infinite loop | unsafe repetition | change loop variable |
| 12 | off-by-one range error | wrong count | missing item | remember stop excluded |
| 13 | assuming range stop included | final number missing | boundary bug | use stop plus one |
| 14 | `break` too early | full scan skipped | missing issues | use only for fail-fast |
| 15 | `continue` skips required logic | item not processed | hidden failures | use clear skip rule |
| 16 | accidental nested cross-product | too many iterations | slow work | check loop structure |
| 17 | loop where expression is enough | unnecessary code | less readable | keep simple |
| 18 | many loops where one clear loop works | duplication | harder to maintain | combine carefully |
| 19 | wrong rule inside loop | repeated mistake | many wrong outcomes | test small sample |
| 20 | branch order wrong inside loop | wrong classification | repeated bad logic | severe rules first |
| 21 | `None` not handled | comparison fails | `TypeError` | check missing first |
| 22 | string/numeric mismatch | invalid comparison | wrong logic | inspect types |
| 23 | expected count inconsistent | false alert | bad validation | verify input data |
| 24 | summary inside loop | repeated summary | noisy output | print after loop |
| 25 | source variable overwritten | source meaning lost | bad lineage | use separate names |
| 26 | list modified while iterating | changing input | unpredictable thinking | avoid for now |
| 27 | infinite retry pattern | no stop | unsafe automation | set maximum attempts |
| 28 | `while True` without exit | unbounded loop | script may never stop | avoid as beginner |
| 29 | `break` when full validation required | stops early | incomplete summary | full scan instead |
| 30 | `continue` hides failures | skipped checks | weak validation | print skip reason |
| 31 | nested-loop performance ignored | work multiplies | slow scripts | estimate iterations |
| 32 | row-by-row loop assumed best for huge data | wrong tool | poor scale | use larger tools later |
| 33 | file traversal introduced too early | scope creep | unsafe learning | use hard-coded labels |
| 34 | external package added | unnecessary dependency | setup burden | standard library only |
| 35 | loop result not explained | unclear output | hard to review | print reason |
