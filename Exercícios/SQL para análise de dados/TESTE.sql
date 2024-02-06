select
	case
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 2 then 'Até dois anos'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 4 then 'De 2 até 4 anos'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 6 then 'De 4 até 6 anos'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 8 then 'De 6 até 8 anos'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 10 then 'De 8 até 10 anos'
		else 'Acima de 10 anos'
		end as "Idade",
	count(*) / (select count(*)::float from sales.funnel) as pct,
	case
		when extract('y' from fun.visit_page_date) - pro.model_year::bigint <= 2 then '1'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 4 then '2'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 6 then '3'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 8 then '4'
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric <= 10 then '5'
		else '6'
		end as "Ordem"
from sales.products as pro
left join sales.funnel as fun
on pro.product_id = fun.product_id
group by "Idade", "Ordem"
order by "Ordem"
