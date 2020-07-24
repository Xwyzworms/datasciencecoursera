setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

# Question Of Interest . 
# Have total emissions from PM2.5 decreased 
# in the United States from 1999 to 2008? 
# Using the base plotting system, make 
# a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999

str(SCC)
SCC$year

TotalSum <- stats::aggregate(SCC$Emissions , by = list(year = SCC$year) , FUN =sum )

TotalSum

#  OUtput
# year       x
# 1 1999 7332967
# 2 2002 5635780
# 3 2005 5454703
# 4 2008 3464206

base::with(TotalSum, {
  graphics::barplot(x 
                    , xlab = "Years" 
                    , ylab = "Emission"
                    , main = "Sum of Emission Per Year"
                    , col = 'red'
                    , names = year
                    )
})

## Saving The plot
grDevices::png(filename = "plot1.png")

base::with(TotalSum, {
  graphics::barplot(x 
                    , xlab = "Years" 
                    , ylab = "Emission"
                    , main = "Sum of Emission Per Year"
                    , col = 'red'
                    , names = year
  )
})

dev.off()




