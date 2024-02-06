-- PARA QUE SERVE ##################################################################
-- Serve para filtrar linhas da seleção por uma coluna agrupada


-- EXEMPLOS ########################################################################

-- (Exemplo 1) seleção com filtro no HAVING 
-- Calcule o nº de clientes por estado filtrando apenas estados acima de 100 clientes
select state, count(*)
from sales.customers
group by state
having count(*) > 100

-- O where não referencia resultados de uma função agregada, apenas de outros tipos de funções e operações, então
-- não podemos o utilizar em todos os casos como where count(*) > 100 pois é uma coluna agregada, então tems de utilizar o having para
-- trabalhar com ela. Poderíamos no mesmo código utilizar where para outras questões, como operações com state. Em contrapartida, poderíamos
-- colocar a comparação do where no having, pois funcionaria, pois ele tem função de where, devendo observar o uso.

select state, count(*)
from sales.customers
group by state
having count(*) > 100 and state <> 'MG'

select state, count(*)
from sales.customers
where state <> 'MG'
group by state
having count(*) > 100

-- RESUMO ##########################################################################
-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados 
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas








