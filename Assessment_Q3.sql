with savings_last_txn AS (
    select
        s.id as plan_id,
        s.owner_id,
        'Savings' as type,
        MAX(s.created_on) as last_transaction_date
    from savings_savingsaccount s
    group by s.id, s.owner_id
    having max(s.created_on) < curdate() - interval 365 day
),

investment_last_txn as (
    select
        p.id as plan_id,
        p.owner_id,
        'Investment' as type,
        
        p.last_charge_date as last_transaction_date
    from plans_plan p
    where p.status_id = 1                        
	and (p.last_charge_date is null or p.last_charge_date < Curdate() - interval 365 day)
)

select  
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
from (
    select * from savings_last_txn
    union all
    select * from investment_last_txn
) as combined
order by inactivity_days desc;
