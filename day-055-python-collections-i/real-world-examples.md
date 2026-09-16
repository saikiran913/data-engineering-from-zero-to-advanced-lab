# Real-World Examples

| # | Scenario | Sequence type | Example values | Why it fits | Risk | Safe design note |
|---|---|---|---|---|---|---|
| 1 | source files | list | `["orders.csv", "customers.csv"]` | collection may change | duplicates | document source meaning |
| 2 | table names | list | `["orders", "customers"]` | ordered labels | wrong order | keep clear names |
| 3 | validation results | list | `["PASS", "REVIEW"]` | count outcomes | invalid status | define allowed values |
| 4 | pipeline steps | list | `["extract", "validate", "load"]` | order matters | reordered steps | avoid accidental mutation |
| 5 | row-like record | tuple | `("ORD-1", "PASS")` | fixed positions | unclear fields | document indexes |
| 6 | status/amount record | tuple | `("PASS", 125.5)` | mixed record fields | wrong order | unpack clearly |
| 7 | schema field positions | tuple | `("order_id", 0)` | fixed mapping | magic positions | document contract |
| 8 | empty file list | list | `[]` | no files received | no loop output | handle empty case |
| 9 | duplicate source label | list | `["orders", "orders"]` | duplicates possible | double count | validate if needed |
| 10 | first file | list index | `files[0]` | quick inspection | empty list | check length |
| 11 | last file | negative index | `files[-1]` | recent label concept | empty list | check length |
| 12 | first two files | slice | `files[:2]` | sample subset | stop misunderstood | remember exclusion |
| 13 | last two files | slice | `files[-2:]` | recent subset | short list | inspect output |
| 14 | append source | list | `.append("payments.csv")` | changing list | unintended mutation | mutate deliberately |
| 15 | copy before mutation | list copy | `files.copy()` | preserve original | shallow copy caveat | keep simple |
| 16 | unpack record | tuple | `order_id, status = record` | readable fields | count mismatch | match shape |
| 17 | list of tuples | list | records | sequence of records | inconsistent shape | use same positions |
| 18 | loop records | list/tuple | order tuples | repeated validation | wrong unpack order | document fields |
| 19 | count PASS | list | result list | validation summary | invalid values | use clear rules |
| 20 | sample subset | slice | `items[:3]` | debug sample | not validation | use carefully |
| 21 | negative index | sequence | `items[-1]` | last item | empty sequence | check length |
| 22 | out-of-range risk | index | `items[10]` | fixed access | error | know length |
| 23 | tuple too large | tuple | many fields | compact record | unreadable | use named structures later |
| 24 | homogeneous list | list | row counts | same meaning | mixed type | keep consistent |
| 25 | mixed tuple record | tuple | ID/status/amount | fixed record | unclear positions | document |
| 26 | mutation side effect | list | append inside function | useful sometimes | hidden change | state policy |
| 27 | immutability benefit | tuple | fixed row | less accidental change | contained mutable caveat | keep simple |
| 28 | nested sequence | list of tuples | records | record collection | nested indexing | unpack |
| 29 | scalar case | no sequence | `record_count = 100` | only one value | overcomplication | no collection needed |
| 30 | future migration | named structure | later topic | clearer complex records | not today | Day 056 continues |
