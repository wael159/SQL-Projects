-- Solution for Q5
SELECT
    u.user_id,
    COALESCE(AVG(s.share_count), 0) AS avg_shares_per_post
FROM user_posts u
LEFT JOIN (
    SELECT post_id, COUNT(*) AS share_count
    FROM post_shares
    GROUP BY post_id
) s ON u.post_id = s.post_id
GROUP BY u.user_id
ORDER BY u.user_id;
