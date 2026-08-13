# Day 035 Glossary

| Term | Simple Meaning | Beginner Example |
|---|---|---|
| Actual population | Data that actually exists | rows in `clean_customer_orders` |
| Actual value | Value found in data | actual report date |
| Blank value | Empty text value | `country_group = ''` |
| Business key | Field identifying a business record | `order_id` |
| Category completeness | Expected categories are present | country groups exist |
| Completeness | Expected data is present | expected orders exist |
| Completeness exception | Gap needing review | missing clean order |
| Completeness percentage | Coverage as a percent | matched / expected * 100 |
| Completeness summary | Compact result of checks | `PASS` or `REVIEW` |
| Coverage percentage | Percent of expected data found | 80 percent dates present |
| Date coverage | Expected dates are present | report date exists |
| Expected category | Category that should exist | `India` |
| Expected date | Date that should exist | `2026-04-03` |
| Expected exclusion | Valid missing record by rule | review row excluded |
| Expected file | File that should arrive | daily source file |
| Expected population | Data that should exist | expected clean orders |
| Expected record | Specific expected row or key | expected `ORD4021` |
| Expected value | Value listed as required | expected status |
| Field completeness | Required fields are populated | no null customer IDs |
| File completeness | Expected files arrived | no missing source file |
| Key completeness | Expected keys are present | expected order IDs in clean |
| Missing key | Expected key not found | missing order ID |
| Missing record | Expected row not found | missing date group |
| Null coverage | Review of null values | null metric count |
| Optional field | Field allowed to be missing | optional comment field |
| Record completeness | Expected records exist | all accepted orders reached clean |
| Required field | Field that must be populated | `order_id` |
| Requiredness | Whether a field is required | customer ID required in clean |
| Source-file coverage | Expected source files present | daily files arrived |
| Stage completeness | Records present across stages | accepted-to-clean coverage |
| Status coverage | Expected statuses present | `COMPLETED`, `PENDING` |
| Unexpected record | Extra record not expected | clean-only order |
| Unexplained gap | Missing data with no documented reason | accepted order missing |
