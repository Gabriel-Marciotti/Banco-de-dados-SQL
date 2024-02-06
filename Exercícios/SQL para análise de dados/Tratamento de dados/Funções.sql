-- PARA QUE SERVEM #################################################################
-- Servem para criar comandos personalizados de scripts usados recorrentemente.


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Crie uma função chamada DATEDIFF para calcular a diferença entre
-- duas datas em dias, semanas, meses, anos

-- Aqui visualizamos muitas utilizações, como o int para substituir múltiplos ors com o mesmo
-- tipo de dado e o uso do case para definir os diferentes casos. O que vamos considerar é que estamos
-- criando uma função, então a partir dos termos, vamos fazer uma determinada operação, o que facilita nossas queries,
-- assim como vemos no exemplo, onde vamos inserir a unidade (e como é o mesmo tipo, utilizamos o in para dar mais opções e
-- tornar flexível o código), data inicial e final, tornando mais fácil nossas extrações de diferenças de datas.
-- OBS: A função será armazenada no SGBD

create function datediff(unidade varchar, data_inicial date, data_final date)
returns integer
language sql
as

$$

select
	case
		when unidade in ('d', 'day', 'days') then (data_final - data_inicial)
		when unidade in ('w', 'week', 'weeks') then (data_final - data_inicial)/7
		when unidade in ('m', 'month', 'months') then (data_final - data_inicial)/30
		when unidade in ('y', 'year', 'years') then (data_final - data_inicial)/365
		end as  intervalo
$$



-- (Exemplo 2) Delete a função DATEDIFF criada no exercício anterior

drop function datediff


-- RESUMO ##########################################################################
-- (1) Para criar funções, utiliza-se o comando CREATE FUNCTION
-- (2) Para que o comando funcione é obrigatório informar (a) quais as unidades dos 
-- INPUTS (b) quais as unidades dos OUTPUTS e (c) em qual linguagem a função será escrita. É muito semelhante a criação de outras funções em linguagens de programação, onde temos de definir a entrada e retornar o resultado, mudando (claro) a sintaxe e alguns detalhes, como a definição da linguagem
-- (3) O script da função deve estar delimitado por $$
-- (4) Para deletar uma função utiliza-se o comando DROP FUNCTION

