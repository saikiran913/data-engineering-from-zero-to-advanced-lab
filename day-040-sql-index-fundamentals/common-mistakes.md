# Common Index Selection Mistakes

| # | Mistake | What is wrong | Why it matters | Evidence to review |
|---|---|---|---|---|
| 1 | Indexing every column | Assumes all indexes help | Write and storage cost grows | Workload catalog |
| 2 | Indexing every `WHERE` column | Filter use alone is not enough | Weak candidates multiply | Frequency and selectivity |
| 3 | No workload analysis | Candidate is guessed | May optimise wrong query | Important query list |
| 4 | No selectivity analysis | Narrowness is unknown | Low-value candidates appear | Distinct counts |
| 5 | No read/write analysis | Write cost ignored | Ingestion slows conceptually | Trade-off cases |
| 6 | Low-cardinality column automatically indexed | Few values may not narrow much | Benefit can be limited | Status/cardinality profile |
| 7 | Small table over-indexed | Scan may be cheap | Complexity without benefit | Table size |
| 8 | Rare query over-optimised | One-off query drives design | Permanent overhead may be unjustified | Frequency band |
| 9 | Duplicate index concept | Same pattern repeated | Wasted storage and maintenance | Existing index review in real systems |
| 10 | Overlapping indexes | Similar composites pile up | Complexity increases | Candidate overlap |
| 11 | Composite order ignored | Column order matters | Candidate may not match workload | Query filter order |
| 12 | Join column automatically indexed | Join use is only one signal | Poor candidates can remain | Join frequency and table size |
| 13 | Sort column automatically indexed | Sort benefit is not guaranteed | Platform behaviour varies | Query plans later |
| 14 | Index assumed always used | Optimizer decides access path | False confidence | Platform evidence |
| 15 | Optimizer behaviour assumed universal | Platforms differ | Tuning advice may be wrong | Platform docs later |
| 16 | Warehouse treated like OLTP database | Warehouses may use other mechanisms | Wrong design approach | Warehouse review |
| 17 | Primary key/index behaviour assumed universal | Implementations vary | Bad portability | Platform behaviour |
| 18 | Storage overhead ignored | Indexes take space | Cost grows | Storage estimate later |
| 19 | Write cost ignored | Indexes require maintenance | Write-heavy tables suffer | Write frequency |
| 20 | Index as substitute for good SQL | Bad queries remain bad | Root cause remains | Query design |
| 21 | No platform evidence | Real behaviour untested | Candidate may fail | Query plans later |
| 22 | DDL left executable | Learners may change databases | Unsafe lesson | Commented DDL only |
| 23 | Query plan claims without plan evidence | Claims are unsupported | Misleading guidance | Actual plan review later |
| 24 | One slow query drives permanent design | Narrow evidence | Overfitting | Workload review |
| 25 | Candidate score treated as real formula | Educational rating is simplified | False certainty | Platform testing |

