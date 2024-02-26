" ALGORITMO: Localização base Bilhetagem (fora terminais e possiveis BRT)
" Autor: Antônio Claudio Dutra Batista
" Orientador: Francisco Moraes de Oliveira Neto
" Metodologia: Mesclagem por informações coincidentes e critério de tempo


## 1.0 Leitura das Bases
## 1.1 Leitura da base - Bilhetagem (Tratamento Inicial)
```{r}
# Instalando bibliotecas necessárias (caso não estiverem instaladas!)
if (!require("dplyr", quietly = TRUE)) {
  install.packages("dplyr")}
library(dplyr)
if (!require("lubridate", quietly = TRUE)) {
  install.packages("lubridate")}
library(lubridate)
if (!require("data.table", quietly = TRUE)) {
  install.packages("data.table")}
library(data.table)

# df's abaixo:
dia_01 <- read.csv('2018-11-01.csv', sep = ',')
dia_02 <- read.csv('2018-11-02.csv', sep = ',')
dia_03 <- read.csv('2018-11-03.csv', sep = ',')
dia_04 <- read.csv('2018-11-04.csv', sep = ',')
dia_05 <- read.csv('2018-11-05.csv', sep = ',') 
dia_06 <- read.csv('2018-11-06.csv', sep = ',')
dia_07 <- read.csv('2018-11-07.csv', sep = ',')
dia_08 <- read.csv('2018-11-08.csv', sep = ',')
dia_09 <- read.csv('2018-11-09.csv', sep = ',')
dia_10 <- read.csv('2018-11-10.csv', sep = ',')

# Continuando...
dia_11 <- read.csv('2018-11-11.csv', sep = ',')
dia_12 <- read.csv('2018-11-12.csv', sep = ',')
dia_13 <- read.csv('2018-11-13.csv', sep = ',')
dia_14 <- read.csv('2018-11-14.csv', sep = ',')
dia_15 <- read.csv('2018-11-15.csv', sep = ',')
dia_16 <- read.csv('2018-11-16.csv', sep = ',')
dia_17 <- read.csv('2018-11-17.csv', sep = ',')
dia_18 <- read.csv('2018-11-18.csv', sep = ',')
dia_19 <- read.csv('2018-11-19.csv', sep = ',')
dia_20 <- read.csv('2018-11-20.csv', sep = ',')

# Continuando...
dia_21 <- read.csv('2018-11-21.csv', sep = ',')
dia_22 <- read.csv('2018-11-22.csv', sep = ',')
dia_23 <- read.csv('2018-11-23.csv', sep = ',')
dia_24 <- read.csv('2018-11-24.csv', sep = ',')
dia_25 <- read.csv('2018-11-25.csv', sep = ',')
dia_26 <- read.csv('2018-11-26.csv', sep = ',')
dia_27 <- read.csv('2018-11-27.csv', sep = ',')
dia_28 <- read.csv('2018-11-28.csv', sep = ',')
dia_29 <- read.csv('2018-11-29.csv', sep = ',')
dia_30 <- read.csv('2018-11-30.csv', sep = ',')

dia_10$prefixo_carro = as.integer(dia_10$prefixo_carro) # transformando coluna com caracters em inteiro!

# Agrupando (10 dias)
dia_01_10 <- bind_rows(dia_01, dia_02, dia_03, dia_04, dia_05, dia_06, dia_07, dia_08, dia_09, dia_10)

# Continuando...
dia_11_20 <- bind_rows(dia_11, dia_12, dia_13, dia_14, dia_15, dia_16, dia_17, dia_18, dia_19, dia_20)

# Continuando...
dia_21_30 <- bind_rows(dia_21, dia_22, dia_23, dia_24, dia_25, dia_26, dia_27, dia_28, dia_29, dia_30)

# Mes completo
mes_tudo <-  bind_rows(dia_01_10, dia_11_20, dia_21_30)

# Deletando explicitamente variaveis denecessárias
rm(dia_01, dia_02, dia_03, dia_04, dia_05, dia_06, dia_07, dia_08, dia_09, dia_10, dia_11, dia_12, dia_13, dia_14, dia_15, dia_16, dia_17, dia_18, dia_19, dia_20, dia_21, dia_22, dia_23, dia_24, dia_25, dia_26, dia_27, dia_28, dia_29, dia_30, dia_01_10, dia_11_20, dia_21_30)

# Visualizando dados em uma janela separada 
View(mes_tudo)

# BUSCAR DADOS NULOS
str(mes_tudo)

# Mostrando dados nulos presentes
colSums(is.na(mes_tudo))

# Juntando colunas de interesse (dia, momento) em uma só:
mes_tudo$momento <- apply(mes_tudo[, c('dia', 'momento')], 1, function(x) paste(x, collapse = '-'))

# REMOVENDO COLUNAS DESNECESSÁRIAS!
mes <- select(mes_tudo, -c('hora', 'dia'))

# Removendo variavel desnecessária
rm(mes_tudo)

# Transformar formato da coluna momento de chr para coluna do tipo data
mes$momento <- as.POSIXct(mes$momento, format='%Y-%m-%d-%H:%M:%S')

# Removendo dados nulos na coluna prefixo_carro (pois a mesclagem sera para encontrar o veiculo corespondente no GPS, ou seja, veiculo em operação!)
mes <- mes[!is.na(mes$prefixo_carro), ]

# Transformando coluna de prefixo carro em inteiro
mes$prefixo_carro <- as.integer(mes$prefixo_carro)

str(mes)

# Última versão do df MES
View(mes)


```


# 1.2 Leitura da base - Dicionário
```{r}
# Lendo arquivo do dicionario
d1 <- read.csv('veiculos2018.csv', sep = ';')

# Mostrando Df
print(d1)

str(d1)

# Removendo caracteres da identifcação dos veciulos na coluna cod_veiculo
# d01 <- d1[grepl("^\\d+$", d1$cod_veiculo), ]
d1$cod_veiculo <- gsub("\\D", "", d1$cod_veiculo)
  
str(d1)

# Transformando coluna de cod_veiculo e id_veiculo em inteiro 
d1$cod_veiculo <- as.integer(d1$cod_veiculo) 


```


# 1.3 Leitura do base - GPS (base bruta com horario formatado!)
```{r}
# Especificando os tipos de dados
dtypes <- list(latitude = 'numeric', longitude = 'numeric', id_veiculo = 'integer', momento = 'character')

# Lendo o CSV com data.table
GPS_I_H <- fread('GPS_I_H_11_2018', select = c('latitude', 'longitude', 'id_veiculo', 'momento'), data.table = FALSE, skip = 0, header = TRUE, colClasses = dtypes)

str(GPS_I_H)
View((GPS_I_H))

# Verificando se existem dados nulos
print(colSums(is.na(GPS_I_H)))

# Transformar formato da coluna momento de character para tipo data
GPS_I_H$momento <- as.POSIXct(GPS_I_H$momento)

# Comprovando alteração para formato adequado
str(GPS_I_H)

# Transformar formato da coluna id_veiculo do df GPS de character para integer
GPS_I_H$id_veiculo <- as.integer(GPS_I_H$id_veiculo)

# Colocando valores em ordem
GPS_I_H <- arrange(GPS_I_H, momento)

# DEVIDO POSSUIREM MAIS DE UMA IDENTIFCAÇÃO PARA UM MESMO VEICULO DA BASE DA BILHETAGEM NO DICIONARIO, ISSO OCASIONARA UMA MAIS DE UMA ASSOCIAÇÃO NO PRIMEIRO MERGE (MESCLAGEM), OU SEJA, DADOS DE UMA MESMA VALIDAÇÃO DUPLICADO (SOMENTE EM CASOS QUE ESSA IDENTIFICACÇÃO SEJA DESSE TIPO!)

```

# 2.0 Junção da bilhetagem com o dicionário
```{r}
# Acrescentando dicionário
mes_d1 <- merge(mes, d1, by.x = 'prefixo_carro', by.y = 'cod_veiculo')

# Colunas do DataFrame resultante da junção
print(colnames(mes_d1))

print(mes_d1)

# Convertendo dados do id de cada veiculo da Bilhetagem para inteiro 
mes_d1$id_veiculo <- as.integer(mes_d1$id_veiculo)

# Colocando df em ordem na coluna momento
mes_geo <- mes_d1[order(mes_geo$momento), ]

rm(mes_d1)

print(str(mes_geo))

```


# 3.0 Integração da coordenada aproximada do ônibus na bilhetagem
''' A partir da mesclagem anterior será feita outra mesclagem utilizando o criterio de tempo mais proximo '''
```{r}
# Coordenada anterior mais próxima do ônibus é extraída da base de GPS e integrada na base da bilhetagem (SOMENTE COLUNAS MOMENTO E ID)
mes_d1_GPS_ <- mes_geo %>%
  approx_joi(GPS_geo, by =  c('momento', 'id_veiculo', method= 'nearest')

# Verificando valores nulos
print(colSums(is.na(mes_d1_GPS)))


# Caso necessite exportar o df localizado
# write.csv(mes_d1_GPS_, 'mes_bilhetagem_fora_terminais_BRT_.xlsx')

```

# 4.0 Plotagem da bilhetagem georreferenciada
```{r}
## 4.1 Instalação das bibliotecas e importação

# Instalando a biblioteca sf com conda
# !conda install -c conda-forge r-sf -y

# Instalando a biblioteca ggplot2 com conda
# !conda install -c conda-forge r-ggplot2 -y

# Carregando as bibliotecas
library(sf)
library(ggplot2)

## 4.2 Leitura de dados espaciais

# Ler os dados com sf
ceara_muni <- st_read('CE_Municipios_2022.shp')

### 4.2.1 Visualização dos dados

# Visualização
# ggplot() +
#   geom_sf(data = ceara_muni, fill = 'white', color = 'black') +
#   theme_minimal()

### 4.2.2 Filtro somente da capital

# Filtrando somente a capital 'Fortaleza'
fortal <- ceara_muni[ceara_muni$NM_MUN == 'Fortaleza', ]

# Salvando somente a geometria da capital
fortal_p <- fortal$geometry

# Mostrando a geometria da capital
print(fortal_p)

# Salvando o shapefile da capital
write_sf(fortal, 'fortal.shp')

# Lendo o shapefile da capital
fortall <- st_read('fortal.shp')

# Visualizando o shapefile da capital
print(fortall)

### 4.2.3 Modelo de dados espaciais e criação de coluna geometrica

# Instalando a biblioteca sf com conda
# !conda install -c conda-forge r-sf -y

# Carregando a biblioteca sf
library(sf)

# Criando coluna geometrica no sf (mes_d1_GPS)
mes_d1_GPS$geometry <- st_sfc(st_point(cbind(as.numeric(mes_d1_GPS$longitude), as.numeric(mes_d1_GPS$latitude))))

# Transformando o dataframe em um objeto sf
mes_d1_GPS_sf <- st_as_sf(mes_d1_GPS, coords = c('longitude', 'latitude'), crs = 4326)

# Mostrando os dados
print(mes_d1_GPS_sf)

### 4.2.4 Operação de interseção entre geometrias

# Filtrando os dados que estão dentro da malha da cidade
mes_geo_fortal <- st_intersection(mes_d1_GPS_sf, fortal_p)

# Mostrando as informações
print(summary(mes_geo_fortal))

# Salvando os dados georreferenciados em Fortaleza
write_sf(mes_geo_fortal, 'mes_geo_fortal.shp')

### 4.2.5 Mostrando dados no mapa de agrupamento (clusters)

# Instalando a biblioteca leaflet com conda
# !conda install -c conda-forge r-leaflet -y

# Carregando a biblioteca leaflet
library(leaflet)

# Criando o mapa de agrupamento
mapa <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = fortal, color = 'black', fillOpacity = 0.0) %>%
  addCircleMarkers(data = mes_geo_fortal, lng = ~longitude, lat = ~latitude, fillOpacity = 0.5, radius = 5)

# Salvando o mapa
saveWidget(mapa, 'mapa_agrupamento.html', selfcontained = FALSE)

### 4.2.6 Mostrando dados no mapa de calor (Heatmap)

# Criando o mapa de calor
mapa_heatmap <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = fortal, color = 'black', fillOpacity = 0.0) %>%
  addHeatmap(data = mes_geo_fortal, lng = ~longitude, lat = ~latitude)

# Salvando o mapa de calor
saveWidget(mapa_heatmap, 'mapa_calor.html', selfcontained = FALSE)

```

# 5.0 Testes
```{r}
## 5.1.0 Motivo do não georreferenciamento da base completa da bilhetagem

# Inspeção na base da bilhetagem e do dicionario para um veiculo especifico
veiculo_12994 <- mes[mes$prefixo_carro == 12994, ]
print(veiculo_12994)

# NOTAMOS QUE ESSE VEICULO ESPECIFICO POSSUI REGISTROS NA BILHETAGEM

### Verificando dados que estão presentes na base da bilhetagem e não na base do dicionario
lista <- unique(d01$cod_veiculo)
print(table(mes$prefixo_carro %in% lista))

# OU SEJA, DOS 100% DE DADOS NA BILHETAGEM APENAS 86,91% POSSUI UM CODIGO CORRESPONDENTE NA BASE DO DICIONARIO!

# VERIFICAÇÃO DO VEICULO 12994 NA BASE DO DICIONARIO 
print(d01[d01$cod_veiculo == 12994, ])

# CONCLUSÃO, APÓS INSPEÇÃO NOTAMOS QUE NÃO FOI POSSÍVEL GEORREFERENCIAR A BASE COMPLETA, POIS ALGUNS VEICULOS NÃO POSSUEM UM VEICULO QUE ASSOCIEI ELE NA BASE DO DICIONARIO, CONSEQUENTIMENTE NÃO TERÁ UM CÓDIGO DE VEÍCULO CORRESPONDENTE NA BASE DO GPS E NÃO VAI SER LOCALIZADO! UMA ABORDAGEM QUE NÃO EXCLUA OS DADOS DO DICIONARIO COM CARFACTERS PODE LOCALIZAR UMA MAIOR QUANTIDADE DE VALIDAÇÕS.

```

