# 🔥 Expert-Level SQL Challenge: Rolling 90-Day Retention Rate by Cohort

## 🧠 Problem Statement

We are given two tables:

### `subscriptions`
| Column Name             | Data Type |
|-------------------------|-----------|
| user_id                 | INTEGER   |
| subscription_start_date| DATE      |
| subscription_end_date  | DATE      |

### `user_events`
| Column Name | Data Type |
|-------------|-----------|
| user_id     | INTEGER   |
| event_date  | DATE      |
| event_type  | TEXT      |

---

## 🎯 Goal

Calculate the **rolling 90-day retention rate by cohort** (grouped by `subscription_start_date` by month).

A user is considered **retained** in their cohort if:
- They either had **any event**, or were **still subscribed**, on or after **90 days** from their `subscription_start_date`.

---

## ✅ Output

| cohort_month | total_users | retained_users | retention_rate_percent |
|--------------|-------------|----------------|-------------------------|
| 2023-01      | 1000        | 725            | 72.50                   |
| 2023-02      | 850         | 670            | 78.82                   |
| ...          | ...         | ...            | ...                     |

---

## ⚠️ Difficulty: Expert (10/10)

- Rolling retention, grouped by cohort
- Combine activity and subscription signals
- Avoid double-counting users
- Must support multi-month data across a full year