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

##


## Saving

grDevices::png(filename = 'plot3.png' ,width = 640 , height = 640)
with(dfsubset , {
  plot(datetime ,Sub_metering_1 ,type = "l" ,col = 'black' , ylab ='Energy Submetering')
  lines(datetime , Sub_metering_2 , type = "l" , col = "red")
  lines(datetime , Sub_metering_3 , type = "l" , col = "blue")
  legend("topright" , legend= c("Sub_metering_1" , "Sub_metering_2" , "Sub_metering_3"),
         col = c("black" , "blue" , "red") , lwd = 1)
  
})
dev.off()

## Reading

library(imager)
img <- imager::load.image("plot3.png")
plot(img)

