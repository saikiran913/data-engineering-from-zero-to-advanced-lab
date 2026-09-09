# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer approach | Validation step |
|---|---|---|---|---|
| Treating JSON as text only | Nested structure is ignored | Required paths may be missed | Define path contract | Check expected paths |
| Assuming same shape | Rows can vary | Extraction may fail | Validate by event type | Extraction summary |
| Vendor syntax assumed universal | Functions differ | SQL may not run elsewhere | Label syntax as platform-specific | Check platform docs |
| Missing key equals null | Different conditions | Wrong exception reason | Separate labels | Validation cases |
| Null equals blank | Different meaning | Data quality is blurred | Check separately | Null and blank counts |
| Numeric text assumed numeric | Text may not cast | Metrics can fail | Validate first | Invalid number cases |
| Unsafe cast | Query may fail | Pipeline may break | Use safe-cast concept | Review invalid values |
| Invalid date ignored | Reporting period breaks | Bad dates enter reports | Validate date text | Invalid date cases |
| Optional field treated as required | False exception | Noise increases | Mark optional paths | Expected path contract |
| Required field not event-specific | Wrong rule applied | Valid rows flagged | Use event type | Required path table |
| Array expanded without parent key | Lineage lost | Cannot reconcile | Preserve event ID | Parent-key check |
| Array index lost | Order may be unclear | Element traceability drops | Keep index where useful | Index min/max |
| Output grain undocumented | Rows are misunderstood | Counts look wrong | State grain | Parent/element counts |
| Row multiplication called duplication | Array expansion expected | False alarms | Reconcile elements | Count by parent |
| Empty array equals missing array | Different shape | Wrong issue type | Track separately | Element type review |
| Object treated as scalar | Wrong extraction | Data lost | Define expected type | Path type checks |
| Scalar treated as array | Expansion fails | Wrong grain | Validate array flag | Expected paths |
| Nested schema drift ignored | Payload changes silently | Downstream breaks | Version paths | Drift summary |
| Relational schema treated as nested schema | `payload_text` column hides changes | Drift missed | Validate nested paths | Schema version comparison |
| Renamed path assumed automatic | Old path may be missing | Lost customer ID | Review possible rename | Schema drift cases |
| Malformed payload mixed with validation | Parse issue is different | Bad triage | Separate payload errors | Malformed cases |
| No exception output | Issues are hard to investigate | Manual review slows | Build queue | Exception query |
| No path contract | Rules are unclear | Inconsistent validation | Document paths | Expected path table |
| Flattening everything | Grain changes unnecessarily | Row counts inflate | Flatten only when needed | Grain review |
| Duplicate array elements ignored | Repeated tags may matter | Counts can inflate | Check duplicates | Grouped tag counts |

