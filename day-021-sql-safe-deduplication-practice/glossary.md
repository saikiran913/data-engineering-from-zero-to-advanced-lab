# Glossary

| Term | Meaning |
| --- | --- |
| audit column | Column used to explain source or timing, such as `source_file` |
| business key | Column or columns defining one logical record |
| clean layer | Data layer where documented rules are applied |
| composite key | Business key made from multiple columns |
| CTE | Named query block created with `WITH` |
| deduplication | Selecting intended records from duplicate groups |
| deterministic result | Same input and rule produce the same selected row |
| duplicate group | Records sharing the same business key |
| earliest record | Record selected by oldest ordering value |
| ingestion time | Time data was loaded or received |
| latest record | Record selected by newest ordering value |
| ordering rule | Rule deciding row order inside a group |
| partition | Group used by a window function |
| preferred status | Status given priority by a business rule |
| raw layer | Preserved source history |
| record version | One version of a repeated business key |
| review flag | Label showing a record needs review |
| row number | Sequence number assigned by `ROW_NUMBER` |
| source file | File where a record came from |
| tie | Two records with the same ordering value |
| tie-breaker | Extra column used to break a tie |
| timestamp | Date and time value |
| window function | Function that looks across related rows without collapsing them |
