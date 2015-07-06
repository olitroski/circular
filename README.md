# Test estadísticos para datos circulares


Este repositorio es parte de un trabajo de investigación sobre estadística circular en el cual se utilizaron pruebas de inferencia que fueron desarrollados para funcionar como `source` en R. Fue escrito por *Oliver Rojas Bustamante* del *Laboratorio de Sueño y Neurobiología* en el *INTA* de la *Universidad de Chile*.

Cada test tiene sus propios requisitos, aunque en general se debe contar con vectores de ángulos en grados (no radianes) con modulo de 360°. Todas las transformaciones o cálculos lo realizan las funciones de cada script.

Algunos script hacen uso el paquete `circular` desarrollado por *Ulric Lund* y *Claudio Agostinelli* para el libro "Topics in circular Statistics" y para cargar el `source` es necesario el paquete `devtools`

Si quieres participar de este proyecto incorporando más pruebas o mejorando las que ya están haz tu `fork` del repositorio o escribe a `olitroski@gmail.com`.

En este enlace encontrarás las pruebas del repositorio:

[**Link a estadísticas circulares**](https://github.com/olitroski/circular/blob/master/stats.md)

### Test disponibles
* Estadisticas descriptivas
* Multigrupo: Test de Watson & Williams
* Multigrupo: Wheeler & Watson (No paramétrico)
* Datos pareados: Test de Hottelling
* Datos pareados: Test de Moore (No paramétrico) 
* Correlación Angular - Angular: Fisher & Lee
* Correlación Angular - Angular: Mardia (No paramétrico)
* Correlación Lineal - Angular: Jhonson, Wherly & Mardia


## Ejemplo de uso
Veamos por ejemplo el test de Moore (1980) para muestras pareadas.

> Cargamos el script del test (se debe cargar el paquete `devtools` y `circular`)

	library(devtools); 	library(circular)
	u <- "https://raw.githubusercontent.com/olitroski/circular/master/paired.moore.r"
	source_url(u)


> Cargar los datos (en forma de vectores) y ejecutar el test.

	# Datos pareados (ángulos en grados)
	var1 <- c(105,120,135,95,155,170,160,155,120,115)
	var2 <- c(205,210,235,245,260,255,240,245,210,200)
	
	# Ejecutar el test
	moore.paired(var1, var2)
	
> Resultados

	Test no parametrico de Moore para muestras circulares pareadas
	k pares       =  10 
	Estadistico R =  1.639599 
	p-valor       =  0.0256

**Nota:** Todos los test han sido checkeados, sin embargo, nuevas validaciones o indicaciones son bienvenidas en el email señalado. Pronto estará en inglés. Aportes en traducción también se agradecerán mucho.

![logo_uchile](https://github.com/olitroski/circular/blob/master/logo.inta.png)




 






