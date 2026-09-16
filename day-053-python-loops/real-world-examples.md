# Real-World Examples

| # | Scenario | Iterable/input | Loop type | Validation/action | Result | Caution |
|---|---|---|---|---|---|---|
| 1 | review source files | file-name list | `for` | print each label | reviewed labels | no filesystem scan |
| 2 | count PASS | result list | `for` | increment pass counter | pass total | initialize first |
| 3 | count REVIEW | result list | `for` | increment review counter | review total | correct branch |
| 4 | count FAIL | result list | `for` | increment fail counter | fail total | full scan needed |
| 5 | total row counts | row-count list | `for` | accumulate total | final rows | handle `None` |
| 6 | zero-row source | row counts | `for` | classify zero | FAIL | zero differs from missing |
| 7 | first critical failure | outcomes | `for` | `break` on FAIL | fail-fast | later items skipped |
| 8 | excluded source | statuses | `for` | `continue` on SKIP | skipped item | explain skip |
| 9 | table names | table labels | `for` | print names | checklist | hard-coded only |
| 10 | partition labels | month labels | `for` | review each | coverage check | ordering can matter |
| 11 | allowed statuses | statuses | `for` | membership check | allowed/review | case matters |
| 12 | null rates | percentages | `for` | threshold classify | review flags | test boundaries |
| 13 | error counts | counts | `for` | summarize | total errors | use accumulator |
| 14 | bounded retry | attempt counter | `while` | repeat three times | safe retry model | no network calls |
| 15 | batch numbering | `range()` | `for` | print numbers | batches labeled | stop excluded |
| 16 | file positions | `enumerate()` | `for` | number labels | readable list | optional concept |
| 17 | files x checks | two iterables | nested `for` | print pairs | cross-checks | work multiplies |
| 18 | work growth | counts | nested concept | estimate iterations | 100 x 100 | avoid surprise |
| 19 | while counter | counter | `while` | bounded loop | three attempts | update counter |
| 20 | missing termination | condition | `while` | no update | stuck script | do not execute |
| 21 | type mismatch | mixed values | `for` | compare carefully | possible error | use Day 051 checks |
| 22 | empty iterable | `[]` | `for` | no body run | no output | normal behaviour |
| 23 | one-item iterable | one file | `for` | one review | one output | still valid |
| 24 | no-fail scan | outcomes | `for` | count all | full summary | no break |
| 25 | fail-fast vs collect-all | outcomes | `for` | break or continue scan | different results | choose deliberately |
| 26 | hard-coded labels | file names | `for` | learning review | safe example | real traversal later |
| 27 | validation stages | stage labels | `for` | print progress | stage log | clear names |
| 28 | no-loop-needed case | one value | none | direct condition | simpler code | avoid unnecessary loop |
