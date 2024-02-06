-- PARA QUE SERVE ##################################################################
-- Servem para executar operações aritméticas nos registros de uma coluna 


-- TIPOS DE FUNÇÕES AGREGADAS ######################################################
-- COUNT()
-- SUM()
-- MIN()
-- MAX()
-- AVG()


-- EXEMPLOS ########################################################################

-- COUNT() -------------------------------------------------------------------------

-- (Exemplo 1) Contagem de todas as linhas de uma tabela
-- Conte todas as visitas realizadas ao site da empresa fictícia
select count(*)
from sales.funnel;

-- (Exemplo 2) Contagem das linhas de uma coluna
-- Conte todos os pagamentos registrados na tabela sales.funnel 
select count(paid_date)
from sales.funnel;

-- (Exemplo 3) Contagem distinta de uma coluna
-- Conte todos os produtos distintos visitados em jan/21
select count(distinct product_id)
from sales.funnel
where visit_page_date between '20210101' and '20210131';

-- OUTRAS FUNÇÕES ------------------------------------------------------------------

-- (Exemplo 4) Calcule o preço mínimo, máximo e médio dos productos da tabela products
select min(price), max(price), round(avg(price),2)
from sales.products;

-- (Exemplo 5) Informe qual é o veículo mais caro da tabela products
select *
from sales.products
where price = (select max(price) from sales.products)

-- Aqui verificamos que para consultar atributos de um item referenciado pelas funções, devemos utilizar a função como item de comparação, ainda assim
-- considerando o select, pois ele faz com que aquele item seja selecionado, como se no fim ele convertesse o select no dado a comparar, por isso será necessário
-- a seleção para extrair a informação do banco.
-- Em comparações do tipo, onde vamos fazer uma operação de comparação (maior, menor, menor ou igual etc.) é necessário sempre os parênteses para o valor a ser
-- comparado, sendo necessário para indicar aquele valor como um objeto apenas.

-- RESUMO ##########################################################################
-- (1) Servem para executar operações aritmética nos registros de uma coluna 
-- (2) Funções agregadas não computam células vazias (NULL) como zero
-- (3) Na função COUNT() pode-se utilizar o asterisco (*) para contar os registros
-- (4) COUNT(DISTINCT ) irá contar apenas os valores exclusivos
-- (5) COUNT(DISTINCT ) atenção sempre nas requisições de pesquisa ou queries a serem executadas, pois como no exemplo 3, calcular os produtos distintos não será as visitas distintas. Atenção!







