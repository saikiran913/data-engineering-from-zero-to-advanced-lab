# Common Mistakes With SQL Views

| # | Mistake | What Is Wrong | Why It Matters | Safer Approach | Validation Step |
|---|---|---|---|---|---|
| 1 | Using `SELECT *` | Output changes with source schema | Consumers can break | Select columns explicitly | Review exposed columns |
| 2 | Unclear view name | Purpose is hidden | Users may misuse it | Use descriptive names | Ask what question it answers |
| 3 | Undocumented grain | Row meaning is unclear | Counts may be wrong | Document output grain | Group by expected key |
| 4 | Duplicate column names | Output is confusing | Consumers may pick wrong field | Use stable aliases | Inspect selected columns |
| 5 | Unstable aliases | Names change often | Reports break | Agree business names | Review downstream use |
| 6 | Row multiplication | Joins create extra rows | Totals inflate | Validate join grain | Count rows per key |
| 7 | Wrong aggregation grain | Grouping is too broad or narrow | Metrics are wrong | Define output grain first | Reconcile totals |
| 8 | Assuming row order | View output order is not guaranteed | Reports appear inconsistent | Use `ORDER BY` outside view | Query with explicit order |
| 9 | Hiding quality issues | Bad rows disappear silently | Problems stay unresolved | Create review views | Count excluded rows |
| 10 | Dropping audit columns | Investigation becomes harder | Lineage is lost | Keep useful audit fields | Check audit availability |
| 11 | Exposing sensitive fields | Too much data is shared | Privacy risk increases | Exclude unnecessary fields | Column exposure review |
| 12 | Assuming views store data | Misunderstands standard view behaviour | Freshness expectations are wrong | Explain standard view logic | Compare with source changes |
| 13 | Assuming views are faster | Short SQL may still run complex logic | Performance surprises happen | Treat performance separately | Review platform guidance |
| 14 | Assuming security | Permissions vary | False confidence | Review platform rules | Security review |
| 15 | Deep view chains | Debugging becomes difficult | Dependencies are hidden | Keep chains shallow | Dependency list |
| 16 | No total validation | Metrics may not reconcile | Reporting trust drops | Compare source and view totals | SUM checks |
| 17 | No uniqueness validation | Duplicate keys remain | Reports multiply rows | Check expected keys | GROUP BY and HAVING |
| 18 | Not checking dependencies | Upstream changes break views | Consumers fail | Document source objects | Dependency review |
| 19 | Changing meanings silently | Same column means different thing | Users lose trust | Version or document changes | Consumer review |
| 20 | Platform-specific syntax | Portability suffers | Learners get confused | Add platform notes | Syntax review |
| 21 | Existing name conflict | Object may already exist | Creation can fail | Check names first | Object-name review |
| 22 | Unsafe replacement assumption | Existing view may be changed | Consumers may break | Use controlled change process | Impact review |
