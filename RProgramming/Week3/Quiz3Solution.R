library(datasets)
data(iris)
head(iris)

df <- as.data.table(iris)
head(df)
viri <-df[Species =="virginica" ]
round(mean(viri$Sepal.Length , na.rm = T))

apply(df[,1:4] , 2 ,mean)

data("mtcars")
NewDf <- as.data.table(mtcars)
head(NewDf)

mean(NewDf$mpg,NewDf$cyl) ## False
tapply(NewDf$mpg,NewDf$cyl,mean) #True
mpg <- NewDf$mpg
cyl<-NewDf$cyl
lapply(mtcars,mean)# Mean For each Coloumns FALSe
apply(mtcars , 2 ,mean)
sapply(split(NewDf$mpg ,NewDf$cyl),mean) #True
with(NewDf,tapply(NewDf$mpg,NewDf$cyl,mean))
NewDfcp<- NewDf[, .(mean_cols = mean(hp)) , by =cyl]
NewDfcp
round(abs(NewDfcp[cyl == 4,mean_cols] - NewDfcp[cyl == 8 ,mean_cols]) )

debug(ls)
ls
