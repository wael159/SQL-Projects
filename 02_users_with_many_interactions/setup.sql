-- Setup for Q2: Users with >=5 interactions yesterday
DROP TABLE IF EXISTS interactions CASCADE;

CREATE TABLE interactions (
    user_a INT NOT NULL,
    user_b INT NOT NULL,
    interaction_date DATE NOT NULL
);

-- Seed interactions. Yesterday relative to project date: 2025-09-04
-- Make user 10 have 5 interactions yesterday (mix of roles A/B).
INSERT INTO interactions(user_a, user_b, interaction_date) VALUES
(10, 20, DATE '2025-09-04'),
(10, 21, DATE '2025-09-04'),
(22, 10, DATE '2025-09-04'),
(23, 10, DATE '2025-09-04'),
(24, 10, DATE '2025-09-04'),

-- Others under threshold
(11, 30, DATE '2025-09-04'),
(12, 31, DATE '2025-09-04'),
(12, 32, DATE '2025-09-04'),
(12, 33, DATE '2025-09-05'); -- today (should not count)
