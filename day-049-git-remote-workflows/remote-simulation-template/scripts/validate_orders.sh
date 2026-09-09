#!/usr/bin/env bash

# Purpose: safely validate a supplied sample orders file.

if [ "$#" -lt 1 ]; then
    echo "Usage: bash scripts/validate_orders.sh <orders-file>" >&2
    exit 1
fi

orders_file="$1"

if [ ! -f "$orders_file" ]; then
    echo "Orders file not found: $orders_file" >&2
    exit 1
fi

line_count=$(wc -l < "$orders_file")
completed_count=$(grep "COMPLETED" "$orders_file" | wc -l)
pending_count=$(grep "PENDING" "$orders_file" | wc -l)

printf 'Orders file: %s\n' "$orders_file"
printf 'Line count: %s\n' "$line_count"
printf 'COMPLETED rows: %s\n' "$completed_count"
printf 'PENDING rows: %s\n' "$pending_count"
printf 'Validation completed without changing source data.\n'

exit 0
