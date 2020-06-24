add <- function(a,b)
{
 (a+b) + 5
}


above10 <- function(x,n)
{
  use <- x > n
  x[use] 
  
}
x <- 1:25
above10(x,20)

columnmean <- function(y , remove_NA = TRUE)
{
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in seq_along(nc))
  {
    means[i] <- mean(y[,i],na.rm = TRUE)
    
  }
  
  means
}
