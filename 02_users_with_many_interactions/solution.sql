-- Solution for Q2
SELECT COUNT(*) AS over_five_interactions
FROM (
    SELECT user_id, COUNT(*) AS cnt
    FROM (
        SELECT user_a AS user_id
        FROM interactions
        WHERE interaction_date = CURRENT_DATE - INTERVAL '1 day'
        UNION ALL
        SELECT user_b AS user_id
        FROM interactions
        WHERE interaction_date = CURRENT_DATE - INTERVAL '1 day'
    ) AS all_users
    GROUP BY user_id
    HAVING COUNT(*) >= 5
) AS users_over_five;
