
## ***************************************************************************
##  Día 2: Manipulación de datos          
##  Solución de ejercicio                                          
##  Medición y diseño de investigación
##  Martín Opertti - 2023                                         
## ***************************************************************************

## Trabajaremos con un dataframe con datos de económicos y políticos de Uruguay. 
# La base se llama "datauru" y esta en formato excel (.xlsx)

## 1. Importar dataframe "datauru" y asignarle el mismo nombre "datauru" y cargar
# el paquete tidyverse y readxl (usar funcion read_excel() para importar la base)
# de datos

## 2. Imprime "datauru" y fijate las variables del dataframe y su tipo
# (puedes ayudarte con el codebook que está en la carpeta "data")

## 3. Cuántas variables y observaciones tiene datauru?

## 4. Usa glimpse() para obtener un resumen de las variables

## 5. ¿Cuál es el rango de años para los cuales datauru tiene datos?

## 6. ¿Cuál es el promedio de inflación y de aprobación presidencial en Uruguay 
# en los años que tenemos datos?

## 7. ¿Cuál es el porcentaje máximo de aprobación de presidente en un año en 
# Uruguay?

## 8. Crea un histograma con la distribución del crecimiento anual de pbi per
# capita (crec_pbi)

## 9. ¿Cuál es la relación entre la inflación y el PBI en Uruguay? Un gráfico
# de dispersión puede ayudar

## 10. Crea una variable "pbi_pc" que calcule el PBI per capita (utilizando las
# variables pbi y poblacion)

## 11. Crea un gráfico de dispersión con gdp_lcu y la nueva variable gdp_pc

## 12. Crea una variable binaria "inf_digitos"que indique si la inflación tiene 
# dos dígitos o no

## 13. Crear una nueva variable que indique los años con inflación y desempleo
# de un dígito

## 14. Crear un nuevo dataframe a partir de datauru pero solo con las 
# observaciones de 1990 en adelante y solo las variables anio, presidente,
# inflacion y aprobacion. Usar el pipeline

## 15. A partir del dataframe creado en el punto anterior, Crear una tabla
# resumen con la media y desvío de inflación y aprobación por presidente

## 16. Pasr la tabla resumen del punto anterior a formato largo

