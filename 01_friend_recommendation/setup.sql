-- PostgreSQL setup for Q1: Friend recommendation (hard)
-- Creates minimal schema + seed data.

DROP TABLE IF EXISTS event_rsvp CASCADE;
DROP TABLE IF EXISTS friendship_status CASCADE;

CREATE TABLE event_rsvp (
    user_id        INT NOT NULL,
    event_id       INT NOT NULL,
    attendance_status TEXT CHECK (attendance_status IN ('going','maybe','not_going')),
    event_type     TEXT CHECK (event_type IN ('private','public')),
    PRIMARY KEY (user_id, event_id)
);

CREATE TABLE friendship_status (
    user_a_id  INT NOT NULL,
    user_b_id  INT NOT NULL,
    status     TEXT CHECK (status IN ('friends','not_friends','blocked')),
    PRIMARY KEY (user_a_id, user_b_id)
);

-- Seed users (implicit via IDs) and events
-- Users: 1..6
-- Events: 10..20 (mix of private/public)

INSERT INTO event_rsvp(user_id, event_id, attendance_status, event_type) VALUES
-- Shared private events between user 1 and 2 (two events -> should be recommended)
(1, 10, 'going', 'private'),
(2, 10, 'maybe', 'private'),
(1, 11, 'going', 'private'),
(2, 11, 'going', 'private'),

-- Only one shared private event between 1 and 3 (should NOT qualify)
(1, 12, 'going', 'private'),
(3, 12, 'going', 'private'),

-- Public event (ignored)
(1, 13, 'going', 'public'),
(2, 13, 'going', 'public'),

-- More noise
(4, 14, 'maybe', 'private'),
(5, 14, 'going', 'private'),
(4, 15, 'going', 'private'),
(6, 16, 'going', 'public');

-- Friendship statuses.
-- 1 & 2 are *not* friends -> eligible for recommendation.
-- 1 & 3 are not friends but share only 1 private event -> not eligible.
-- 4 & 5 are already friends -> should be excluded even though they share events.
INSERT INTO friendship_status(user_a_id, user_b_id, status) VALUES
(1, 2, 'not_friends'),
(2, 1, 'not_friends'), -- include reverse to show directionality if desired
(1, 3, 'not_friends'),
(4, 5, 'friends'),
(5, 4, 'friends');
