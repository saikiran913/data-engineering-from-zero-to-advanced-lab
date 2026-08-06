# Glossary

| Term | Simple Meaning |
|---|---|
| additive change | A change that adds something, such as a new column |
| aggregation impact | Effect caused by changing grouped calculations |
| breaking change | A change that may break or alter consumers |
| change impact | Possible effect of a proposed change |
| change log | Written record of what changed and why |
| column contract | Expected column names, meanings, types, and behaviour |
| consumer | Report, query, extract, application, or view using a view |
| consumer sensitivity | How strongly a consumer may be affected by change |
| dependency | Object or rule that a view relies on |
| dependency chain | Path from source objects through views to consumers |
| downstream consumer | Something that uses the view output |
| expected change | Difference that is planned and documented |
| filter impact | Effect caused by changing included or excluded rows |
| grain change | Change to what one output row represents |
| join impact | Effect caused by changing join logic |
| key uniqueness | Whether key columns identify one row as expected |
| null-behaviour change | Change in how null values appear or are handled |
| old-versus-new comparison | Query pattern that compares current and proposed logic |
| reconciliation | Comparing totals or counts between outputs |
| regression check | Check that expected behaviour remains stable |
| representative sample | Small set of rows inspected manually |
| reporting validation | Checks used before trusting reporting output |
| required column | Column a consumer depends on |
| review queue | List of records or checks needing review |
| row multiplication | Extra rows caused by joins or grain changes |
| schema change | Change to columns, types, or structure |
| source dependency | Source table, column, or view needed by logic |
| upstream dependency | Object or logic used before the view output |
| view interface | View treated as a shared reusable contract |
| view replacement | Replacing a view definition; behaviour varies by platform |
