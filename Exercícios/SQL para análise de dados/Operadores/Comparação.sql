-- PARA QUE SERVE ##################################################################
-- Servem para comparar dois valores retornando TRUE ou FALSE
-- Muito utilizado em conjunto com a função WHERE para filtrar linhas de uma seleção


-- TIPOS ###########################################################################
-- =
-- >
-- <
-- >=
-- <=
-- <>


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Uso de operadores como flag
-- Crie uma coluna que retorne TRUE sempre que um cliente for um profissional clt 
select first_name, professional_status,
(professional_status = 'clt') as "verifica clt"
from sales.customers;


-- RESUMO ##########################################################################
-- (1) Servem para comparar dois valores retornando TRUE ou FALSE
-- (2) Muito utilizado em conjunto com a função WHERE para filtrar linhas de uma 
-- seleção
-- (3) Utilizados para criar colunas Flag que retornem TRUE ou FALSE
-- (4) Utilize o Guia de comandos para consultar os operadores utilizados no SQL
-- (5) Colocar seleções com operadores e semelhantes entre parênteses configuram boa prática







