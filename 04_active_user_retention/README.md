# Q4 — Active‑user retention (medium–hard)

**Goal:** Count users who were active in **July 2022** *and* also had activity in **June 2022** (previous month).

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```

## What to expect
Users `{1,2,5}` qualify → **3 monthly active users** for July.

## Notes
- `EXISTS` checks prior‑month activity for each July row.
- `DATE_TRUNC('month', ...)` aligns months for comparison.
