
## ***************************************************************************
##  Día 2: Manipulación de datos          
##  Solución de ejercicio                                          
##  Medición y diseño de investigación
##  Martín Opertti y Fabricio Carneiro - 2023                                         
## ***************************************************************************

## Trabajaremos con un dataframe con datos de económicos y políticos de Uruguay. 
# La base se llama "datauru" y esta en formato excel (.xlsx)

## 1. Importar dataframe "datauru" y asignarle el mismo nombre "datauru" y cargar
# el paquete tidyverse y readxl (usar funcion read_excel() para importar la base)
# de datos
library(tidyverse)
library(readxl)

rm(list=ls())

datauru <- read_excel("data/datauru.xlsx")

## 2. Imprime "datauru" y fijate las variables del dataframe y su tipo
# (puedes ayudarte con el codebook que está en la carpeta "data")
print(datauru)

## 3. Cuántas variables y observaciones tiene datauru?
dim(datauru)

## 4. Usa glimpse() para obtener un resumen de las variables
glimpse(datauru)

## 5. ¿Cuál es el rango de años para los cuales datauru tiene datos?
range(datauru$anio)

## 6. ¿Cuál es el promedio de inflación y de aprobación presidencial en Uruguay 
# en los años que tenemos datos?
mean(datauru$inflacion)
mean(datauru$aprobacion, na.rm = TRUE)

## 7. ¿Cuál es el porcentaje máximo de aprobación de presidente en un año en 
# Uruguay?
max(datauru$aprobacion, na.rm = TRUE)

## 8. Crea un histograma con la distribución del crecimiento anual de pbi per
# capita (crec_pbi)
hist(datauru$crec_pbi, 
     main = "Crecimiento anual del PBI per cápita en Uruguay")

## 9. ¿Cuál es la relación entre la inflación y el PBI en Uruguay? Un gráfico
# de dispersión puede ayudar
plot(datauru$pbi, datauru$inflacion,
     main = "Relación entre inflación y PBI en Uruguay")

## 10. Crea una variable "pbi_pc" que calcule el PBI per capita (utilizando las
# variables pbi y poblacion)
datauru <- mutate(datauru, pbi_pc = pbi / poblacion)

## 11. Crea un gráfico de dispersión con gdp_lcu y la nueva variable gdp_pc
plot(datauru$pbi, datauru$pbi_pc,
     main = "Relación entre PBI y PBI per cápita en Uruguay")

## 12. Crea una variable binaria "inf_digitos"que indique si la inflación tiene 
# dos dígitos o no
datauru <- mutate(datauru, inf_digitos = case_when(inflacion >= 10 ~ 1,
                                                   TRUE ~ 0))

## 13. Crear una nueva variable que indique los años con inflación y desempleo
# de un dígito
datauru <- datauru %>% 
  mutate(inf_desempleo = case_when(inflacion < 10 & desempleo < 10 ~ 1,
                                   TRUE ~ 0))
table(datauru$inf_desempleo)

## 14. Crear un nuevo dataframe a partir de datauru pero solo con las 
# observaciones de 1990 en adelante y solo las variables anio, presidente,
# inflacion y aprobacion. Usar el pipeline
datauru_2 <- datauru %>% 
  filter(anio >= 1990) %>% 
  select(anio, presidente, aprobacion, inflacion)

## 15. A partir del dataframe creado en el punto anterior, Crear una tabla
# resumen con la media y desvío de inflación y aprobación por presidente
tabla_resumen <- datauru_2 %>% 
  group_by(presidente) %>% 
  summarise(media_inflacion = mean(inflacion),
            desvio_inflacion = sd(inflacion),
            media_aprobacion = mean(aprobacion),
            desvio_aprobacion = mean(aprobacion))

tabla_resumen

## 16. Pasr la tabla resumen a formato largo
tabla_resumen %>% 
  pivot_longer(-presidente,
               values_to = "valores",
               names_to = "medida")





