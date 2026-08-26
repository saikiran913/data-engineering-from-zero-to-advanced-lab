# Sample Tables for Day 038

Day 038 uses four business-style CSV files plus two rule/catalog files.

| File | Purpose | Grain | Candidate key | Relationship role | Known validation issues |
|---|---|---|---|---|---|
| `customers.csv` | Customer parent data | One row per customer | `customer_id` | Parent of orders | duplicate ID, null ID, optional country null, unsupported status |
| `orders.csv` | Order child data | One row per order | `order_id` | Child of customers, parent of payments | duplicate ID, null ID, null customer, orphan customer, negative amount, unsupported status |
| `payments.csv` | Payment child data | One row per payment | `payment_id` | Child of orders | duplicate ID, null ID, orphan order, null amount, negative amount, unsupported status |
| `products.csv` | Product reference data | One row per product | `product_id` | Reference data | duplicate product code, null code, zero price, negative price, unsupported status |
| `constraint_rules.csv` | Documented validation rules | One row per rule | `rule_id` | Rule catalog | covers primary key, foreign key, unique, check, and not-null concepts |
| `constraint_casebook.csv` | Design scenarios | One row per case | `case_id` | Learning catalog | covers validation-only and no-constraint-needed cases |

## Table Details

| Table | Columns | Useful checks |
|---|---|---|
| `customers` | `customer_id`, `customer_name`, `country`, `customer_status`, `signup_date`, `source_file`, `loaded_at` | primary-key-like checks, status check, null customer ID |
| `orders` | `order_id`, `customer_id`, `order_date`, `order_status`, `order_amount`, `source_file`, `loaded_at` | order key checks, customer orphan checks, amount range, status list, required fields |
| `payments` | `payment_id`, `order_id`, `payment_status`, `payment_amount`, `payment_date`, `source_file`, `loaded_at` | payment key checks, order orphan checks, payment amount range, required fields |
| `products` | `product_id`, `product_code`, `product_name`, `category`, `unit_price`, `product_status`, `source_file`, `loaded_at` | product-code uniqueness, product-code not-null, price range, status list |

## Relationship Map

| Parent table | Parent key | Child table | Child key | Relationship meaning | Orphan allowed? |
|---|---|---|---|---|---|
| `customers` | `customer_id` | `orders` | `customer_id` | Each order should reference an existing customer | No, for this lesson rule |
| `orders` | `order_id` | `payments` | `order_id` | Each payment should reference an existing order | No, for this lesson rule |

## Important Learning Issues

- primary-key-like checks need both duplicate and null validation
- foreign-key-like checks should preserve orphan evidence
- unique rules are not identical to primary keys
- check rules should come from documented business meaning
- not-null rules express requiredness
- audit columns help investigation

