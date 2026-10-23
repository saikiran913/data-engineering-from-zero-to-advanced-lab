# Common Mistakes

| # | Problem | Consequence | Safer approach |
|---|---|---|---|
| 1 | Assuming annotations validate runtime input | Bad values reach comparisons | Parse and validate explicitly |
| 2 | Hint says `str` but branch returns `None` | Contract misleads callers | Use `str | None` or change behaviour |
| 3 | Optional result hint omits `None` | Missing case is invisible | Annotate `float | None` |
| 4 | Treating `str | None` as safe string | `.strip()` may fail | Check `None` first |
| 5 | Annotating everything as `Any` | Type information is lost | Use specific simple hints |
| 6 | Complex nested hints for a tiny helper | Signature is hard to read | Keep shape shallow or name it |
| 7 | List element hint disagrees with values | Static guidance becomes unreliable | Correct element type or values |
| 8 | Comparing string amount with a number | `TypeError` or wrong logic | Convert raw text first |
| 9 | Assuming `TypedDict` checks runtime keys | Missing key still raises `KeyError` | Check required fields |
| 10 | Assuming dataclass hints validate business rules | Invalid record can be constructed | Add explicit rule checks |
| 11 | Docstring describes old behaviour | Reviewers trust a false contract | Update it with code |
| 12 | Docstring repeats syntax only | Purpose remains unclear | Explain meaning and constraints |
| 13 | Failure behaviour omitted | Caller cannot handle invalid input | Document `None` or exception |
| 14 | Side effects omitted | Print/write surprises caller | State side effects |
| 15 | Comment every obvious assignment | Important comments disappear in noise | Comment only why |
| 16 | Unusual business rule lacks explanation | Future change may break it | Add a brief rationale |
| 17 | Vague names like `x` or `f` | Meaning is hard to follow | Use `raw_amount`, `status` |
| 18 | Literal threshold scattered in code | Rule drifts between functions | Name or pass the threshold |
| 19 | `OK`, `PASS`, and `VALID` mixed | Reports become inconsistent | Choose one status vocabulary |
| 20 | Tuple on one branch, string on another | Callers cannot unpack safely | Use one return shape |
| 21 | Printing where caller needs a result | Logic cannot be reused | Return value; print in entry point |
| 22 | Validator reads hidden global config | Dependency is invisible | Pass allowed values and threshold |
| 23 | Cleaning changes raw dictionary | Source evidence is lost | Return a new record |
| 24 | One very long function | Tests and review are difficult | Split focused stages |
| 25 | Mixing parsing, validation, I/O, and display | Failures are hard to isolate | Separate responsibilities |
| 26 | Catching every exception | Programming bugs are hidden | Catch expected exceptions only |
| 27 | Duplicating validation rules | Results drift | Reuse one helper |
| 28 | Class for one-line stateless cleanup | More code without benefit | Use a function |
| 29 | Workflow executes during import | Reuse causes surprises | Use a `main()` guard |
| 30 | Installing typing tools for this beginner lesson | Unneeded setup work | Use standard-library examples |
