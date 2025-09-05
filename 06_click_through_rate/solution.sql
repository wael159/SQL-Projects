-- Solution for Q6
SELECT
    app_id,
    ROUND(
        100.0 *
        SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) /
        NULLIF(SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 0)
    , 2) AS ctr
FROM events
WHERE timestamp >= '2022-01-01' AND timestamp < '2023-01-01'
GROUP BY app_id
ORDER BY app_id;
