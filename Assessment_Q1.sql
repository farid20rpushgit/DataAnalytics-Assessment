select 

u.id as owner_id,
concat(u.first_name, ' ', u.last_name) as name, 
count(distinct s.id) as savings_count,
count(distinct p.id) as investment_count,
sum(s.amount) as total_deposits

from users_customuser u 
join savings_savingsaccount s on u.id = s.owner_id
join plans_plan p on u.id = p.owner_id
where s.amount>0
and p.plan_type_id=2
and p.status_id=1
group by u.id, name 
having savings_count >=1 and investment_count >=1
order by total_deposits desc;

