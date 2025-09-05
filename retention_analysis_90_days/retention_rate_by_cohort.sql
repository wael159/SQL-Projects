WITH cohort_base AS (
    SELECT 
        user_id,
        DATE_TRUNC('month', subscription_start_date) AS cohort_month,
        subscription_start_date,
        subscription_start_date + INTERVAL '90 day' AS day_90
    FROM subscriptions
),

activity_after_90 AS (
    SELECT DISTINCT ue.user_id
    FROM user_events ue
    JOIN cohort_base cb ON ue.user_id = cb.user_id
    WHERE ue.event_date >= cb.day_90
),

still_subscribed_on_90 AS (
    SELECT user_id
    FROM subscriptions s
    JOIN cohort_base cb ON s.user_id = cb.user_id
    WHERE s.subscription_end_date >= cb.day_90
),

retained_users AS (
    SELECT user_id FROM activity_after_90
    UNION
    SELECT user_id FROM still_subscribed_on_90
),

retention_status AS (
    SELECT 
        cb.user_id,
        cb.cohort_month,
        CASE WHEN ru.user_id IS NOT NULL THEN 1 ELSE 0 END AS retained_flag
    FROM cohort_base cb
    LEFT JOIN retained_users ru ON cb.user_id = ru.user_id
),

final_retention AS (
    SELECT 
        cohort_month,
        COUNT(*) AS total_users,
        SUM(retained_flag) AS retained_users,
        ROUND(100.0 * SUM(retained_flag)::numeric / COUNT(*), 2) AS retention_rate_percent
    FROM retention_status
    GROUP BY cohort_month
    ORDER BY cohort_month
)

SELECT * FROM final_retention;