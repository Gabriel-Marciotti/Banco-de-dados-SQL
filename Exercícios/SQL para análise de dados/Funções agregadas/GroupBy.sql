-- PARA QUE SERVE ##################################################################
-- Serve para agrupar registros semelhantes de uma coluna
-- Normalmente utilizado em conjunto com as Funções de agregação


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Contagem agrupada de uma coluna
-- Calcule o nº de clientes da tabela customers por estado
select state, count(*) as contagem
from sales.customers
group by state
order by contagem

-- utilizamos todos os registros para realizar o count pois independente do caso, haverá um id, tornando o código mais limpo (count usa como base o id para realizar os cálculos)

-- Vamos sempre focar na organização de nossos dados a serem demonstrados, por isso é sempre interessante utilizarmos os artifícios de ordem como order by, apelidos de colunas, limit etc.


-- (Exemplo 2) Contagem agrupada de várias colunas
-- Calcule o nº de clientes por estado e status profissional 
select state, professional_status, count(*) as contagem
from sales.customers
group by state, professional_status
order by contagem
order by state;

-- Dessa forma, vamos garantir que estejão organizados por estado e por quantidade

select state, professional_status, count(*) as contagem
from sales.customers
group by 1, 2
order by contagem
order by state;


-- É possível fazer desta forma também, contudo, caso o group by esteja muito distante das colunas referenciadas, trará sujeiras para o código, pois ele irá
-- ordenadamente atribuir aos números, então utilizamos este método apenas pesquisas enxutas

-- (Exemplo 3) Seleção de valores distintos
-- Selecione os estados distintos na tabela customers utilizando o group by
select state
from sales.customers
group by (state)
order by state


-- RESUMO ##########################################################################
-- (1) Serve para agrupar registros semelhantes de uma coluna, 
-- (2) Normalmente utilizado em conjunto com as Funções de agregação
-- (3) Pode-se referenciar a coluna a ser agrupada pela sua posição ordinal 
-- (ex: GROUP BY 1,2,3 irá agrupar pelas 3 primeiras colunas da tabela) 
-- (4) O GROUP BY sozinho funciona como um DISTINCT, eliminando linhas duplicadas


