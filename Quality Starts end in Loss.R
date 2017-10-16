#This displays quality starts by team resulting in a win

Data <- read.csv(file="/Users/zachtallevast/Box Sync/Quality Starts Resulting in Loss.csv", na.strings = "..",header=TRUE,sep=",", fill=TRUE)


table(Data$Tm)

barplot(Sum, main="Quality starts resulting in a loss by team", horiz=TRUE)



data1 <-table(new <-Sum[order(Data$Tm)])


