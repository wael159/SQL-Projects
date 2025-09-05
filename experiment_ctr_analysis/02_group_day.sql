-- Step 2: Aggregate daily impressions and clicks per group/day
WITH filtered AS (
  SELECT
    a.experiment_group,
    TIMESTAMPDIFF(DAY, a.assigned_at, ai.impression_time) AS day_index,
    ai.clicked
  FROM ad_assignments a
  JOIN ad_impressions ai
    ON ai.user_id = a.user_id
   AND ai.impression_time >= a.assigned_at
   AND ai.impression_time <  a.assigned_at + INTERVAL 7 DAY
)
, group_day AS (
  SELECT
    experiment_group,
    day_index,
    COUNT(*)     AS daily_impr,
    SUM(clicked) AS daily_clicks
  FROM filtered
  WHERE day_index BETWEEN 0 AND 6
  GROUP BY experiment_group, day_index
)
SELECT * FROM group_day ORDER BY experiment_group, day_index;