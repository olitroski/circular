# Test estadísticos para datos circulares


Este repositorio es parte de un trabajo de investigación sobre estadística circular en el cual se utilizaron pruebas de inferencia que fueron desarrollados para funcionar como `source` en R. Fue escrito por *Oliver Rojas Bustamante* del *Laboratorio de Sueño y Neurobiología* en el *INTA* de la *Universidad de Chile*.

Cada test tiene sus propios requisitos, aunque en general se debe contar con vectores de ángulos en grados (no radianes) con modulo de 360°. Todas las transformaciones o cálculos lo realizan las funciones de cada script.

Algunos script hacen uso el paquete `circular` desarrollado por *Ulric Lund* y *Claudio Agostinelli* para el libro "Topics in circular Statistics" y para cargar el `source` es necesario el paquete `devtools`

Si quieres participar de este proyecto incorporando más pruebas o mejorando las que ya están haz tu `fork` del repositorio o escribe a `olitroski@gmail.com`.

En este enlace encontrarás las pruebas del repositorio:

[**Link a estadísticas circulares**](https://github.com/olitroski/circular/blob/master/stats.md)

## Test disponibles
* Estadisticas descriptivas
* Multigrupo: Test de Watson & Williams
* Multigrupo: Wheeler & Watson (No paramétrico)
* Datos pareados: Test de Hottelling
* Datos pareados: Test de Moore (No paramétrico) 
* Correlación Angular - Angular: Fisher & Lee
* Correlación Angular - Angular: Mardia (No paramétrico)
* Correlación Lineal - Angular: Jhonson, Wherly & Mardia


## Ejemplo de uso
Estadísticas descriptivas: 

> Cargar el source
>
	library(circular); library(devtools)
	dir <- "https://raw.githubusercontent.com/olitroski/circular/master/summ.circ.R"
	source_url(dir)

> Cargar datos y ejecutar
> 
	data <- c(45,55,81,96,110,117,132,154)
	summ.circ(data)

> Resultados
> 
	       Summary of Circular Statistics
	+---------------------+---------------------+
	| Mean        98.988  | Min          45.00  |
	| rho          0.825  | Q1 (25%)     74.50  |
	| Sum(cos)/n  -0.129  | Median      103.00  |
	| Sum(sin)/n   0.815  | Q3 (75%)    120.75  |
	| Sample n         8  | Max         154.00  |
	+---------------------+---------------------+



**Nota:** Todos los test han sido checkeados, sin embargo, nuevas validaciones o indicaciones son bienvenidas en el email señalado. Pronto estará en inglés. Aportes en traducción también se agradecerán mucho.



![logo_uchile](https://github.com/olitroski/circular/blob/master/logo.inta.png)




 






