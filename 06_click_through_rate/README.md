# Q6 — Click‑through rate (medium)

**Goal:** Compute CTR per `app_id` in **2022**: `clicks / impressions * 100` (percentage, 2 decimals).

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```

## What to expect
- App 1: 2 clicks / 3 impressions → **66.67**
- App 2: 1 click / 2 impressions → **50.00**

## Notes
- `NULLIF(...,0)` prevents division by zero.
