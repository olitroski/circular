#--------------------------------------------------------------------------------#
#---- Watson & Wheeler test for multigroup of circular data  --------------------#
#---- Based on circular package - programmed by Oliver Rojas --------------------#
#---- Lab.Sueño, INTA, U. de Chile, 07.2015 -------------------------------------#
#--------------------------------------------------------------------------------#
# Wheeler, S., & Watson, G. S. (1964). 
# A distribution-free two-sample test on the circle. 
# Biometrika1, 51, 256-257.
#
# This is only a little improvenment to the wheeler-watson test included in package

# Example data:
# a <- c(94,65,45,52,38,47,73,82,90,40,87)
# b <- c(77,70,61,45,50,35,48,65,36)
# c <- c(45,55,81,96,110,117,132,154)
# data <- list(a, b, c); rm(a, b, c)

test.wheeler.watson <- function(data) {
require(circular)
options(digits=5)

# Pasar elementos de la lista a formato circular
sets <- length(data)
for (i in 1:sets) {data[[i]] <- circular(data[[i]], units="degrees", modulo="2pi", zero=0) }


## Test y resultados globales
test <- watson.wheeler.test(data)

	# Output
	cat("Wheeler & Watson test for homogeneity of angles\n")

	w <- unlist(test[3])
	cat(" W-Statistics =", w, "\n")

	df <- unlist(test[2])
	cat("      df(chi) =", df, "\n")	
	
	k <- length(data)
	gl <- 2*(k-1)
	x2 <- qchisq(0.95, gl)
	cat("  Crit.Val 5% =", x2, "\n")
	
	p <- unlist(test[4])
	cat("      p-value =", p, "\n")		
	
	cat("       Groups =", sets, "\n")	


# Comparaciones pareadas

## Comparaciones de pares, sin ajuste de probabilidad
# Calcula los pares. LAS FILAS ES EL INDICE
pares <- 1:sets
comb <- t(combn(pares, 2))   # Combinaciones
filas <- nrow(comb)	# para el loop


# output de inicio
cat("\n        Multiple comparisons\n" )
cat("    Pair       W-value     p-value\n")
cat("+-----------+-----------+-----------+\n")


# Uso valores fila i, y traigo elementos de la data original
# i <- 1
# LOOOP
for (i in 1:filas) {
combina <- comb

	# Fabrica la data para el par, no se puede sacar desde la lista por el circular()
	grupo1 <- combina[i,1]
	grupo2 <- combina[i,2]

	grupo1 <- unlist(data[grupo1])
	grupo2 <- unlist(data[grupo2])

	grupo1 <- circular(grupo1, units="degrees", modulo="2pi", zero=0)
	grupo2 <- circular(grupo2, units="degrees", modulo="2pi", zero=0)
	par <- list(grupo1, grupo2)


# test y archivar resultados segun i
options(warn=-1)
par <- watson.wheeler.test(par)

pval <- unlist(par[4])
wpar <- unlist(par[3])
grup <- paste(comb[i, 1], " - ", comb[i, 2], sep="")

	# Dejar igual largo
	p2 <- as.character(round(pval,3)); 	p2 <- paste("        ", p2, sep=""); 	p2 <- substr(p2, nchar(p2)-8, nchar(p2))
	p3 <- as.character(round(wpar,3)); 	p3 <- paste("        ", p3, sep=""); 	p3 <- substr(p3, nchar(p3)-8, nchar(p3))
	p4 <- as.character(grup)         ; 	p4 <- paste("        ", p4, sep=""); 	p4 <- substr(p4, nchar(p4)-8, nchar(p4))
	
# Output para este par
cat("|", p4, "|",  p3 ,"|" ,  p2, "|\n")
options(warn=0)
}
cat("+-----------+-----------+-----------+\n")


}	
# test.wheeler.watson(data)


