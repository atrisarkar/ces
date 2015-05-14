# TODO: Add comment
# 
# Author: Atri
###############################################################################


go <- function() {
	fileAddress <- "E:\\CS886TEMP\\FULL\\Input\\Apache.csv"
	outputAddress <- "E:\\CS886TEMP\\Output"
	outputFilename <- "llvm_pair"
	dataAddr <<- paste("file:///", fileAddress, sep="")
	crs.dataset <- read.csv(dataAddr, na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")
	crs.test.temp.buff <- data.frame()
	mand <<- c("Base","PERF")
	conf <<- matrix(0,2,length(names(crs.dataset))-length(mand))
	colnames(conf) <<- setdiff(colnames(crs.dataset), mand)
	i<-0
	final.set <- NULL
	crs.pool <- seq(1,nrow(crs.dataset))
	while(0<1){
		i<-i+1
		set.seed(i)
		crs.sample <- sample(length(crs.pool), 1)
		temp <- setdiff(crs.pool, crs.sample)
		crs.pool <- temp
		add(crs.sample)
		complete <- complete()
		if(complete){
			final.set <<- setdiff(seq_len(nrow(crs.dataset)), crs.pool)
			break
		}
		final.train <- setdiff(seq(1:nrow(crs.dataset)),final.set)
		build(final.set,final.train)
	}

}
add <- function(x){
	crs.validate <- NULL
	crs.train <- x
	print(x)
	crs.input <- setdiff(colnames(crs.dataset), mand)
	g <<- crs.dataset[crs.train, c(crs.input)]
	for(i in 1:ncol(g)){
		row <- g[i]
		if(row=="Y"){
			conf[1,i] <<- conf[1,i] + 1
		} else {
			conf[2,i] <<- conf[2,i] + 1
		}
		
	}
	
}

complete <- function(){
	m <- (conf[,] >=3 )
	res <- TRUE
	for(i in 1:nrow(m)) {
		for (j in col(m)){
			if(m[i,j]==FALSE){
				res <- FALSE
				break
			}
		if(res==FALSE){
			break
		}
		}
	}
	return(res)
}


build <- function(train,test)
