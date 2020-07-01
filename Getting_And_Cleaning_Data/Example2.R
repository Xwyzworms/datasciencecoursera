if(!dir.exists(".\\CsvFolder")){dir.create(".\\CsvFolder")}
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"   
download.file(url = url  , destfile = ".\\CsvFolder\\Example.csv")
base::list.files(".\\CsvFolder")

df = utils::read.csv(".\\CsvFolder\\Example.csv")
head(df , n =5)
## Summary
base::summary(df)

##More Information
str(df)

##Quantiles of quantitative var
stats::quantile(df$councilDistrict , na.rm = T)

#Quantiles with given prob
stats::quantile(df$councilDistrict , na.rm = T,
                probs=c(0.50 , 0.75 , 0.90))
?stats::quantile

##Using table for summarize
?base::table
base::table(df$zipCode , useNA = "no")

##Build tables 
base::table(df$councilDistrict , df$zipCode , useNA = "no")

##Na Checking  
base::sum(is.na(df$councilDistrict))
base::any(is.na(df$councilDistrict))
base::all(df$councilDistrict)
##
base::colSums(is.na(df) ,na.rm = T)
base::rowSums(is.na(df) ,na.rm = T)

##Creating table with specific values

base::table(df$zipCode %in% c("21212","21213"))


## Extracing DataFrame With Style
df[df$zipCode %in% c("21212" , "21213") ,names(df) ]


## Cross tabs  
data("UCBAdmissions")
dfNew = as.data.frame(UCBAdmissions)
summary(dfNew)

library(dplyr)
#selecting columns
df %>% dplyr::select(zipCode)
#Rename Col 
df <- df %>% dplyr::rename(Lonte = zipCode)
names(df)
 
base::colnames(df) <- c("NAME" , "zipCode" ,"neighborhood",
                        "councilDistrict" , "policDistrict",
                        "Location.1","X2010.Census.Neighborhoods",
                        "X2010.census.Wards.Precints","Zip.Codes")
names(df) ## NEED TO SPECIFY Every Single name
## Removing Rows that contain NA

clean_df <- stats::na.omit(df)
clean_df

dplyr::select(df , c(-zipCode,-NAME))
str(df)

df %>% 
  select(c(-X2010.Census.Neighborhoods ,-X2010.census.Wards.Precints ,-Zip.Codes,
           -NAME , -neighborhood , -policDistrict , -Location.1)) %>%
  stats::cor()
