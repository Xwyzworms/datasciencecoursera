## Quiz Sol
library(dplyr);library(plyr)
FileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(url = FileUrl , destfile = ".\\csvFolder\\Quiz3.csv" )
list.files(".\\csvFolder")
df <- read.csv(".\\csvFolder\\Quiz3.csv")
df <- dplyr::tbl_df(df)
head(df)


agricultureLogic <- base::which(df$ACR == 3 & df$AGS == 6)
head(agricultureLogic)
unique(df$ACR)

library(jpeg)
FileUrl2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file (url = FileUrl2 , destfile = ".\\Jeff.jpg" , mode = "wb")
pic <- jpeg::readJPEG(source = ".\\jeff.jpg" , native =TRUE)
quantile(pic , probs = c(0.3,0.8))


FileUrl3 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
FileUrl31= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url = FileUrl3 , destfile = ".\\csvFolder\\no3.csv")
download.file(url = FileUrl31 , destfile =".\\csvFolder\\no31.csv")
library(data.table)
df1 <- data.table::fread(".\\csvFolder\\no3.csv" , select = c(1,2,4,5),nrows = 190
                         , skip =6 ,col.names=c("CountryCode", "Rank", "Economy", "Total"))

df2 <- data.table::fread(input = ".\\csvFolder\\no31.csv")
Merged <- dplyr::inner_join(df1,df2 , by = "CountryCode")
nrow(Merged)
Merged %>% arrange(desc(Rank)) -> answer
answer[12,Economy]


Mergedtbl <- dplyr::tbl_df(Merged)
Mergedtbl <- dplyr::rename(Mergedtbl , Income_Group = "Income Group" ,
                           Currency_unit = "Currency Unit")
Mergedtbl %>% dplyr::group_by(Income_Group ) %>% 
  filter(Income_Group == "High income: OECD") %>% 
  base::tapply(X = Mergedtbl$Rank , INDEX = Mergedtbl$Income_Group , FUN = mean) %>%
  print
  
base::tapply(X = Mergedtbl$Rank , INDEX = Mergedtbl$Income_Group , FUN = mean)

?base::tapply()
Mergedtbl$Rank
seq(0,1 ,0.2)
breakz <- stats::quantile(x = Mergedtbl$Rank , probs = seq(0 , 1 , 0.2),  ## Trying To make The Percentiles Right
                        na.rm = T)

Mergedtbl$RankGroups <- base::cut(Mergedtbl$Rank , breaks =breakz) ## Cutting Using Percentiles
#table(Mergedtbl$RankGroups , Mergedtbl$Income_Group)
Mergedtbl %>% dplyr::filter(Income_Group == "Lower middle income" ) -> VALUES
VALUES <- as.data.table(VALUES)
VALUES[, c("Income_Group" , "RankGroups")]
table(VALUES$Income_Group , VALUES$RankGroups)
?dplyr::filter
