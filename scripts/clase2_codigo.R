
## ***************************************************************************
##  Día 2: Manipulación de datos          
##  Código de la presentación                                      
##  Medición y diseño de investigación
##  Martín Opertti y Fabricio Carneiro - 2023                                         
## ***************************************************************************


##  1. Directorios de trabajo  ===============================================

# Fijar el directorio de trabajo con setwd() 

library(readxl)

desempleo_uru <- read_excel("data/desempleo.xlsx")
head(desempleo_uru, 4) 
rm(desempleo_uru)



##  2. Importar datos a R   ==================================================

rm(list=ls())

## 2.1. Datos desde .csv ----

# Uno de los formatos más utilizados para almacenar datos son los archivos .csv
# En la carpeta data verán un .csv con datos de gapminder. 
# Tidyverse (mediante readr) nos permite importarlo con la función read_csv()
gapminder_csv <- read_csv("data/gapminder.csv")
head(gapminder_csv) # Usamos head para imprimir las primeras filas


## 2.2. Datos desde excel ----

# En la carpeta hay también un archivo llamado "gapminder" pero en formato excel
# Para importar datos de excel podemos utilizar el paquete readxl 
# Usamos la función read_excel()
library(readxl)
gapminder_excel <- read_excel("data/gapminder.xlsx")
head(gapminder_excel)


## 2.3. Desde un paquete de R ----

# Algunos paquetes vienen con datos, por ejemplo, gapminder.
# En la documentación del paquete se encuentra el nombre de los datos 
# Con una simple asignación los podemos cargar 
library(gapminder)
d_gap <- gapminder


## 2.4. Datos desde SPSS y Stata ----
# Para estos tipos de datos usamos el paquete haven
library(haven)
gapminder_spss <- read_spss("data/gapminder.sav") # SPSS
class(gapminder_spss$continent)
head(gapminder_spss)

gapminder_stata <- read_stata("data/gapminder.dta") # STATA
head(gapminder_stata)

# Para esto no necesitamos cargar paquetes. 
# Guardar un objeto como .rds:
saveRDS(object = d_gap, file = "resultados/d_gap.rds") # Creamos un archivo .rds

miobjeto_rds <- readRDS(file = "resultados/d_gap.rds") # Leemos un archivo .rds

# Con .rda se pueden guardar varios objetos al mismo tiempo!
save(d_gap, miobjeto_rds, 
     file = "resultados/dos_dataframes.Rdata") # Creamos un archivo .Rdata

rm(d_gap, miobjeto_rds) # Eliminamos el objeto del ambiente

load("resultados/dos_dataframes.Rdata") # Leemos un archivo .Rdata



##  3. Exportar datos =======================================================

rm(list = ls())

# Guardar .csv
d_gap <- gapminder
write_excel_csv(d_gap, "resultados/gapminder.csv")

# Guardar excel
library(writexl)
write_xlsx(d_gap, "resultados/gapminder.xlsx")

# Guardar .dta (Stata)
write_dta(d_gap, "resultados/gapminder.dta")

# Guardar .sav (SPSS)
write_sav(d_gap, "resultados/gapminder.sav")

# Guardar .sas (SAS)
write_sas(d_gap, "resultados/gapminder.sas")

# Chequeen en su carpeta de resultados que estén las bases nuevas



##  4. Factores  ============================================================

rm(list = ls())

d_gap <- gapminder

# Podemos chequear y coercionar factores
is.factor(d_gap$continent) # Chequeo si es factor
levels(d_gap$continent) # Chequeo los niveles

# Transformo a caracter
d_gap$continent <- as.character(d_gap$continent)
class(d_gap$continent)

# De vuelta a factor
d_gap$continent <- as.factor(d_gap$continent) 
class(d_gap$continent)



##  5. Explorar datos  ======================================================

# R tiene un visor para datos. Pueden clickear en el dataframe en el ambiente o:
View(d_gap)
dim(d_gap) # Número de filas y columnas
names(d_gap) # Nombre de variables
head(d_gap, 3) # Imprime primeras filas (3 en este caso)
glimpse(d_gap) # Recomiendo utilizar esta función


# Para obtener una tabla de frecuencias de una variable usamos la función 
# table() de R Base
table(d_gap$continent) # Frecuencia simple

tabla_1 <- table(d_gap$continent) # Frecuencia simple

prop.table(tabla_1) # Proporciones

addmargins(tabla_1) # Totales

addmargins(prop.table(tabla_1)) # Proporciones y totales



## 6. Estadisticos descriptivos ============================================

# R cuenta también con funciones para obtener estadísticos descriptivos
mean(d_gap$lifeExp) # Media
median(d_gap$lifeExp) # Mediana
sd(d_gap$lifeExp) # Desvío estandar
range(d_gap$lifeExp) # Rango
max(d_gap$lifeExp) # Minimo
min(d_gap$lifeExp) # Maximo


# También podemos crear un histograma muy fácilmente
hist(d_gap$lifeExp,
     main = "Distribución de expectativa de vida (Gapminder)")

# Gráfico de dispersión (scatterplot)
plot(d_gap$lifeExp, d_gap$gdpPercap,
     main = "Relación entre expectativa de vida y PBI per cápita")

quantile(d_gap$lifeExp, probs=c(0.2, 0.4, 0.6, 0.8)) # Cuantiles
quantile(d_gap$lifeExp, probs=seq(0, 1, 0.2)) # Cuantiles

# Con la función ntile() de dplyr podemos asignar quintiles en una variable
d_gap$lifeExp_quintil <- ntile(d_gap$lifeExp, 5)

# Tabla cruzada 
table(d_gap$continent, d_gap$lifeExp_quant)



##  7. Filtrar observaciones   ==============================================

## Una de las transformaciones más frecuentes cuando manipulamos datos 
# Tenemos datos de muchos años:
table(d_gap$year)

# Filtremos para con los datos a partir de 2007
gapminder_07 <- filter(d_gap, year == 2007)
table(gapminder_07$year)

# Todas los años menos 2007
gapminder_pre07 <- filter(d_gap, year != 2007)
table(gapminder_pre07$year)

# Solo los siguientes años: 1952, 1992 y 2007
anios_especificos <- c(1952, 1992, 2007)
gapminder_esp <- filter(d_gap, year %in% anios_especificos)
table(gapminder_esp$year)

# O podría hacer
gapminder_esp <- filter(d_gap, year %in% c(1952, 1992, 2007))
table(gapminder_esp$year)



##  8. Seleccionar variables (columnas)  ====================================

d_gap <- gapminder # cargo la base de vuelta
colnames(d_gap)

# Selccionar un conjunto de variables (país, año, población)
select(d_gap, country, year, pop)

# Selccionar todas las variables menos las especificadas
select(d_gap, -continent)

# Seleccionar un rango de variables según orden
select(d_gap, country:lifeExp)
select(d_gap, 1:3) # Orden numérico



##  9. Pipeline   ===========================================================

# Supongamos que queremos filtrar la base para quedarnos con las observaciones
# del año 2007 y del continente americano. Y desoués quedemos borrar la variable
# continente porque ya no nos sirve (todos los valores son "Americas") y ordenar
# de mayor a menor según expectativa de vida

# Con el pipeline podemos hacer todo esto especificando una sola vez el 
# dataframe al comienzo. Cada %>% se lee como un "y entonces". R interpreta
# las distintas funciones en orden
gapminder_07_america <- d_gap %>% 
  filter(year == 2007 & continent == "Americas") %>% 
  select(-continent) %>% 
  arrange(desc(lifeExp))

print(gapminder_07_america)



##  10. Crear y recodificar variables   ======================================

rm(list=ls())

## 10.1.  Crear variables con mutate() de dplyr ----

d_gap <- gapminder
head(d_gap, 3)

# Primero veamos cómo crear una constante
d_gap <- mutate(d_gap, var1 = "Valor fijo") # Variable de caracteres
d_gap <- mutate(d_gap, var2 = 7) # Variable numérica
head(d_gap, 3)

# También podemos crear ambas variables dentro de la misma línea 
d_gap <- gapminder
d_gap <- mutate(d_gap, 
                var1 = "Valor fijo",
                var2 = 7)
head(d_gap, 3)

# Podríamos haber hecho lo mismo con R Base
d_gap <- gapminder
d_gap$var1 <- "Valor fijo"
d_gap$var2 <- 7
head(d_gap, 3)

# Con mutate() también podemos hacer operaciones sobre variables ya existentes
# Calculemos el pbi total (pbi per capita * población)
d_gap <- mutate(gapminder, gdp = gdpPercap * pop)
head(d_gap, 3)

# Podemos calcular el logaritmo
d_gap <- mutate(d_gap, gdp_log = log(gdp))
head(d_gap, 3)


## 10.3 Transformar tipo de datos de variables 

# Exploro tipo de variables
glimpse(d_gap)

# Variable continente a caracteres y año a factor
d_gap <- d_gap %>% 
  mutate(continent = as.character(continent),
         year = as.factor(year))

# Exploro tipo de variables
glimpse(d_gap)

# Variable año a numérica nuevamente
d_gap <- d_gap %>% 
  mutate(year = as.numeric(year))

# Exploro tipo de variables
glimpse(d_gap)



## 11. Recodificaciones condicionales =========================================

rm(list=ls())


## 11.1. Recodificación con case_when() ----
d_gap <- gapminder

# Creemos una variable que indique si el país es Uruguay o no
d_gap <- mutate(d_gap, uruono = case_when(country == "Uruguay" ~ "Si",
                                          TRUE ~ "No"))

table(d_gap$uruono)

## Con case_when() podemos establecer varias condiciones fácilmente
d_gap <- mutate(d_gap, mercosur = case_when(country == "Uruguay" ~ 1,
                                            country == "Argentina" ~ 1,
                                            country == "Paraguay" ~ 1,
                                            country == "Brazil" ~ 1,
                                            TRUE ~ 0))
table(d_gap$mercosur)

# También podemos usar operadores para simplificar
d_gap <- mutate(d_gap, mercosur_2 = case_when(
  country %in% c("Argentina", "Paraguay", "Brazil", "Uruguay") ~ 1,
  TRUE ~ 0)
) 

d_gap <- mutate(d_gap, mercosur_3 = case_when(
  country == "Argentina" | country == "Paraguay" | 
    country == "Brazil" | country == "Uruguay" ~ 1,
  TRUE ~ 0)
)

identical(d_gap$mercosur, d_gap$mercosur_2)
identical(d_gap$mercosur_2, d_gap$mercosur_3)

# También puedo crear variables en función a dos variables 
d_gap <- mutate(d_gap, var1 = case_when(gdpPercap > 20000 ~ 1,
                                        lifeExp > 75 ~ 1,
                                        TRUE ~ 0))
table(d_gap$var1)



## 12. Resumir datos  ====================================================

## Resumen con la media de lifeExp
gapminder %>% 
  summarise(media = mean(lifeExp, na.rm=T))

# Por ahora no hay mucha diferencia con
mean(gapminder$lifeExp, na.rm = TRUE)

## Pero, con group_by() podemos crear grupos para nuestros resumenes
gapminder %>% 
  group_by(year) %>% 
  summarise(media = mean(lifeExp, na.rm = T))

## Como con la mayoría de las funciones de dplyr, nos devuelve un dataframe, 
# que podemos guardar en un objeto
gap_resumen <- gapminder %>% 
  group_by(year) %>% 
  summarise(media = mean(lifeExp, na.rm = T))

## Podemos agrupar por dos o más variables si queremos también
# Por ejemplo, calculemos la media de expectativa de vida por año comparando
# America y Europa para 1997, 2002 y 2007:
resumen_1 <- gapminder %>% 
  filter(continent %in% c("Americas", "Europe")) %>% 
  filter(year >= 1997) %>% 
  group_by(continent, year) %>% 
  summarise(media = mean(lifeExp, na.rm = TRUE))

# Podemos generar varios resumenes son summarise(), que son variables del 
# dataframe que devuelve
resumen_2 <- gapminder %>% 
  filter(continent %in% c("Americas", "Europe")) %>%
  filter(year == 2007) %>%
  group_by(continent) %>% 
  summarise(media = mean(gdpPercap),
            desvio = sd(gdpPercap),
            suma = sum(gdpPercap),
            max = max(gdpPercap),
            min = min(gdpPercap),
            paises = n()) 
resumen_2

# Es muy flexible por ejemplo podemos hacer operaciones dentro de las variables
# por ejemplo sumarle el número 5 a la variable de la media
gapminder %>% 
  filter(continent %in% c("Americas", "Europe")) %>%
  filter(year == 2007) %>%
  group_by(continent) %>% 
  summarise(media = mean(lifeExp),
            media_5 = mean(lifeExp) + 5) 



## 13. Cambios de estructura  =============================================

# Muchas veces los datos que importamos o las salidas mismas de funciones
# no tienen el formato que queremos. Para cambiar eso podemos pasar los datos
# de largo a anacho o de ancho a largo

# Tomemos por ejemplo el resumen_2 que creamos previamente. 
print(resumen_2)

# Cada medida es una variable. Podríamos querer ver esta misma información en 
# formato largo donde el tipo de medida (las columnas) se una variable, y 
# los valores otra. Para esto tenemos que pasar el dataframe a formato largo:

resumen_2_largo <- resumen_2 %>% 
  pivot_longer(cols = -continent, # Unimos todas las columnas menos continent 
               names_to = "medida", # Nombre de variable con las columnas 
               values_to = "valor") # Nombre de variable con valores

# Ahora a este mismo resumen podría querer transformarlo en una tabla más
# parecida a lo que estamos acostumbrados a leer. La medida seguiría siendo
# una columna pero los valores se distribuirían en dos columnas distintas: 
# Americas y Europa. 

# Para hacer esto pasamos de formato largo a ancho:
resumen_2_largo %>% 
  pivot_wider(names_from = continent, # Variable que pasa a distintas columnas
              values_from = valor) # Variable donde se extraen los valores





