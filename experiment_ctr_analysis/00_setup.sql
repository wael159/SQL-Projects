
-- Step 0: Create and select database
CREATE DATABASE IF NOT EXISTS ab_test_demo;
USE ab_test_demo;

-- Drop tables if exist (for reruns)
DROP TABLE IF EXISTS ad_impressions;
DROP TABLE IF EXISTS ad_assignments;

-- Create assignments table
CREATE TABLE ad_assignments (
  user_id INT,
  experiment_group ENUM('control','experiment'),
  assigned_at DATETIME
);

-- Create impressions table
CREATE TABLE ad_impressions (
  user_id INT,
  impression_time DATETIME,
  clicked TINYINT(1)
);

-- Insert sample assignments
INSERT INTO ad_assignments (user_id, experiment_group, assigned_at) VALUES
(1, 'control',    '2025-01-01 00:00:00'),
(2, 'control',    '2025-01-01 00:00:00'),
(3, 'experiment', '2025-01-01 00:00:00'),
(4, 'experiment', '2025-01-01 00:00:00');

-- Insert sample impressions (user_id, impression_time, clicked)
INSERT INTO ad_impressions (user_id, impression_time, clicked) VALUES
(1, '2025-01-01 01:00:00', 1), -- control day 0 click
(1, '2025-01-02 10:00:00', 0), -- control day 1 no click
(2, '2025-01-01 02:00:00', 0), -- control day 0 no click
(2, '2025-01-02 11:00:00', 0), -- control day 1 no click

(3, '2025-01-01 01:30:00', 1), -- experiment day 0 click
(3, '2025-01-02 09:00:00', 0), -- experiment day 1 no click
(3, '2025-01-03 08:00:00', 0), -- experiment day 2 no click
(4, '2025-01-02 12:00:00', 0), -- experiment day 1 no click
(4, '2025-01-03 14:00:00', 1); -- experiment day 2 click
