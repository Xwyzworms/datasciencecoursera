setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

# load Library
library(ggplot2)
#Question of Interest
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999


names(NEI)
unique(NEI$SCC.Level.Two)

VehicleLogic <- grepl("Vehicle" , ignore.case = T , x = NEI$SCC.Level.Two)
VehicleSCC <- NEI[VehicleLogic ,"SCC"] 

VehicleSCC
# [1] 2201001000 2201001110 2201001111 2201001112 2201001113 2201001114 220100111B 220100111T 220100111V 220100111X
# [11] 2201001130 2201001131 2201001132 2201001133 2201001134 220100113B 220100113T 220100113V 220100113X 2201001150
# [21] 2201001151 2201001152 2201001153 2201001154 220100115B 220100115T 220100115V 220100115X 2201001170 2201001171

FinData <- SCC[SCC$SCC %in% VehicleSCC , ]
FinData <- FinData[FinData$fips == "24510" , ]

TotalEms <- stats::aggregate(x = FinData$Emissions , by = list(FinData$year) , FUN = sum)
TotalEms

#Ouput
# Group.1        x
# 1    1999 403.7700
# 2    2002 192.0078
# 3    2005 185.4144
# 4    2008 138.2402
names(TotalEms) <- c("year","total")
ggplot(data = TotalEms , aes(x = as.factor(year) , y = total , fill = as.factor(year)) )+
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90 , hjust = 1 ,vjust = 0)) + 
  labs(x = "Year" , y = expression("Emission" * PM[25]) ,title = "Vehicle Emission in Baltimore")+
  guides(fill = guide_legend(title = "Year")) 

## Saving

grDevices::png(filename = "plot5.png")

ggplot(data = TotalEms , aes(x = as.factor(year) , y = total , fill = as.factor(year)) )+
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 90 , hjust = 1 ,vjust = 0)) + 
  labs(x = "Year" , y = expression("Emission" * PM[25]) , title = "Vehicle Emission in Baltimore")+
  guides(fill = guide_legend(title = "Year")) 

dev.off()

