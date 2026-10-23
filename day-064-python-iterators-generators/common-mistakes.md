# Common Mistakes

| # | Problem | Why it matters | Safer approach |
|---|---|---|---|
| 1 | Assuming generator is a list | No indexing or stored full output | Iterate or materialise deliberately |
| 2 | Indexing a generator | Raises `TypeError` | Use a list for random access |
| 3 | Calling `len(generator)` | Length is not directly available | Count while consuming |
| 4 | Expecting reuse after exhaustion | Second pass is empty | Recreate generator |
| 5 | Calling `next()` after exhaustion | Raises `StopIteration` | Handle it or use a loop |
| 6 | Calling `list()` accidentally | Materialises all remaining values | Consume incrementally when possible |
| 7 | Debugging by materialising a live generator | Later consumer sees nothing | Recreate after inspection |
| 8 | Printing the generator object | Shows its representation, not records | Iterate over values |
| 9 | Writing a generator function without `yield` | It is an ordinary function | Add `yield` when sequence is intended |
| 10 | Using `return` for multiple records | Only one result is returned | Yield records one at a time |
| 11 | Using an unbounded generator in a script | Run may never finish | Set a small explicit limit |
| 12 | Treating generator expression as a tuple | Output behaviour is misunderstood | Recognise `(expr for item in items)` |
| 13 | Assuming parentheses always mean a tuple | Generator expression is lazy | Inspect the `for` clause |
| 14 | Claiming zero memory use with a list source | Source list remains allocated | Describe whole source-to-consumer flow |
| 15 | Sorting a generator without noting collection | `sorted()` builds a list | Budget for full ordering |
| 16 | Expecting two passes over one generator | First pass exhausts it | Recreate or use a list |
| 17 | Sharing one iterator between consumers | Each steals values from the other | Give each a fresh source |
| 18 | Hiding side effects inside a generator | Timing of effects is surprising | Keep stages focused and pure where possible |
| 19 | Mutating raw records during yielding | Source evidence changes | Yield new dictionaries |
| 20 | Expecting an error at generator creation | Body runs later | Test consumption path |
| 21 | Assuming validation happened before iteration | Lazy validation has not run yet | Consume and count results |
| 22 | Building a very long generator chain | Debugging is difficult | Use a few named stages |
| 23 | Hiding complex business rules in one `yield` | Decisions are hard to review | Use a named classifier |
| 24 | Yielding one mutable object repeatedly | Earlier outputs may change | Create a new record per yield |
| 25 | Using a generator when indexing is needed | Cannot select by position directly | Materialise a list |
| 26 | Using a generator for repeated reuse | One-pass state is awkward | Use a list or source factory |
| 27 | Converting to list before the pipeline | Loses incremental benefit | Defer collection until required |
| 28 | Converting to list after every stage | Creates full intermediates | Chain stages directly |
| 29 | Exaggerating memory savings | Source and consumer may materialise | Evaluate whole workflow |
| 30 | Adding a streaming framework for a basic example | Unnecessary complexity | Use standard Python generators |
| 31 | Implementing a custom iterator class too early | Distracts from concepts | Use `iter()` and `yield` |
| 32 | Introducing async generators needlessly | Adds unrelated control flow | Learn synchronous generators first |
| 33 | Never testing an empty source | Edge behaviour is unknown | Run each stage on empty input |
| 34 | Not handling a malformed record | Error emerges late | Validate fields in a focused stage |
| 35 | Consuming a generator in a condition or debug helper | Downstream misses values | Avoid hidden consumption |
| 36 | Expecting automatic restart | Exhaustion is permanent for that iterator | Recreate from source |
| 37 | Assuming `next()` peeks | It advances state | Store returned item if needed |
| 38 | Reusing `iter(generator)` to restart | It returns the same generator | Call the generator function again |
