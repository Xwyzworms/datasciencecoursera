# Notice that vector only applies the SAME data TYPES 

## Creating A Vector {Same Data Types}
numeric <- c(0.5,0.6) ##Numeric Vector 
logical1 <- c(TRUE , FALSE) ## Logical Vector
logical2 <- c(T,F) ## LOGICAL Vector
chara <- c("A","b","c") ## Character 
Stringme <- c("LOL") # String
Sequence_Vec <- 1:20 ## 1 - 20 Int
FormaComples <- c[1+0i , 2+5i] ## COMPLEX

## Printing All of thos Vect
print(numeric)
print(logical1)
print(logical2)
print(chara)
print(Stringme)
print(Sequence_Vec)

##Explicit Coercion
print('\n Example OF Explicit Coercion')
coerc1 <- 1:20
print(as.numeric(coerc1))
print(as.logical(coerc1))
print(as.character(coerc1))

##LIST The most valuable Data types, i also love the python list :D
List1 <- list("Sampis",2,4,"QoryGore","Jumaaah","LOL",2,5.4)
print(List1)

##Matrices relies on vector in R
matrices <- matrix(data = 1:15,nrow =5  , ncol = 3)
print(matrices)
print(dim(matrices))
print(attributes(matrices))
## initiates matrix from vector
m <- 1:10
dim(m) <- c(2,5)  ## Transform the m to matrix (2,5) --> total 10 rows 
print((m))
## initiates matrix from cbind rbind

x <- 1:3
y <- 10:12
columnBinded <-cbind(x,y) ## Column bind so the output 
print(columnBinded)
RowBinded <- rbind(x,y)
print(RowBinded)

# Factor Are Used to represent categorical data.Factors can be unordered or ordered

##input is character Vector

FactorEx = factor(x = c("Male","Female",
                        "Undefined"),levels = c("Male" ,"Female" ,"Undefined"))
print(FactorEx)


## Missing values #What i get in R is that the outputs mainly using the vectors
## While in python a list,let's finish this first week
Missingex <- c(1,2,NaN,NA,4)
print(is.na(Missingex))
print(is.nan(Missingex))
## See That NA can notice also the NAN values,LOL
## Data Frames --> Bunch of Stacked List
df <-data.frame(row1 = 1:4, colums = c(T,F,F,T)  )
print(df)