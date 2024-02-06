-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers
with visits as (
	select customer_id, count(visit_id) as num_visits
	from sales.funnel
	group by customer_id
)
select
	cus.customer_id,
	cus.first_name, 
	visits.num_visits
from sales.customers as cus
inner join visits
on cus.customer_id = visits.customer_id
order by visits.num_visits desc