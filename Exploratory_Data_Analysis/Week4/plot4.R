setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

# load Library
library(ggplot2)
#Question of Interest
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999

base::unique(NEI)
names(NEI)

SubsetData <- NEI[,c(1,2,7,10)]
SubsetData
CombData <- grepl("comb" , ignore.case = T , x = SubsetData[, 3]) 

SubsetData$SCC.Level.One[CombData]
# Output :
# [1] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers      
# [4] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers      
# [7] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers      
# [10] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers      
# [13] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers      
# [16] External Combustion Boilers       External Combustion Boilers       External Combustion Boilers  

CoalData <- grepl("coal" , ignore.case = T , x = SubsetData[,4])
SubsetData$SCC.Level.Four[CoalData]

# #
# [1] Pulverized Coal                                                       
# [2] Pulverized Coal: Wet Bottom (Bituminous Coal)                         
# [3] Pulverized Coal: Dry Bottom (Bituminous Coal)                         
# [4] Cyclone Furnace (Bituminous Coal)                                     
# [5] Spreader Stoker (Bituminous Coal)                                     
# [6] Traveling Grate (Overfeed) Stoker (Bituminous Coal)                   
# [7] Wet Bottom (Tangential) (Bituminous Coal)                             
# [8] Pulverized Coal: Dry Bottom (Tangential) (Bituminous Coal)            
# [9] Cell Burner (Bituminous Coal)                                         
# [10] Atmospheric Fluidized Bed Combustion: Bubbling Bed (Bituminous Coal)  
# [11] Atmospheric Fluidized Bed Combustion: Circulating Bed (Bitum. Coal)   
# [12] Pulverized Coal: Wet Bottom (Subbituminous Coal)                      
# [13] Pulverized Coal: Dry Bottom (Subbituminous Coal)                      
# [14] Cyclone Furnace (Subbituminous Coal)                                  
# [15] Spreader Stoker (Subbituminous Coal)                                  
# [16] Traveling Grate (Overfeed) Stoker (Subbituminous Coal)

TheSCC <- NEI[CoalData & CombData, "SCC"] ## Only Take True Values

CoalSCC <- NEI[CoalData , "SCC"]
CombSCC <- NEI[CombData , "SCC"]


table(SCC$SCC %in% TheSCC)
# FALSE    TRUE 
# 6493084    4567 
FinData <- SCC[SCC$SCC %in% TheSCC,]


head(FinData)

#Output : 

# fips      SCC Pollutant Emissions  type year
# 9979  09011 10100217  PM25-PRI   479.907 POINT 1999
# 19504 23005 10200202  PM25-PRI     0.119 POINT 1999
# 22888 23009 10200219  PM25-PRI     3.419 POINT 1999
# 28873 23017 10200219  PM25-PRI    11.242 POINT 1999
# 44907 25005 10100202  PM25-PRI  1012.027 POINT 1999
# 44911 25005 10100212  PM25-PRI  1050.520 POINT 1999

TotalEms <- stats::aggregate(x = FinData$Emissions , by = list(FinData$year) , FUN = sum)

TotalEms

# Output
# Group.1        x
# 1    1999 551535.2
# 2    2002 474708.6
# 3    2005 481834.4
# 4    2008 332024.4
names(TotalEms) <- c("year" , "total")
ggplot(data = TotalEms , aes(x = as.factor(year) , y = total ,fill = as.factor(year))) +
  geom_bar(stat = "identity") + 
  labs(x = "Year" , y =expression("Emission" * PM[25]) , title = "Coal & Comb Emission") +
  theme(axis.text.x = element_text(angle = 90 ,vjust = 0 ,hjust = 1 )) +
  guides(fill = guide_legend(title = "Year"))

## Saving 

grDevices::png(filename = "plot4.png")


ggplot(data = TotalEms , aes(x = as.factor(year) , y = total ,fill = as.factor(year))) +
  geom_bar(stat = "identity") + 
  labs(x = "Year" , y =expression("Emission" * PM[25]) , title = "Coal & Comb Emission") +
  theme(axis.text.x = element_text(angle = 90 ,vjust = 0 ,hjust = 1 )) +
  guides(fill = guide_legend(title = "Year"))


dev.off()

