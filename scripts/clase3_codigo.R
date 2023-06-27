
## ***************************************************************************
##  Módulo 3: Análisis de datos          
##  Código de la presentación                                      
##  Medición y diseño de investigación
##  Martín Opertti y Fabricio Carneiro - 2023                                         
## ***************************************************************************

##  1. Factores  ============================================================

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


