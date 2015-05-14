# TODO: Add comment
# 
# Author: Atri
###############################################################################


#train <- "E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\x264_3_way_perf_train"
#test <- "E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\x264_3_way_perf_test"
rm(list=ls())
train <- "E:\\CS886TEMP\\pairSampling\\sqllite\\sqllite_3_way"
test <- "E:\\CS886TEMP\\pairSampling\\sqllite\\sqllite_all"

outputAddress <- "E:\\CS886TEMP\\pairSampling\\2-way combinatorial\\t-way\\output"
outputFilename <- "sql_3"


testAddr <<- paste("file:///", test, sep="")
trainAddr <<- paste("file:///", train, sep="")


crs.test <- read.csv(testAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")
crs.train <- read.csv(trainAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")


#Training Set Size
training.size <- nrow(crs.train)

seedRepetitions <- 30
#crv.seed <- 1
methodName <- "anova"
samplingType <- 1

faultDataset <- NULL
resultDataset <- NULL
resultDataset <- rbind(resultDataset, c("Sampling Amount", "Fault Rate"))

	for(samplingIter in 1:training.size){
		for(seedIter in 1:seedRepetitions){
			set.seed(seedIter)
			training.current <- crs.train[1:samplingIter,]
			testing.current <- sample(nrow(crs.test), samplingIter)
			
			crs.input <- setdiff(colnames(crs.train), "PERF")
			crs.numeric <- NULL
			crs.categoric <- NULL
			crs.target  <- "PERF"
			crs.risk    <- NULL
			crs.ident   <- NULL
			crs.ignore  <- NULL
			crs.weights <- NULL
			print(paste("Training Done",samplingIter))
			# Building a CART model ###################################################################
			require(rpart, quietly=TRUE)
			set.seed(1)
			info <- list(split="information")
			crs.rpart <- rpart(PERF ~ .,
					data=training.current[c(crs.input, crs.target)],method="anova",
					control=rpart.control(
							minsplit=2,
							minbucket=1,
							maxdepth=25,
							cp=0,
							usesurrogate=0,
							maxsurrogate=0))
			print(paste("Building Done",samplingIter))
			# Evaluate the CART model #################################################################
			# Obtain predictions for the Decision Tree model on BerkeleyC.csv [test]
			crs.pr <- predict(crs.rpart, newdata=crs.test[testing.current, c(crs.input)])
			# Extract the relevant variables from the dataset
			sdata <- subset(crs.test[testing.current,], select=c("PERF"))
			disp <- abs(sdata - crs.pr)
			sd <- sdata
			#print(disp)
			#print(sdata)
		    #print("------")
			faultRate <- abs(sdata - crs.pr) / sdata * 100
			if(is.null(faultDataset)){
				faultDataset <- faultRate
			}else{
				faultDataset <- cbind(faultDataset, faultRate)
			}
		} # for(seedIter in 1:seedRepetitions)
		faultRate <- mean(rowMeans(faultDataset))
		#print("------")
		#print(rowMeans(faultDataset))
		#print(faultRate)
		resultDataset <- rbind(resultDataset, c(samplingIter, faultRate))
		
		faultDataset <- NULL
	} # for(samplingIter in samplingLower:samplingUpper)
	
	address00 <- paste(outputAddress, "\\", outputFilename, ".csv", sep="")
	#write.csv(resultDataset, file=address00, row.names=FALSE, col.names=FALSE)
	write.table( resultDataset,file=address00, sep=",",  col.names=FALSE,row.names=FALSE )
