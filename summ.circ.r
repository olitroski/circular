#--------------------------------------------------------------------------------#
#---- Summary of circular statistics for a sample vector ------------------------#
#---- based on circular package - programmed by OliverRojas ---------------------#
#---- Lab.Sueño, INTA, UdeChile, 06.2015 ----------------------------------------#
#--------------------------------------------------------------------------------#
# Data must be angles in degrees, not necesary in set circular 
# Example data: From Zar(2010) - Biostatistical analysis, page 613 
# data <- c(45,55,81,96,110,117,132,154)

# Options
require(circular)


# Funcion
summ.circ <- function(data, circular = FALSE) {

if (circular == FALSE) {
	data <- circular(data, units="degrees", modulo="2pi", zero=0)
}

# Estadisticos descriptivos
trig <- trigonometric.moment(data)
q <- round(as.numeric(quantile.circular(data)), 2)


# Recorte 
mu  <- as.character(round(trig[["mu"]], 3));  mu  <- paste("        ", mu , sep=""); mu  <- substr(mu,  nchar(mu)-6 , nchar(mu))
rho <- as.character(round(trig[["rho"]],3));  rho <- paste("        ", rho, sep=""); rho <- substr(rho, nchar(rho)-6, nchar(rho))
sin <- as.character(round(trig[["sin"]],3));  sin <- paste("        ", sin, sep=""); sin <- substr(sin, nchar(sin)-6, nchar(sin))
cos <- as.character(round(trig[["cos"]],3));  cos <- paste("        ", cos, sep=""); cos <- substr(cos, nchar(cos)-6, nchar(cos))
n   <- as.character(round(trig[["n"]],3))  ;  n   <- paste("        ", n, sep="")  ; n   <- substr(n,   nchar(n)-6, nchar(n))


# Arreglar los cuartiles
for (i in 1:5) {
	q[i] <- q[i] + 0.0000001 
}

q <- as.character(q)

for (i in 1:5) {
	dot <- as.numeric(gregexpr(pattern = ".", q[i], fixed=TRUE))
	q[i] <- substr(q[i], 1, dot+2)
	q[i] <- paste("     ", q[i], sep="")
	q[i] <- substr(q[i], nchar(q[i])-7, nchar(q[i]))
}



# Intervalos de confianza 95% con 10000 reps, vía bootstrap
limites <- mle.vonmises.bootstrap.ci(data, reps=10000)
limites <- unlist(limites[1])

 # Recorte
 li <- as.character(round(limites[1],3)); li <- paste("        ", li, sep=""); li <- substr(li,   nchar(li)-6, nchar(li))
 ls <- as.character(round(limites[2],3)); ls <- paste("        ", ls, sep=""); ls <- substr(ls,   nchar(ls)-6, nchar(ls))

	
	
# Tabla de salida
cat("\n     Summary of Circular Statistics\n")
cat("+--------------------+--------------------+\n")
cat("| Mean      ",  mu, "| Min       ", q[1],"|\n")
cat("| rho       ", rho, "| Q1 (25%)  ", q[2],"|\n")
cat("| Sum(cos)/n", cos, "| Median    ", q[3],"|\n")
cat("| Sum(sin)/n", sin, "| Q3 (75%)  ", q[4],"|\n")
cat("| Sample n  ",   n, "| Max       ", q[5],"|\n")
cat("| Lim.Inf 5%",  li, "| Lim.Sup 5%",   ls,"|\n")
cat("+--------------------+--------------------+\n")


# Set output list
num <- function(x) {
	x <- as.numeric(x)
}	

return(invisible(list(mu=num(trig[["mu"]]), rho=num(trig[["rho"]]), sin=num(trig[["sin"]]), 
  cos=num(trig[["cos"]]), n=num(trig[["n"]]), lim=limites, cuartile= num(quantile.circular(data)))))

}
# summ.circ(data)
# a <- summ.circ(data); a