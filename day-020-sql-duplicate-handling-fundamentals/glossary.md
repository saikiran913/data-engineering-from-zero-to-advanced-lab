# Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Duplicate | Appears more than expected | Same order row twice |
| Exact Duplicate | All selected values match | Same full event row |
| Duplicate Row | Repeated row values | File loaded twice |
| Duplicate Business Key | Key appears more than expected | Same `order_id` twice |
| Repeated Value | Any value appearing again | Same country many times |
| Normal Repetition | Expected repeated value | Customer with many orders |
| Suspicious Repetition | Repetition needing review | Same transaction ID twice |
| DISTINCT | Returns unique output rows | Unique countries |
| Unique Value | Value shown once | `UK` |
| Unique Combination | Combination shown once | Status + payment status |
| GROUP BY | Groups rows by columns | Count by order_id |
| HAVING | Filters grouped results | Count greater than 1 |
| COUNT | Counts rows | Total rows per key |
| Business Key | Business identifier | `order_id` |
| Technical Key | System/table identifier | `contact_id` |
| Composite Key | Key made from multiple columns | campaign + date + country |
| Grain | What one row represents | One row per event |
| Table Grain | Table-level row meaning | One row per payment |
| Row Grain | Row-level meaning | One row per order |
| Source File | File row came from | `orders_retry.csv` |
| Retry File | Reloaded file | Retry load source |
| Late-Arriving Correction | Correction arriving later | Updated order status |
| Duplicate Investigation | Process to inspect repeats | Check repeated order IDs |
| Safe Deduplication | Removing only with rules | Keep latest approved record |
| Deduplication Rule | Business rule for duplicates | Keep paid transaction |
| Keep Rule | Which row to retain | Keep latest update |
| Quarantine | Hold suspicious records aside | Review duplicate rows |
| Flag for Review | Mark suspicious rows | Needs investigation |
| Raw Layer | Original loaded data | Preserve source rows |
| Clean Layer | Standardised data | Cleaned statuses |
| Business Layer | Reporting-ready data | Deduped dashboard table |
| Exact Duplicate Removal | Removing identical rows | `DISTINCT` output |
| Key-Based Deduplication | Dedup by business key | One row per order_id |
| One-to-Many Relationship | One record relates to many | Customer has many orders |
| Source Traceability | Knowing row origin | `source_file` |
