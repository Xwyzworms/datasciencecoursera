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
dfsubset$datetime <- strptime(paste(dfsubset$Date,dfsubset$Time , sep =" ") , "%d/%m/%Y %H:%M:%S")

dfsubset$Sub_metering_1 <- as.numeric(dfsubset$Sub_metering_1,na.rm = T)
dfsubset$Sub_metering_2 <- as.numeric(dfsubset$Sub_metering_2 , na.rm = T)
dfsubset$Sub_metering_3 <- as.numeric(dfsubset$Sub_metering_3 , na.rm = T)

dfsubset$Voltage <- as.numeric(dfsubset$Voltage , na.rm = T)
dfsubset$Global_reactive_power <- as.numeric(dfsubset$Global_reactive_power ,na.rm = T)
dfsubset$Global_active_power <- as.numeric(dfsubset$Global_active_power ,na.rm = T)




# Saving

grDevices::png(filename = "plot4.png" , width = 640 , height = 640)


par(mfrow = c(2,2) , mar = c(4,4,1,1))
with(dfsubset , {
  plot(datetime , Global_active_power, type = "l" , xlab = " " , ylab = 'Global Active Power')
  plot(datetime , Voltage , type = "l" , xlab = 'datetime' , ylab = 'Voltage')
  plot(datetime , Sub_metering_1 , type = 'l' ,col = "black")
  lines(datetime , Sub_metering_2 , type = 'l' ,col = 'blue')
  lines(datetime , Sub_metering_3 , type = "l" , col = "red")
  legend("topright" , legend = c('Sub_metering_1' , "sub_Metering_2" , "Sub_Metering_3") ,
         col = c("black","blue","red") ,lty = 1 , lwd = 2 ,cex = 0.80)
  plot(datetime , Global_reactive_power , type = 'l' ,col = "black")
  
})

dev.off()

## Reading
library(imager)

img <- imager::load.image("plot4.png")
plot(img)


