# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Set Operation | SQL operation that combines query results | `UNION ALL` |
| UNION | Combines rows and removes exact duplicates | UK plus India unique rows |
| UNION ALL | Combines rows and keeps every row | Raw file stacking |
| Vertical Combination | Adding rows below rows | Monthly files stacked |
| Row Stacking | Another name for vertical combination | January rows above February rows |
| Combined Dataset | Output after combining sources | Global orders |
| Source Dataset | Original input table or file | `uk_orders` |
| Source Label | Constant value showing origin | `UK` |
| Source Region | Region origin label | `India` |
| Source File | File origin label | `january_orders.csv` |
| Source Month | File or load month label | `January` |
| Source Channel | Channel origin label | `Search` |
| Exact Duplicate | All selected values match | Same event row twice |
| Repeated Key | Same ID appears more than once | Same `event_id` |
| Business Key | Identifier meaningful to business | `order_id` |
| Column Count | Number of selected columns | Seven order columns |
| Column Order | Position of selected columns | ID then date then amount |
| Compatible Data Type | Values can stack safely | Amount under amount |
| Output Schema | Columns returned by query | Combined order columns |
| Schema Alignment | Making schemas match | Alias `amount AS order_amount` |
| Schema Compatibility | Schemas can be combined safely | Same columns and types |
| NULL Placeholder | Blank placeholder column | `NULL AS revenue` |
| Alias | Output name for a column | `AS source_file` |
| First SELECT | First query in a UNION chain | Controls output names |
| Final Output Column Name | Column name in combined result | First alias wins |
| Data Lineage | Where data came from | Source file label |
| Source Traceability | Ability to trace origin | Region label |
| Regional Dataset | Dataset for one region | UK orders |
| Monthly File | File for one month | February orders |
| Historical Dataset | Older data source | Archive orders |
| Current Dataset | Current active source | Current orders |
| Late-Arriving Record | Event appears in a later file | January order in February file |
| Grain | Level of detail | One row per order |
| Row Count Validation | Checking expected row totals | 15 + 15 = 30 |
| UNION vs JOIN | Rows vs columns | Stack files vs connect tables |
