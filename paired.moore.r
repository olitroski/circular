######################################################################
## Test no parametrico de Moore para muestras pareadas              ## 
##   - Calculos relativos a Zar(2010), seccion 27.14 Pagina 654     ##
##   - Randomization test acoorde a Pewsey(2012) Pagina 147         ##
##   - Tabla, acoorde a Moore(1980)                                 ##
## Escrito por: Oliver Rojas Bustamante - olitroski@gmail.com       ##
##              Lab. Sueño - U.Chile - Junio.2015                   ##
######################################################################
#rm(list=ls())
#antes <- c(105,120,135,95,155,170,160,155,120,115)
#despues <- c(205,210,235,245,260,255,240,245,210,200)

# Funcion
paired.moore <- function(var1, var2)   {
require(circular)

# Ver cual es mayor para la resta (ARREGLAR PORFA)
mean1 <- mean(var1); mean2 <- mean(var2)
if (mean1 > mean2) {
	a.ang <- var1
	b.ang <- var2
	} else {
		b.ang <- var1
		a.ang <- var2
		}
	rm(mean1, mean2, var1, var2)


# Seno y cosenos
a.cos <- cos(rad(a.ang))
a.sin <- sin(rad(a.ang))
b.cos <- cos(rad(b.ang))
b.sin <- sin(rad(b.ang))


# Diferencias
X <- a.cos - b.cos
Y <- a.sin - b.sin
r <- sqrt(X^2 + Y^2)
cos.phi <- X/r
sin.phi <- Y/r
ranks <- rank(r)
k <- length(r)
	rm(a.ang, a.cos, a.sin, b.ang, b.cos, b.sin, X, Y)


# Calculos del estadistico
X.moore <- (sum(ranks * cos.phi) / k)
Y.moore <- (sum(ranks * sin.phi) / k)
R.Moore <- sqrt((X.moore^2 + Y.moore^2) / k)				# R Observado
	rm(X.moore, Y.moore)


# Test randomizado
NR <- 9999   # Number of randomizados
nxtrm <- 1

# Calcula NR rantomizaciones
for (r in 1:NR) {
 cosphirand <- 0
 sinphirand <- 0
 # print(r)

	# Randomiza cada obs para formar un set
	for (j in 1:k) {
	if (runif(1) < 0.5) {
		cosphirand[j] <- cos.phi[j]
		sinphirand[j] <- sin.phi[j] }
		else {
			cosphirand[j] <- -cos.phi[j]
			sinphirand[j] <- -sin.phi[j] } }

	# Calcula el R de la muestra randomizada
	RRand <- ((sum(ranks*cosphirand)/k)^2 + (sum(ranks*sinphirand)/k)^2) / k
		if (RRand >= R.Moore) { nxtrm <- nxtrm+1 }
}

pval <- nxtrm/(NR+1)

# Output
cat("\t", "Test no parametrico de Moore para muestras circulares pareadas\n")
cat("\t\t", "k pares       = ", k, "\n")
cat("\t\t", "Estadistico R = ", R.Moore, "\n")
cat("\t\t", "p-valor       = ", pval)

}



