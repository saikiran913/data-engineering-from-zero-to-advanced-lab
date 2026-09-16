# Common Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | first index assumed 1 | Python starts at 0 | wrong item | use index `0` |
| 2 | index out of range | position missing | `IndexError` | check `len()` |
| 3 | negative index misunderstood | counts from end | wrong item | use `-1` for last |
| 4 | slice stop inclusive | stop excluded | missing/extra item | remember stop excluded |
| 5 | wrong slice bounds | wrong subset | bad sample | test small list |
| 6 | single tuple missing comma | becomes string/grouping | wrong type | use `("orders",)` |
| 7 | list confused with tuple | mutability differs | wrong expectations | choose intentionally |
| 8 | tuple assumed mutable | cannot assign | `TypeError` | create new tuple |
| 9 | list mutation unexpected | list changed | side effect | document mutation |
| 10 | same list reference reused | changes shared | confusing result | copy when needed |
| 11 | copy not made | original mutated | source changed | use `.copy()` |
| 12 | mixed-type list without reason | unclear meaning | fragile processing | keep semantic consistency |
| 13 | magic index positions | `record[2]` unclear | hard to maintain | document positions |
| 14 | record undocumented | meaning hidden | wrong field use | add contract |
| 15 | unpack count mismatch | variables and values differ | error | match counts |
| 16 | wrong field order | values swapped | bad output | document tuple order |
| 17 | empty sequence not handled | no items | missing output | decide empty rule |
| 18 | duplicates assumed impossible | lists allow duplicates | wrong counts | validate if needed |
| 19 | order assumed unimportant | sequence order matters | wrong logic | preserve order |
| 20 | order changed unintentionally | positions change | downstream bug | mutate carefully |
| 21 | membership wrong type | value not found | false result | match types |
| 22 | `"100"` in integer list | string vs int | false membership | inspect types |
| 23 | index when direct iteration simpler | unnecessary complexity | harder to read | iterate items |
| 24 | unnecessary `range(len())` | index not needed | noisy code | direct loop |
| 25 | nested indexing hard to read | meaning hidden | maintenance risk | unpack values |
| 26 | mutable object in tuple caveat ignored | inner object may change | surprise | keep caveat in mind |
| 27 | append vs extend confused | nested list possible | wrong shape | choose method carefully |
| 28 | remove vs pop confused | value vs position | wrong removal | know method meaning |
| 29 | pop when mutation not intended | list changed | source lost | avoid mutation |
| 30 | modifying while iterating | changing input | confusing behavior | avoid for now |
| 31 | slicing as validation substitute | shape not proven | hidden issue | validate contract |
| 32 | fixed tuple too large | positions hard to remember | error prone | use named structures later |
| 33 | dictionaries introduced early | scope creep | too much at once | defer to Day 056 |
| 34 | external package added | unnecessary dependency | setup burden | standard library only |
| 35 | sequence contract missing | unclear expectations | fragile code | document sequence |
| 36 | empty tuple misunderstood | `()` has no items | wrong assumption | inspect `len()` |
