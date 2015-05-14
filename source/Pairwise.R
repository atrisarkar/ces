# TODO: Add comment
# 
# Author: Atri
###############################################################################


train <- "E:\\CS886TEMP\\pairSampling\\LLVM_train"
test <- "E:\\CS886TEMP\\pairSampling\\LLVM_test"
fileAddress <- "E:\\CS886TEMP\\FULL\\Input\\LLVM.csv"
outputAddress <- "E:\\CS886TEMP\\Output"
outputFilename <- "llvm_pair"
dataAddr <<- paste("file:///", fileAddress, sep="")
testAddr <<- paste("file:///", test, sep="")
trainAddr <<- paste("file:///", train, sep="")
crs.dataset <- read.csv(dataAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")
crs.test <- read.csv(testAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")
crs.train <- read.csv(trainAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")

# Calculate number of features
featureCount <<- ncol(crs.dataset) - 1

# Calculate number of observations
obsCount <<- nrow(crs.dataset) - 1
seedRepetitions <- 5
crv.seed <- 1
methodName <- "anova"
samplingType <- 1





# Select the variables
crs.input <- setdiff(colnames(crs.train), "PERF")
crs.numeric <- NULL
crs.categoric <- NULL
crs.target  <- "PERF"
crs.risk    <- NULL
crs.ident   <- NULL
crs.ignore  <- NULL
crs.weights <- NULL
print("Training Done")
# Building a CART model ###################################################################
require(rpart, quietly=TRUE)
set.seed(1)
info <- list(split="information")
crs.rpart <- rpart(PERF ~ .,
		data=crs.train[c(crs.input, crs.target)],method="anova",
		control=rpart.control(
				minsplit=2,
				minbucket=1,
				maxdepth=5,
				cp=0,
				usesurrogate=0,
				maxsurrogate=0))
print("Building Done")
# Evaluate the CART model #################################################################
# Obtain predictions for the Decision Tree model on BerkeleyC.csv [test]
crs.pr <- predict(crs.rpart, newdata=crs.test[ c(crs.input)])
# Extract the relevant variables from the dataset
sdata <- subset(crs.test, select=c("PERF"))
faultRate <- abs(sdata - crs.pr) / sdata * 100
faultDataset <- faultRate
faultRate <- mean(rowMeans(faultDataset))
resultDataset <- NULL
resultDataset <- rbind(resultDataset, c(1, 1, 1,1, faultRate))
print("DONE")
