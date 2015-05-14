# TODO: Add comment
# 
# Author: Atri
###############################################################################


	rm(list=ls())
	m<- read.csv("file:///E:\\CS886TEMP\\Output_Dec10\\apache_10_30.csv",header = FALSE)
	x.g <- as.numeric(as.matrix(m$V1[2:length(m$V1)]))
	y.g <- as.numeric(as.matrix(m$V3[2:length(m$V3)]))
	
	m<- read.csv("file:///E:\\CS886TEMP\\out_feature_coverage\\apache.csv",header = FALSE)
	x.p <- as.numeric(as.matrix(m$V1[3:length(m$V1)]))
	y.p <- as.numeric(as.matrix(m$V3[3:length(m$V3)]))
	
	data.prog <- data.frame("Sample-Size"=x.g,Accuracy=100-y.g,check.names=F)
	data.proj <- data.frame("Sample-Size"=x.p,Accuracy=y.p,check.names=F)
	
	print(data.prog,row.names=FALSE)
	