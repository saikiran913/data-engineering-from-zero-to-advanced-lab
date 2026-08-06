# Glossary

| Term | Simple Meaning |
|---|---|
| accepted record | Row that meets documented rules |
| audit column | Column used for investigation, such as `source_file` |
| auditability | Ability to trace and investigate data |
| business key | Column or columns used to identify business rows |
| checkpoint | Validation point between stages |
| clean layer | Layer of accepted and standardised data |
| clean output | Data ready for clean-layer handoff |
| CTE stage | Named query step inside one statement |
| downstream consumer | Next process, report, or query using the output |
| handoff | Passing output from one stage to another |
| input grain | What one input row represents |
| intermediate result | Data produced between source and final output |
| lineage | Trace of where data came from |
| output grain | What one output row represents |
| persistent stage | Stored intermediate stage concept |
| pipeline stage | Step in a data pipeline |
| quarantine concept | Keeping suspicious rows separate for review |
| raw layer | Source-aligned data layer |
| reconciliation | Comparing counts or totals between stages |
| reporting layer | Consumer-ready summary layer |
| review queue | List of rows requiring investigation |
| review record | Row that needs investigation |
| source count | Count of input rows |
| stage count | Count of intermediate-stage rows |
| stage owner | Role responsible for a stage |
| staging layer | Controlled preparation layer |
| staging table | Persistent intermediate table concept |
| temporary result | Short-lived intermediate result |
| temporary table concept | Platform-specific short-lived table idea |
| validation checkpoint | Check used before handoff |
| validation reason | Explanation for accepted or review status |
