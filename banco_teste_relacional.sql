-- ######################
-- CRIANDO BANCO DE DADOS "BANCO", PARA TESTES
-- Mostrando banco de dados criados 
SHOW DATABASES;

-- Comando para usar o banco de dados desejado 
-- USE banco_teste;

-- Criando banco de dados 
-- CREATE DATABASE banco;
USE banco_tp_fortaleza;

-- Executando o processo de restauração com o comando original:
-- mysql.exe --defaults-file="C:\Users\SAMSUNG\AppData\Local\Temp\tmpauictldx.cnf"  --protocol=tcp --host=127.0.0.1 --user=root --port=3306 --default-character-set=utf8 --comments --database=banco_teste < "C:\\Users\\SAMSUNG\\Cálculos\\Analises_NOVO\\MySQL\\Banco de Dados\\banco_lojas.sql"

-- #######################


-- #######################
-- COMONDO SELECT
-- EXEMPLO 01: SELECT* (seleciona todas as linhas e colunas da tabela)
-- Selecionando a tabela com dados dos clientes
SELECT * FROM clientes;  
-- Selecionando a tabela com dados dos pedidos dos clientes
SELECT * FROM pedidos; 

-- EXEMPLO 02: SELECT FROM (seleciona as linhas e colunas especificas da tabela)
-- Selecionando colunas especificas com dados dos clientes
SELECT Nome, Sobrenome, Email FROM clientes;  

-- EXEMPLO 03: SELECT AS (seleciona as linhas e colunas especificas da tabela e DAR NOMES)
-- Selecionando colunas especificas com dados dos PEDIDOS dos clientes e dar nomes
SELECT Data_Venda AS "Data da venda", ID_Produto AS "Id do produto", Qtd_Vendida AS "Quantidade vendida" FROM pedidos;  

-- EXEMPLO 04: SELECT LIMIT (seleciona as linhas e colunas especificas da tabela e LIMITA A QUANTIDADE DE LINHAS)
-- Selecionando colunas especificas com dados dos PEDIDOS dos clientes e ESPECIFICAS AS LINHAS A SEREM PEGAS 
SELECT * FROM pedidos LIMIT 100;

-- #######################


-- #######################
-- COMANDO ORDER BY
-- EXEMPLO 01: Ordenação dos dados a partir de uma determinada colunas da tabela
-- Ordenando de acordo com o nome do cliente em ordem alfabetica ASCENDENTE
SELECT *
FROM clientes
ORDER BY Nome;
-- ORDEM ALFABETICA DESCENDENTE:
-- SELECT *
-- FROM clientes
-- ORDER BY Nome desc;

-- ORDENNADO POR MAIS DE UMA COLUNA:
SELECT *
FROM clientes
ORDER BY Nome,Sobrenome;

-- EXEMPLO 02: Ordenação dos dados a partir de uma determinada colunas da tabela
-- Ordenando de acordo com a renda anual de maior para menor
SELECT *
FROM clientes
ORDER BY Renda_Anual DESC;


-- EXEMPLO 03: Ordenação dos dados a partir de uma determinada colunas da tabela
-- Ordenando de acordo com a data de nascimento do maior novo para o mais velho e colunas especificas 
SELECT Nome, Sobrenome, Email, Data_Nascimento
FROM clientes
ORDER BY Data_Nascimento DESC;

-- #######################


-- #######################
-- COMANDO WHERE
-- EXEMPLO 01: Seleção de informações especificas das colunas da tabela
-- Selecionando apenas os clientes do sexo feminino
SELECT *
FROM clientes
WHERE Sexo = "F";

-- EXEMPLO 02: Seleção de informações especificas das colunas da tabela
-- Selecionando apenas os produtos com preco acima de 2000
SELECT *
FROM produtos
WHERE Preco_Unit > 2000;

-- EXEMPLO 03: Seleção de informações especificas das colunas da tabela
-- Selecionando apenas os pedidos realizados em uma data especifica (10/03/2019)
SELECT *
FROM pedidos
WHERE Data_Venda = "2019-03-10";

-- #######################


-- #######################
-- COMANDOS SUM, COUNT, AVG, MIN E MAX
-- EXEMPLO 01: SUM - SOMA de dados de uma coluna especifica 
-- Somando os valores da coluna receita: receita total
SELECT SUM(Receita_Venda) AS "RECEITA TOTAL"
FROM pedidos;
 
-- EXEMPLO 02: COUNT - CONTAGEM de dados de uma coluna especifica 
-- Contando os individuos do sexo masculino  os valores da coluna receita: receita total
SELECT COUNT(Nome) AS "Quantidade de clientes"
FROM clientes
WHERE SEXO = "M";

-- EXEMPLO 03: AVG - MÉDIA ARITIMÉTRCIA de dados de uma coluna especifica 
-- Contando a média de salarios dos clientes
SELECT AVG(Renda_Anual) AS "Média salario por ano"
FROM clientes;

-- EXEMPLO 04: MIN e MAX- RETORNA O MENOR e MAIOR VALOR de dados de uma coluna especifica 
-- Pegando o menor preço de produto
SELECT MIN(Preco_Unit) AS "Preço unitrio minimo"
FROM produtos;
-- Pegando o maior preço de produto
SELECT MAX(Preco_Unit) AS "Preço unitrio minimo"
FROM produtos;

-- #######################


-- #######################
-- COMANDOS GROUP BY
-- EXEMPLO 01: GROUP BY - AGRUPAMENTO de dados de uma coluna especifica da tabela
-- Agrupamento que mostra a quantidade de produtos por marca
SELECT Marca_Produto, COUNT(Marca_Produto) AS "Quantidade Produtos"
FROM produtos
GROUP BY Marca_Produto;

-- EXEMPLO 02: GROUP BY - AGRUPAMENTO de dados de uma coluna especifica da tabela
-- Agrupamento que mostra a quantidade de clientes por escolariade
SELECT Escolaridade, COUNT(Escolaridade) AS "Quantidade de clientes"
FROM clientes
GROUP BY Escolaridade;

-- EXEMPLO 03: GROUP BY - AGRUPAMENTO de dados de uma coluna especifica da tabela
-- Agrupamento que mostra o total de receita po r id da loja 
SELECT ID_Loja, SUM(Receita_Venda) AS "Receita por loja"
FROM pedidos
GROUP BY ID_Loja;

-- #######################


-- #######################
-- COMANDOS JOIN
-- EXEMPLO 01: JOIN - RELACIONA dados de colunas especificas de tabelas
-- Trazer os dados da coluna LOJA para a tabela de pedidos 
SELECT pedidos.ID_Loja, Loja, Data_Venda, Receita_Venda
FROM pedidos
INNER JOIN lojas 
ON pedidos.Id_Loja = lojas.ID_Loja;

-- EXEMPLO 02: GROUP BY - RELACIONA dados de colunas especificas de tabelas
-- Trazer os dados da coluna LOJA para a tabela de pedidos e MOSTRAR O TOTAL DA RECEITA POR LOJA
SELECT Loja, SUM(Receita_Venda) AS "Receita total"
FROM pedidos
INNER JOIN lojas 
ON pedidos.Id_Loja = lojas.ID_Loja
GROUP BY Loja;

-- #######################

