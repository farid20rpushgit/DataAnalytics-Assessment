DataAnalytics-Assessment

Overview

This repository contains SQL queries solving the Data Analytics Assessment questions. Each SQL file corresponds to a specific question.

Files

- `Assessment_Q1.sql`: High-Value Customers with Multiple Products
- `Assessment_Q2.sql`: Transaction Frequency Analysis
- `Assessment_Q3.sql`: Account Inactivity Alert
- `Assessment_Q4.sql`: Customer Lifetime Value Estimation

✅ Assessment Solutions

Q1. High-Value Customers with Multiple Products**

Objective: Identify customers with both funded savings and investment plans.  
Approach: 
- Joined `savings_savingsaccount` and `plans_plan` on `owner_id`.  
- Filtered for at least one savings and one investment plan per customer.  
- Aggregated total deposits and sorted results.


Q2. Transaction Frequency Analysis**

Objective:Analyze customer transaction frequency for segmentation.  
Approach:  
- Counted total transactions per customer and averaged them per month.  
- Used conditional logic to categorize frequency levels into High, Medium, and Low.


Q3. Account Inactivity Alert

Objective:Flag active savings or investment accounts with no deposits in the past year.  
Approach:  
- Used `DATEDIFF` to calculate inactivity days.  
- Selected accounts with no deposits in the last 365 days and labeled them as "Savings" or "Investment".


Q4. Customer Lifetime Value (CLV) Estimation

Objective: Estimate customer CLV using account tenure and transaction activity.  
Approach:  
- Calculated months since signup using `TIMESTAMPDIFF`.  
- Aggregated transactions and computed CLV based on a profit-per-transaction model.

Challenges Encountered

- The `name` field in `users_customuser` was empty. Resolved by concatenating `first_name` and `last_name`.
- Needed to trim or clean `owner_id` values for accurate JOIN operations.
- Optimizing queries for performance.
- Handling NULL and data consistency issues.

