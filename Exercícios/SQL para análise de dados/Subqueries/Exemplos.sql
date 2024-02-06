-- EXEMPLOS ########################################################################

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas
with primeira_visita as (
	select customer_id, min(visit_page_date) as visita_1
	from sales.funnel
	group by customer_id
)
select
	visit_page_date,
	(fun.visit_page_date <> primeira_visita.visita_1) as lead_recorrente,
	count(*)
from sales.funnel as fun
left join primeira_visita
on fun.customer_id = primeira_visita.customer_id
group by fun.visit_page_date, lead_recorrente
order by fun.visit_page_Date desc, lead_recorrente

-- O raciocínio nestes casos é começar pelos filtros que não possuímos em nossas tabelas, que vão gerar a subquery,
-- então primeiro pegamos todas as primeiras visitas separadamente, depois juntamos a tabela geral com ela para saber quais
-- daqueles dados foram a primeira visita e posteriormente fazemos a verificação se é ou não um lead recorrente para demonstrar os
-- valores separados e agrupamos pelas primeiras visitas e pelas demais, o que vai concluir nossa query e fazer com que a cada duas
-- linhas tenhamos primeiras visitas e demais visitas no dia

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)
with media as (
	select brand, avg(price)
	from sales.products
	group by brand
)

select
	visit_id,
	customer_id,
	pro.brand,
	((pro.price) + fun.discount * 100)
from sales.funnel as fun
left join sales.products as pro
on fun.product_id = pro.product_id