-- TIPOS ###########################################################################
-- LOWER()
-- UPPER()
-- TRIM()
-- REPLACE()

-- EXEMPLOS ########################################################################

-- (Exemplo 1) Corrija o primeiro elemento das queries abaixo utilizando os comandos 
-- de tratamento de texto para que o resultado seja sempre TRUE 

select upper('São Paulo') = 'SÃO PAULO'


select lower('São Paulo') = 'são paulo'


select trim('SÃO PAULO     ') = 'SÃO PAULO'


select replace('SAO PAULO', 'SAO', 'SÃO') = 'SÃO PAULO'

-- Não utilizamos apenas o A pois ele mudaria outros aspectos, então nestes casos onde vai dar um resultado diferente,
-- temos de especificar o local ou a parte do texto onde queremos a substituição para não haver uma alteração geral.



-- RESUMO ##########################################################################
-- (1) LOWER() é utilizado para transformar todo texto em letras minúsculas
-- (2) UPPER() é utilizado para transformar todo texto em letras maiúsculas
-- (3) TRIM() é utilizado para remover os espaços das extremidades de um texto
-- (4) REPLACE() é utilizado para substituir uma string por outra string









