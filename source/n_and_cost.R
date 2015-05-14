# TODO: Add comment
# 
# Author: Atri
###############################################################################

path <- "E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\output\\n-values\\3way\\data.weiss"
pathAddr <<- paste("file:///", path, sep="")
data <- read.csv(pathAddr, encoding="UTF-8",header = FALSE)
n.exp <- function(a,b,s){
	t1 <- logb((-2/((s/3)*1*(a*log(b)))),b)
	return(t1)
}

n.power <- function(a,b,s){
	t1 <- -2/(1*(s/3)*a*b)
	t2 <- t1^(1/(b-1))
	return(t2)
}

n.log <- function(a,b,s){
	t1 <- -(1/2)*(1*(s/3)*b)
	return(t1)
}

n.weiss <- function(a,b,s){
	t1 <- ((-1*((1*(s/3)*b)/2))^0.5) - 1
	return(t1)
}

go <- function(){
	n.apache.weiss <- n.weiss(data$V1[1],data$V2[1],data$V3[1])
	print(n.apache.weiss);
	n.bc.weiss <- n.weiss(data$V1[2],data$V2[2],data$V3[2])
	print(n.bc.weiss);
	n.bj.weiss <- n.weiss(data$V1[3],data$V2[3],data$V3[3])
	print(n.bj.weiss);
	n.llvm.weiss <- n.weiss(data$V1[4],data$V2[4],data$V3[4])
	print(n.llvm.weiss);
	n.sql.weiss <- n.weiss(data$V1[5],data$V2[5],data$V3[5])
	print(n.sql.weiss);
	n.x264.weiss <- n.weiss(data$V1[6],data$V2[6],data$V3[6])
	print(n.x264.weiss);
	
}

