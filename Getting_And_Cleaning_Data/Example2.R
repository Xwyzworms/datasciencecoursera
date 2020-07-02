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
clean_df$name

dplyr::select(df , c(-zipCode,-NAME))
str(df)

df %>% 
  select(c(-X2010.Census.Neighborhoods ,-X2010.census.Wards.Precints ,-Zip.Codes,
           -NAME , -neighborhood , -policDistrict , -Location.1)) %>%
  stats::cor()
clean_df
## Joining columns 
df1 <- dplyr::tibble(
  name = c("Moe" , "Larry" , "Curly" , "Harry"),
  year_born = c(1887,1982,1903,1964) , 
  place_born = c("BensonHurst" , "Philadelphia" ,"Brooklyn" , "Moscow")
)
df2 <- dplyr::tibble(
  name = c("Curly" , "Moe" , "Larry"),
  year_ded = c(1952,1975,1975)
)

base::cbind(df1 , df2)
df1
dplyr::inner_join(df1 , df2 , by = "name")
dplyr::full_join(df1 , df2 , by ="name")
dplyr::left_join(df1 , df2 , by ="name")
dplyr::right_join(df1 , df2 , by ="name")
library(dplyr)

df = utils::read.csv(".\\CsvFolder\\Example.csv")
#Creating Sequences for indexes
s1 <- base::seq(1 , 10 ,by = 2);s1
s2 <- base::seq(1,10 , length = 3) ;s2
x <- c(1,3,7,21,3111);seq(along = x)

## Creating Binary Variables 
df$zipWrong = base::ifelse(df$zipCode < 0 , TRUE , FALSE)
table(df$zipWrong , df$zipCode < 0)
##Creating Categorical Variables From Numeric
df$zipGroups = base::cut(df$zipCode , breaks = stats::quantile(df$zipCode))
base::table(df$zipGroups)
### This Make my life easier
base::table(df$zipGroups , df$zipCode)

##Creating Factor variables
df$zcFactor <- factor(df$zipCode)
head(df)
##Sampling and Simulation
yesno <- base::sample(x = c("yes","no") , size = 100 , replace = T)
yesnofac <- factor(x = yesno , levels = c("yes" , "no"))
yesnofac
relevel(yesnofac , ref ="yes")
as.numeric(yesnofac)

## In case You want Logic Only 
Example1 <- c(T,F,T,T,F,T)
base::sum(Example1) ## True Only
length(Example1) - base::sum(Example1)

