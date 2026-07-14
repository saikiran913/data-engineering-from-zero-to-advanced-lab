# Day 015 Glossary

| Term | Simple Meaning | Beginner Example |
| --- | --- | --- |
| Data Cleaning | Preparing messy data for use | Trim customer names |
| Raw Data | Original source data | CSV export values |
| Clean Data | Standardised data | `UK` instead of `U.K.` |
| Business-Ready Data | Data ready for reporting | Dashboard customer table |
| Raw Layer | Stored original data | Landing table |
| Clean Layer | Standardised data layer | Clean customer table |
| Business Layer | Reporting layer | Sales dashboard data |
| NULL | Missing database value | email is `NULL` |
| Blank String | Empty text value | `''` |
| Unknown Value | Readable replacement label | `Unknown` city |
| TRIM | Removes outer spaces | `TRIM(name)` |
| LOWER | Converts text lowercase | clean email |
| UPPER | Converts text uppercase | country code |
| COALESCE | Returns first non-NULL value | `COALESCE(city, 'Unknown')` |
| Alias | Output column name | `clean_email` |
| AS | Keyword for alias | `AS clean_email` |
| Clean Column | New cleaned output column | `clean_country` |
| Raw Column | Original source column | `country` |
| Standardisation | Making values consistent | active -> Active |
| Text Standardisation | Cleaning text labels | Email -> email |
| Country Standardisation | Mapping countries | U.K. -> UK |
| Status Standardisation | Mapping status labels | PAID -> Paid |
| Boolean Standardisation | Mapping true/false-like values | Y -> true |
| CASE | Conditional expression | Map dirty values |
| WHEN | Condition inside CASE | `WHEN value = 'uk'` |
| THEN | Result when condition matches | `THEN 'UK'` |
| ELSE | Fallback result | `ELSE 'Unknown'` |
| END | Closes CASE | `END AS clean_status` |
| Mapping Rule | Dirty-to-clean rule | U.S.A -> USA |
| Cleaning Rule | Logic used to clean data | Trim and lowercase |
| Dirty Value | Messy source value | ` active ` |
| Clean Value | Standard output value | `Active` |
| Data Quality Issue | Data problem | Missing status |
| Preserve Raw Data | Keep original data | Store raw CSV values |
| Reporting Output | Data used by dashboards | Clean customer list |
| ETL Cleaning | Clean before load | Transform before target |
| ELT Cleaning | Clean after load | SQL transform in warehouse |
