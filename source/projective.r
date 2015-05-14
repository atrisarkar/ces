# TODO: Add comment
# 
# Author: Atri
###############################################################################
rm(list=ls())
library(Hmisc)
smooth <- function(x){
	k <- seq(2,length(x)-1)
	smth<-x
	smthi<-x
	for(i in k) {
		smthi[i] <- (smth[i-1] + smth[i] + smth[i+1])/3
		smth <- smthi
		
	}
	return(smthi)
}

find.corr <- function(x,y){
	x.log <- x.power <- log(x)
	x.weiss <- x/(x+1)
	x.exp <- x
	y.log <- y.weiss <- y
	y.power <- y.exp <- log(y)
	
	rho.log <- rcorr(x.log,y.log,type="pearson")
	rho.weiss <- rcorr(x.weiss,y.weiss,type="pearson")
	rho.power <- rcorr(x.power,y.power,type="pearson")
	rho.exp <- rcorr(x.exp,y.exp,type="pearson")
	 
	result = data.frame( 
			name=c("Log","Weiss","Power","Exp"),
				cor.cof=c(rho.log$r[1,2],rho.weiss$r[1,2],rho.power$r[1,2],rho.exp$r[1,2])
		)
	return(result)
}

fit.log <- function(x,y){
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

readextract <- function(){
	m<- read.csv("file:///E:\\CS886TEMP\\pairSampling\\sqllite\\sql_fea_cov.csv",header = FALSE)
	x <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	y <- as.numeric(as.matrix(m$V3[3:length(m$V3)]))
	#x <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	#y <- as.numeric(as.matrix(m$V5[3:length(m$V5)]))
	y <- smooth(y)
	x<<-x
	y<<-y
}

readextract2 <- function(){
	m<- read.csv("file:///E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\output\\sql_2.csv",header = TRUE)
	x <- as.numeric(as.matrix(m$Sampling.Amount[1:length(m$Sampling.Amount)]))
	y <- as.numeric(as.matrix(m$Fault.Rate[1:length(m$Fault.Rate)]))
	#x <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	#y <- as.numeric(as.matrix(m$V5[3:length(m$V5)]))
	y <- smooth(y)
	x<<-x
	y<<-y
}

go <- function(){
	readextract()
	cr <- find.corr(x,y)
	return(cr)
}

n.exp <- function(a,b){
	t1 <- logb((-1/(63*1*(a*log(b)))),b)
	return(t1)
}

n.power <- function(a,b){
	t1 <- -1/(1*63*a*b)
	t2 <- t1^(1/(b-1))
	return(t2)
}

n.log <- function(a,b){
	t1 <- -1*(1*63*b)
	return(t1)
}

n.weiss <- function(a,b){
	t1 <- ((-1*(1*63*b))^0.5) - 1
	return(t1)
}

fit <- function(x,y){
	print("exp")
	print(fit.exp(x,y))
	print("power")
	print(fit.power(x,y))
	print("weiss")
	print(fit.weiss(x,y))
	print("log")
	print(fit.log(x,y))
}


