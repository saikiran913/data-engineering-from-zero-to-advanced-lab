# Sample Tables for Day 041

Day 041 uses two business sample tables and four plan-analysis CSV files. The plan files are simplified educational metadata so beginners can practise reading plan ideas without depending on one SQL platform.

## Files

| File | Purpose | Grain | Key | Plan-analysis role |
|---|---|---|---|---|
| `orders_plan_sample.csv` | Example order data | One row per order | `order_id` | Filters, joins, sorts, aggregates |
| `customers_plan_sample.csv` | Example customer data | One row per customer | `customer_id` | Joins and customer filters |
| `query_plan_catalog.csv` | Simplified plan steps | One row per plan step | `plan_id`, `step_number` | Main plan-reading dataset |
| `plan_operator_catalog.csv` | Operator definitions | One row per operator | `operator_name` | Glossary-like operator reference |
| `plan_comparison_cases.csv` | Two-plan comparisons | One row per comparison case | `case_id` | Compare broad plan differences |
| `query_plan_casebook.csv` | Review scenarios | One row per scenario | `case_id` | Practice risk and review thinking |

## `orders_plan_sample.csv`

| Column | Meaning |
|---|---|
| `order_id` | Unique order identifier |
| `customer_id` | Customer connected to the order |
| `order_date` | Business order date |
| `order_status` | Low-cardinality status such as Delivered or Pending |
| `country_group` | Broad region group |
| `order_amount` | Order value |
| `source_file` | File lineage label |
| `loaded_at` | Load timestamp |

Questions to ask:

- Is the filter selective, such as one `order_id`, or broad, such as one common status?
- Would sorting all orders be more work than sorting a filtered set?
- Does a grouped report need to process many input rows before returning fewer rows?

## `customers_plan_sample.csv`

| Column | Meaning |
|---|---|
| `customer_id` | Unique customer identifier |
| `customer_status` | Customer state such as Active or Inactive |
| `country_group` | Broad region group |
| `signup_date` | Customer signup date |
| `customer_segment` | Customer segment |
| `loaded_at` | Load timestamp |

Questions to ask:

- Is this a small lookup table or a growing dimension table?
- Does joining to orders multiply rows?
- Are filters on status or segment broad or selective?

## Plan Metadata Files

| File | Columns | Questions learners should ask |
|---|---|---|
| `query_plan_catalog.csv` | `plan_id`, `query_name`, `step_number`, `parent_step`, `operator_name`, `table_name`, `estimated_rows`, `estimated_cost`, descriptions, notes | Which operators appear, where are rows filtered, and where do row counts grow? |
| `plan_operator_catalog.csv` | operator name, category, meaning, input, output, caution | What does this operator mean in plain language? |
| `plan_comparison_cases.csv` | plan A, plan B, differences, interpretation | Which plan difference matters most and what evidence is still needed? |
| `query_plan_casebook.csv` | business question, query pattern, operator, row band, cost band, risk, review | What should a beginner review before guessing? |

## Sample Data Design

| Design choice | Learning purpose |
|---|---|
| Repeated customers in orders | Shows join row multiplication |
| Low-cardinality statuses | Shows why some filters are broad |
| Repeated dates | Shows sorting and grouping patterns |
| Several country groups | Supports group summaries |
| Simplified plan steps | Keeps the lesson platform-neutral |
| Cost and row bands | Supports safe comparison without vendor detail |

