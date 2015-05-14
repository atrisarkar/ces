# TODO: Add comment
# 
# Author: Atri
###############################################################################


cost.exp <- function(n,s,a,b) {
	t <- s-n
	e <- a*(b^n)
	c <- (n + (t*e))
	return(c)
}

cost.log <- function(n,s,a,b) {
	t <- s-n
	e <- a + (b*log(n))
	c <- (n + (t*e))
	return(c)
}

cost.actual <- function(n,s,e) {
	t <- s/3
	c <- (2*n + (t*e))
	return(c)
}

cost.power <- function(n,s,a,b) {
	t <- s/3
	e <- a*(n^b)
	c <- (n + (t*e))
	return(c)
}

cost.weiss <- function(n,s,a,b) {
	t <- s/3
	e <- a + ((b*n)/(n+1))
	c <- (n + (t*e))
	return(c)
}

error.log <- function(n,a,b) {
	e <- a + b*(log(n))
	return(e)
}

error.weiss <- function(n,a,b) {
	e <- a + (b*n)/(n+1)
	return(e)
}

error.power <- function(n,a,b) {
	e <- a * (n^b)
	return(e)
}

error.exp <- function(n,a,b) {
	e <- a * (b^n)
	return(e)
}

