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
    ),
    group_day AS (
SELECT
    experiment_group, day_index,
    COUNT(*) AS daily_impr,
    SUM(clicked) AS daily_clicks
FROM filtered
WHERE day_index BETWEEN 0 AND 6
GROUP BY experiment_group, day_index
    ),
    ctr_daily AS (
SELECT
    experiment_group, day_index, daily_impr, daily_clicks,
    CASE WHEN daily_impr = 0 THEN NULL
    ELSE daily_clicks / daily_impr
    END AS daily_ctr
FROM group_day
    ),
    ctr_cum AS (
SELECT
    experiment_group,
    day_index,
    SUM(daily_impr)   OVER (PARTITION BY experiment_group ORDER BY day_index) AS cum_impr,
    SUM(daily_clicks) OVER (PARTITION BY experiment_group ORDER BY day_index) AS cum_clicks,
    CASE WHEN SUM(daily_impr) OVER (PARTITION BY experiment_group ORDER BY day_index) = 0 THEN NULL
    ELSE (SUM(daily_clicks) OVER (PARTITION BY experiment_group ORDER BY day_index)) /
    (SUM(daily_impr)  OVER (PARTITION BY experiment_group ORDER BY day_index))
    END AS cum_ctr
FROM ctr_daily
    ),
    pivot_daily AS (
SELECT
    day_index,
    MAX(CASE WHEN experiment_group='control'    THEN daily_impr END) AS control_impr_daily,
    MAX(CASE WHEN experiment_group='control'    THEN daily_ctr  END) AS control_ctr_daily,
    MAX(CASE WHEN experiment_group='experiment' THEN daily_impr END) AS experiment_impr_daily,
    MAX(CASE WHEN experiment_group='experiment' THEN daily_ctr  END) AS experiment_ctr_daily
FROM ctr_daily
GROUP BY day_index
    ),
    pivot_cum AS (
SELECT
    day_index,
    MAX(CASE WHEN experiment_group='control'    THEN cum_impr END) AS control_impr_cum,
    MAX(CASE WHEN experiment_group='control'    THEN cum_ctr  END) AS control_ctr_cum,
    MAX(CASE WHEN experiment_group='experiment' THEN cum_impr END) AS experiment_impr_cum,
    MAX(CASE WHEN experiment_group='experiment' THEN cum_ctr  END) AS experiment_ctr_cum
FROM ctr_cum
GROUP BY day_index
    )
SELECT
    d.day_index,
    d.control_impr_daily, d.control_ctr_daily,
    d.experiment_impr_daily, d.experiment_ctr_daily,
    (d.experiment_ctr_daily - d.control_ctr_daily)                             AS ctr_diff_daily,
    (d.experiment_ctr_daily - d.control_ctr_daily) / NULLIF(d.control_ctr_daily, 0) AS ctr_lift_daily,
    c.control_impr_cum, c.control_ctr_cum,
    c.experiment_impr_cum, c.experiment_ctr_cum,
    (c.experiment_ctr_cum - c.control_ctr_cum)                                 AS ctr_diff_cum,
    (c.experiment_ctr_cum - c.control_ctr_cum) / NULLIF(c.control_ctr_cum, 0)  AS ctr_lift_cum
FROM pivot_daily d
         JOIN pivot_cum   c USING (day_index)
ORDER BY d.day_index;
