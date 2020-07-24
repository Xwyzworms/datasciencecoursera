setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

# load Library
library(ggplot2)
#Question of Interest
# Of the four types of sources indicated by the 
# type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999

base::unique(SCC$type)
#Output
# [1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD" 

SubsetSCC <- SCC[SCC$fips == "24510",]
SubsetSCC <- stats::aggregate(x = SCC$Emissions , by = list(SCC$type , SCC$year) , FUN = sum)

names(SubsetSCC) <- c("type" , "year" , "total")
SubsetSCC
# Output 
#     type year     total
# 1  NON-ROAD 1999  307126.5
# 2  NONPOINT 1999 5518185.3
# 3   ON-ROAD 1999  183895.1
# 4     POINT 1999 1323759.8
# 5  NON-ROAD 2002  344087.5
# 6  NONPOINT 2002 4254247.0
# 7   ON-ROAD 2002  154222.2
# 8     POINT 2002  883223.8
# 9  NON-ROAD 2005  313628.1
# 10 NONPOINT 2005 4043390.2
# 11  ON-ROAD 2005  134291.8
# 12    POINT 2005  963392.9
# 13 NON-ROAD 2008  183666.2
# 14 NONPOINT 2008 2438866.9
# 15  ON-ROAD 2008  107384.1
# 16    POINT 2008  734288.6

library(ggplot2)

ggplot(SubsetSCC , aes(x = as.factor(year), y = total , fill = as.factor(year))) + 
  geom_bar(stat = 'identity') +
  ggplot2::facet_grid(. ~ type ) +
  theme(axis.text.x = element_text(angle = 90 ,vjust = 0 ,hjust = 1 )) + 
  guides(fill =guide_legend(title = "Year")) +
  labs(x = "Year" , y = expression("Emission " * PM[25]) , title = "Baltimore City Emission per year BY Type")

## Saving
grDevices::png(filename = "plot3.png")

ggplot(SubsetSCC , aes(x = as.factor(year), y = total , fill = as.factor(year))) + 
  geom_bar(stat = 'identity') +
  ggplot2::facet_grid(. ~ type ) +
  theme(axis.text.x = element_text(angle = 90 ,vjust = 0 ,hjust = 1 )) + 
  guides(fill =guide_legend(title = "Year")) +
  labs(x = "Year" , y = expression("Emission " * PM[25]) , title = "Baltimore City Emission per year BY Type")

dev.off()

