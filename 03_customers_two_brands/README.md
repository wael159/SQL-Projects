# Q3 — Customers who bought two brands (medium–hard)

**Goal:** Return customers who purchased from **both** `brand_1` **and** `brand_2`.

## How to run
```bash
psql -U postgres -d postgres -f setup.sql
psql -U postgres -d postgres -f solution.sql
```

## What to expect
Only **Alice Amin** qualifies in the seed data.

## Notes
- CTE extracts unique (customer, brand) pairs for the two brands.
- Group per customer and keep those with `COUNT(DISTINCT brand_name) = 2`.
