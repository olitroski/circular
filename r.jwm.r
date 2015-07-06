#-----------------------------------------------------------------------#
#------ Coeficiente de correlacion angular lineal ----------------------#
#------ Johnson-Wehrly-Mardia Correlation Coefficient ------------------#
#------ Escrito por olitroski@gmail.com en Lab.Sueño INTA UChile -------#
#-----------------------------------------------------------------------#
#km <- c(48,55,26,23,22,62,64)
#ang <- c(190,160,210,225,220,140,120)
#lvar <- km; cvar <- ang; rm(km,ang)

## Funcion Stat calcular r
r.jwm.stat <- function(lvar, cvar) {
require(circular)

cvar.sin <- sin(rad(cvar))
cvar.cos <- cos(rad(cvar))
n <- length(lvar)

rxc <- cor(lvar, cvar.cos)
rxs <- cor(lvar, cvar.sin)
rsc <- cor(cvar.sin, cvar.cos)

# estadistico
numer <- rxc^2 + rxs^2 - 2*rxc*rxs*rsc
denom <- 1 - rsc^2

# Resultados
r <- sqrt(numer/denom)
nr <- n * r^2
chi <- qchisq(.95, df=2)
return(c(r, nr, chi))
}
# r.jwm.stat(lvar, cvar)


## Funcion test aleatorizacion
r.jwm.rnd <- function(lvar, cvar, NR=9999) {

robs <- r.jwm.stat(lvar, cvar)
robs <- robs[1]
nxtrm <- 1

for (r in 1:NR) {
	vec.rand <- sample(lvar)
	rand.stat <- r.jwm.stat(vec.rand, cvar)
	rand.stat <- rand.stat[1]
	
	if (rand.stat > robs) {
		nxtrm <- nxtrm + 1
	}
}

pval <- nxtrm / (NR + 1)
return(pval)
}


## Funcion output del test
r.jwm <- function(lvar, cvar, NR=9999) {

k <- length(lvar)
data1 <- r.jwm.stat(lvar, cvar)
data2 <- r.jwm.rnd(lvar, cvar)

cat("\t", "Coeficiente de Correlacion \"Angular - Lineal\" (Johnson-Wehrly-Mardia)\n")
cat("\t", "Randomization test p-value & 5% Crit value\n")
cat("\t\t", "k pares       = ", k, "\n")
cat("\t\t", "Coeficiente r = ", data1[1], "\n")
cat("\t\t", "Valor test.   = ", data1[2], "\n")
cat("\t\t", "Valor crit.   = ", data1[3], "\n")
cat("\t\t", "p-valor       = ", data2)

}















