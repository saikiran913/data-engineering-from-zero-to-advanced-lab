# Day 014 Practice Questions

## Section 1: Simple Questions

1. What does `INNER JOIN` return?
2. What does `LEFT JOIN` preserve?
3. What does the `ON` condition do?
4. What is a join key?
5. Why can a wrong join key create wrong results?
6. Why does the left table matter?
7. Why can row count increase after a join?
8. Why can row count decrease after an `INNER JOIN`?
9. What is an unmatched record?
10. What does `NULL` after `LEFT JOIN` often mean?
11. Why are ambiguous columns risky?
12. What is one join debugging step?

## Section 2: Pick the Correct Left Table

1. Find all customers even if they have no orders.
2. Find all orders even if customer details are missing.
3. Find all products even if never ordered.
4. Find all order items even if product details are missing.
5. Find all payments even if order is missing.
6. Find all orders even if payment is missing.
7. Find all support tickets even if customer is missing.
8. Find all campaigns even if performance is missing.
9. Find all performance rows even if campaign details are missing.
10. Find all customers even if no support tickets.
11. Find all orders even if no order items.
12. Find all products and any quantities sold.

## Section 3: INNER JOIN or LEFT JOIN?

1. Show matched customer-order rows.
2. Find customers with no orders.
3. Find orders with unknown customers.
4. Add product category to valid order items.
5. Find products never ordered.
6. Match payments to valid orders.
7. Find payments with unknown orders.
8. Find orders without payments.
9. Match tickets to customers.
10. Find tickets with unknown customers.
11. Match campaign performance to campaign names.
12. Find campaigns without performance.
13. Find campaign performance with unknown campaigns.
14. Build matched order-payment data.
15. Preserve all products while checking quantities sold.

## Section 4: Identify the Join Mistake

1. Joining customers to orders using country.
2. Missing the `ON` condition.
3. Using `INNER JOIN` to find missing customers.
4. Starting from orders when the goal is all customers.
5. Using `SELECT *` in a join.
6. Selecting `customer_id` without table prefix.
7. Thinking one customer must return one row after joining orders.
8. Filtering right-table columns after a `LEFT JOIN` without thinking.
9. Using `= NULL`.
10. Joining product name to product ID.
11. Joining payments directly to customers using unrelated IDs.
12. Not checking row counts.
13. Not documenting join logic.
14. Assuming `NULL` always means an error.
15. Joining tables only because both contain `country`.

## Section 5: Choose the Correct Query

For each scenario, choose the better query idea.

| Scenario | Better Query Idea |
| --- | --- |
| Customers with no orders | `customers LEFT JOIN orders WHERE o.order_id IS NULL` |
| Orders with unknown customers | `orders LEFT JOIN customers WHERE c.customer_id IS NULL` |
| Products never ordered | `products LEFT JOIN order_items WHERE oi.order_item_id IS NULL` |
| Order items with unknown products | `order_items LEFT JOIN products WHERE p.product_id IS NULL` |
| Payments without orders | `payments LEFT JOIN orders WHERE o.order_id IS NULL` |
| Orders without payments | `orders LEFT JOIN payments WHERE pay.payment_id IS NULL` |
| Campaigns without performance | `campaigns LEFT JOIN campaign_performance WHERE cp.campaign_id IS NULL` |
| Performance with unknown campaigns | `campaign_performance LEFT JOIN campaigns WHERE ca.campaign_id IS NULL` |
| Tickets with unknown customers | `support_tickets LEFT JOIN customers WHERE c.customer_id IS NULL` |
| Orders with customer names | `orders INNER JOIN customers ON customer_id` |
| Order items with product categories | `order_items INNER JOIN products ON product_id` |
| Campaign revenue by campaign name | `campaigns LEFT JOIN campaign_performance GROUP BY campaign_name` |

## Section 6: Write JOIN Queries

Write SQL for:

1. `INNER JOIN` customers and orders.
2. `LEFT JOIN` customers and orders.
3. Find customers with no orders.
4. Find orders with unknown customers.
5. Join order items with products.
6. Find order items with unknown products.
7. Find products never ordered.
8. Join payments with orders.
9. Find payments with unknown orders.
10. Find orders without payments.
11. Join support tickets with customers.
12. Find support tickets with unknown customers.
13. Join campaigns with performance data.
14. Find campaigns without performance data.
15. Find campaign performance with unknown campaign IDs.

## Section 7: Row Count Reasoning

Say whether row count may increase, decrease, stay similar, or require investigation.

1. `customers INNER JOIN orders`
2. `customers LEFT JOIN orders`
3. `orders INNER JOIN order_items`
4. `products LEFT JOIN order_items`
5. `orders LEFT JOIN payments`
6. `campaigns INNER JOIN campaign_performance`
7. `campaign_performance LEFT JOIN campaigns`
8. `order_items LEFT JOIN products`
9. `customers LEFT JOIN support_tickets`
10. Wrong join on country

## Section 8: Think Like a Data Engineer

1. What is the business question?
2. Which tables are needed?
3. Which keys connect them?
4. Which join type is appropriate?
5. Which table should be left?
6. What row behavior, data quality risk, and debugging check should be expected?

## Section 9: Mini Assignment

Describe or write checks to:

1. Enrich orders with customer details.
2. Find customers with no orders.
3. Find orders with unknown customers.
4. Enrich order items with product details.
5. Find order items with unknown products.
6. Find products never ordered.
7. Match payments to orders.
8. Find payments with unknown orders.
9. Find orders without payments.
10. Match tickets to customers.
11. Find tickets with unknown customers.
12. Match campaign performance to campaigns.
13. Find campaigns without performance.
14. Find performance rows with unknown campaigns.
15. Explain one row count increase after a one-to-many join.

## Answer Key

### Section 1

1. Matching rows only.
2. All rows from the left table.
3. It defines how tables connect.
4. The column used to join tables.
5. It can connect unrelated rows.
6. It decides which rows are preserved.
7. One-to-many relationships can multiply rows.
8. Unmatched rows are removed.
9. A row without a related match.
10. No matching right-side row.
11. SQL may not know which column is meant.
12. Check row counts or missing matches.

### Section 2

1. customers
2. orders
3. products
4. order_items
5. payments
6. orders
7. support_tickets
8. campaigns
9. campaign_performance
10. customers
11. orders
12. products

### Section 3

1. `INNER JOIN`
2. `LEFT JOIN`
3. `LEFT JOIN`
4. `INNER JOIN`
5. `LEFT JOIN`
6. `INNER JOIN`
7. `LEFT JOIN`
8. `LEFT JOIN`
9. `INNER JOIN`
10. `LEFT JOIN`
11. `INNER JOIN`
12. `LEFT JOIN`
13. `LEFT JOIN`
14. `INNER JOIN`
15. `LEFT JOIN`

### Section 4

1. Wrong join key.
2. Missing relationship condition.
3. Wrong join type.
4. Wrong left table.
5. Noisy and ambiguous output.
6. Ambiguous column.
7. One-to-many misunderstanding.
8. Filter may remove unmatched rows.
9. Use `IS NULL`.
10. Wrong key.
11. Missing relationship path.
12. Missing validation.
13. Missing documentation.
14. Context is needed.
15. Same column name does not prove relationship.

### Section 6

Use the matching examples from `join-practice-queries.sql` for each task.

### Section 7

1. May decrease compared with customers or increase compared with matched customers.
2. May increase because customers can have many orders.
3. May increase because orders can have many items.
4. May increase because products can have many items.
5. May stay similar or increase if multiple payments exist.
6. May increase or decrease depending on matches.
7. Usually preserves performance rows.
8. Usually preserves order item rows.
9. May increase if customers have many tickets.
10. Requires investigation because the join key is suspicious.
