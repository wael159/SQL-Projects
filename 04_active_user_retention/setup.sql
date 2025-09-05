-- Setup for Q4: Monthly active users who performed actions in both the current and previous month (focus: July 2022)
DROP TABLE IF EXISTS user_actions CASCADE;

CREATE TABLE user_actions (
    user_id    INT NOT NULL,
    event_date DATE NOT NULL,
    event_type TEXT
);

-- Seed: Users active in June and July 2022
INSERT INTO user_actions VALUES
(1,'2022-06-05','login'),
(1,'2022-07-10','purchase'),
(2,'2022-06-15','login'),
(2,'2022-07-20','click'),
(3,'2022-07-05','login'),     -- July only
(4,'2022-06-25','purchase'),  -- June only
(5,'2022-06-01','login'),
(5,'2022-07-30','click'),
(6,'2022-07-15','click');     -- July only
