# Day 032 Glossary

| Term | Simple Meaning | Beginner Example |
|---|---|---|
| Accepted population | Rows allowed to move forward | Staged orders with `validation_status = 'ACCEPTED'` |
| Audit column | Column used for traceability | `source_file` or `received_at` |
| Auditability | Ability to trace where data came from | Knowing which file produced an order |
| Candidate grain | What one candidate row represents | One candidate row per `order_id` |
| Candidate record | A row selected for validation | Latest order event candidate |
| Checkpoint | A validation point between stages | Count rows after standardisation |
| Clean grain | What one clean row represents | One row per clean order |
| Clean handoff | Passing validated clean data onward | Clean orders passed to reporting |
| Country group | Reporting-friendly country category | `IN` becomes `India` |
| Current-state record | The selected latest record for an entity | Latest event for an order |
| Deduplication rule | Documented rule for choosing records | Latest `event_timestamp` wins |
| Handoff contract | Documentation for the next stage | Grain, key, rules, and audit fields |
| Input grain | What one input row represents | One raw event |
| Late-arriving record | A record received later than its event date | December event received in January |
| Mapping table | Reference table for standardising values | Raw status to standard status |
| Output grain | What one output row represents | One report row per date and country group |
| Reconciliation | Comparing stages for expected differences | Accepted plus review equals staged |
| Reporting grain | What one reporting row represents | One row per `report_date` and `country_group` |
| Review population | Rows needing investigation | Rows with null customer IDs |
| Review queue | List of rows or issues to investigate | Review rows with validation reasons |
| Source event | One received raw event | One row in `raw_customer_orders` |
| Source standardisation | Converting raw values into consistent values | `paid` becomes `COMPLETED` |
| Stage grain | What one staged row represents | One staged candidate per order |
| Staged candidate | Prepared row ready for validation | Ranked order event where `row_num = 1` |
| Standard status | Clean status value used downstream | `COMPLETED` |
| Status mapping | Rule for converting raw status | `cancelled` and `canceled` map to `CANCELLED` |
| Tie-breaker | Rule used when rows are equally ranked | Use latest `received_at` |
| Unresolved tie | Tie that cannot be safely resolved | Same order and same event timestamp |
| Validation flag | Decision column for a row | `ACCEPTED` or `REVIEW` |
| Validation reason | Explanation for the decision | `NULL_CUSTOMER_ID` |
