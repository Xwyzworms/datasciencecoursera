## R Reading Data 
#Below Is the Common Functs
#1  read.table / read.csv --> Reading A tabular data
#2 readLines --> Reading lines of a text file
#3 source --> reading in R Code Files {inverse of dump}
#4 dget --> Reading in R code Files Pinverse of dput
#5 load --> Reading in saved workspaces
#6 unserialize --> Reading Single R objects in binary form

## R Writing Data
#Below Is the Common Functs
#1 write.table
#2 writeLines
#3 dump
#4 dput
#5 save
#6 serialize

## read.table() Hyperparams
# file --> the name of a file
# header --> Logic /True or false the file has a header_line
# sep --> How The columns seperated
# colClasses --> a char of vector indicating the class of each column in data set
# nrows --> the number of rows in dataset
# skip --> Same as skipfooter
# stringASFactors ==> should character variables be coded as factors

## Substing or indexing,same like python ,This is for vector
x <- c(1:20)
print(x [x > 15] ) ## Returning Logical output #2
print( x[-1] )
print( x[x > 5 & x < 10])

