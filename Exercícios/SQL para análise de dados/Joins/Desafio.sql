-- EXERCÍCIOS ########################################################################

-- (Exercício 1) Identifique quais as marcas de veículo mais visitadas na tabela sales.funnel
-- Ordem dos Joins: funnel, products
-- Contagem: visit_id
-- conexão: product_id

select prod.brand, count(visit_id) as visitas
from sales.funnel as visit
left join sales.products as prod
on visit.product_id = prod.product_id
group by prod.brand
order by visitas desc;

-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel
-- Ordem dos Joins: funnel, stores
-- Contagem: visit_id
-- conexão: store_id

select store_name, count(visit_id) as visitas
from sales.funnel as visit
left join sales.stores as store
on visit.store_id = store.store_id
group by store_name
order by visitas desc
limit 10

-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)
-- Ordem dos Joins: customers, funnel
-- Contagem: size
-- conexão: city, state
-- detalhe: há diferença na formatação pois alguns clientes colocaram com maíusculo e outros com minúsculo

select reg.size, count(size) 
from temp_tables.regions as reg
right join sales.customers as cus
on lower(reg.city) = lower(cus.city) and lower(reg.state) = lower(cus.state)
group by size
order by size

-- Devemos sempre pensar, de todos X, quero saber quantos Y tem aqui. Por exemplo, de todos esses clientes,
-- qual a região deles. Ou então, de todas essas visitas, quais marcas pesquisaram e quais lojas, pois isso vai
-- definir quem está à esquerda ou direita do join (consecutivamente de acordo com os exemplos) e então trazer o resultado
-- correto para as pesquisas, pois precisamos sempre da quantidade de um e o que queremos achar dele na outra
-- (se invertermos, será diferente, ou seja, da tabela à esquerda, o que queremos filtrar na direita considerando todos aqueles valores)