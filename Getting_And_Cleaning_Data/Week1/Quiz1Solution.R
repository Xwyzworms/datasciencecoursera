## Creating Folder dude
if (!dir.exists("CsvFolder")){dir.create("CsvFolder")}
fileurl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(url = fileurl , destfile = ".\\CsvFolder\\cameras.csv")
list.files(".\\CsvFolder")
date_downloaded <- date()
print(date_downloaded)

dataframe = read.csv(".\\CsvFolder\\cameras.csv")
head(dataframe)
ncol(dataframe)

## Excelfile
if(!dir.exists("CsvFolder")){dir.create("CsvFolder")}
library(XLConnect)
library(xlsx)
#fileurl <-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD" 
#download.file(url = fileurl,destfile = ".\\CsvFolder\\cameras.xlsx")
#list.files(".\\CsvFolder")
#cameradata <- read.xlsx(".\\CsvFolder\\cameras.xlsx" , sheetIndex = 1 ,
#                        HEAD = TRUE)
library(XML)
fileurl <- "https://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(sub("s","",fileurl) , useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

library(jsonlite)
jsondata <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsondata)

jsondata$name


if (!dir.exists("CsvFolder")){dir.create("CsvFolder")}
fileurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(url = fileurl , destfile = ".\\CsvFolder\\quiz1.csv")
list.files(".\\CsvFolder")
date_downloaded <- date()
print(date_downloaded)

df = read.csv(".\\CsvFolder\\quiz1.csv")
head(df)
table(df$VAL == 24)


df$FES

library(xlsx)

fileurl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url = fileurl , destfile = ".\\CsvFolder\\quiz2.xlsx" , mode = 'wb')
list.files(".\\CsvFolder")
date_downloaded <- date()
print(date_downloaded)
df <- xlsx::read.xlsx(file = ".\\CsvFolder\\quiz2.xlsx" ,sheetIndex = 1,rowIndex = 18:23 ,colIndex = 7:15 )
head(df)

library(XML)
library(RCurl)
fileurl <- RCurl::getURL("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml")
doc <- XML::xmlTreeParse(fileurl , useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
ZipExtracted <- xpathSApply(doc = rootNode , "//zipcode" , xmlValue)
ZipExtracted
table(ZipExtracted)



fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url = fileurl , destfile = ".\\CsvFolder\\quiz5.csv")
list.files(".\\CsvFolder")
DT <- data.table::fread(".\\CsvFolder\\quiz5.csv")
head(DT)

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[, mean(pwgtp15),by=SEX])
