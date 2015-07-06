#--------------------------------------------------------------------------------#
#---- Hotelling test for paried circular data -----------------------------------#
#---- Based on circular package - programmed by Oliver Rojas --------------------#
#---- Lab.Sueño, INTA, U. de Chile, 07.2015 -------------------------------------#
#--------------------------------------------------------------------------------#
# Best acording example in Zar, page 653
# Zar, J. H. (2010). Biostatistical Analysis. Pearson.

# Example: 
# rm(list=ls())
# antes <- c(105,120,135, 95,155,170,160,155,120,115)
# despues <- c(205,210,235,245,260,255,240,245,210,200)

# Funcion del test
paired.hotelling <- function(var1, var2) {
library(circular)
options(digits=5)			# para los decimales

# ver cual es mas grande
mean1 <- mean(var1); mean2 <- mean(var2)
if (mean1 > mean2) {
	a.ang <- var1
	b.ang <- var2
	} else {
		b.ang <- var1
		a.ang <- var2
		}

# Seno y cosenos
a.cos <- cos(rad(a.ang))
a.sin <- sin(rad(a.ang))
b.cos <- cos(rad(b.ang))
b.sin <- sin(rad(b.ang))

# Diferencias
Y <- a.sin - b.sin
X <- a.cos - b.cos
XY <- X*Y
rm(a.ang, a.cos, a.sin, b.ang, b.cos, b.sin)

# Otros datos
k <- length(XY)
X.prom <- mean(X)
Y.prom <- mean(Y)

# Sumatorias
sum.x  <- sum(X^2) - (sum(X)^2 / k)
sum.y  <- sum(Y^2) - (sum(Y)^2 / k)
sum.xy <- sum(X*Y) - (sum(X)*sum(Y) / k)
rm(X, Y, XY)

# Estadistico: dividido en 3 partes
p1 <- (k*(k-2))/2
p2 <- (X.prom^2 * sum.y) - (2 * X.prom * Y.prom * sum.xy) + (Y.prom^2 * sum.x)
p3 <- (sum.x * sum.y) - sum.xy^2
F  <- p1 * (p2 / p3)

# Finales y print
crit <- qf(0.95, 2, k-2)	# Critico
pval <- 1 - pf(F, 2, k-2)

cat("\t", "Test de Hottelling para muestras circulares pareadas\n")
cat("\t\t", "k pares       = ", k, "\n")
cat("\t\t", "Estadistico F = ", F, "\n")
cat("\t\t", "Critico 5%    = ", crit, "\n")
cat("\t\t", "p-valor       = ", pval)

}


