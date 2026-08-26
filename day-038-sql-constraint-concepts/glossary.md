# Day 038 Glossary

| Term | Simple meaning | Beginner example |
|---|---|---|
| Allowed value | A value permitted by a rule | `COMPLETED` order status |
| Allowed-value rule | Rule limiting values to a known list | status in allowed list |
| Business key | Key with business meaning | `customer_id` |
| Candidate key | Column that could identify rows | `order_id` |
| Check constraint | Rule for allowed values or conditions | amount >= 0 |
| Child key | Column in child table referencing parent | orders.customer_id |
| Child table | Table that references another table | orders |
| Composite grain | Grain identified by multiple fields | order plus line number |
| Composite key | Key made from multiple columns | order_id + line_number |
| Constraint | Rule data is expected to follow | order_id unique |
| Constraint exception | Review row for a rule violation | orphan payment exception |
| Constraint violation | Data that breaks a rule | duplicate order_id |
| Documented constraint | Rule recorded but validated separately | contract says product_code unique |
| Enforced constraint | Database actively checks a rule | platform-enforced primary key |
| Foreign key | Child value referencing parent value | payment order_id |
| Foreign-key-like validation | Query that checks child-parent matches | left join orphan check |
| Key | Column used for identity or relationship | customer_id |
| Natural key | Business key from real-world meaning | product_code |
| Not null | Field must contain a value | order_date required |
| Orphan record | Child row with no matching parent | order customer not found |
| Parent key | Key in referenced table | customers.customer_id |
| Parent table | Referenced table | customers |
| Primary key | Row identity rule | one customer_id per customer |
| Primary-key-like validation | Read-only check for key uniqueness and nulls | count distinct and duplicate check |
| Range rule | Rule for numeric or date boundary | unit_price > 0 |
| Referential integrity | Parent-child keys stay consistent | payment references existing order |
| Required field | Field that must be present | payment_amount |
| Surrogate key | Internal identifier conceptually | generated customer row ID |
| Unique constraint | Rule that values should not duplicate | product_code unique |
| Uniqueness | No repeated value for the rule | one payment_id per payment |
| Validation rule | Documented check run with SQL | unsupported status check |

