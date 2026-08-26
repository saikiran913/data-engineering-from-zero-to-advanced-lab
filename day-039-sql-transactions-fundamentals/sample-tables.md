# Sample Tables for Day 039

Day 039 uses before and expected-after CSV snapshots. This lets learners practise transaction thinking without running write SQL.

| File | Purpose | Grain | Business key | Scenario role | Validation questions |
|---|---|---|---|---|---|
| `account_balances_before.csv` | Starting account balances | One row per account | `account_id` | Before state for transfer concept | Do target accounts exist? What is the before total? |
| `account_balances_expected_after.csv` | Expected balances after conceptual transfer | One row per account | `account_id` | Expected after state | Did one account decrease and another increase by the same amount? |
| `order_status_before.csv` | Starting order statuses | One row per order | `order_id` | Before state for status change | Which orders are targeted? |
| `order_status_expected_after.csv` | Expected order status and review flags | One row per order | `order_id` | Expected after state | Did only intended rows change? |
| `transaction_rules.csv` | Transaction validation rules | One row per rule | `rule_id` | Rule catalog | Which pre-checks and post-checks matter? |
| `transaction_casebook.csv` | Transaction scenarios | One row per case | `case_id` | Scenario catalog | Is a transaction useful, unnecessary, or too broad? |

## Balance Scenario

Accounts 101 and 202 model a conceptual transfer:

- Account 101 decreases by 250
- Account 202 increases by 250
- the grand total remains unchanged
- all other accounts remain unchanged

## Order Status Scenario

Orders O2001 and O2002 model a conceptual multi-field update:

- status changes from `PENDING` to `COMPLETED`
- review flag changes from `Yes` to `No`
- unrelated orders remain unchanged

## Important Learning Issues

- target keys should exist before a change
- expected affected row counts should be known
- before and after control totals should reconcile
- unchanged rows should be checked
- commit conditions and rollback conditions should be defined before changes

