# Common Mistakes

| Mistake | What is wrong | Why it matters | Safer habit | Validation step |
|---|---|---|---|---|
| `SELECT *` by default | Every column is returned | Wide outputs are unclear | Select required columns | Compare column contract |
| Carrying unused columns | Intermediate steps stay wide | Later logic is harder to review | Prune columns | Review final required fields |
| Late filtering | Irrelevant rows move through later steps | Joins and sorts may do more work | Filter safely earlier | Compare counts and totals |
| Unsafe filter movement | Filter is moved across sensitive logic | Result may change | Preserve semantics | Compare old and new output |
| Unnecessary joins | Joined table adds no output or filter | Adds work and duplicate risk | Remove only after review | Confirm no hidden rule |
| Hidden join logic ignored | Join acts as eligibility rule | Removing it changes result | Document join purpose | Compare eligible counts |
| Join duplicates ignored | Duplicate keys multiply rows | Totals can inflate | Check key uniqueness | Use grouped duplicate checks |
| Many-to-many multiplication | Both sides repeat keys | Rows can grow unexpectedly | Define grain | Count rows before and after |
| DISTINCT used as repair | Duplicate cause is hidden | Bad joins remain | Fix grain or join | Compare business-key counts |
| Wrong pre-aggregation grain | Detail is lost too early | Output changes | Aggregate at required grain | Compare distinct keys |
| Unnecessary sort | Rows are ordered without need | Sorting can add work | Sort only with purpose | Confirm consumer contract |
| Sort before large filter | More rows are sorted than needed | Work increases conceptually | Filter first | Compare row counts before sort |
| Repeated aggregation | Same grouping appears repeatedly | Query is harder to maintain | Reuse clear CTE | Compare grouped totals |
| Repeated CASE | Same expression appears many times | Logic can drift | Derive once | Compare labels |
| Repeated subquery | Logic duplicated in branches | More complexity | Reuse a named step | Compare outputs |
| CTE assumed faster | Platform behaviour varies | Claim may be false | Use CTE for clarity | Inspect plan evidence |
| Shorter SQL assumed faster | Less text is not less work | Hidden scans or joins may remain | Review query shape | Compare plan signals |
| Rewrite without validation | Result may silently change | Business trust is damaged | Validate every rewrite | Counts, keys, totals |
| Row count only validation | Totals or keys may differ | False confidence | Use multiple checks | Compare totals and keys |
| Total only validation | Different rows can sum the same | Missing keys are hidden | Check keys too | Distinct key comparison |
| Changed date filter | Wrong period is reported | Business result changes | Use true business date | Min/max date check |
| Changed output grain | One row now means something else | Reports become misleading | Document grain | Grain comparison |
| Changed column contract | Consumer may break | Interface changed | Keep required columns | Column list review |
| Optimizer assumed universal | Platforms differ | Advice may not travel | Stay platform-aware | Validate locally |
| Small query over-optimised | Complexity increases for little benefit | Maintenance suffers | Leave simple queries alone | Confirm no problem |

