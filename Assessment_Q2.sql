with customer_txn AS (
    select 
        u.id as owner_id,
        COUNT(s.id) as total_transactions,
        timestampdiff(month, MIN(s.created_on), MAX(s.created_on) + interval 1 day) as active_months
    from users_customuser u
    join savings_savingsaccount s ON u.id = s.owner_id
    where s.created_on IS NOT NULL
    group by u.id
),
customer_freq as (
    select
        owner_id,
        total_transactions,
        
        case when active_months = 0 then total_transactions else total_transactions / active_months end as avg_txn_per_month,
        case
            when (case when active_months = 0 then total_transactions else total_transactions / active_months end) >= 10 then 'High Frequency'
            when (case when active_months = 0 then total_transactions else total_transactions / active_months end) between 3 and 9 then 'Medium Frequency'
            else 'Low Frequency'
        end as frequency_category
    from customer_txn
)

select
    frequency_category,
    COUNT(owner_id) as customer_count,
    ROUND(avg(avg_txn_per_month), 2) as avg_transactions_per_month
from customer_freq
group by frequency_category
order by 
    case frequency_category
        when 'High Frequency' THEN 1
        when 'Medium Frequency' THEN 2
        when 'Low Frequency' THEN 3
    end;
