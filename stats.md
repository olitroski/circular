# Pruebas estadísticas

El contenido del repositorio se encuentra dividido por script disponible, cada uno con una pequeña descripción y requisitos. Dentro del script se encuentran mayores detalles sobre la función y/o datos de ejemplo.

> **Estrategia de uso:**
>
1. Cargar los paquetes	`circular` y `devtools`
2. Copiar el url del source address a un objeto `test <- "https://raw.github......etc.."`
3. Cargar el souce `source_url(test)`
4. Ejecutar el test

>
**Ejemplo:**
>
	library(circular); library(devtools)
	test <- https://raw.githubusercontent.com/olitroski/circular/master/summ.circ.R
	source_url(test)


## Estadísticas descriptivas
Este es un pequeño script para mostrar un output de estadísticas circulares de forma tabular más amigable que lo existente.

> Notas:
>
* Requiere un vector de ángulos en grados con módulo 360° sin mayor configuración 
* Si está configurado con `circular()` añadir la opción `circular = TRUE`
* Ejecutar con: `summ.circ(data)`

> Source url:
>
	https://raw.githubusercontent.com/olitroski/circular/master/summ.circ.R

## Comparaciones de grupo
### Test de Watson & Williams
El siguiente test contrasta la uniformidad de medias circulares y se consdiera un test paramétrico análogo a un *t-test*, pero que puede ser utilizado con más de un grupo. Es una mejora al test disponible en el paquete `circular`. 

	Watson, G. S., Williams, E. (1956). 
	On the construction of significance tests on the circle and the sphere.
	Biometrika, 43(2), 344-352.

> Notas:
>
* El input es `lista` de vectores de ángulos en grados con módulo 360° sin mayor configuración
* Una vez cargado el source ejecuar con: `test.watson.williams(data)`
* Las comparaciones de pares no tienen ajuste de probabilidad

> Source url:
>
	https://raw.githubusercontent.com/olitroski/circular/master/test.watson.williams.r

> Ejemplo:
> 
	a <- c(94,65,45,52,38,47,73,82,90,40,87)
    b <- c(77,70,61,45,50,35,48,65,36)
	c <- c(45,55,81,96,110,117,132,154)
	data <- list(a, b, c)
	test.watson.williams(data)

### Test de Wheeler & Watson
Este es un test no paramétrico para la hipótesis de igualdad de distribuciones de grupos en un circulo.

	Wheeler, S., & Watson, G. S. (1964). 
	A distribution-free two-sample test on the circle. 
	Biometrika1, 51, 256-257.

> Notas:
>
* El input es `lista` de vectores de ángulos en grados con módulo 360° sin mayor configuración
* Cada grupo debe tener `n >= 10`
* Una vez cargado el source ejecuar con: `test.wheeler.watson(data)`
* Las comparaciones de pares no tienen ajuste de probabilidad
* Warning 1: La función advierte y recomienda si hay empates en los rangos
* Warning 2: La función advierte si un grupo tiene menos de 10 observaciones

> Source url:
>
	https://raw.githubusercontent.com/olitroski/circular/master/test.wheeler.watson.r

> Ejemplo (datos que producen warnings):
> 
	a <- c(94,65,45,52,38,47,73,82,90,40,87)
    b <- c(77,70,61,45,50,35,48,65,36)
	c <- c(45,55,81,96,110,117,132,154)
	data <- list(a, b, c)
	test.wheeler.watson(data)


### Test de Hotelling para muestras pareadas
Este test es un análogo a t-test para muestras dependientes. Para mejores referencias consultar:

	Zar, J. H. (2010). Biostatistical Analysis. Page: 653

> Notas
>
* Requiere datos pareados en 2 vectores de ángulos en grados
* Una vez cargado el source ejecutar con `paired.hottelling(antes, despues)`

> Source url:
> 
	https://raw.githubusercontent.com/olitroski/circular/master/paired.hotelling.r

> Ejemplo:
>
	befor <- c(105,120,135, 95,155,170,160,155,120,115)
	after <- c(205,210,235,245,260,255,240,245,210,200)
	paired.hotelling(befor, after)

### Test de Moore para muestras pareadas
Este es un test no paramétrico análogo a la prueba de Wilcoxon. Incluye el cálculo del p-valor mediante un test de aleatorización (Pewsey, 2010). 

	Moore, B. R. (1980). 
	A Modification of the Rayleigh Test for Vector Data. 
	Biometrika, 67(1), 175-180. 

	Pewsey, A., Neuhäuser, M., & Ruxton, G. (2013). 
	Circular Statistics in R. Oxford University Press.
	
> Notas
>
* Requiere datos pareados en 2 vectores de ángulos en grados
* El cálculo del test de aleatorización puede tomar mucho tiempo si la data es grande
* Una vez cargado el source ejecutar con `paired.moore(antes, despues)`

> Source url:
> 
	https://raw.githubusercontent.com/olitroski/circular/master/paired.moore.r

> Ejemplo:
>
	befor <- c(105,120,135, 95,155,170,160,155,120,115)
	after <- c(205,210,235,245,260,255,240,245,210,200)
	paired.moore(befor, after)


### Correlación de Fisher & Lee
Tipo **Angular - Angular** considerada paramétrica

	Fisher, N. I., & Lee, A. J. (1983). 
	A correlation coefficient for circular data. 
	Biometrika, 70, 327-332.

Incluye el cálculo de Limites de confianza (Zar, 2010) y un test de aleatorización descrito en Pewsery (2013)

	Zar, J. H. (2010). Biostatistical Analysis. Page: 656

	Pewsey, A., Neuhäuser, M., & Ruxton, G. (2013). 
	Circular Statistics in R. Oxford University Press. Page: 156

> Notas:
>
* Se requieren dos vectores de ángulos en grados con módulo 360°
* El cálculo del test de aleatorización puede tomar mucho tiempo si la data es grande
* Una vez cargado el source ejecutar con `r.fisher.lee(data1, data2)`

> Source url:
> 
	https://raw.githubusercontent.com/olitroski/circular/master/r.fisher.lee.r

> Ejemplo
>
	data1 <- c(105,120,135, 95,155,170,160,155,120,115)
	data2 <- c(205,210,235,245,260,255,240,245,210,200)
	r.fisher.lee(data1, data2)





### Correlación de Mardia
Esta corrleación **Angular - Angular** no paramétrica es análoga al coeficiente de Spearman.

	Mardia, K. V. (1975). 
	Statistics of directional data. 
	Journal of Royal Stat. Soc., B37, 349-393.

> Notas:
>
* Se requieren dos vectores de ángulos en grados con módulo 360°
* El cálculo del test de aleatorización puede tomar mucho tiempo si la data es grande
* Una vez cargado el source ejecutar con `r.mardia(data1, data2)`

> Source url:
> 
	https://raw.githubusercontent.com/olitroski/circular/master/r.mardia.r

> Ejemplo
>
	data1 <- c(105,120,135, 95,155,170,160,155,120,115)
	data2 <- c(205,210,235,245,260,255,240,245,210,200)
	r.mardia(data1, data2)


### Correlación de Jhonson, Wherly & Mardia
Esta correlación es para **Angular - Circular** y hace uso extensivo de la correlación de Pearson y las coordenadas rectangulares de los ángulos para calcular el coeficiente. 

	Jhonson, R. A., & Wehrly, T. E. (1977). 
	Measures and models for angular correlation and angular-linear correlation.
	Journal of Royal Statist. Soc., 39(B), 222-229.

> Notas:
>
* Se requieren dos vectores de ángulos en grados con módulo 360°
* El cálculo del test de aleatorización puede tomar mucho tiempo si la data es grande
* Una vez cargado el source ejecutar con `r.jwm(data1, data2)`

> Source url:
> 
	https://raw.githubusercontent.com/olitroski/circular/master/r.jwm.r

> Ejemplo
>
	km  <- c( 48, 55, 26, 23, 22, 62, 64)
	ang <- c(190,160,210,225,220,140,120)
	r.jwm(km, ang)



