#!/usr/bin/env Rscript
args<-commandArgs(TRUE)

pathIn<-args[1]
pathOut<-args[2]
specific<-args[3]

if(missing(pathIn) || is.na(pathIn)){
    pathIn <- "files/all.csv"
    result <- read.csv(pathIn,header=TRUE)
}else{
    filenames=list.files(path=pathIn, full.names=TRUE)
    #print(str(filenames))
    datalist = lapply(filenames, function(x){read.csv(file=x,header=TRUE)})
    result=Reduce(function(x,y) {merge(x,y,all=TRUE)}, datalist)
}

if(missing(pathOut) ||  is.na(pathOut)){
    pathOut <- ""
}

v <- result
#print(str(v))
#summary(v)
options(error=function()traceback(2))

isSpec <-! missing(specific) && ! is.na(specific)
if(isSpec){
    str <- paste("v <- result$",specific, sep='')
    p <- parse(text=str)
    eval(p)
    myMean <- mean(v,na.rm=TRUE)
    myMedian <- median(v,na.rm=TRUE)
    mySd <- sd(v,na.rm=TRUE)
    re <- quantile(v,0.99999,na.rm=TRUE)
    #coef(v)
} else {
    v <- result[c("appconnect_time","namelookup_time","pretransfer_time","total_time","redirect_time","starttransfer_time","connect_time")]
}

svg(paste(pathOut,"boxplot.svg",sep=""), width = 9, height = 9)
par(las=2)
boxplot(v,ylim = c(0, max(result$total_time,na.rm=TRUE)),cex.axis=0.7)
if(isSpec){
    legend('topright', legend = c(paste(" Mean =", round(myMean, 3), "\n Median =",  round(myMedian, 3), "\n Std.Dev =", round(mySd, 3)," \n 99,999% =",re)), bty = "n" )
}
dev.off()

if(isSpec){
    svg(paste(pathOut,"hist.svg",sep=""), width = 9, height = 9)
    par(las=2)
    hist(v)
    legend('topright', legend = c(paste(" Mean =", round(myMean, 3), "\n Median =",  round(myMedian, 3), "\n Std.Dev =", round(mySd, 3)," \n 99,999% =",re)), bty = "n" )
    dev.off()
}
