-- (Query 1) Gênero dos leads
-- Colunas: gênero, leads(#)
select
	case
		when gen.gender = 'female' then 'feminino'
		when gen.gender = 'male' then 'masculino'
		end as "gênero",
	count(*)
from temp_tables.ibge_genders as gen
inner join sales.customers as cus
on lower(cus.first_name) = lower(gen.first_name)
group by gen.gender
order by gen.gender



-- (Query 2) Status profissional dos leads
-- Colunas: status profissional, leads (%)
select
	case
		when professional_status = 'clt' then 'Clt'
		when professional_status = 'freelancer' then 'Freelancer'
		when professional_status = 'retired' then 'Aposentado(a)'
		when professional_status = 'self_employed' then 'Autônomo(a)'
		when professional_status = 'other' then 'Outro'
		when professional_status = 'businessman' then 'Empresário(a)'
		when professional_status = 'civil_servant' then 'Funcionário(a) público(a)'
		when professional_status = 'student' then 'Estudante'
		end as "Status_Profissional",
		count(*)::float / (select count(*)::float from sales.customers)  as "leads(#)"
from sales.customers
group by professional_status


-- (Query 3) Faixa etária dos leads
-- Colunas: faixa etária, leads (%)
select
	case
		when datediff('y', birth_date, current_date) < 20 then '0-20'
		when datediff('y', birth_date, current_date) < 40 then '20-40'
		when datediff('y', birth_date, current_date) < 60 then '40-60'
		when datediff('y', birth_date, current_date) < 80 then '60-80'
		else '80+'
		end as "Faixa_Etaria",
		count(*) / (select count(*)::float from sales.customers) as "leads(#)"
from sales.customers
group by "Faixa_Etaria"
order by "Faixa_Etaria"



-- (Query 4) Faixa salarial dos leads
-- Colunas: faixa salarial, leads (%), ordem
select
	case
		when income < 5000 then '0-5000'
		when income < 10000 then '5000-10000'
		when income < 15000 then '10000-15000'
		when income < 20000 then '15000-20000'
		else '20000+'
		end as "faixa_salarial",
	count(*) / (select count(*)::float from sales.customers),
	case
		when income < 5000 then 1
		when income < 10000 then 2
		when income < 15000 then 3
		when income < 20000 then 4
		else 5 
		end as "ordem"
from sales.customers
group by "faixa_salarial", ordem
order by ordem desc


-- (Query 5) Classificação dos veículos visitados
-- Colunas: classificação do veículo, veículos visitados (#)
-- Regra de negócio: Veículos novos tem até 2 anos e seminovos acima de 2 anos
select
	case
		when extract('y' from fun.visit_page_date) - pro.model_year::numeric > 2 then 'Semi-novos'
		else 'Novos'
		end as "Classificacao",
		count(*)
from sales.products as pro
left join sales.funnel as fun
on pro.product_id = fun.product_id
group by "Classificacao"
order by "Classificacao"



-- (Query 6) Idade dos veículos visitados
-- Colunas: Idade do veículo, veículos visitados (%), ordem
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



-- (Query 7) Veículos mais visitados por marca
-- Colunas: brand, model, visitas (#)
select
	pro.brand,
	pro.model,
	count(*)
from sales.funnel as fun
left join sales.products as pro
on fun.product_id = pro.product_id
group by brand, model
order by brand, model











