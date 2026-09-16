# Common Mistakes

| Mistake | Why it matters | Safer approach |
| --- | --- | --- |
| Indexing a dictionary | Dictionaries use keys | Use `record["key"]` |
| Misspelled key | Causes missing lookup or `KeyError` | Use consistent snake_case names |
| Direct access to optional key | May raise `KeyError` | Use intentional `.get()` |
| `.get()` for required data | Can hide a contract failure | Validate or access directly |
| Missing key confused with `None` | Different business states | Check membership and value |
| Default hides quality issue | Unknown data becomes plausible | Use defaults only intentionally |
| Duplicate dictionary key | Earlier value is overwritten | Validate literals and contracts |
| `in` assumed to check values | It checks keys | Use `.values()` deliberately |
| Keys and values confused | Wrong validation target | Name loop variables clearly |
| `.items()` unpacked incorrectly | Breaks iteration | Use `for key, value in ...` |
| Unexpected mutation | Original record changes | Copy or document side effects |
| No copy before mutation | Shared object is changed | Use `.copy()` for shallow copies |
| Resize during iteration | Can raise an error | Change after the loop |
| Relying on dictionary order | Semantics become fragile | Use explicit keys |
| `{}` for empty set | Creates a dictionary | Use `set()` |
| Indexing a set | Sets are not positional | Use membership |
| Relying on set order | Output order is not a contract | Sort later only when needed |
| List to set when duplicates matter | Frequency is lost | Keep the list |
| List to set when order matters | Sequence is lost | Keep the list |
| Mixed set types | Membership may fail unexpectedly | Standardise values |
| Using `remove()` casually | Missing value raises `KeyError` | Prefer `discard()` when appropriate |
| Reversed difference | Missing fields are reversed | Read `expected - observed` |
| Union/intersection confusion | Wrong schema result | Test a small example |
| Nested key assumed present | Lookup can fail | Check level by level |
| Deep lookup chain | Hard to diagnose | Use intermediate variables |
| Inconsistent nested shape | Records process unevenly | Document a shape contract |
| Inconsistent keys in records | Fields cannot be trusted | Validate required keys |
| Optional key undocumented | Consumers guess meaning | State optional fields |
| Required contract undefined | Failures appear late | Define expected keys |
| Extra key treated as error | Useful new data may be rejected | Investigate context |
| Tuple used for named data | Position is unclear | Use a dictionary |
| Dictionary used for simple ordered list | Adds unnecessary names | Use a list |
| Set used when frequency matters | Counts disappear | Keep sequence or count later |
| External package added | Not needed for basics | Use built-in collections |
| Nested data undocumented | Readers cannot navigate it | Write a small shape example |
| Blind conversion between collections | Meaning can change | Choose based on business need |
