
## ========================================================================
## Script para limpiar LAPOP 2019
## ========================================================================


library(tidyverse)
library(stargazer)

rm(list=ls())


## 1. Cargar base y seleccionar variables  -------------------------------

df <- haven::read_dta("data_lapop/lapop_uruguay_2019.dta") %>% 
  haven::as_factor()

# Seleccionar variables
df <- df %>%
  mutate(ed = as.numeric(ed)) %>% 
  mutate(ed_rec = factor(case_when(
    ed %in% c(1:6) ~ "Primaria",
    ed %in% c(7:9) ~ "Ciclo basico",
    ed %in% c(10:12) ~ "Bachillerato",
    ed %in% c(13:8) ~ "Terciaria",
  ),
  levels = c("Primaria", "Ciclo basico", "Bachillerato", "Terciaria"))) %>% 
  mutate(id_par = factor(
    case_when(
    vb10 == "No" ~ "No simpatiza con ningun partido",
    vb10 %in% c("No sabe", "No responde") ~ "NS/NC",
    vb11 == "Frente Amplio" ~ "Frente Amplio",
    vb11 == "Partido Nacional" ~ "Partido Nacional",
    vb11 == "Partido Colorado" ~ "Partido Colorado",
    TRUE ~ "Otros partidos"
  ),
  levels = c("Frente Amplio", "Partido Nacional", "Partido Colorado",
             "Otros partidos", "No simpatiza con ningun partido", "NS/NC"))) %>% 
  select(idnum, fecha, q1, q2, ed_rec, q3cn, ocup4a,
         vb2, vb3n, id_par, pol1, uruvbnc1, l1,
         a4, soct2, idio2, prot3, redist3, ing4,
         )

glimpse(df)


# Regresión lineal
df <- df %>% 
  mutate(l1_rec = case_when(
    l1 == "No responde" ~ NA_real_,
    l1 == "No sabe" ~ NA_real_,
    TRUE ~ as.numeric(l1)
    )
    ) %>% 
  mutate(q2 = as.numeric(q2),
         redist3 = case_when(
           redist3 %in% c("No sabe", "No responde") ~ NA_real_,
           TRUE ~ as.numeric(redist3)
           )
         ) %>% 
  mutate(prot3 = case_when(
    prot3 == "Sí ha participado" ~ 1,
    TRUE ~ 0
  )) %>% 
  mutate(q1 = case_when(
    q1 == "Mujer" ~ 1,
    TRUE ~ 0
  ))

glimpse(df)

table(df$l1_rec)

df <- df %>% 
  rename(mujer = q1,
         edad = q2,
         nivel_educativo = ed_rec,
         preferencias_redistribucion = redist3,
         participo_protesta = prot3)

m1 <- glm(l1_rec ~ mujer + edad + nivel_educativo + 
            preferencias_redistribucion + participo_protesta, 
          data = df)

summary(m1)

stargazer(m1, 
          type='latex',
          summary=FALSE, 
          font.size = "footnotesize", 
          p.auto = T)

# Gráfico de coeficientes de regresión
df_m1 <- broom::tidy(m1, conf.int = TRUE)

ggplot(df_m1 %>% 
         filter(term != "(Intercept)"), aes(x = estimate, y = fct_rev(term))) +
  geom_pointrange(aes(xmin = conf.low, xmax = conf.high)) +
  labs(title = "Determinantes de la ideología en Uruguay",
       subtitle = "Modelo de mínimos cuadrados ordinales",
       caption = "Data: LAPOP 2019") +
  theme_minimal(base_size = 16) +
  xlim(-1.5, 1.5) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  labs(x = "Coeficientes",
       y = "")

ggsave(filename = "coeficientes.png", height = 20, width = 25, units = "cm")


table(df$participo_protesta)
table(df$l1_rec)

data(mtcars)
dat <- subset(mtcars, select=c(mpg, am, vs))
dat


p1 <- ggplot(dat, aes(x=mpg, y=vs)) + geom_point() + 
  stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE) +
  theme_minimal(base_size = 16) +
  labs(title = "Regresión logística",
       x = "", 
       y = "") +
  ylim(-0.2, 1.2)

p2 <- ggplot(dat, aes(x=mpg, y=vs)) + geom_point() + 
  geom_smooth(method = "lm", se = FALSE) +
  theme_minimal(base_size = 16) +
  labs(title = "Regresión lineal",
       x = "", 
       y = "") +
  ylim(-0.2, 1.2)

library(ggpubr)

ggarrange(p1, p2)

ggsave(filename = "logistica.png", height = 20, width = 30, units = "cm")









