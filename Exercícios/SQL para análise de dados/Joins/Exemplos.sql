-- EXERCÍCIOS ########################################################################

-- (Exemplo 1) Identifique qual é o status profissional mais frequente nos clientes 
-- que compraram automóveis no site
select t2.professional_status, count(t1.paid_date) as quantidade
from sales.funnel as t1
left join sales.customers as t2
on t1.customer_id = t2.customer_id
group by t2.professional_status
order by count(t1.paid_date) desc

-- O count nunca pode ser feito às cegas, devemos verificar se a tabela que devemos contar possui dados
-- nulos e focar o count para que não sejam computados dados nulos, afinal, ele contaria TODOS os elementos
-- da tabela esquerda. Logo, focamos no nosso objetivo (no exemplo foi a data de pagamento) e contamos a partir dele, que são os dados necessários

-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
select gend.gender, count(paid.paid_date)
from sales.funnel as paid
left join sales.customers as cust
on paid.customer_id = cust.customer_id
left join temp_tables.ibge_genders as gend
on lower(cust.first_name) = gend.first_name
group by gend.gender;

-- Aqui vemos que temos de nos atentar a formatação e estrutura dos dados, pois caso não coloquemos em lower, ele não 
-- conseguirá linkar ambas as tabelas, então sempre precisamos fazer uma análise estruturada de quais tabelas, dados,
-- tipos e joins vamos utilizar, para que tudo seja organizado. Novamente nos deparamos também com o count e nosso objetivo,
-- pois se contássemos pelo gênero, podiam aparecer resultados sem compras, mas como queremos de acordo com as compras, temos de contar por elas,
-- já que o join está feito e temos certeza que todas as compras que puxarmos estarão com um gênero, então se queremos os que COMPRARÃO, precisamos nos 
-- atentar a isso e contar pelo campo que delimita isso, que é o paid_date.
-- Ter certeza do tipo de dados e objeto da contagem para contar apenas os dados necessários ao objetivo.

-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select reg.region, count(visit.visit_id) as quantidade
from sales.funnel as visit
left join sales.customers as cust
on visit.customer_id = cust.customer_id
left join temp_tables.regions as reg
on cust.state = reg.state
group by reg.region
order by reg.region

-- Aqui notamos que o conhecimento de negócio é imprescindível (neste caso é óbvio), pois em alguns casos teremos de relacionar o join 
-- com mais de uma coluna para não causar conflitos ou duplicidades. No exemplo, utilizamos apenas state, mas caso necessitássemos do tamanho
-- da região, precisaríamos de ambos os campos juntos, cidade e estado para designar um tamanho em específico. Não utilizamos, mas é bom saber que em
-- alguns casos dois atributos vão designar uma relação nos joins, para que ela exista de maneira correta e seja direcionada de maneira correta, pois por exemplo, duas
-- cidades podem ser de estados diferentes e ter tamanhos diferentes ou ter o mesmo nome e tamanhos iguais.