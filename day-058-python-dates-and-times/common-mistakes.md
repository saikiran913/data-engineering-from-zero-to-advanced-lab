# Common Mistakes

| Mistake | Why it matters | Safer approach |
| --- | --- | --- |
| Compare timestamp strings | Text lacks time semantics | Parse first |
| Wrong `strptime` format | Parsing fails | Match contract |
| Month/day swapped | Wrong date | Prefer year-month-day |
| Ambiguous date | Readers disagree | Use explicit format |
| Impossible date | Invalid input | Validate source |
| `%m` for minute | It means month | Use `%M` |
| Wrong `%H` use | Clock is wrong | Use 00–23 hour |
| Arithmetic before parsing | Text has no duration | Parse first |
| Expect `strftime` datetime | It returns text | Use for output |
| Expect `strptime` string | It returns datetime | Format separately |
| Assume naive means UTC | Meaning unstated | Document contract |
| Assume local means UTC | Instant shifts | Use explicit zone |
| Mix naive and aware | Comparison fails | Make values compatible |
| Attach unknown timezone | Invents meaning | Confirm source |
| Fixed offset as zone rule | DST changes offset | Use ZoneInfo |
| Ignore DST | Local time is wrong | Use regional zone rules |
| Implicit local timezone | Environment varies | State zone |
| Freshness zone mismatch | Age is misleading | Normalise first |
| Date with datetime | Granularity differs | Compare like types |
| Boundary unclear | Inclusion varies | Document rule |
| Adjacent windows overlap | Duplicates occur | Exclusive end |
| Adjacent windows gap | Data is missed | Align end/start |
| Compare `None` | Raises error | Check missing first |
| Ignore future value | Negative age hidden | Flag review |
| Event equals processing | Latency lost | Keep both |
| Partition basis unstated | Meaning unclear | Document event/processing basis |
| Thirty days is month | Calendar varies | Treat as duration |
| Dynamic current test | Output changes | Use fixed fixture |
| `now()` no timezone | Contract unclear | Use UTC if appropriate |
| Show UTC as local | Clock is misread | Convert for display |
| Store local time alone | Instant ambiguous | Store zone/offset |
| Ignore offset suffix | Instant changes | Parse/document it |
| Overwrite raw timestamp | Traceability lost | Keep raw and parsed |
| Silent precision change | Ordering changes | Document precision |
| Zone typo | Conversion fails | Use valid IANA name |
| Add third-party package | Not needed | Use standard library |
| Introduce pandas | Scope expands | Use datetime |
| Timezone contract absent | Rules cannot repeat | Write one |
| Dynamic time for fixture | Test unstable | Use fixed time |
| Assume ISO-like universal | Input varies | Define exact format |
