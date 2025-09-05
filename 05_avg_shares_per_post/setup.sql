-- Setup for Q5: Average number of shares per post for each user
DROP TABLE IF EXISTS user_posts CASCADE;
DROP TABLE IF EXISTS post_shares CASCADE;

CREATE TABLE user_posts (
    post_id  INT PRIMARY KEY,
    user_id  INT NOT NULL,
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE post_shares (
    share_id SERIAL PRIMARY KEY,
    post_id  INT REFERENCES user_posts(post_id),
    shared_at TIMESTAMP DEFAULT now()
);

-- Seed posts
INSERT INTO user_posts(post_id, user_id) VALUES
(100, 1),
(101, 1),
(102, 2),
(103, 2),
(104, 3); -- user 3 has a post with zero shares

-- Seed shares
INSERT INTO post_shares(post_id) VALUES
(100),(100),(100), -- 3 shares
(101),             -- 1 share
(102),(102),       -- 2 shares
(103);             -- 1 share
-- post 104 has 0 shares
