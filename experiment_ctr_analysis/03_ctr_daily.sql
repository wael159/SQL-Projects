-- Step 3: Compute daily CTR safely
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
  SELECT experiment_group, day_index,
         COUNT(*) AS daily_impr, SUM(clicked) AS daily_clicks
  FROM filtered
  WHERE day_index BETWEEN 0 AND 6
  GROUP BY experiment_group, day_index
)
, ctr_daily AS (
  SELECT experiment_group, day_index, daily_impr, daily_clicks,
         CASE WHEN daily_impr = 0 THEN NULL ELSE daily_clicks / daily_impr END AS daily_ctr
  FROM group_day
)
SELECT * FROM ctr_daily ORDER BY experiment_group, day_index;