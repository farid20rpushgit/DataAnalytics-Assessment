with txn_summary as (
    select 
        trim(s.owner_id) as owner_id,
        count(s.id) as total_transactions,
        sum(s.amount) as total_amount,
        avg(s.amount * 0.001) as avg_profit_per_transaction
    from savings_savingsaccount s
    group by TRIM(s.owner_id)
),

tenure as (
    select
        trim(u.id) as customer_id,
        Concat(u.first_name, ' ', u.last_name) as full_name,
        Timestampdiff(month, u.date_joined, curdate()) as tenure_months
    from users_customuser u
)

select
    t.customer_id,
    t.full_name as name,
    t.tenure_months,
    ts.total_transactions,
    round(
        (ts.total_transactions / NULLIF(t.tenure_months, 0)) * 12 * ts.avg_profit_per_transaction,
        2
    ) as estimated_clv
from tenure t
join txn_summary ts on ts.owner_id = t.customer_id
where t.full_name is not null
order by estimated_clv desc;

