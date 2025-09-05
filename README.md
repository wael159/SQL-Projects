# SQL Training

This repo contains advanced SQL practice questions and solutions.  
Each script is step-by-step, so you can follow the logic and learn.

---

## 📌 Question: Daily & Cumulative CTR for an A/B Test

**Problem Statement**

We are running an A/B test on an ad system.  
Users are randomly assigned to either a **control** group or an **experiment** group at time `assigned_at`.  
We want to measure whether the **experiment increased the click-through rate (CTR)** in the **7 days after assignment**.

### Available Tables

**ad_assignments**
- `user_id`
- `experiment_group` (`control` or `experiment`)
- `assigned_at` (datetime)

**ad_impressions**
- `user_id`
- `impression_time` (datetime)
- `clicked` (0 or 1)

### Task

Write a SQL query (MySQL 8) that produces:

1. **Daily metrics** (for days 0–6 after assignment):  
   - Impressions per group  
   - Clicks per group  
   - CTR per group  

2. **Cumulative metrics** (running totals):  
   - Cumulative impressions per group  
   - Cumulative clicks per group  
   - Cumulative CTR per group  

3. **Comparison metrics**:  
   - Daily CTR difference & lift (experiment vs control)  
   - Cumulative CTR difference & lift  

### Expected Output Format

One row per `day_index` (0–6), with columns for:

- `control_impr_daily`, `control_ctr_daily`  
- `experiment_impr_daily`, `experiment_ctr_daily`  
- `ctr_diff_daily`, `ctr_lift_daily`  
- `control_impr_cum`, `control_ctr_cum`  
- `experiment_impr_cum`, `experiment_ctr_cum`  
- `ctr_diff_cum`, `ctr_lift_cum`  

---

## ✅ Solution

Scripts are provided in the `/sql/` folder, step by step:

- `01_filtered.sql` → filter impressions, compute `day_index`  
- `02_group_day.sql` → daily counts  
- `03_ctr_daily.sql` → daily CTR  
- `04_ctr_cum.sql` → cumulative CTR  
- `05_pivot_daily.sql` → pivot daily view  
- `06_pivot_cum.sql` → pivot cumulative view  
- `07_final_select.sql` → join and calculate differences/lifts  

---

## Difficulty

**Level:** Advanced (~8.5/10)  
Tests your ability to combine filtering, GROUP BY, safe division, window functions, pivoting, and business interpretation.
