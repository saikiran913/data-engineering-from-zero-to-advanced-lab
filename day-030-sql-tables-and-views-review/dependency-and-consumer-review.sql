-- Day 030: Dependency and Consumer Review
-- Purpose: Match consumers to interfaces and identify interface mismatches.
-- Safety: Non-destructive examples only. No table or view is deployed automatically.

-- Consumer inventory.
SELECT
    consumer_id,
    consumer_type,
    consumer_name,
    required_interface,
    expected_grain,
    required_columns,
    freshness_need,
    history_need,
    change_sensitivity
FROM interface_consumers
ORDER BY required_interface, consumer_name;

-- Interface-to-consumer mapping.
SELECT
    required_interface,
    COUNT(*) AS consumer_count,
    SUM(CASE WHEN change_sensitivity = 'HIGH' THEN 1 ELSE 0 END) AS high_sensitivity_count
FROM interface_consumers
GROUP BY required_interface
ORDER BY required_interface;

-- High-sensitivity consumer review.
SELECT
    consumer_name,
    required_interface,
    expected_grain,
    required_columns,
    change_sensitivity
FROM interface_consumers
WHERE change_sensitivity = 'HIGH'
ORDER BY required_interface;

-- Required-column comparison is documented through metadata.
SELECT
    consumer_name,
    required_interface,
    required_columns
FROM interface_consumers
WHERE required_columns IS NOT NULL;

-- Expected-grain comparison.
SELECT
    required_interface,
    expected_grain,
    COUNT(*) AS consumer_count
FROM interface_consumers
GROUP BY required_interface, expected_grain
ORDER BY required_interface;

-- Freshness-needs review.
SELECT
    freshness_need,
    COUNT(*) AS consumer_count
FROM interface_consumers
GROUP BY freshness_need
ORDER BY freshness_need;

-- History-needs review.
SELECT
    history_need,
    COUNT(*) AS consumer_count
FROM interface_consumers
GROUP BY history_need
ORDER BY history_need;

-- Interface mismatch review.
SELECT
    consumer_name AS consumer,
    required_interface,
    expected_grain,
    'HISTORY_INTERFACE_REVIEW' AS mismatch_type,
    'HIGH_REVIEW' AS impact_level,
    'Consumer needs history; confirm the interface preserves history.' AS review_action
FROM interface_consumers
WHERE history_need LIKE '%history%'
  AND required_interface NOT LIKE '%raw%'
  AND required_interface NOT LIKE '%table%'
UNION ALL
SELECT
    consumer_name,
    required_interface,
    expected_grain,
    'GRAIN_REVIEW',
    'MEDIUM_REVIEW',
    'Confirm the required interface matches the expected grain.'
FROM interface_consumers
WHERE expected_grain LIKE '%event%'
   OR expected_grain LIKE '%region-date%'
UNION ALL
SELECT
    consumer_name,
    required_interface,
    expected_grain,
    'STABLE_COLUMNS_REVIEW',
    'HIGH_REVIEW',
    'Consumer requires stable reporting columns.'
FROM interface_consumers
WHERE consumer_type IN ('dashboard', 'scheduled extract', 'application report');
