-- TIPOS ###########################################################################
-- INTERVAL
-- DATE_TRUNC
-- EXTRACT
-- DATEDIFF


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Soma de datas utilizando INTERVAL
-- Calcule a data de hoje mais 10 unidades (dias, semanas, meses, horas)

-- O resultado será apresentado em data e hora, sendo assim, para conseguirmos apenas a data, podemos transformar todo o resultado em data,
-- pois durante o cálculo ele considera outro formato


select current_date + 10

select (current_date + interval '10 weeks')::date
select (current_date + interval '10 days')::date
select (current_date + interval '10 months')::date
select current_date + interval '10 hours'


-- (Exemplo 2) Truncagem de datas utilizando DATE_TRUNC
-- Calcule quantas visitas ocorreram por mês no site da empresa

-- Sempre será retornado o primeiro dia do mês em que estamos utilizando na fórmula, contudo, podemos utilizar para mês,
-- dia e ano, uma vez que ele indicará os dias que possuem valores e os selecionará. É mais utilizável para ano e mês, pois
-- independente do dia conseguimos agrupar os dados e como sempre vão coincidir com a mesma data, podemos fazer um group by, afinal,
-- se fosse sem o trunc, durante o group by seriam várias datas do mesmo mês, já neste, ele coloca todos na mesma data do e no agrupamento
-- é apresentado um resultado só para contarmos x visitas no mês.

-- Alteramos o tipo para data pois o comando de truncagem altera o tipo para data e hora


select
	date_trunc('month', visit_page_date)::date as mes,
	count(*)
from sales.funnel
group by mes
order by mes





-- (Exemplo 3) Extração de unidades de uma data utilizando EXTRACT
-- Calcule qual é o dia da semana que mais recebe visitas ao site

-- retorna a numeração do day of week

select
	'2022-01-30'::date,
	extract('dow' from '2022-01-30'::date)

select
	extract('dow' from visit_page_date) as dia_da_semana,
	count(*) as contagem
from sales.funnel
group by dia_da_semana
order by contagem desc



-- (Exemplo 4) Diferença entre datas com operador de subtração (-) 
-- Calcule a diferença entre hoje e '2018-06-01', em dias, semanas, meses e anos.

-- Consiste em uma questão matemática, pois temos no primeiro o total de dias, então se quisermos saber semanas,
-- dividimos por 7 e podemos expandir até décadas, trimestre, semestre etc, assim como fazemos no cotidiano

select (current_date - '2018-06-01')
select (current_date - '2018-06-01')/7
select (current_date - '2018-06-01')/30
select (current_date - '2018-06-01')/365


-- RESUMO --------------------------------------------------------------------------
-- (1) O comando INTERVAL é utilizado para somar datas na unidade desejada. Caso a 
-- unidade não seja informada, o SQL irá entender que a soma foi feita em dias.
-- (2) O comando DATE_TRUNC é utilizado para truncar uma data no início do período
-- (3) O comando EXTRACT é utilizado para extrair unidades de uma data/timestamp
-- (4) O cálculo da diferença entre datas com o operador de subtração (-) retorna  
-- valores em dias. Para calcular a diferença entre datas em outra unidade é necessário
-- fazer uma transformação de unidades (ou criar uma função para isso)
-- (5) Utilize o Guia de comandos para consultar as unidades de data e hora utilizadas 
-- no SQL

