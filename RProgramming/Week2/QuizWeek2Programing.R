pollutantmean <- function(directory,pollutant ,  id = 1:332)
{
  
  
  files <- Sys.glob(directory)
  
  combined_information <- c()
  
  for (i in id)
  {
    
    file_dat <- read.csv(files[i] , sep = ",")
    pollutant_dat <- file_dat[,pollutant]
    pollutant_dat <- pollutant_dat[!is.na(pollutant_dat)]
    combined_information <- c(combined_information , pollutant_dat)
  
  }
  return(mean(combined_information))
  
}

pollutantmean("Week2//specdata//*.csv","sulfate",1:10)

pollutantmean("Week2//specdata//*.csv","nitrate",70:72)

pollutantmean("Week2//specdata//*.csv","sulfate",34)

pollutantmean("Week2//specdata//*.csv","nitrate")

complete <- function(directory , id = 1:332)
{
  files <- Sys.glob(directory)
  
  Thenobs <- c()
  for (i in id)
  {
    file_dat <-read.csv(files[i] , sep = ",")
    complete.cases_dat <- file_dat[complete.cases(file_dat) , ] ## Check wheter the Desired Row have Missing Values
    Thenobs <- c(Thenobs , nrow(complete.cases_dat))
  }
  return (data.frame(cbind(id,Thenobs)))
  
}
cc <- complete("Week2//specdata//*.csv" , c(6,10,20,34,100,200,310))
print(cc)

cc2 <- complete("Week2//specdata//*.csv",54)

print(cc2)

corr <- function(directory , threshold = 0)
{
  
  files <- Sys.glob(directory)
  vect_corr <- c()
  for( file in seq_along(files))
  {
    file_dat <- read.csv(files[file] , sep = ",")
    No_Nihil <- file_dat[complete.cases(file_dat) ,]
    if(NROW(No_Nihil) > threshold)
    {
      vect_corr <- c(vect_corr , cor(No_Nihil$sulfate , No_Nihil$nitrate))
      
    }
  }
  return(vect_corr)
  
}

RNGversion("3.5.1")
set.seed(42)
cc <- complete("Week2//specdata//*.csv" , 332:1)
use <- sample(332 , 10)
print(cc[use,"Thenobs"])
cr <-corr("Week2//specdata//*.csv")
cr <- sort(cr)
RNGversion("3.5.1")
set.seed(868)
out <- round(cr[sample(length(cr),5)] ,4)
print(out)

cr <-corr("Week2//specdata//*.csv",129)
cr <- sort(cr)
n <- length(cr)
RNGversion("3.5.1")
set.seed(197)
out <- c(n,round(cr[sample(n,5)] ,4))
print(out)


cr <-corr("Week2//specdata//*.csv",2000)
n <- length(cr)
cr <-corr("Week2//specdata//*.csv",1000)
cr <- sort(cr)
print(c(n,round(cr,4)))

