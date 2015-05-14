# TODO: Add comment
# 
# Author: Atri
###############################################################################


find.slope <- function(){
	m<- read.csv("file:///E:\\CS886TEMP\\Output_Dec10\\apache_10_30.csv",header = FALSE)
	x.g <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	y.g <- as.numeric(as.matrix(m$V3[3:length(m$V3)]))
	x <- y <- x.g
	length <- length(x)
	seq <- seq(from=0,to=length-10,by=10)
	th <- -0.1
	n.star <- 0
	for(i in seq){
		if(i!=0){
			print(i)
			n <- i
			from <- n-5
			to <- n+5
			x <- x.g[from:to]
			y <- y.g[from:to]
			slope <- fit.lrls(x,y)
			print(slope)
			if(th<slope){
				n.star <- i
				break
			}
		}
	}
	
	return(n.star)
}

go <- function(){
	
	n.star <- find.slope()
	return(n.star)
}

fit.lrls <- function(x,y){
	fit <- lsfit(x,y)
	a <- as.matrix(fit$coefficients[1])[1]
	b <- as.matrix(fit$coefficients[2])[1]
	return(b)
	
}