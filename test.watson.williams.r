#--------------------------------------------------------------------------------#
#---- Watson & Williams test for multigroup of circular data  -------------------#
#---- Based on circular package - programmed by OliverRojas ---------------------#
#---- Lab.Sueño, INTA, U. de Chile, 06.2015 -------------------------------------#
#--------------------------------------------------------------------------------#
# Watson, G. S., & Williams, E. (1956). On the construction of significance tests 
# on the circle and the sphere. Biometrika, 43(2), 344-352.
#
# This is only a little improvenment to the william watson test included in package

# Example data:
# a <- c(94,65,45,52,38,47,73,82,90,40,87)
# b <- c(77,70,61,45,50,35,48,65,36)
# c <- c(45,55,81,96,110,117,132,154)
# data <- list(a, b, c); rm(a, b, c)


## Funcioon para test de Watson - Williams --------------------------------------#
test.watson.williams <- function(data) {
require(circular)
options(digits=5)


# Pasar elementos de la lista a formato circular
sets <- length(data)
for (i in 1:sets) {data[[i]] <- circular(data[[i]], units="degrees", modulo="2pi", zero=0) }


# Test y resultados GLOBALES
test <- watson.williams.test(data)

	# output
	cat("Watson-Williams test for homogeneity of means \n")

	f <- unlist(test[3])
	cat("  F-Statistic =", f, "\n")
	
	df <- unlist(test[2])
	cat("        df(1) =", df[1], "\n        df(2) =", df[2], "\n")
	
	p <- unlist(test[4])
	cat("      p-value =",  p, "\n\n")
	
	enes <- numeric()
	for (i in 1:length(data)) { enes <- c(enes, length(data[[i]])) }
		
	prom <- test[5]
	prom <- as.data.frame(prom); prom$n <- enes
	colnames(prom) <- c("Group Means", "Sample Size")
	print(prom); cat("\n")
	
## Comparaciones de pares, sin ajuste de probabilidad
# Calcula los pares. LAS FILAS ES EL INDICE
pares <- 1:sets
comb <- t(combn(pares, 2))
filas <- nrow(comb)	# para el loop


# output de inicio
cat("              Multiple comparisons\n" )
cat("    Pair        Diff       F-value     p-value\n")
cat("+-----------+-----------+-----------+-----------+\n")


# Uso valores fila i, y traigo elementos de la data original
# i <- 1
# LOOOP
for (i in 1:filas) {
combina <- comb

grupo1 <- combina[i,1]
grupo2 <- combina[i,2]

grupo1 <- unlist(data[grupo1])
grupo2 <- unlist(data[grupo2])

grupo1 <- circular(grupo1, units="degrees", modulo="2pi", zero=0)
grupo2 <- circular(grupo2, units="degrees", modulo="2pi", zero=0)
par <- list(grupo1, grupo2)


# test y archivar resultados segun i
options(warn=-1)
par <- watson.williams.test(par)
grp.mean <- as.vector(unlist(par[5]))
dif.mean <- abs(grp.mean[1] - grp.mean[2])
pval <- unlist(par[4])
fpar <- unlist(par[3])
grup <- paste(comb[i, 1], " - ", comb[i, 2], sep="")

	# Dejar igual largo
	p1 <- as.character(round(dif.mean,3)); 	p1 <- paste("        ", p1, sep=""); 	p1 <- substr(p1, nchar(p1)-8, nchar(p1))
	p2 <- as.character(round(pval,3)); 	p2 <- paste("        ", p2, sep=""); 	p2 <- substr(p2, nchar(p2)-8, nchar(p2))
	p3 <- as.character(round(fpar,3)); 	p3 <- paste("        ", p3, sep=""); 	p3 <- substr(p3, nchar(p3)-8, nchar(p3))
	p4 <- as.character(grup); 	p4 <- paste("        ", p4, sep=""); 	p4 <- substr(p4, nchar(p4)-8, nchar(p4))
	
# Output para este par
cat("|", p4, "|", p1, "|",  p3 ,"|" ,  p2, "|\n")
options(warn=0)
}
cat("+-----------+-----------+-----------+-----------+\n")


# Fin de la funcion
}

# test.ww(data)
