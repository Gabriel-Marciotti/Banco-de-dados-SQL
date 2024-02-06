-- TIPOS ###########################################################################
-- CASE WHEN
-- COALESCE()


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Agrupamento de dados com CASE WHEN
-- Calcule o nº de clientes que ganham abaixo de 5k, entre 5k e 10k, entre 10k e 
-- 15k e acima de 15k

-- O condicional pode ser utilizado em casos onde temos de agrupar múltiplos valores ou analisar um dado para gerar
-- uma resposta com diferentes casos, substituindo o group by, pois vamos criar agrupamentos de dados e trabalhar com eles
-- já prontos em uma seleção, inclusive, fazemos ele nas subqueryes, para assim como vimos anteriormente, utilizá-las posteriormente.
-- Muito semelhante aos cases de outras linguagens, aqui ele vai trabalhar com a variável apresentada, ou seja, vai definir ela a partir do
-- item de comparação dentro da coluna operada que estamos criando.

with faixa_De_renda as (
	select
		income,
		case
			when income < 5000 then '0-5000'
			when income >= 5000 and income < 10000 then '5000-10000'
			when income >= 10000 and income < 15000 then '10000-15000'
			else '15000+'
			end as faixa_renda
	from sales.customers
)
select faixa_renda, count(*)
from faixa_de_renda
group by faixa_renda
order by count(*)

-- Não utilizamos between pois ele iria desconsiderar o 5000 e o 10000, por exemplo, ou seja, temos de nos atentar nas utilizações e adequar cada
-- necessidade (se colocássemos o primeiro já considerando o 5000, poderíamos seguir nessa lógica)


-- (Exemplo 2) Tratamento de dados nulos com COALESCE
-- Crie uma coluna chamada populacao_ajustada na tabela temp_tables.regions e
-- preencha com os dados da coluna population, mas caso esse campo estiver nulo, 
-- preencha com a população média (geral) das cidades do Brasil

-- Podemos resolver conforme o case when, lembrando que para compararmos ou operarmos com dados de funções de agregação,
-- temos de usar um select senão vai dar erro, afinal, precisamos selecionar aquele valor (por ser único) para então utilizar ele.
-- Desta forma, invés de só informarmos avg, pois essa coluna não existe e essa consulta também não existe dentro da função.

select
	*,
	case
		when population is not null then population
		else (select avg(population) from temp_tables.regions)
		end as populacao_ajustada
from temp_tables.regions

-- Fazendo com o coalesce para tratar casos nulos fica melhor. Novamente nos deparamos com avg e relembramos, sempre que utilizarmos avg,
-- min, max para comparação ou operação dentro de uma função, temos de dar um select para trazer esses valores operados, pois dentro da função é
-- necessário o valor já estar pronto ou então pescarmos ele de novo

select
	*,
	coalesce(population, (select avg(population) from temp_tables.regions)) as populacao_ajustada
from temp_tables.regions


-- RESUMO ##########################################################################
-- (1) CASE WHEN é o comando utilizado para criar respostas específicas para 
-- diferentes condições e é muito utilizado para fazer agrupamento de dados
-- (2) COALESCE é o comando utilizado para preencher campos nulos com o primeiro
-- valor não nulo de uma sequência de valores. Podemos utilizá-lo para outros valores, ou seja, se inserirmos mais termos, ele verificará se o segundo campo não é nulo e se for, vai pro terceiro.

