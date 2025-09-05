-- Solution for Q4
SELECT
    EXTRACT(MONTH FROM curr.event_date) AS month,
    COUNT(DISTINCT curr.user_id) AS monthly_active_users
FROM user_actions AS curr
WHERE EXISTS (
    SELECT 1
    FROM user_actions AS prev
    WHERE prev.user_id = curr.user_id
      AND DATE_TRUNC('month', prev.event_date) =
          DATE_TRUNC('month', curr.event_date) - INTERVAL '1 month'
)
  AND DATE_TRUNC('month', curr.event_date) = DATE '2022-07-01'
GROUP BY EXTRACT(MONTH FROM curr.event_date);
