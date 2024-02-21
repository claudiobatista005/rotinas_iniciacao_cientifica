--  COMANDOS TESTES PARA CRIAÇÃO E GERENCIAMENTO DE BANCO DE DADOS
-- OBS: MODELAGEM DO BANCO DE DADOS DO TIPO RELACIONAL DO TRANSPORTE PUBLICO AINDA SERÁ FEITA!


-- CRIANDO BANCO DE DADOS
-- Banco com dados do GPS, Dicionario e Bilhetagem
CREATE DATABASE banco_tp_fortaleza;
USE banco_tp_fortaleza;

-- Criando tabela do GPS
CREATE TABLE gps_bruto(
direction int,
latitude double,
longitude double,
metrictimestamp bigint,
odometer int,
routecode int,
speed int,
device_deviceid char(15),
vehicle_vehicleid int);

-- Visualizando tabela dicionario
SELECT *
FROM veiculos2018;

-- Quantidade de linhas da tabela
SELECT COUNT(*) AS "Quantidade de Linhas" 
FROM veiculos2018;

-- Descobrindo caminho permitido pelo --secure-file-priv para colar arquivo da planilha
SHOW VARIABLES LIKE "secure_file_priv";

-- Salvando o modo sql atual
-- SET @old_sql_mode = @@sql_mode;

-- Modificando o sql para desativar o strict_trans_tables temporariamente
-- SET SESSION sql_mode = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';

-- Carregando dados do GPS com o comando LOAD DATA INFILE (apos colar arquivo)
--  DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Paint112018.csv'
-- INTO TABLE gps_bruto
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- #### OBS: "FOI USADO UM CODIGO EM PYTHON PARA DIVIDIR A INSERÇÃO DAS LINHAS POR LOTES" ####


-- Revertendo para o sql original
-- SET SESSION slq_mode = @old_sql_mode;

-- Visualizando tabela GPS 
SELECT *
FROM gps_bruto;

-- Quantidade de linhas da tabela
SELECT COUNT(*) AS "Quantidade de Linhas" 
FROM gps_bruto;

-- Criando tabela da bilhetagem
CREATE TABLE bilhetagem_2018(
id int,
linha int,
nome_linha text,
prefixo_carro text,
hora char(20),
tipo_cartao text,
nome_cartao text,
sentido_viagem text,
integracao text,
dia char(20),
momento char(20));

-- Dados da tabela bilhetagem tambwm foram inseridos em lote por auxilio de um script em python!

-- Visualizando tabela Bilhetagem
SELECT *
FROM bilhetagem_2018;


-- TRATAMENTO INICIAL
-- Transformando coluna metrictimestamp no formato adequado para manipulação 
-- UPDATE paint112018
-- SET metrictimestamp = STR_TO_DATE(metrictimestamp, '%Y%m%d%H%i%s')
