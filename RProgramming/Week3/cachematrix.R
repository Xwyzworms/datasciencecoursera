## Put comments here that give an overall description of what your

##
## MakeCacheMatrix Fucntion.
## Hi , So what this function does is that Creating A Cache Matrix 
## for cacheSolve ,so we can inverse the given matrix,lol
#

## Creating caches Matrix, try to know what is caches first :D 
##
makeCacheMatrix <- function(x = matrix()) {
  matriex <- x 
  matriex_inverse <- NULL
  
  SetVectorValue <- function(value)
  {
    matriex <<- value ## And Turn it Global
    matriex_inverse <<- NULL ##And Turn it global
  }
  GetVectorValue <-function()
  {
    return(x)
  }
  SetInverse <- function(TheInverse) {matriex_inverse <<- TheInverse }
  GetInverse <- function() {return (matriex_inverse)}
  ## Creating List For Storing These values
  return(list(setvec = SetVectorValue,
       getvec = GetVectorValue,
       setInverse = SetInverse,
       GetInverse = GetInverse))
  
}
## Write a short comment describing this function
## Cache Solve Will Take The Inverse Matrix and also the matrix then
## Through A lot calculation it will returned the inverse Matrix 
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  Matriex <- x$getvec()
  Matriex_inv <- x$GetInverse()
  
  if(!is.null(Matriex_inv))
  {
    print("Already calculated")
  }
  else
  {
    Matriex_inv <- solve(Matriex,...)
    x$setInverse(Matriex_inv)
  }
  
  return(Matriex_inv)
}

lol<-makeCacheMatrix(matrix(data = 1:4 ,ncol =2 ,nrow = 2))
ca<-cacheSolve(lol)
ca