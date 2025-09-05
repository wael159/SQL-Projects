# Q1 — Friend‑recommendation (hard)

**Goal:** Recommend new friend pairs: users who are *not currently friends* but have shown interest in **at least two of the same private events** (`attendance_status IN ('going','maybe')`).

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```
> Adjust connection flags as needed.

## What to expect
With the provided seed, only `(1,2)` qualifies (two shared private events and `status='not_friends'`).

## Notes
- We first filter private, opted‑in events via a CTE.
- Self‑join on `event_id` to form user pairs.
- Join to `friendship_status` to exclude existing friends.
- `HAVING COUNT(*) >= 2` ensures at least two shared private events.
