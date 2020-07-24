setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

# load Library
library(ggplot2)
#Question of Interest
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999


# Taking Vehicle Dat
VehicleLogic<- grepl(pattern = "Vehicle" , ignore.case = T,
                    x = NEI$SCC.Level.Two)

VehicleDat <- NEI[VehicleLogic , "SCC"]
names(SCC)
FinDat <- SCC[SCC$SCC %in% VehicleDat , ]

## Spare Baltimore & Los Angeles
BaltimoreDat <- FinDat[FinDat$fips == "24510" , ]
nrow(BaltimoreDat) # ] 1393

LosAngelesDat <- FinDat[FinDat$fips == "06037" , ]
nrow(LosAngelesDat) # 1324


## Lets Aggregate that

BaltimoreEms <- stats::aggregate(x = BaltimoreDat$Emissions , by = list(BaltimoreDat$year) , FUN = sum)
LosAngelesEMS <- stats::aggregate(x = LosAngelesDat$Emissions , by = list(LosAngelesDat$year) ,FUN = sum)
names(BaltimoreEms) <- c("year","total")
names(LosAngelesEMS) <- c("year","total")

par(mfrow = c(1,2) )
with(BaltimoreEms , {
  barplot(total , col = year , xlab = "Year" , ylab = expression("Emission" *PM[25]) ,main ="Baltimore city")
  legend("topright" , legend = year ,fill = year ,cex = 0.75)
  })
with(LosAngelesEMS , {
  
  barplot(total , col = year ,xlab = "year" , ylab = expression("Emission" * PM[25]) , main = "LosAngeles City")
  legend("topright", legend = year , fill = year ,cex = 0.22) 
})

## With GGplot
library(dplyr)
BaltimoreDat$city <- c("Baltimore City")
nrow(BaltimoreDat) # 1393

LosAngelesDat$city <- c("LosAngeles City")
nrow(LosAngelesDat) # 1324

MergedData <- dplyr::full_join(BaltimoreDat , LosAngelesDat)
nrow(MergedData) # 2717

MergedDataAgg <- stats::aggregate(x = MergedData$Emissions , by = list(MergedData$year , MergedData$city) ,FUN = sum)
names(MergedDataAgg) <- c("year" ,"city" , "total")
ggplot(data = MergedDataAgg ,aes(as.factor(year) , total ,fill = as.factor(year))) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ city) +
  labs(x = "YEAR" , y = expression("Emission" * PM[25]) ,title = "LosAngeles Vs Baltimore") +
  theme(axis.text.x = element_text(angle = 90)) +
  guides(fill = guide_legend(title = "Year"))


## Saving

grDevices::png(filename = "plot6.png")

ggplot(data = MergedDataAgg ,aes(as.factor(year) , total ,fill = as.factor(year))) +
  geom_bar(stat = "identity") +
  facet_grid(. ~ city) +
  labs(x = "YEAR" , y = expression("Emission" * PM[25]) ,title = "LosAngeles Vs Baltimore") +
  theme(axis.text.x = element_text(angle = 90)) +
  guides(fill = guide_legend(title = "Year"))

dev.off()
