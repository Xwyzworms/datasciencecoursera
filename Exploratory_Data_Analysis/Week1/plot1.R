setwd("D:\\Exploratory_Data_Analysis")

## Reading File

df <- read.table(".\\DataSet\\exdata_data_household_power_consumption\\household_power_consumption.txt",sep = ';',
                 header = T ,stringsAsFactors =  F )

nrow(df) #Checking Rows
unique(df$Date) # Cheking the date

dfsubset <- df[df$Date %in% c("1/2/2007" , "2/2/2007") , ]
nrow(dfsubset) ## 2880 rows
names(dfsubset)

dfsubset$Global_active_power <- as.numeric(dfsubset$Global_active_power)

## Plotting & Saving it to png
## 

grDevices::png(filename=".\\plot1.png" ,width = 640 , height = 640)

graphics::par(mfrow = c(1,1) , mar = c(4,4,1,1))

base::with(dfsubset , {
  graphics::hist(Global_active_power , col = 'red' , main = "Global Active Power" ,
                 xlab = "Global Active Power (kilowatts)" , ylab = "Frequency")
})

dev.off()

## Reading Png files
#install.packages("imager")


library(imager)

img <- imager::load.image(".\\plot1.png")
plot(img)