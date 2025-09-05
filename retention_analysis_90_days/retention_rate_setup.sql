-- Create subscriptions table
CREATE TABLE subscriptions (
    user_id INT,
    subscription_start_date DATE,
    subscription_end_date DATE
);

-- Create user_events table
CREATE TABLE user_events (
    user_id INT,
    event_date DATE,
    event_type TEXT
);

-- Insert test data into subscriptions
INSERT INTO subscriptions (user_id, subscription_start_date, subscription_end_date) VALUES
(1, '2023-01-01', '2023-03-15'),
(2, '2023-01-01', '2023-05-01'),
(3, '2023-01-01', '2023-04-15'),
(4, '2023-01-01', '2023-02-15');

-- Insert test data into user_events
INSERT INTO user_events (user_id, event_date, event_type) VALUES
(1, '2023-02-01', 'login'),
(2, '2023-05-10', 'purchase'),
(3, '2023-03-10', 'click'),
(4, '2023-04-15', 'login');