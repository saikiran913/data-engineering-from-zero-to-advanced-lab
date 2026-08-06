# Glossary

| Term | Simple Meaning |
|---|---|
| `CREATE VIEW` | SQL command that defines a named view |
| `SELECT *` | Selects all columns; risky in reusable views |
| aggregate view | A view that returns grouped summary rows |
| audit column | A column used for investigation, such as `updated_at` |
| base table | A source table used by a view |
| business rule | Agreed logic behind filters or calculations |
| clean interface | A view with intentional, understandable columns |
| consumer | Person, report, or query that uses a view |
| CTE | Temporary named query block for one statement |
| dependency | Object or column a view relies on |
| derived column | A calculated or renamed column |
| exposed column | Column returned by a view |
| materialized view | View-like object that may store results physically |
| named query | Query saved under a name |
| output grain | What one result row represents |
| permanent table | Database object that stores rows |
| reporting layer | Clean set of views for reports |
| reusable query | Query logic that can be referenced again |
| schema change | Change to table or column structure |
| schema stability | Keeping columns and meanings reliable |
| security caution | Reminder that permissions vary by platform |
| source grain | What one source row represents |
| standard view | View that usually stores query logic, not copied rows |
| subquery | Query embedded inside another query |
| validation query | Query used to check view correctness |
| view | Named reusable query definition |
| view definition | SQL logic saved behind a view name |
| view dependency | Source object or column needed by a view |
| view-on-view chain | A view built on another view |
