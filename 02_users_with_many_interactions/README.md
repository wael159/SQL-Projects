# Q2 — Users with many interactions (medium–hard)

**Goal:** Count users who had **≥5** interactions **yesterday**, counting either side of an interaction.

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```

## What to expect
With the provided seed (yesterday = 2025-09-04), the result should be `1` (only user 10 reaches ≥5).

## Notes
- We **flatten** `user_a` and `user_b` with `UNION ALL` into a single column.
- Filter to `CURRENT_DATE - INTERVAL '1 day'`.
- Group by user and keep those with `COUNT(*) >= 5`, then count them.
- If you run on a different day, either re‑seed for that day's yesterday or replace the date filter with a fixed date.
