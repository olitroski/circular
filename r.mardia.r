#-----------------------------------------------------------------------#
#------ Coeficiente de correlacion angular angular de Mardia (1985) ----#
#------ Escrito por olitroski@gmail.com en Lab.Sueño INTA UChile -------#
#-----------------------------------------------------------------------#
# Mardia 1975

## Funcion para el estadistico
r.mardia.stat <- function(cdat1, cdat2)    {
require(circular)

n <- length(cdat1)
C <- 360/n
dif <- rank(cdat1) - rank(cdat2)
add <- rank(cdat1) + rank(cdat2)

r1 <- (sum(cos(rad(C*dif)))^2 + sum(sin(rad(C*dif)))^2) /n^2
r2 <- (sum(cos(rad(C*add)))^2 + sum(sin(rad(C*add)))^2) /n^2
r.obs <- (r1 - r2)
r.test <- (n-1)*r.obs


# Sacar r.crit 5% a 2 colas desde la tabla
A <- 2.99; B <- 2.16
r.crit <- A + B/n

return(c(r.obs, r.test, r.crit))
}



## Test de aleatorizacion
r.mardia.rnd <- function(cdat1, cdat2, NR=9999) {

robs <- r.mardia.stat(cdat1, cdat2)
robs <- robs[1]
nxtrm <- 1

for (r in 1:NR) {
	vec.rand <- sample(cdat1)
	rand.stat <- r.mardia.stat(vec.rand, cdat2)
	rand.stat <- rand.stat[1]
	
	if (rand.stat > robs) {
		nxtrm <- nxtrm + 1
	}
}

pval <- nxtrm / (NR + 1)
return(pval)
}



## Funcion del test
r.mardia <- function(cdat1, cdat2, NR=9999) {

k <- length(cdat1)
data1 <- r.mardia.stat(cdat1, cdat2)
data2 <- r.mardia.rnd(cdat1, cdat2)

cat("\t", "Coeficiente de Correlacion \"Angular - Angular\" (Mardia)\n")
cat("\t", "Randomization test p-value & 5% Crit value\n")
cat("\t\t", "k pares       = ", k, "\n")
cat("\t\t", "Coeficiente r = ", data1[1], "\n")
cat("\t\t", "Valor test.   = ", data1[2], "\n")
cat("\t\t", "Valor crit.   = ", data1[3], "\n")
cat("\t\t", "p-valor       = ", data2)

}




















