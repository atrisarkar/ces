# TODO: Add comment
# 
# Author: Atri
###############################################################################


fit.log <- function(n){
	fit <- lsfit(log(x),y)
	a <- as.matrix(fit$coefficients[1])[1]
	b <- as.matrix(fit$coefficients[2])[1]
	result = data.frame( 
			name=c("A","B"),
			coeff=c(a,b)
	)
	return(result)
	
}

fit.weiss <- function(x,y){
	fit <- lsfit(x/(x+1),y)
	a <- as.matrix(fit$coefficients[1])[1]
	b <- as.matrix(fit$coefficients[2])[1]
	result = data.frame( 
			name=c("A","B"),
			coeff=c(a,b)
	)
	return(result)
	
}

fit.power <- function(x,y){
	fit <- lsfit(log(x),log(y))
	a <- as.matrix(fit$coefficients[1])[1]
	b <- as.matrix(fit$coefficients[2])[1]
	result = data.frame( 
			name=c("A","B"),
			coeff=c(a,b)
	)
	return(result)
	
}

fit.exp <- function(x,y){
	fit <- lsfit(x,log(y))
	a <- as.matrix(fit$coefficients[1])[1]
	b <- as.matrix(fit$coefficients[2])[1]
	result = data.frame( 
			name=c("A","B"),
			coeff=c(a,b)
	)
	return(result)
	
}
