-- Solution for Q1 (PostgreSQL)
WITH private_events AS (
    SELECT user_id, event_id
    FROM event_rsvp
    WHERE attendance_status IN ('going', 'maybe')
      AND event_type = 'private'
)
SELECT
    pairs.user_a_id,
    pairs.user_b_id
FROM (
    SELECT e1.user_id AS user_a_id, e2.user_id AS user_b_id
    FROM private_events e1
    JOIN private_events e2
      ON e1.user_id <> e2.user_id
     AND e1.event_id = e2.event_id
) AS pairs
JOIN friendship_status AS f
  ON pairs.user_a_id = f.user_a_id
 AND pairs.user_b_id = f.user_b_id
WHERE f.status = 'not_friends'
GROUP BY pairs.user_a_id, pairs.user_b_id
HAVING COUNT(*) >= 2
ORDER BY 1,2;
