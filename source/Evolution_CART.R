# TODO: Add comment
# 
# Author: Atri
###############################################################################


train <- "E:\\CS886TEMP\\Benchmarks\\benchmarks-h264-llvm\\LLVM\\350\\train"
crs.train <- NULL
trainAddr <<- paste("file:///", train, sep="")
crs.train <- read.csv(trainAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")

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
				maxdepth=4,
				cp=0,
				usesurrogate=0,
				maxsurrogate=0))
print("Building Done")
#dev.copy(png,filename="r1211.png");
#dev.off ();
