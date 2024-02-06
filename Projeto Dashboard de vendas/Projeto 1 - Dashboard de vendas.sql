-- (Query 1) Receita, leads, conversão e ticket médio mês a mês
-- Colunas: mês, leads (#), vendas (#), receita (k, R$), conversão (%), ticket médio (k, R$)
with
	leads as(
	select 
		date_trunc('month', visit_page_date)::date as mes,
		count(visit_page_date) as leads
	from sales.funnel
	group by mes
	order by mes
	),

	payments as (
	select
		date_trunc('month', paid_date)::date as mes,
		count(*) as vendas,
		(sum((pro.price + (fun.discount * pro.price)))/1000) as receita
	from sales.funnel as fun
	inner join sales.products as pro
	on fun.product_id = pro.product_id
	group by mes
	order by mes
	)

select 
	lea.mes,
	lea.leads,
	pay.vendas,
	pay.receita,
	(pay.vendas::float / lea.leads::float) as conversao,
	(pay.receita/pay.vendas) as ticket
from leads as lea
left join payments as pay
on lea.mes = pay.mes

-- (Query 2) Estados que mais venderam no último mês
-- Colunas: país, estado, vendas (#)
select
	'Brazil' as pais,
	cus.state as estado,
	count(fun.paid_date) as vendas
from sales.funnel as fun
left join sales.customers as cus
on fun.customer_id = cus.customer_id
where fun.paid_date between '2021-08-01' and '2021-08-31'
group by state
order by vendas desc


-- (Query 3) Marcas que mais venderam no último mês
-- Colunas: marca, vendas (#)
select
	pro.brand,
	count(fun.paid_date) as vendas
from sales.funnel as fun
left join sales.products as pro
on fun.product_id = pro.product_id
where fun.paid_date between '2021-08-01' and '2021-08-31'
group by pro.brand
order by vendas desc


-- (Query 4) Lojas que mais venderam
-- Colunas: loja, vendas (#)
select
	sto.store_name,
	count(fun.paid_date) as vendas
from sales.funnel as fun
left join sales.stores as sto
on fun.store_id = sto.store_id
where fun.paid_date between '2021-08-01' and '2021-08-31'
group by sto.store_name
order by vendas desc


-- (Query 5) Dias da semana com maior número de visitas ao site
-- Colunas: dia_semana, dia da semana, visitas (#)
create function dia_semana(unidade numeric)
returns varchar
language sql
as
$$
	select
		case
			when unidade = 0 then 'Segunda-feira'
			when unidade = 1 then 'Terça-feira'
			when unidade = 2 then 'Quarta-feira'
			when unidade = 3 then 'Quinta-feira'
			when unidade = 4 then 'Sexta-feira'
			when unidade = 5 then 'Sábado'
			when unidade = 6 then 'Domingo'
			end
$$


select
	extract('dow' from visit_page_date) as dia_numerico,
	dia_semana(extract('dow' from visit_page_date)),
	count(visit_id) as quantidade
from sales.funnel
where visit_page_date between '2021-08-01' and '2021-08-31'
group by dia_numerico
order by dia_numerico