# Beginner Summary

## What Learners Should Remember

Constraints describe important data rules. A constraint may be enforced by a database, documented by a data contract, or validated using read-only SQL.

Primary keys represent row identity. A primary-key-like check should confirm both uniqueness and requiredness. If a key has duplicates, it does not identify one row. If a key is null, it may not satisfy the intended business rule.

Composite keys use multiple columns to identify one row. They are closely connected to grain. For example, an order-line table may need `order_id` and `line_number` together.

Foreign keys describe parent-child relationships. Customers can be parents of orders. Orders can be parents of payments. An orphan record is a child row with no matching parent row. Foreign-key validation should report orphans for review, not remove them.

Unique rules prevent duplicate values conceptually, but they are not always the same as primary keys. A product code may need to be unique even when `product_id` is the row identifier. Null behaviour under unique rules varies by SQL platform.

`CHECK` rules validate allowed conditions, such as status values or numeric ranges. These rules should come from documented business meaning. A negative value is not universally invalid; it is invalid only when the agreed rule says so.

`NOT NULL` expresses requiredness. Required fields such as order ID, customer ID, order date, payment amount, and product code should be checked carefully.

Database enforcement varies by platform. Some analytical systems may document or accept constraints without enforcing every rule in the same way as transactional databases. Validation queries remain useful even when constraints are not enforced.

Constraint violations should become review outputs. Include the table name, entity key, constraint concept, issue type, expected rule, actual result, severity, source file, load timestamp, and review message.

Constraints connect to schema contracts, grain, keys, relationships, and data quality. All Day 038 executable SQL remains read-only and non-destructive.

## Mental Model

Define the table grain, identify keys and relationships, document allowed values and required fields, validate each rule, and report anything that violates the contract.

## Final Warnings

> A constraint describes an important rule about data structure or allowed values. Whether the database actually enforces that rule depends on the SQL platform and implementation.

> A primary-key-like validation should confirm both uniqueness and requiredness. A unique-looking column with nulls may not satisfy the intended business rule.

> Foreign-key validation should identify unmatched child records for review. It should not automatically delete orphan records.

> Day 038 teaches constraint concepts and read-only validation patterns. It does not create, alter, drop, enable, or disable database constraints.

## What Comes Next

Day 039 will deepen constraint validation through integrated practice and debugging while keeping all SQL non-destructive.

