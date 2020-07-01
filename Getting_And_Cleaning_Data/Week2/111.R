connDb <- RMySQL::dbConnect(MySQL() ,user = "genome",
                            host = "genome-mysql.cse.ucsc.edu")
db <- DBI::dbGetQuery(connDb , "show databases")
RMySQL::dbDisconnect(connDb)
db


hg19Conn <- RMySQL::dbConnect(MySQL() , user ="genome",
                              db = "hg19" , host ="genome-mysql.cse.ucsc.edu")
hg19tables <- DBI::dbListTables(hg19Conn)
length(hg19tables)
#RMySQL::dbDisconnect(hg19Conn)

hg19tables[1:10] # show 1 to 10 tables

dbListFields(hg19Conn,"affyU133Plus2")

DBI::dbGetQuery(hg19Conn , "select count(*) from affyU133Plus2")

## Read Table
AffyData <- DBI::dbReadTable(hg19Conn , "affyU133Plus2")
head(AffyData)

# cuz Tables in databases is big ,we'll take the subset 
query <- DBI::dbSendQuery(hg19Conn , "select * from affyU133Plus2 where misMatches between 1 and 3")
AffyDataSubset <- DBI::fetch(query) 
stats::quantile(AffyDataSubset$misMatches)
base::dim(AffyDataSubset)
RMySQL::dbDisconnect(hg19Conn)
## END OF READING FROM MYSQL !!

## Skipped HD5 cuz m lazy
## READING From Web 
htmlconn = httr::GET(url = "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
content = httr::content(htmlconn , as = "text")
parsedHtml = XML::htmlParse(content , asText =TRUE)
XML::xpathSApply(parsedHtml , "//title" , XML::xmlValue)


library(httr)
library(httpuv)
library(jsonlite)

httr::oauth_endpoints("github")

myapp <- httr::oauth_app(appname = "Coursera_John_Hopkins" , 
                         key = "b1087c4380f32ffcb869",
                         secret = "7451afe5bec4b1f568a4b0cfe15415124f771a2")
github_token <- httr::oauth1.0_token(httr::oauth_endpoints("github"),myapp)
print(github_token)
gtoken <- config(token = github_token)
req <- httr::GET("https://api.github.com/users/jtleek/repos",gtoken)
print(req)
stop_for_status(req)

jsondata = content(req)

DF = jsonlite::fromJSON(jsonlite::toJSON(jsondata))

DF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

##Number 2
if(!dir.exists("csvFolder")) {dir.create("csvFolder")}
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = ".\\csvFolder\\quiz2.csv")
list.files(".\\csvFolder")
acs = data.table::data.table(read.csv(".\\csvFolder\\quiz2.csv"))
que1 <- sqldf::sqldf("select pwgtp1 from acs where AGEP < 50")

## Number 3 
que2 <- sqldf::sqldf("select distinct AGEP from acs")

##Number 4
conn <- base::url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode <- base::readLines(conn)
base::close(con = conn)
htmlcode
c(base::nchar(htmlcode[10]) , base::nchar(htmlcode[20]),
  base::nchar(htmlcode[30]) , base::nchar(htmlcode[100]))

##number 5 
url = base::url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
Thelines <- base::readLines(url , n = 10)
Thelines
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3) ## Width for the columns unit
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12", 
              "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
              "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4, col.names = colNames)
d <- d[, base::grep("^[^filler]" ,names(d) )]
sum(d[,4])
