-- Step 1: Filter impressions to 7-day window and compute day_index
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
SELECT * FROM filtered;