#
# For Downloading data = https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2

setwd("D:/Reproducible Research/Week4")
## Reading File 

## Question Of Interest

# Across the United States, which types of events are most harmful with respect to population health?
# Across the United States, which types of events have the greatest economic consequences?
library(dplyr)
library(plyr)
library(ggplot2)
library(reshape2)
stromdf <- read.csv("./DataSet/repdata_data_StormData.csv/repdata_data_StormData.csv")
stromdf <- stromdf[,c("EVTYPE" , "FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")]
# lets take a look for a brief information of the data.
# Processing Data 

stromdf$PROPDMG
TotalGrouped <- subset(stromdf , EVTYPE != '?' & (FATALITIES > 0 | INJURIES > 0 | PROPDMG > 0 | CROPDMG > 0))
TotalGrouped$PROPDMGEXP <- toupper(TotalGrouped$PROPDMGEXP)
TotalGrouped$CROPDMGEXP <- toupper(TotalGrouped$CROPDMGEXP)
## Convert the Exponent Variables
Propdmgconv <- c("-" = 10^0, "+" = 10^0,
                 "H" = 10^2, "K" = 10^3,
                 "M" = 10^6, "B" = 10^9,
                 "0" = 10^0, "1" = 10^1,
                 "2" = 10^2, "3" = 10^3,
                 "4" = 10^4, "5" = 10^5,
                 "6" = 10^6, "7" = 10^7,
                 "8" = 10^8 ,"9" = 10^9)
Cropdmgconv <- c( 
                 "?" = 10^0,"0" = 10^0,
                 "K" = 10^3,"M" = 10^4,
                 "B" = 10^9) 
TotalGrouped$PROPDMGEXP[TotalGrouped$PROPDMGEXP == ""] <- 10^0
TotalGrouped$CROPDMGEXP[TotalGrouped$CROPDMGEXP == ""] <- 10^0

TotalGrouped$PROPDMGEXP <- revalue(TotalGrouped$PROPDMGEXP , Propdmgconv)
TotalGrouped$CROPDMGEXP <- revalue(TotalGrouped$CROPDMGEXP , Cropdmgconv)


TotalGrouped %>% 
        dplyr::group_by(EVTYPE) %>%
        dplyr::summarise(FATALITIES = sum(FATALITIES),INJURIES = sum(INJURIES),
                         TOTAL = sum(FATALITIES) + sum(INJURIES)) -> Totalaccident

Totalaccident <- Totalaccident[order(-Totalaccident$FATALITIES),] # Sorting Values
Top10 <- head(Totalaccident , n =10)
Top10 <- reshape2::melt(data = Top10 , id.vars = c("EVTYPE") ,variable.name = "accident")

ggplot2::ggplot(data = Top10, aes(x = reorder(EVTYPE, -value) , y = value , fill = accident)) +
        ggplot2::geom_bar(stat = "identity" , position = 'dodge') +
        ggplot2::labs(x = "Disasters" , y = "Total Value" , title = "Top 10 Disasters causing Death") +
        ggplot2::theme(axis.text.x = element_text(angle = 45 ,size = 7)) 
        

sess
## Economic         
OverallLoss <- TotalGrouped
OverallLoss$proploss <- OverallLoss$PROPDMG * as.numeric(OverallLoss$PROPDMGEXP)
OverallLoss$croploss <- OverallLoss$CROPDMG * as.numeric(OverallLoss$CROPDMGEXP)
OverallLoss %>% 
        dplyr::group_by(EVTYPE) %>%
        dplyr::summarise(proplossTot = sum(proploss) ,
                  CROPlossTot = sum(croploss) , 
                  TotalLoss = sum(proplossTot) + sum(CROPlossTot))  -> OverallLoss

OverallLoss <- OverallLoss[order(-OverallLoss$TotalLoss) , ] 
Top10Loss <- head(OverallLoss , 10)
Top10Loss <-reshape2::melt(data = Top10Loss , id.vars = c('EVTYPE'),variable.name = "Disasters")
#Top10Loss <- reshape2::melt(data = Top10Loss , id.vars = c("EVTYPE") , variable.name = "Category")

ggplot2::ggplot(data = Top10Loss , aes(x = reorder(EVTYPE , -value) , y =value ,fill = Disasters )) +
        ggplot2::geom_bar(stat = "identity" , position = "dodge" ,) + 
        ggplot2::labs(x = "Disasters" , y = "Total Value" , title = "Top 10 Disasters causing Big Loss")+
        ggplot2::theme(axis.text.x = element_text(angle = 45 , size = 4))
