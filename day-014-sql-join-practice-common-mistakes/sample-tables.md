# Sample Tables for Day 014

This lesson uses eight simple business tables:

1. `customers`
2. `orders`
3. `products`
4. `order_items`
5. `campaigns`
6. `campaign_performance`
7. `payments`
8. `support_tickets`

## customers table

Columns: `customer_id`, `customer_name`, `country`, `city`, `signup_date`, `email`, `customer_status`

Relationship use: `customers.customer_id` connects to `orders.customer_id` and `support_tickets.customer_id`.

## orders table

Columns: `order_id`, `customer_id`, `order_date`, `order_amount`, `order_status`, `payment_status`, `country`

Relationship use: `orders.customer_id` connects to `customers.customer_id`. `orders.order_id` connects to `order_items.order_id` and `payments.order_id`.

## products table

Columns: `product_id`, `product_name`, `category`, `price`, `is_active`

Relationship use: `products.product_id` connects to `order_items.product_id`.

## order_items table

Columns: `order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`

Relationship use:

- `order_items.order_id` connects to `orders.order_id`.
- `order_items.product_id` connects to `products.product_id`.

## campaigns table

Columns: `campaign_id`, `campaign_name`, `channel`, `country`, `campaign_status`, `budget`

Relationship use: `campaigns.campaign_id` connects to `campaign_performance.campaign_id`.

## campaign_performance table

Columns: `performance_date`, `campaign_id`, `channel`, `country`, `impressions`, `clicks`, `cost`, `conversions`, `revenue`

Relationship use: performance rows should usually connect to a known campaign.

## payments table

Columns: `payment_id`, `order_id`, `payment_date`, `payment_amount`, `payment_method`, `payment_status`

Relationship use: `payments.order_id` connects to `orders.order_id`.

## support_tickets table

Columns: `ticket_id`, `customer_id`, `ticket_date`, `issue_type`, `ticket_status`

Relationship use: `support_tickets.customer_id` connects to `customers.customer_id`.

## Relationship Map

| Relationship | Join Key | Typical Question |
| --- | --- | --- |
| customers to orders | `customer_id` | Which customers placed orders? |
| orders to order_items | `order_id` | Which items belong to each order? |
| products to order_items | `product_id` | Which products were ordered? |
| orders to payments | `order_id` | Which orders have payments? |
| customers to support_tickets | `customer_id` | Which customers raised tickets? |
| campaigns to campaign_performance | `campaign_id` | Which campaigns have performance? |
