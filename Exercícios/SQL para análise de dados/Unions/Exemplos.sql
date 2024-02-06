-- SINTAXE #########################################################################
select coluna_1, coluna_2
from schema_1.tabela_1

union / union all

select coluna_3, coluna_4 
from schema_2.tabela_2


-- EXEMPLOS ########################################################################

-- (Exemplo 1) União simples de duas tabelas
-- Una a tabela sales.products com a tabela temp_tables.products_2
select *
from sales.products
union all
select *
from temp_tables.products_2

-- Aqui podemos ver um exemplo prático. Imaginemos que foi solicitada a atualização de produtos do catálogo e que,
-- como ainda não tinham confirmado a entrada, deixaram na tabela temporária mas agora querem subir para a tabela raiz para
-- de fato entrar nos produtos da loja. Dessa forma, pegamos da tabela temporária (não inclusos) e unimos com a tabela de produtos (inclusos).
