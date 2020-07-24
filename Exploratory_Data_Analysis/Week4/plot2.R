setwd("D:/Exploratory_Data_Analysis/Week4")

# Reading Data .
NEI <- base::readRDS("./DataSet/Source_Classification_Code.rds")
SCC <- base::readRDS("./DataSet/summarySCC_PM25.rds")

#Question of Interest
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

head(SCC)

# Output (Note This is for 1999 , 2002 , 2005 ,2008 theres something must be going on unstable)
# fips      SCC Pollutant Emissions  type year
# 4  09001 10100401  PM25-PRI    15.714 POINT 1999
# 8  09001 10100404  PM25-PRI   234.178 POINT 1999
# 12 09001 10100501  PM25-PRI     0.128 POINT 1999
# 16 09001 10200401  PM25-PRI     2.036 POINT 1999
# 20 09001 10200504  PM25-PRI     0.388 POINT 1999
# 24 09001 10200602  PM25-PRI     1.490 POINT 1999

SubsetSCC <- subset(SCC , fips == "24510")

head(SubsetSCC)
# Output
# fips      SCC Pollutant Emissions  type year
# 114288 24510 10100601  PM25-PRI     6.532 POINT 1999
# 114296 24510 10200601  PM25-PRI    78.880 POINT 1999
# 114300 24510 10200602  PM25-PRI     0.920 POINT 1999
# 114308 24510 30100699  PM25-PRI    10.376 POINT 1999
# 114325 24510 30183001  PM25-PRI    10.859 POINT 1999
# 114329 24510 30201599  PM25-PRI    83.025 POINT 1999

TotalEmissionBM <-stats::aggregate(x = SubsetSCC$Emissions , by = list(SubsetSCC$year) ,
                                  FUN = sum) 
names(TotalEmissionBM) <- c("year" , "total") 

with(TotalEmissionBM ,{
  graphics::barplot(total , names = year,
                    ylab = "Emission" , xlab = "Years",
                    main = "Total Emission in Baltimore and Maryland", col =year,
                    )
  graphics::legend("topright" , cex = 0.75 , legend = year ,
                   fill = year )
  
})

#Saving
grDevices::png(filename = "plot2.png")


with(TotalEmissionBM ,{
  graphics::barplot(total , names = year,
                    ylab = "Emission" , xlab = "Years",
                    main = "Total Emission in Baltimore and Maryland", col =year,
  )
  graphics::legend("topright" , cex = 0.75 , legend = year ,
                   fill = year )
  
})

dev.off()
