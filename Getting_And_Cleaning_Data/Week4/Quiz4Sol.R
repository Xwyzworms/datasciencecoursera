if (!dir.exists("CsvFolder")){dir.create("CsvFolder")}
FileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url = FileUrl , destfile = ".\\CsvFolder\\Quiz4.csv")
list.files("CsvFolder") 

## Reading Data
data <- data.table::fread(input = ".\\CsvFolder\\Quiz4.csv")
head(data)
base::strsplit(x = names(data), split = "wgtp")


FileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url = FileUrl2 , destfile = ".\\CsvFolder\\Quiz42.csv")
data <- data.table::fread(input = ".\\CsvFolder\\Quiz42.csv" , skip = 5 ,
                          nrows = 190 ,
                          select = c(1,2,4,5) , 
                          col.names = c("CountryCode","rank","Country","GDP"))

data[, mean(as.integer(gsub(pattern = "," ,replacement = "" , x = GDP)) , na.rm = T)]

table(grepl(pattern = "^United" , x = data[,Country]))

library(dplyr)
FileUrl3 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = FileUrl3 , destfile = ".\\CsvFolder\\Quiz43.csv")
data2 <- data.table::fread(input = ".\\CsvFolder\\Quiz43.csv")
data3 <-dplyr::inner_join(x = data , y = data2 , by = "CountryCode")
table(grepl(pattern = "Fiscal year end: June 30;" , x =data3[, `Special Notes`]))
grep(pattern = "Fiscal year end: March 31" , x = data3[,`Special Notes`] ,)

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

df <- data.table::data.table(time = sampleTimes)
head(df)

df %>%
  dplyr::filter(time >= "2012-01-01" & time <= "2013-01-01") %>%
  dplyr::summarise(count = n()) %>% print

df %>%
  dplyr::filter( (time >= "2012-01-01" & time <= "2013-01-01") & (base::weekdays(df$time) == "Monday") ) %>%
  dplyr::summarise(count = n()) %>% print
