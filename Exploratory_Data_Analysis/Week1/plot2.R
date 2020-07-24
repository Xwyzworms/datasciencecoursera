setwd("D:/Exploratory_Data_Analysis")

df <- read.table("./DataSet/exdata_data_household_power_consumption/household_power_consumption.txt",
                 header = T , stringsAsFactors = F,sep = ";")

unique(df$Date)
str(df)
dfsub <- df[df$Date %in% c("1/2/2007" , "2/2/2007"),]


# strptime(paste(dfsub$Date, dfsub$Time, sep=" ") , "%d/%m/%Y %H:%M:%S")

dfsub$dateTime <- strptime(paste(dfsub$Date, dfsub$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
dfsub$Global_active_power <- as.numeric(dfsub$Global_active_power )


## Saving 
grDevices::png(filename = "plot2.png" ,width = 640 , height = 640)
plot(dfsub$dateTime,dfsub$Global_active_power ,type = "l" ,xlab = ' ' , ylab =" Global Active Power (kilowatts)")
dev.off()

## READING
library(imager)

img <- imager::load.image("plot2.png")
plot(img)

