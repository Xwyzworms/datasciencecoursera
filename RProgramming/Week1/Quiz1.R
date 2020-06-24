df <- read.csv(file="hw1_data.csv")
df[1:2,]
print(NROW(df))
tail(df,2)
df[47,]
sum(is.na(df)) 
mean(df[,1] ,na.rm = T)
num18 <- df[,("Ozone" > 31 && "Temp" > 90 )]
mean(num18[,"Solar.R"],na.rm=T)
mean(df[,("Temp" >0 & "Month" == 6)] , na.rm =T)
#mean(newDf[,"Temp"],na.rm=T)
num20 <- df[,("Month" == 5)]
num20
num18