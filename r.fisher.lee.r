# -----------------------------------------------------------------------------------------
# ---- 1.- Parametric Circular-Circular: Fisher-Lee ---------------------------------------
# -----------------------------------------------------------------------------------------
# Escrito por Oliver Rojas - olitroski@gmail.com	- 06.2015
# Laboratorio de Sueño - INTA - Universidad de Chile
# Fisher lee en Pewsey
# Confidence limits en Zar 27.20

# a <- c(145, 190, 310, 210, 80)
# b <- c(120, 180, 330, 225, 55)



## Funcion para el coeficiente
rFLCorrCoeff <- function(lcdat1, lcdat2) {

# tranformaciones
library(circular)
lcdat1 <- rad(lcdat1)
lcdat2 <- rad(lcdat2)

A <- sum(cos(lcdat1)*cos(lcdat2)) 
B <- sum(sin(lcdat1)*sin(lcdat2))

C <- sum(cos(lcdat1)*sin(lcdat2))
D <- sum(sin(lcdat1)*cos(lcdat2))

E <- sum(cos(2*lcdat1))
F <- sum(sin(2*lcdat1))

G <- sum(cos(2*lcdat2))
H <- sum(sin(2*lcdat2))

n <- length(lcdat1) 

	# Calculo acuerdo a Fisher (1993:151)
	numer <- 4*((A*B)-(C*D))
	denom <- sqrt(((n*n)-(E*E)-(F*F))*((n*n)-(G*G)-(H*H)))
	rFL <- numer/denom 

return(rFL)
}



## Metodo de Upton & Fingleton para Limites 
fisher.lee.limits <- function(lcdat1, lcdat2) {

n <- c(1: length(a))
upton <- data.frame(n, a, b)

	# Calculamos el vector de r para el procedimiento
	i = 1
	r.upton <- vector("numeric", length=0)
	for (i in n) {
		temp <- upton[-i,]
		r.temp <- rFLCorrCoeff(temp$a, temp$b)
		r.upton <- c(r.upton, r.temp)
	}

# Media y varianza para calculos
r.obs <- rFLCorrCoeff(a,b)
mean.upton <- mean(r.upton)
var.upton  <- stats::var(r.upton)
n <- length(r.upton)

# Calculos limites al 5%
L1 <- n*r.obs - (n-1)*mean.upton - 1.96*sqrt(var.upton/n)
L2 <- n*r.obs - (n-1)*mean.upton + 1.96*sqrt(var.upton/n)

return(c(L1, L2))
}



## Test de aleatorizacion
fisher.lee.random <- function(lcdat1, lcdat2, NR=9999) {

# tranformaciones
library(circular)
lcdat1 <- rad(lcdat1)
lcdat2 <- rad(lcdat2)

rFLObs <- rFLCorrCoeff(lcdat1, lcdat2) 
nxtrm <- 1

	for (r in 1:NR) {
		lcdat1Rand <- sample(lcdat1) 						# Toma una muestra sample 1
		rFLRand <- rFLCorrCoeff(lcdat1Rand, lcdat2)			# Calcula corr entre muestra y dat2

	if (abs(rFLRand) >= abs(rFLObs)) { 
		nxtrm <- nxtrm + 1} }							# Evalua si el valor del random > obs

	pval <- nxtrm/(NR+1)

return(pval)
}



## Test de Fisher-Lee
r.fisher.lee <- function(data1, data2, NR=9999)  {
options(digits=5)

k <- length(data1)
r <- rFLCorrCoeff(data1, data2)
limits <- fisher.lee.limits(data1, data2)
pvalue <- fisher.lee.random(data1, data2, NR)

cat("Coeficiente de Correlacion \"Angular - Angular\" (Fisher & Lee, 1983)\n")
cat("Randomization test p-value & 5% Confidence limits\n")
cat("  k pares       = ", k, "\n")
cat("  Coeficiente r = ", r, "\n")
cat("  Limite Inf.   = ", limits[1], "\n")
cat("  Limite Sup.   = ", limits[2], "\n")
cat("  p-valor       = ", pvalue)

}