-- Setup for Q6: CTR per app_id in 2022
DROP TABLE IF EXISTS events CASCADE;

CREATE TABLE events (
    app_id     INT NOT NULL,
    event_type TEXT CHECK (event_type IN ('click','impression')),
    timestamp  TIMESTAMP NOT NULL
);

-- Seed: impressions and clicks across 2022 for apps 1 and 2
INSERT INTO events(app_id, event_type, timestamp) VALUES
(1,'impression','2022-01-01 00:00'),
(1,'impression','2022-01-02 00:00'),
(1,'impression','2022-01-03 00:00'),
(1,'click','2022-02-01 00:00'),
(1,'click','2022-02-02 00:00'),

(2,'impression','2022-03-01 00:00'),
(2,'impression','2022-03-02 00:00'),
(2,'click','2022-03-03 00:00');
