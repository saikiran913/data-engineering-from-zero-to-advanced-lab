# Common Mistakes

| # | Mistake | What is wrong | Why it matters | Safer approach |
|---|---|---|---|---|
| 1 | forgetting parentheses | function not called | no work happens | use `function_name()` |
| 2 | defining but never calling | only definition exists | no output/result | call the function |
| 3 | missing colon after `def` | invalid syntax | script fails | add `:` |
| 4 | bad indentation | body unclear | syntax error | use four spaces |
| 5 | vague function name | meaning hidden | hard to reuse | use business names |
| 6 | vague parameter name | input unclear | confusing interface | use descriptive names |
| 7 | too many responsibilities | function does too much | hard to review | one focused job |
| 8 | print instead of return | result not reusable | caller gets `None` | return the value |
| 9 | returned value ignored | output lost | no reuse | assign result |
| 10 | missing return branch | returns `None` | inconsistent output | return from all paths |
| 11 | inconsistent return types | caller surprised | fragile logic | return one kind of value |
| 12 | local variable expected outside | scope misunderstanding | `NameError` | return value |
| 13 | hidden global dependency | input not visible | hard to test | pass parameter |
| 14 | modifying global state | external change | unpredictable | return new value |
| 15 | shadowing misunderstood | local name hides outer | surprising output | choose clear names |
| 16 | parameter order wrong | values swapped | bad calculation | use keyword args |
| 17 | keyword name wrong | unexpected keyword | `TypeError` | match parameter name |
| 18 | too many parameters | hard interface | difficult review | split function |
| 19 | default misunderstood | omitted value used | wrong threshold | document default |
| 20 | mutable default caution | advanced risk | surprising reuse later | use simple defaults today |
| 21 | copied business rule | duplication | inconsistent updates | make reusable function |
| 22 | wrong input to function | type/meaning mismatch | wrong result | validate call |
| 23 | transformation prints | side effect | result not reusable | return transformed value |
| 24 | validation mutates input | hidden change | source meaning lost | return outcome |
| 25 | validate name transforms silently | misleading interface | caller surprised | name honestly |
| 26 | unexpected `None` | no return | broken workflow | inspect return paths |
| 27 | caller assumes non-None | missing not handled | later error | check result |
| 28 | missing-value rule undocumented | unclear contract | inconsistent handling | document rule |
| 29 | unclear signature | inputs unknown | hard to call | use clear parameters |
| 30 | no docstring | reusable rule unexplained | weak documentation | add short docstring |
| 31 | one giant function | hard to test | hard to debug | split steps |
| 32 | advanced feature used | too much too soon | distracts learner | keep simple |
| 33 | `global` keyword shortcut | hidden mutation | fragile code | pass and return |
| 34 | side effects mixed with calculation | hard to reuse | unpredictable | separate orchestration |
| 35 | external package added | unnecessary dependency | setup burden | standard library only |
