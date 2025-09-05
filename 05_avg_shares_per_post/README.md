# Q5 — Average shares per post (medium)

**Goal:** For each user, compute the **average** number of shares across their posts (include posts with zero shares).

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```

## What to expect
- User 1: posts (100:3 shares, 101:1 share) → avg **2.0**
- User 2: posts (102:2, 103:1) → avg **1.5**
- User 3: post (104:0) → avg **0.0**
