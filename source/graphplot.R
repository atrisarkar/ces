# TODO: Add comment
# 
# Author: Atri
###############################################################################
dev.new(width=5, height=4)

	rm(list=ls())
	m<- read.csv("file:///E:\\CS886TEMP\\Output_Dec10\\x264_10_30.csv",header = FALSE)
	x.g <- as.numeric(as.matrix(m$V1[2:length(m$V1)]))
	y.g <- as.numeric(as.matrix(m$V3[2:length(m$V3)]))
	
	m<- read.csv("file:///E:\\CS886TEMP\\out_feature_coverage\\x264.csv",header = FALSE)
	x.p <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	y.p <- as.numeric(as.matrix(m$V3[3:length(m$V3)]))
	
	#m<- read.csv("file:///E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\output\\x264_2.csv",header = FALSE)
	#x.2w <- as.numeric(as.matrix(m$V1[2:length(m$V1)]))
	#y.2w <- as.numeric(as.matrix(m$V2[2:length(m$V2)]))
	
	#m<- read.csv("file:///E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\output\\x264_3.csv",header = FALSE)
	#x.3w <- as.numeric(as.matrix(m$V1[2:length(m$V1)]))
	#y.3w <- as.numeric(as.matrix(m$V2[2:length(m$V2)]))



	plot(x=NULL,y=NULL,xlim=c(1, 600),ylim=c(50,100),type="n",xlab="Sample Size",ylab="Accuracy",main="x264",xaxt='n',yaxt='n')
	axis(side=1, at=seq(from=0, to=600, by=50), cex.axis=0.75)
	axis(side=2, at=seq(from=50, to=100, by=10), cex.axis=0.75)
	points(x.g,100-y.g,type="o",col="red")
	points(x.p,100-y.p,type="p",col="black",pch=0)
	#points(x.2w,100-y.2w,type="p",col="blue",pch=19)
	#points(x.3w,100-y.3w,type="p",col="darkgreen",pch=23)
	# exp
	#curve(100-(74.3291*(0.8430176^x)),type="l",col="blue",add=TRUE)
	#curve(100-(40.15754*(0.9232735^x)),type="l",col="darkgreen",add=TRUE)
	curve(100-(44.76649*(0.9210129^x)),type="l",col="black",add=TRUE)
	
	
	
	#power
	curve(100-(76.24951*(x^-(0.677399))),type="l",col="green",add=TRUE)
	
	#log
	#curve(100-(7.528343 + (-0.705582 * log(x))),type="l",col="cyan",add=TRUE)
	
	
	
	#legend("bottomright", c("AS","Exp","Power"),cex=0.8, col=c("red","black","green"),lty=1,pch=c(1,0,0))
	#legend("bottomright", c("AS","Exp"),cex=0.8, col=c("red","black"),lty=1,pch=c(1,0))
	#legend("bottomright", c("AS","Exp","Power","Log"),cex=0.8, col=c("red","black","green","cyan"),lty=1,pch=c(1,0,0,0))
	
	#l1 <- legend("bottomright", c("Progressive","Exp","Power"),cex=0.8, col=c("red","black","black"),lty=c(0,0,0),,pch=c(1,0,0),lwd=1)
	#legend(x=l1$rect$left,y=l1$rect$top, c("","",""),cex=0.8, col=c("red","black","green"),lty=c(1,1,1),pch=c(NA,NA,NA),lwd=1,bg="transparent",bty="n")
	#legend("topleft", c("Optimal Sample Size","Initial Datapoints for Projection"),cex=c(0.8,0.8), col=c("black","black"),pch=c(24,0),pt.bg=c("black",NA))
	
	#legend("bottomright", c("AS","Exp","Log"),cex=0.8, col=c("red","black","cyan"),lty=1,pch=c(1,0,0,0))
	

	#add n* s
	points(50,100-7.05,type="p",col="red",pch=24,bg="red")
	points(88,100-(44.76649*(0.9210129^88)),type="p",col="black",pch=24,bg="black")
	
	points(364,100-(76.24951*(364^-(0.677399))),type="p",col="green",pch=24,bg="green")
	#points(240,100-(7.528343 + (-0.705582 * log(240))),type="p",col="cyan",pch=24,bg="cyan")
	
	dev.copy(png,filename="x264_final.png");
	dev.off ();
	
